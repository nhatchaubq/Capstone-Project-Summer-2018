import { Line, mixins } from "vue-chartjs";

export default {
  extends: Line,
  mixins: [mixins.reactiveProp],
  props: ["chartData", "options", "isWorkorderChart"],
  // data() {
  //     return {
  //         gradient: null,
  //         gradient2: null,
  //         grandient3: null
  //     }
  // },
  mounted() {
    this.gradient = this.$refs.canvas
      .getContext("2d")
      .createLinearGradient(0, 0, 0, 450);
    this.gradient2 = this.$refs.canvas
      .getContext("2d")
      .createLinearGradient(0, 0, 0, 450);
    this.gradient3 = this.$refs.canvas
      .getContext("2d")
      .createLinearGradient(0, 0, 0, 450);

    this.gradient.addColorStop(0, "rgba(204, 0, 0, 0.8)");
    this.gradient.addColorStop(0.5, "rgba(204, 0, 0, 0.5)");
    this.gradient.addColorStop(1, "rgba(204, 0, 0, 0.3)");

    this.gradient2.addColorStop(0, "rgba(0, 0, 204, 0.8)");
    this.gradient2.addColorStop(0.5, "rgba(0, 0, 204, 0.5)");
    this.gradient2.addColorStop(1, "rgba(0, 0, 204, 0.3)");

    this.gradient3.addColorStop(0, "rgba(255, 255, 0, 0.6)");
    this.gradient3.addColorStop(0.5, "rgba(255, 255, 0, 0.3)");
    this.gradient3.addColorStop(1, "rgba(255, 255, 0, 0.15)");

    // Overwriting base render method with actual data.
    this.renderChart(
      {
        labels: this.chartData.monthLabels,
        datasets: [
          {
            label: this.chartData.labels[0],
            backgroundColor: this.gradient,
            data: this.chartData.monthData[0],
            lineTension: 0
          },
          {
            label: this.chartData.labels[1],
            backgroundColor: this.gradient2,
            data: this.chartData.monthData[1],
            lineTension: 0
          }
        ]
      },
      { 
        responsive: true, 
        maintainAspectRatio: false,
        scales: {
          yAxes: [{
              ticks: {
                  beginAtZero: true,
                  callback: function (value) { if (Number.isInteger(value)) { return value; } },
                  stepSize: 1
              },
              scaleLabel: {
                display: true,
                labelString: this.isWorkorderChart ? 'Work Order' : 'Equipment',
              }
          }]
        }
      }
    );
  },
  methods: {
    update: function(data) {
      this.renderChart(
        {
          labels: data.monthLabels,
          datasets: [
            {
              label: data.labels[0],
              backgroundColor: this.gradient,
              data: data.monthData[0],
              lineTension: 0
            },
            {
              label: data.labels[1],
              backgroundColor: this.gradient2,
              data: data.monthData[1],
              lineTension: 0
            }
          ]
        },
        { 
          responsive: true, 
          maintainAspectRatio: false,
          scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true,
                    callback: function (value) { if (Number.isInteger(value)) { return value; } },
                    stepSize: 1
                },
                scaleLabel: {
                  display: true,
                  labelString: this.isWorkorderChart ? 'Work Order' : 'Equipment',
                }
            }]
          }
        }
      );
    }
  }
};
