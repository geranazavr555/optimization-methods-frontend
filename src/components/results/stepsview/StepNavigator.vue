<template>
    <div>
        <button class="hor leftButton" @click="leftClick">&laquo;</button>
        <div class="hor">Шаг: {{currentStep}} из {{steps.length}}</div>
        <button class="hor rightButton" @click="rightClick">&raquo;</button>
    </div>
</template>

<script>
export default {
    name: "StepNavigator",
    props: ["steps", "method"],

    data() {
        return {
            currentStep: 0
        }
    },

    beforeMount() {
        this.$root.$on("paramsChanged", () => this.currentStep = 0);
    },

    methods: {
        leftClick() {
            if (this.currentStep > 0) {
                this.currentStep--;
            }
            this.updateCanvas();
        },
        rightClick() {
            if (this.currentStep <= this.steps.length) {
                this.currentStep++;
            }
            this.updateCanvas();
        },
        updateCanvas() {
            const step = this.steps[this.currentStep];
            this.$root.$emit("rerender");
            if (this.method === "dichotomy") {
                this.$root.$emit("canvasDrawBoundX", step.left);
                this.$root.$emit("canvasDrawBoundX", step.right);

                this.$root.$emit("canvasDrawPointXY", step.argument, step.value);
                this.$root.$emit("canvasDrawPointXY", step.secondArgument, step.secondValue);
            } else if (this.method === "goldenRatio") {
                this.$root.$emit("canvasDrawBoundX", step.left);
                this.$root.$emit("canvasDrawBoundX", step.right);

                this.$root.$emit("canvasDrawPointXY", step.argument, step.value);
                this.$root.$emit("canvasDrawPointXY", step.secondArgument, step.secondValue);
            } else if (this.method === "fibonacci") {
                this.$root.$emit("canvasDrawBoundX", step.left);
                this.$root.$emit("canvasDrawBoundX", step.right);

                this.$root.$emit("canvasDrawPointXY", step.argument, step.value);
                this.$root.$emit("canvasDrawPointXY", step.secondArgument, step.secondValue);
            } else if (this.method === "parabola") {
                this.$root.$emit("canvasDrawBoundX", step.left);
                this.$root.$emit("canvasDrawBoundX", step.right);

                const x1 = step.argument;
                const x2 = step.secondArgument;
                // const x3 = step.thirdArgument;
                const a = step.a2;
                const b = step.a1 - step.a2 * x2 - step.a2 * x1;
                const c = step.a0 - step.a1 * x1 + step.a2 * x1 * x2;

                this.$root.$emit("canvasDrawParabolaABC", a, b, c);
                this.$root.$emit("canvasDrawPointXY", step.minArgument, step.minValue);
                this.$root.$emit("canvasDrawPointXY", step.argument, step.value);
                this.$root.$emit("canvasDrawPointXY", step.secondArgument, step.secondValue);
                this.$root.$emit("canvasDrawPointXY", step.thirdArgument, step.thirdValue);
            } else if (this.method === "brent") {
                this.$root.$emit("canvasDrawBoundX", step.left);
                this.$root.$emit("canvasDrawBoundX", step.right);
                console.log(step);


                if (step.a0 && step.a1 && step.a2 && !isNaN(step.a0) && !isNaN(step.a1) && !isNaN(step.a2)) {
                    const x1 = step.firstMinimum;
                    const x2 = step.secondMinimum;
                    // const x3 = step.thirdArgument;
                    const a = step.a2;
                    const b = step.a1 - step.a2 * x2 - step.a2 * x1;
                    const c = step.a0 - step.a1 * x1 + step.a2 * x1 * x2;

                    this.$root.$emit("canvasDrawParabolaABC", a, b, c);
                }
                this.$root.$emit("canvasDrawPointXY", step.firstMinimum, step.firstMinimumValue);
                this.$root.$emit("canvasDrawPointXY", step.secondMinimum, step.secondMinimumValue);
            }
        }
    }
}
</script>

<style scoped>
    .hor {
        display: inline;
        margin-left: 1em;
    }
</style>