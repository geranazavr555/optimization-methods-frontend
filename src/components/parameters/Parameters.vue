<template>
    <div>
        <label :for="$id('method')">Метод:</label>
        <select id="$id('method')" v-model="method" @change="onChangeParams">
            <option value="dichotomy" selected>Дихотомия</option>
            <option value="goldenRatio">Золотое сечение</option>
            <option value="fibonacci">Фибоначчи</option>
            <option value="parabola">Парабол</option>
            <option value="brent">Метод Брента</option>
        </select>

        <DichotomyParams v-if="method === 'dichotomy'" :initParams="initParams"/>
        <GoldenRatioParams v-if="method === 'goldenRatio'" :initParams="initParams"/>
        <FibonacciParams v-if="method === 'fibonacci'" :initParams="initParams"/>
        <ParabolaParams v-if="method === 'parabola'" :initParams="initParams"/>
        <BrentParams v-if="method === 'brent'" :initParams="initParams"/>
    </div>
</template>

<script>
import DichotomyParams from "@/components/parameters/DichotomyParams";
import GoldenRatioParams from "@/components/parameters/GoldenRatioParams";
import FibonacciParams from "@/components/parameters/FibonacciParams";
import ParabolaParams from "@/components/parameters/ParabolaParams";
import BrentParams from "@/components/parameters/BrentParams";

export default {
    name: "Parameters",
    components: {ParabolaParams, FibonacciParams, GoldenRatioParams, DichotomyParams, BrentParams},
    props: ["initParams"],
    data: function () {
        return {
            method: "dichotomy"
        }
    },

    beforeMount() {
        this.onChangeParams();
    },

    methods: {
        onChangeParams: function () {
            this.$root.$emit("paramsChanged", {
                method: this.method
            });
        }
    }
}
</script>

<style scoped>

</style>