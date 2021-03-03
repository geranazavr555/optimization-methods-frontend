<template>
    <div class="stepsTable">
        <select :id="$id('viewMode')" v-model="viewMode">
            <option value="html" selected>html</option>
            <option value="latex">latex</option>
        </select>

        <HtmlStepsTable v-if="viewMode === 'html'" :steps="stepsPrepared" :fields="fields" :floatPrettier="floatPrettier"/>
        <LatexStepsTable v-if="viewMode === 'latex'" :steps="stepsPrepared" :fields="fields" :floatPrettier="floatPrettier"/>
    </div>
</template>

<script>
import HtmlStepsTable from "@/components/results/HtmlStepsTable";
import LatexStepsTable from "@/components/results/LatexStepsTable";
export default {
    name: "StepsTable",
    components: {LatexStepsTable, HtmlStepsTable},
    props: ["steps", "floatPrettier"],

    data() {
        return {
            viewMode: "html"
        }
    },

    computed: {
        fields() {
            const names = ["#", "length", "ratio"];
            for (const step of this.steps) {
                for (const field in step) {
                    if (Object.prototype.hasOwnProperty.call(step, field) && !names.includes(field)) {
                        names.push(field);
                    }
                }
            }
            return names;
        },

        stepsPrepared() {
            const result = [];
            this.steps.forEach((step, i) => {
                const stepClone = Object.assign({}, step);
                stepClone["#"] = i + 1;
                stepClone.length = step.right - step.left;
                if (i !== 0) {
                    stepClone.ratio = stepClone.length / result[result.length - 1].length;
                }
                result.push(stepClone);
            });
            return result;
        }
    }
}
</script>

<style scoped>

</style>