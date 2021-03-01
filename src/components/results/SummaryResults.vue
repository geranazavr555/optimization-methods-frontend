<template>
    <div>
        <div class="result-field">
            Минимум функции f*(x*):
            <div class="result-value">{{ naWrap(fmin) }}</div>
        </div>
        <div class="result-field">
            x*:
            <div class="result-value">{{ naWrap(xmin) }}</div>
        </div>
    </div>
</template>

<script>
export default {
    name: "SummaryResults",

    props: ["fmin", "xmin"],

    methods: {
        naWrap: function (value) {
            return (value === null || value === undefined) ? "N/A" : value;
        }
    }
}
</script>

<style scoped>
    .result-field {
        display: inline-block;
        margin-left: 1rem;
    }
</style>