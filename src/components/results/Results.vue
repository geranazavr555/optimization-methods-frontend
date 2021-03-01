<template>
    <div class="results">
        <SummaryResults :fmin="fmin" :xmin="xmin"/>
        <CanvasView :width="500" :height="500" :from-x="fromX" :to-x="toX"/>
    </div>
</template>

<script>
import SummaryResults from "@/components/results/SummaryResults";
import CanvasView from "@/components/results/CanvasView";
export default {
    name: "Results",
    components: {CanvasView, SummaryResults},

    data: function () {
        return {
            fmin: null,
            xmin: null,
            fromX: 0,
            toX: 0
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
        });
    }
}
</script>

<style scoped>
    .results {
        margin-top: 1rem;
    }
</style>