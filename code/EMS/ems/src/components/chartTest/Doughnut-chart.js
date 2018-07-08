import {
    Doughnut,
    mixins
} from "vue-chartjs";
const {
    reactiveProp
} = mixins;
export default {
    extends: Doughnut,
    mixins: [reactiveProp],
    props: ['data', 'options'],
    mounted() {

        // Overwriting base render method with actual data.
        this.renderChart({
            labels: this.data.TodayLabels,
            datasets: [{
                // label: "Data 3",
                backgroundColor: [
                    "#00796B",
                    "#CFD8DC",
                ],
                data: this.data.TodayData
            }]
        }, {
            responsive: true,
            maintainAspectRatio: false,
            cutoutPercentage: 75

        });
    }
};