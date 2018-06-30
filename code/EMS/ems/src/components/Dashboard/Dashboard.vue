<template>
    <div v-if="Dashboard">
        <div>
            <div class="" style="width: 100%; margin-bottom: 1rem">
            <!-- <div class="viewgraph " > -->
                <!-- line chart -->
                    <strong>Number of Work Order Completed</strong>
                    <div style="width:100%" class="Chart">
                        <bar-chart :data="lineChartData" styles="height: 40vh"></bar-chart>
                    </div>
            </div> <!-- line chart -->
            <div class="col-12 row">
                <div class="col-6">&#8203</div>
                <div class="col-6" style="padding-left:2rem"><strong>Equipment items by status</strong></div>
            </div>
            <div>
                <div class="row">
                    <!-- test -->
                    <div class="col-6" style="padding: 0px !important">
                        <div class="statusworkorder row">
                            <div class="row col-12" style="margin-bottom: 1rem;padding-right: 0px; padding-left: 25px !important">
                                <div class="status column material-shadow-animate">
                                    <div class="headerstatus columns">
                                        <div style="width:40%" class="column">
                                        <strong>Requested</strong>
                                        </div>

                                    </div>
                                    <div class="contentstatus" >
                                        <p style="color: var(--status-request); font-size:38px; text-align: center;font-weight: bold;">{{Dashboard.Requested}}</p>
                                        <p style="font-size:15px;" >Work Orders</p>
                                    </div>
                                </div>
                                <div class="status column material-shadow-animate" >
                                    <div class="headerstatus columns">
                                        <div style="width:40%" class="column">
                                        <strong>Checked</strong>
                                        </div>

                                    </div>
                                    <div class="contentstatus ">
                                        <p style="color: var(--status-checked); font-size:38px; text-align: center;font-weight: bold;">{{Dashboard.Checked}}</p>
                                        <p style="font-size:15px;">Work Orders</p>
                                    </div>
                                </div>
                            </div>
                            <div class="row col-12" style="padding-right: 0px; padding-left: 25px !important" >
                                <div class="status column material-shadow-animate">
                                    <div class="headerstatus columns">
                                        <div style="width:40%" class="column">
                                        <strong>Approved</strong>
                                        </div>

                                    </div>
                                    <div class="contentstatus">
                                        <p style="color: var(--status-approved); font-size:38px; text-align: center;font-weight: bold;">{{Dashboard.Approve}}</p>
                                        <p style="font-size:15px;">Work Orders</p>
                                    </div>
                                </div>
                                <div class="status column material-shadow-animate" >
                                    <div class="headerstatus columns">
                                        <div style="width:40%" class="column">
                                        <strong>In Progress</strong>
                                        </div>

                                    </div>
                                    <div class="contentstatus" >
                                        <p style="color: var(--status-delivered); font-size:38px; text-align: center;font-weight: bold;">{{Dashboard.InProgress}}</p>
                                        <p style="font-size:15px; ">Work Orders</p>
                                    </div>
                                </div>
                            </div>

                            
                        </div>
                    </div>
                    <!-- /test -->

                        <div class="col-6 ">
                            <!-- <div class="workordergraph viewgraph"> -->
                                <!-- <div class="titlediv">
                                    <strong>Equipment items by status</strong>
                                </div> -->

                        <div style="width:100%" class="Chart1">
                            <pie-chart styles="height: 45.5vh" :data="pieChartData"></pie-chart>
                        </div>
                  
                        </div>
                </div>
                <!-- test -->
                <!-- <div class="statusworkorder columns">
                    <div class="status column">
                        <div class="headerstatus columns">
                            <div style="width:40%" class="column">
                            <strong>Requested</strong>
                            </div>

                        </div>
                        <div class="contentstatus" >
                            <p style="color: var(--status-request); font-size:38px; text-align: center;font-weight: bold;">{{Dashboard.Requested}}</p>
                            <p style="font-size:15px;" >Work Orders</p>
                        </div>
                    </div>
                    <div class="status column">
                        <div class="headerstatus columns">
                            <div style="width:40%" class="column">
                            <strong>Checked</strong>
                            </div>

                        </div>
                        <div class="contentstatus">
                            <p style="color: var(--status-checked); font-size:38px; text-align: center;font-weight: bold;">{{Dashboard.Checked}}</p>
                            <p style="font-size:15px;">Work Orders</p>
                        </div>
                    </div>
                                    <div class="status column">
                        <div class="headerstatus columns">
                            <div style="width:40%" class="column">
                            <strong>Approve</strong>
                            </div>

                        </div>
                        <div class="contentstatus">
                            <p style="color: var(--status-approved); font-size:38px; text-align: center;font-weight: bold;">{{Dashboard.Approve}}</p>
                            <p style="font-size:15px;">Work Orders</p>
                        </div>
                    </div>
                                    <div class="status column" style="margin-right:0rem !important">
                        <div class="headerstatus columns" >
                            <div style="width:40%" class="column">
                            <strong>In Progress</strong>
                            </div>

                        </div>
                        <div class="contentstatus" >
                            <p style="color: var(--status-delivered); font-size:38px; text-align: center;font-weight: bold;">{{Dashboard.InProgress}}</p>
                            <p style="font-size:15px; ">Work Orders</p>
                        </div>
                    </div>

                    
                </div> -->
                <!-- /test -->

                <div class="divrow3 columns" style="margin-right:0rem !important">
                    <div class="column" style="padding: 0 !important; margin-right: 1.8rem;">
                        <div class="row3childs">
                        <!-- <div> -->
                            <div style="font-size:17px; margin:0.8rem 0rem 0.8rem 0rem;">
                                <strong>Maintain</strong>
                            </div>
                            <div class="row3child material-shadow-animate1">                            
                                <div class="headerstatus columns"  style="padding: 0.5rem 0 0.5rem 0">
                                    <div class="column">
                                        <strong>Today: {{Dashboard.MaintainCountToday}} maintain order</strong>
                                    </div> 
                                    <div class="numItem column" style="text-align:right;">
                                        <strong>{{Dashboard.MaintainCountTodayQItem}}</strong> items
                                    </div>
                                </div>
                                
                                <div class="contentstatus" style="padding: 0.5rem">
                                    
                                </div>    
                            </div>
                            <div class="row3child material-shadow-animate1">                            
                                <div class="headerstatus columns"  style="padding: 0.5rem 0 0.5rem 0">
                                    <div class="column">
                                        <strong>Tomorrow: {{Dashboard.MaintainCountTomorrow}} maintain order</strong>
                                    </div> 
                                    <div class="numItem column" style="text-align:right;">
                                        <strong>{{Dashboard.MaintainCountTomorrowQItem}}</strong> items
                                    </div>
                                </div>
                                
                                <!-- <div class="contentstatus" style="padding: 0.5rem">
                                     <bar></bar> 
                                </div>     -->
                            </div>

                        </div>
                    </div>
                    <div class="column" style="padding: 0 !important">
                        <div class="row3childs">
                            <div style="font-size:17px; margin:0.8rem 0rem 0.8rem 0rem;">
                                <strong>Returns</strong>
                            </div>
                            <div class="row3child material-shadow-animate1">                            
                                <div class="headerstatus columns"  style="padding: 0.5rem 0 0.5rem 0">
                                    <div class="column is-9">
                                        <strong>Today: {{Dashboard.ReturnCountToday}} orders to be returned</strong>
                                    </div> 
                                    <div class="numItem column" style="text-align:right;">
                                        <strong>{{Dashboard.ReturnCountTodayQItem}}</strong> items
                                    </div>
                                </div>
                                
                                <div class="contentstatus" style="padding: 0.5rem">
                                    
                                </div>    
                            </div>
                            <div class="row3child material-shadow-animate1">                            
                                <div class="headerstatus columns"  style="padding: 0.5rem 0 0.5rem 0">
                                    <div class=" column is-9">
                                        <strong>Tomorrow: {{Dashboard.ReturnCountTomorrow}} orders to be returned</strong>
                                    </div> 
                                    <div class="numItem column" style="text-align:right;">
                                        <strong>{{Dashboard.ReturnCountTomorrowQItem}}</strong> items
                                    </div>
                                </div>
                                
                                <div class="contentstatus" style="padding: 0.5rem">
                                    
                                </div>    
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import Server from "@/config/config.js";
import BarChart from "../../components/chartTest/bar-chart.js";
import PieChart from "../../components/chartTest/pie-chart.js";

