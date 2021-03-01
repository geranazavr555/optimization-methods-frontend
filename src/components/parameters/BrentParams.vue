<template>
    <div>
        <FunctionParam :init-params="initParams"/>

        <div class="parameter">
            <label :for="$id('eps')">Eps:</label>
            <input v-model="eps" :id="$id('eps')" type="number"/>
        </div>
    </div>
</template>

<script>
import FunctionParam from "@/components/parameters/FunctionParam";

export default {
    name: "BrentParams",
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
}
</script>

<style scoped>

</style>