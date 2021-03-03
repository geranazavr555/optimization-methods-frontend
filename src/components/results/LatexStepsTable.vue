<template>
    <div v-if="steps !== undefined && steps.length > 0 && fields !== undefined && fields.length > 0">
        <pre>
\begin{longtable}{|<code v-for="x in fields.length" :key="'latex iter' + fields[x]">c|</code>}
\hline
\text{ {{fields[0]}} } <code v-for="field in fields.slice(1)" :key="'latex field' + field">& \text{ {{field}} }</code> \\
\hline
<code v-for="step in steps" :key="'latex step' + JSON.stringify(step)"><!--
-->{{step[fields[0]]}}<code v-for="field in fields.slice(1)" :key="field + 'val' + JSON.stringify(step)"> & {{floatPrettier(step[field])}}</code> \\
\hline
</code>
\end{longtable}
        </pre>
    </div>
</template>

<script>
export default {
    name: "LatexStepsTable",
    props: ["steps", "fields", "floatPrettier"],
}
</script>

<style scoped>

</style>