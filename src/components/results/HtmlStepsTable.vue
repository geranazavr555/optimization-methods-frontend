<template>
    <div>
        <table v-if="steps !== undefined && steps.length > 0">
            <thead>
                <tr>
                    <td v-for="field in fields" :key="'html' + field">{{field}}</td>
                </tr>
            </thead>
            <tbody>
                <tr v-for="step in steps" :key="'html' + JSON.stringify(step)">
                    <td v-for="field in fields" :key="'html' + field + '-' + JSON.stringify(step)">
                        {{pretty(step[field])}}
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
export default {
    name: "HtmlStepsTable",
    props: ["steps", "fields", "floatPrettier"],

    methods: {
        pretty(value) {
            if (value === undefined || value === null || value === "")
                return "";
            return this.floatPrettier(value);
        }
    }
}
</script>

<style scoped>

</style>