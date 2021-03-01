<template>
    <canvas :id="$id('canvas')" :width="width" :height="height"></canvas>
</template>

<script>
    export default {
        name: "CanvasView",
        props: ["width", "height", "fromX", "toX"],

        data() {
            return {
                rawPoints: [],
                fromY: 0,
                toY: 0
            }
        },

        methods: {
            x(originX) {
                const fromX = parseFloat(this.fromX);
                const toX = parseFloat(this.toX);
                const width = parseFloat(this.width);
                // fromX -> 0
                // toX -> width
                const k = width / (toX - fromX);
                const b = -k * fromX;
                return k * originX + b;
            },
            originX(x) {
                const fromX = parseFloat(this.fromX);
                const toX = parseFloat(this.toX);
                const width = parseFloat(this.width);
                const k = width / (toX - fromX);
                const b = -k * fromX;
                return (x - b) / k;
            },
            y(originY) {
                const fromY = parseFloat(this.fromY);
                const toY = parseFloat(this.toY);
                const height = parseFloat(this.width);
                // fromY -> height
                // toY -> 0
                const k = height / (fromY - toY);
                const b = -k * toY;
                return k * originY + b;
            },
            originY(y) {
                const fromY = parseFloat(this.fromY);
                const toY = parseFloat(this.toY);
                const height = parseFloat(this.width);
                const k = height / (fromY - toY);
                const b = -k * toY;
                return (y - b) / k;
            },
            countYInterval() {
                const minY = Math.min(...this.points.map(point => point.y));
                const maxY = Math.max(...this.points.map(point => point.y));
                const delta = maxY - minY;
                this.fromY = minY - delta / 2.0;
                this.toY = maxY + delta / 2.0;
            },
            renderFunction(canvas) {
                const context = canvas.getContext("2d");
                context.beginPath();
                context.moveTo(this.x(0), this.y(0));
                for (const point of this.points) {
                    context.lineTo(this.x(point.x), this.y(point.y));
                }
                context.stroke();
            },
            renderAxes(canvas) {
                let context = canvas.getContext("2d");
                context.beginPath()
                context.moveTo(this.x(-1000), this.y(0));
                context.lineTo(this.x(1000), this.y(0));
                context.stroke();

                context = canvas.getContext("2d");
                context.beginPath()
                context.moveTo(this.x(0), this.y(-1000));
                context.lineTo(this.x(0), this.y(1000));
                context.stroke();
            },
            render() {
                this.countYInterval();
                const canvas = document.getElementById(this.$id('canvas'));
                const context = canvas.getContext("2d");
                context.clearRect(0, 0, canvas.width, canvas.height);
                this.renderFunction(canvas);
                this.renderAxes(canvas);
            }
        },

        computed: {
            points() {
                const isOkNumber = x => x !== undefined && x != null && typeof x === "number" && !isNaN(x);
                return this.rawPoints.filter(point => isOkNumber(point.x) && isOkNumber(point.y));
            }
        },

        beforeMount() {
            this.$root.$on("pointsChanged", points => {
                this.rawPoints = points;
                this.render();
            });
        },

        mounted() {
            this.render();
        }
    }
</script>

<style scoped>

</style>