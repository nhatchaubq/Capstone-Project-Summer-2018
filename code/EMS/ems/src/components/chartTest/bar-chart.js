import {
    Line
} from "vue-chartjs";

export default {
    extends: Line,
    data() {
        return {
            gradient: null,
            gradient2: null,
            grandient3: null
        }
    },
    mounted() {
        this.gradient = this.$refs.canvas.getContext('2d').createLinearGradient(0, 0, 0, 450)
        this.gradient2 = this.$refs.canvas.getContext('2d').createLinearGradient(0, 0, 0, 450)
        this.gradient3 = this.$refs.canvas.getContext('2d').createLinearGradient(0, 0, 0, 450)


        this.gradient.addColorStop(0, 'rgba(255, 0,0, 0.5)')
        this.gradient.addColorStop(0.5, 'rgba(255, 0, 0, 0.25)');
        this.gradient.addColorStop(1, 'rgba(255, 0, 0, 0)');

        this.gradient2.addColorStop(0, 'rgba(0, 231, 255, 0.9)')
        this.gradient2.addColorStop(0.5, 'rgba(0, 231, 255, 0.25)');
        this.gradient2.addColorStop(1, 'rgba(0, 231, 255, 0)');

        this.gradient3.addColorStop(0, 'rgba(255, 255, 0, 0.6)')
        this.gradient3.addColorStop(0.5, 'rgba(255, 255, 0, 0.3)');
        this.gradient3.addColorStop(1, 'rgba(255, 255, 0, 0.15)');
        // Overwriting base render method with actual data.
        this.renderChart({
            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
            datasets: [{
                label: 'Data One',
                backgroundColor: this.gradient,
                data: [40, 39, 10, 40, 39, 80, 40]
            }, {
                label: 'Data Two',
                backgroundColor: this.gradient2,
                data: [60, 55, 32, 10, 2, 12, 53]
            }, ]
        }, {
            responsive: true,
            maintainAspectRatio: false
        });
    }
};