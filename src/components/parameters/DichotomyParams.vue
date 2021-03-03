<template>
    <div>
        <FunctionParam :init-params="initParams"/>

        <div class="parameter">
            <label :for="$id('eps')">Eps:</label>
            <input v-model="eps" v-on:change="onChangeParams" :id="$id('eps')"/>
        </div>

        <div class="parameter">
            <label :for="$id('delta')">Delta:</label>
            <input v-model="delta" v-on:change="onChangeParams"  :id="$id('delta')"/>
        </div>
    </div>
</template>

<script>
import FunctionParam from "@/components/parameters/FunctionParam";

export default {
    name: "DichotomyParams",
    components: {FunctionParam},
    props: ["initParams"],

    data() {
        return {
            eps: parseFloat(this.initParams.eps || "0.0"),
            delta: parseFloat(this.initParams.delta || "0.0")
        }
    },

    beforeMount() {
        this.onChangeParams();
    },

    methods: {
        onChangeParams: function () {
            this.$root.$emit("paramsChanged", {
                eps: this.eps,
                delta: this.delta
            });
        }
    }
}
</script>

<style scoped>

</style>