export default {
  components: {
    BarChart,
    PieChart
  },
  created() {
    let URL = Server.DASHBOARD_API_PATH;
    this.axios.get(URL).then(res => {
      if (res.status == 200) {
        // alert("alao alo");
        let data = res.data;
        this.Dashboard = data.Dashboard;
        this.pieChartData.labels.push(data.PieChartData.Availble.Name);
        this.pieChartData.labels.push(data.PieChartData.WokingRequesting.Name);
        this.pieChartData.labels.push(
          data.PieChartData.MaintainanceRequesting.Name
        );
        this.pieChartData.labels.push(data.PieChartData.Working.Name);
        this.pieChartData.labels.push(data.PieChartData.Damaged.Name);
        this.pieChartData.labels.push(data.PieChartData.Maintaining.Name);
        this.pieChartData.labels.push(data.PieChartData.Lost.Name);

        this.pieChartData.values.push(data.PieChartData.Availble.Quantity);
        this.pieChartData.values.push(
          data.PieChartData.WokingRequesting.Quantity
        );
        this.pieChartData.values.push(
          data.PieChartData.MaintainanceRequesting.Quantity
        );
        this.pieChartData.values.push(data.PieChartData.Working.Quantity);
        this.pieChartData.values.push(data.PieChartData.Damaged.Quantity);
        this.pieChartData.values.push(data.PieChartData.Maintaining.Quantity);
        this.pieChartData.values.push(data.PieChartData.Lost.Quantity);

        // line chart data - start
        this.lineChartData.workingLabel = data.LineChart.WorkingName;
        this.lineChartData.maintainLabel = data.LineChart.MaintainName;

        // months labels
        this.lineChartData.monthLabels.push(data.LineChart.Month.Last11Month);
        this.lineChartData.monthLabels.push(data.LineChart.Month.Last10Month);
        this.lineChartData.monthLabels.push(data.LineChart.Month.Last9Month);
        this.lineChartData.monthLabels.push(data.LineChart.Month.Last8Month);
        this.lineChartData.monthLabels.push(data.LineChart.Month.Last7Month);
        this.lineChartData.monthLabels.push(data.LineChart.Month.Last6Month);
        this.lineChartData.monthLabels.push(data.LineChart.Month.Last5Month);
        this.lineChartData.monthLabels.push(data.LineChart.Month.Last4Month);
        this.lineChartData.monthLabels.push(data.LineChart.Month.Last3Month);
        this.lineChartData.monthLabels.push(data.LineChart.Month.Last2Month);
        this.lineChartData.monthLabels.push(data.LineChart.Month.LastMonth);
        this.lineChartData.monthLabels.push(data.LineChart.Month.ThisMonth);

        this.lineChartData.monthData.maintain.push(
          data.LineChart.Maintain.Last11Month
        );
        this.lineChartData.monthData.maintain.push(
          data.LineChart.Maintain.Last10Month
        );
        this.lineChartData.monthData.maintain.push(
          data.LineChart.Maintain.Last9Month
        );
        this.lineChartData.monthData.maintain.push(
          data.LineChart.Maintain.Last8Month
        );
        this.lineChartData.monthData.maintain.push(
          data.LineChart.Maintain.Last7Month
        );
        this.lineChartData.monthData.maintain.push(
          data.LineChart.Maintain.Last6Month
        );
        this.lineChartData.monthData.maintain.push(
          data.LineChart.Maintain.Last5Month
        );
        this.lineChartData.monthData.maintain.push(
          data.LineChart.Maintain.Last4Month
        );
        this.lineChartData.monthData.maintain.push(
          data.LineChart.Maintain.Last3Month
        );
        this.lineChartData.monthData.maintain.push(
          data.LineChart.Maintain.Last2Month
        );
        this.lineChartData.monthData.maintain.push(
          data.LineChart.Maintain.LastMonth
        );
        this.lineChartData.monthData.maintain.push(
          data.LineChart.Maintain.ThisMonth
        );

        this.lineChartData.monthData.working.push(
          data.LineChart.Working.Last11Month
        );
        this.lineChartData.monthData.working.push(
          data.LineChart.Working.Last10Month
        );
        this.lineChartData.monthData.working.push(
          data.LineChart.Working.Last9Month
        );
        this.lineChartData.monthData.working.push(
          data.LineChart.Working.Last8Month
        );
        this.lineChartData.monthData.working.push(
          data.LineChart.Working.Last7Month
        );
        this.lineChartData.monthData.working.push(
          data.LineChart.Working.Last6Month
        );
        this.lineChartData.monthData.working.push(
          data.LineChart.Working.Last5Month
        );
        this.lineChartData.monthData.working.push(
          data.LineChart.Working.Last4Month
        );
        this.lineChartData.monthData.working.push(
          data.LineChart.Working.Last3Month
        );
        this.lineChartData.monthData.working.push(
          data.LineChart.Working.Last2Month
        );
        this.lineChartData.monthData.working.push(
          data.LineChart.Working.LastMonth
        );
        this.lineChartData.monthData.working.push(
          data.LineChart.Working.ThisMonth
        );
        // line chart data - end
      }
    });
  },
  data() {
    return {
      Dashboard: null,
      pieChartData: {
        labels: [],
        values: []
      },
      lineChartData: {
        workingLabel: "",
        maintainLabel: "",
        monthLabels: [],
        monthData: {
          working: [],
          maintain: []
        }
      }
    };
  }
};
</script>

