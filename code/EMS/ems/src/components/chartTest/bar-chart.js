import {
    Line,
    mixins
} from "vue-chartjs";
const {
    reactiveProp
} = mixins;
export default {
    extends: Line,
    mixins: [reactiveProp],
    props: ['data', 'options'],
    // data() {
    //     return {
    //         gradient: null,
    //         gradient2: null,
    //         grandient3: null
    //     }
    // },
    mounted() {
        this.gradient = this.$refs.canvas.getContext('2d').createLinearGradient(0, 0, 0, 450)
        this.gradient2 = this.$refs.canvas.getContext('2d').createLinearGradient(0, 0, 0, 450)
        this.gradient3 = this.$refs.canvas.getContext('2d').createLinearGradient(0, 0, 0, 450)


        this.gradient.addColorStop(0, 'rgba(255, 0, 0, 0.8)')
        this.gradient.addColorStop(0.5, 'rgba(255, 0, 0, 0.6)');
        this.gradient.addColorStop(1, 'rgba(255, 0, 0, 0.3)');

        this.gradient2.addColorStop(0, 'rgba(0, 0, 255, 0.8)')
        this.gradient2.addColorStop(0.5, 'rgba(0, 0, 255, 0.5)');
        this.gradient2.addColorStop(1, 'rgba(0, 0, 255, 0.3)');

        this.gradient3.addColorStop(0, 'rgba(255, 255, 0, 0.6)')
        this.gradient3.addColorStop(0.5, 'rgba(255, 255, 0, 0.3)');
        this.gradient3.addColorStop(1, 'rgba(255, 255, 0, 0.15)');
        // Overwriting base render method with actual data.
        this.renderChart({
            labels: this.data.monthLabels,
            datasets: [{
                label: this.data.workingLabel,
                backgroundColor: this.gradient,
                data: this.data.monthData.working
            }, {
                label: this.data.maintainLabel,
                backgroundColor: this.gradient2,
                data: this.data.monthData.maintain
            }, ]
        }, {
            responsive: true,
            maintainAspectRatio: false
        });
    }
};