import {
    Pie,
    mixins
} from "vue-chartjs";
const {
    reactiveProp
} = mixins;
export default {
    extends: Pie,
    mixins: [reactiveProp],
    props: ['data', 'options'],
    mounted() {
        this.work1 = this.$refs.canvas
            .getContext("2d")
            .createLinearGradient(0, 0, 0, 175);
        this.work2 = this.$refs.canvas
            .getContext("2d")
            .createLinearGradient(0, 0, 0, 175);

        this.work1.addColorStop(0, "rgba(0, 231, 255, 0.9)");
        this.work1.addColorStop(0.5, "rgba(0, 231, 255, 0.7)");
        this.work1.addColorStop(1, "rgba(0, 231, 255, 0.4)");
        // this.work1.addColorStop(0.0, '#ACE1DB');
        // this.work1.addColorStop(1.0, '#7FBDB9');


        this.work2.addColorStop(0, "rgba(255, 0, 0, 1)");
        this.work2.addColorStop(0.5, "rgba(255, 0, 0, 0.7)");
        this.work2.addColorStop(1, "rgba(255, 0, 0, 0.3)");

        // Overwriting base render method with actual data.
        this.renderChart({
            labels: this.data.labels,
            datasets: [{
                // label: "Data 3",
                backgroundColor: [
                    "#E74C3C",
                    "#8E44AD",
                    "#3498DB",
                    "#16A085",
                    "#2ECC71",
                    "#F39C12",
                    "#D35400"
                ],
                data: this.data.values
            }]
        }, {
            responsive: true,
            maintainAspectRatio: false
        });
    }
};