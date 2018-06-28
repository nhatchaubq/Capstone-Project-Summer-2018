import {
    Pie
} from "vue-chartjs";

export default {
    extends: Pie,
    data() {
        return {
            work1: null,
            work2: null,

        }
    },
    mounted() {
        this.work1 = this.$refs.canvas.getContext('2d').createLinearGradient(0, 0, 0, 450)
        this.work2 = this.$refs.canvas.getContext('2d').createLinearGradient(0, 0, 0, 450)



        this.work1.addColorStop(0, 'rgba(201, 89, 170, 0.3)')
        this.work1.addColorStop(0.5, 'rgba(201, 89, 170, 0.2)');
        this.work1.addColorStop(1, 'rgba(201, 89, 170, 0.01)');

        this.work2.addColorStop(0, 'rgba(0, 231, 255, 0.9)')
        this.work2.addColorStop(0.5, 'rgba(0, 231, 255, 0.25)');
        this.work2.addColorStop(1, 'rgba(0, 231, 255, 0)');

        // Overwriting base render method with actual data.
        this.renderChart({
            labels: ['AVAILABLE', 'WORKING REQUESTING', 'MAINTAINANCE REQUESTING', 'WORKING', 'DAMAGED', 'MAINTAINING', 'LOST'],
            datasets: [{
                label: 'Data 3',
                backgroundColor: ["#00aac1", "#304ffe", "#00c853", "#ab47bc", "#ffd600", "#2ebaac", "#fafafa"],
                data: [40, 39, 10, 40, 39, 80, 40]
            }, ]
        }, {
            responsive: true,
            maintainAspectRatio: false
        });
    }
};