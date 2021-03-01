<template>
    <div>
        <div class="parameter">
            <label :for="$id('function')">Функция:</label>
            <input class="function" v-on:change="onChangeParams" :id="$id('function')" v-model="func"/>
        </div>

        <div class="parameter">
            <label>Границы:</label>
            <label :for="$id('left')">от</label>
            <input v-model="left" v-on:change="onChangeParams" :id="$id('left')" type="number"/>
            <label :for="$id('right')">до</label>
            <input v-model="right"  v-on:change="onChangeParams" :id="$id('right')" type="number"/>
        </div>
    </div>
</template>

<script>
export default {
    name: "FunctionParam",
    props: ["initParams"],

    data() {
        return {
            left: parseFloat(this.initParams.left || "0.0"),
            right: parseFloat(this.initParams.right || "0.0"),
            func: this.initParams.function || "pow(log10(x - 2), 2.0) + pow(log10(10 - x), 2.0) - pow(x, 0.2)"
        }
    },

    beforeMount() {
        this.onChangeParams();
    },

    methods: {
        onChangeParams: function () {
            this.$root.$emit("paramsChanged", {
                function: this.func,
                left: this.left,
                right: this.right
            });
        }
    }
}
</script>

<style scoped>
    .function {
        width: 35rem;
    }
</style>