<style scoped>
.dashboard-tile {
  /* border: 1px solid #bdbdbd; */
  height: 200px;
  width: 100%;
  margin-bottom: 20px;
}

.dashboard-tile-title {
  border-bottom: 1px solid #e0e0e0;
  padding: 10px 15px 10px 15px;
}

.dashboard-tile-content {
  padding: 10px 15px 10px 15px;
}
.viewgraph {
  background-color: white;
  width: 100%;
  margin: 0.3rem;
  padding: 1rem;
}
.statusworkorder {
  background-color: #fafafa;
  width: 100%;
  margin: 0.3rem;
  margin-right: 0.3rem !important;

  padding: 0rem;
}
.titlediv {
  font-size: 15px;
  margin-bottom: 0.3rem;
}
.status {
  background-color: white;
  margin-right: 1.2rem;
}

.status:hover {
  cursor: pointer;
}
.headerstatus {
  border-bottom: 1px #cfd8dc solid;
  background-color: #f5f5f5;
}
p {
  text-align: center;
}
.divrow3 {
  background-color: #fafafa;
  width: 100%;
  margin: 0.3rem;
}
.workordergraph {
  background-color: white;
  margin-right: 1rem;
  height: 250px !important;
}

.row3childs {
  display: grid;
  grid-row-gap: 1rem;
}

