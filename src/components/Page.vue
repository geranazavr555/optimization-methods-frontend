<template>
    <div class="page">
        <Parameters :initParams="getInitParams"/>
        <input type="button" @click.prevent="run" value="Поехали!"/>
        <Results/>
    </div>
</template>

<script>
import Parameters from "@/components/parameters/Parameters";
import Results from "@/components/results/Results";
import axios from "axios";
export default {
    name: "Page",
    components: {Results, Parameters},

    data() {
        return {
            paramNames: ["function", "left", "right", "eps", "delta", "method"],
            function: null,
            left: null,
            right: null,
            eps: null,
            delta: null,
            method: null
        }
    },

    methods: {
        run() {
            this.$root.$emit("recalculate");
        }
    },

    computed: {
        getInitParams() {
            const initParams = {};
            for (const paramName of this.paramNames) {
                if (this[paramName] !== undefined && this.paramNames !== null && paramName !== "method") {
                    initParams[paramName] = this[paramName];
                }
            }
            return initParams;
        }
    },

    beforeMount() {
        this.$root.$on("paramsChanged", (params) => {
            for (const paramName of this.paramNames) {
                if (params[paramName] !== undefined) {
                    this[paramName] = params[paramName];
                }
            }

            axios.post("/plot", {
                function: this.function,
                from: this.left,
                to: this.right,
                stepDelta: (this.right - this.left) / 1000
            }).then(response => {
                if (response.status === 200) {
                    this.$root.$emit("pointsChanged", response.data);
                } else {
                    console.error(response);
                }
            }).catch(error => {
                console.error(error);
            });
        });

        this.$root.$on("recalculate", () => {
            axios.post("/calculate", {
                function: this.function,
                left: this.left,
                right: this.right,
                eps: this.eps,
                delta: this.delta
            }, {
                headers: {
                    method: this.method
                }
            }).then(response => {
                if (response.status === 200) {
                    this.$root.$emit("resultsChanged", response.data);
                } else {
                    console.error(response);
                }
            }).catch(error => {
                console.error(error);
            })
        });
    }
}
</script>

<style scoped>
    div.page {
        margin: 1rem;
    }
</style>