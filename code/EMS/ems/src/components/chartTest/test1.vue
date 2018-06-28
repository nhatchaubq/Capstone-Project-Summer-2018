<template>
<div>
    <div class="Chart">
        <!-- <div> -->
        <h2>Linechart</h2>
        <bar-chart ref="canvas"></bar-chart>
    </div>
      

</div>
</template>

<script>
// import Pie from "./bar-chart.js";
import BarChart from "./bar-chart.js";
// import VueChart from "vue-chartjs";
export default {
  components: {
    BarChart
  }
};
</script>

<style>
.Chart {
  background: #212733;
  border-radius: 15px;
  box-shadow: 0px 2px 15px rgba(25, 25, 25, 0.27);
  margin: 25px 0;
}

.Chart h2 {
  margin-top: 0;
  padding: 15px 0;
  color: rgba(255, 0, 0, 0.5);
  border-bottom: 1px solid #323d54;
}
</style>