.row3child {
  background-color: white;
  padding: 0.7rem 1rem 0.3rem 1rem;
  height: 250px !important;
}
.Chart {
  background: #ffffff;
  /* background: #1e5ad1; */
  border-radius: 0px;
  box-shadow: 0px 2px 15px rgba(25, 25, 25, 0.27);
  /* margin: 25px 0; */
  margin: 0em !important;
  padding: 1rem;
}
.Chart1 {
  /* background: #212733; */
  background: #ffffff;
  border-radius: 0px;
  box-shadow: 0px 2px 15px rgba(25, 25, 25, 0.27);
  /* margin: 25px 0; */
  margin: 0em !important;
  padding: 1rem;
}
.Chart h2 {
  margin-top: 0;
  padding: 15px 0;
  color: rgba(255, 0, 0, 0.5);
  border-bottom: 1px solid #323d54;
}
.material-shadow-animate {
  box-shadow: 0px 2px 15px rgba(25, 25, 25, 0.27) !important;
  transition: all 0.2s ease-in-out;
}
.material-shadow-animate:hover {
  box-shadow: 1px 4px 30px rgba(25, 25, 25, 0.27) !important;
}
.material-shadow-animate1 {
  box-shadow: 0px 2px 15px rgba(25, 25, 25, 0.27) !important;
  transition: all 0.2s ease-in-out;
}
</style>
