import {
    Doughnut
} from "../../../node_modules/vue-chartjs/es/BaseCharts/doughnut";

export default {
    extends: Doughnut,
    data() {
        return {
            work1: null,
            work2: null,

        }
    },
    mounted() {
        this.work1 = this.$refs.canvas.getContext('2d').createLinearGradient(0, 0, 0, 450)
        this.work2 = this.$refs.canvas.getContext('2d').createLinearGradient(0, 0, 0, 450)



        this.work1.addColorStop(0, 'rgba(255, 0,0, 0.5)')
        this.work1.addColorStop(0.5, 'rgba(255, 0, 0, 0.25)');
        this.work1.addColorStop(1, 'rgba(255, 0, 0, 0)');

        this.work2.addColorStop(0, 'rgba(0, 231, 255, 0.9)')
        this.work2.addColorStop(0.5, 'rgba(0, 231, 255, 0.25)');
        this.work2.addColorStop(1, 'rgba(0, 231, 255, 0)');

        // Overwriting base render method with actual data.
        this.renderChart({
            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
            datasets: [{
                label: 'Data 3',
                backgroundColor: this.work1,
                data: [40, 39, 10, 40, 39, 80, 40]
            }, {
                label: 'Data 4',
                backgroundColor: this.work2,
                data: [60, 55, 32, 10, 2, 12, 53]
            }, ]
        }, {
            responsive: true,
            maintainAspectRatio: false
        });
    }
};