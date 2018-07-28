import {
    PolarArea,
    mixins
} from "vue-chartjs";
const {
    reactiveProp
} = mixins;
export default {
    extends: PolarArea,
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
            // labels: ['Strength', 'skill', 'Health', 'Luck'],
            labels: this.data.equipCateLabels,

            datasets: [{
                    label: 'Points1',
                    backgroundColor: "#f44336",
                    data: [10, 20, 55, 30]

                }, {
                    label: 'Points2',
                    backgroundColor: "#f45255",
                    data: [15, 36, 10, 20]
                }
                // datasets: [{
                //         label: this.data.equipmentData.labels,
                //         backgroundColor: "#f44336",
                //         data: this.data.equipmentData.avaivalues

                //     },
                //  {
                //     label: this.data.equipmentData.labels,
                //     backgroundColor: this.gradient2,
                //     data: this.data.equipmentData.avaivalues
                // },
            ]
        }, {
            responsive: true,
            maintainAspectRatio: false
        });
    }
};