<template>
    <div>
        <FunctionParam :init-params="initParams"/>

        <div class="parameter">
            <label :for="$id('eps')">Eps:</label>
            <input v-model="eps" v-on:change="onChangeParams" :id="$id('eps')" type="number"/>
        </div>
    </div>
</template>

<script>
import FunctionParam from "@/components/parameters/FunctionParam";

export default {
    name: "ParabolaParams",
    components: {FunctionParam},
    props: ["initParams"],

    data: function () {
        return {
            eps: parseFloat(this.initParams.eps || "0.0"),
        }
    },

    beforeMount() {
        this.onChangeParams();
    },

    methods: {
        onChangeParams: function () {
            this.$root.$emit("paramsChanged", {
                eps: this.eps
            });
        }
    }
}
</script>

<style scoped>

</style>