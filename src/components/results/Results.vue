<template>
    <div class="results">
        <SummaryResults :fmin="fmin" :xmin="xmin" :floatPrettier="floatPrettier"/>
        <CanvasView :width="500" :height="500" :from-x="fromX" :to-x="toX" />
        <StepsTable :steps="steps" :floatPrettier="floatPrettier"/>
    </div>
</template>

<script>
import SummaryResults from "@/components/results/SummaryResults";
import CanvasView from "@/components/results/CanvasView";
import StepsTable from "@/components/results/StepsTable";
export default {
    name: "Results",
    components: {CanvasView, SummaryResults, StepsTable},
    props: ["eps"],

    data: function () {
        return {
            fmin: null,
            xmin: null,
            fromX: 0,
            toX: 0,
            steps: []
        }
    },

    computed: {
        floatPrettier() {
            return (x) => {
                if (x !== undefined && x != null) {
                    let num = x;
                    if (typeof x !== "number") {
                        num = parseFloat(x);
                    }

                    const exp = Math.log10(this.eps);
                    return Math.round10(num, exp - 2);
                } else {
                    return "";
                }
            };
        }
    },

    beforeMount() {
        this.$root.$on("paramsChanged", params => {
            if (params.left !== undefined) {
                this.fromX = parseFloat(params.left);
            }
            if (params.right !== undefined) {
                this.toX = parseFloat(params.right);
            }
        });

        this.$root.$on("resultsChanged", results => {
            this.fmin = results.value;
            this.xmin = results.argument;
            this.steps = results.steps;
        });
    }
}
</script>

<style scoped>
    .results {
        margin-top: 1rem;
    }
</style>