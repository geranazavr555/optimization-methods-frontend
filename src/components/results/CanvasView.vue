<template>
    <canvas :id="$id('canvas')" :width="width" :height="height"></canvas>
</template>

<script>
    import axios from "axios";

    export default {
        name: "CanvasView",
        props: ["width", "height", "fromX", "toX", "floatPrettier"],

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
                this.renderByPoints(canvas, this.points, false);
            },
            renderByPoints(canvas, points, color) {
                // console.log(points);
                const context = canvas.getContext("2d");

                if (color === true) {
                    context.strokeStyle = "Red";
                }

                context.beginPath();
                context.moveTo(this.x(0), this.y(0));
                for (const point of points) {
                    context.lineTo(this.x(point.x), this.y(point.y));
                }
                context.stroke();

                context.strokeStyle = "Black";
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
            },
            drawBound(x) {
                const canvas = document.getElementById(this.$id('canvas'));
                const context = canvas.getContext("2d");

                context.beginPath();
                context.moveTo(this.x(x), this.y(-1000));
                context.lineTo(this.x(x), this.y(1000));
                context.stroke();
            },
            drawPoint(x, y) {
                const canvas = document.getElementById(this.$id('canvas'));
                const context = canvas.getContext("2d");

                context.beginPath();
                context.arc(this.x(x), this.y(y), 2, 0, Math.PI * 2, true);
                context.stroke();
            },
            drawParabola(a, b, c) {
                const canvas = document.getElementById(this.$id('canvas'));
                const func = `(${this.floatPrettier(a)}) * x * x + (${this.floatPrettier(b)}) * x + (${this.floatPrettier(c)})`;

                axios.post("/plot", {
                    function: func,
                    from: this.fromX,
                    to: this.toX,
                    stepDelta: (this.toX - this.fromX) / 500
                }).then(response => {
                    if (response.status === 200) {
                        this.renderByPoints(canvas, response.data, true);
                    } else {
                        console.error(response);
                    }
                }).catch(error => {
                    console.error(error);
                });
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

            this.$root.$on("rerender", () => this.render());
            this.$root.$on("canvasDrawBoundX", (x) => this.drawBound(x));
            this.$root.$on("canvasDrawPointXY", (x, y) => this.drawPoint(x, y));
            this.$root.$on("canvasDrawParabolaABC", (a, b, c) => this.drawParabola(a, b, c));
        },

        mounted() {
            this.render();
        }
    }
</script>

<style scoped>

</style>