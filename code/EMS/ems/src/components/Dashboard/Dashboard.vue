<template>
    <div>
        <div>
            <div class="" style="width: 100%; margin-bottom: 1rem">
            <!-- <div class="viewgraph " > -->
                <!-- line chart -->
                    <strong>Number of Work Order Completed</strong>
                    <div style="width:100%" class="Chart">
                        <bar-chart styles="height: 40vh" ref="canvas"></bar-chart>
                    </div>
            </div> <!-- line chart -->
            <div>
                <div class="row">
                    <!-- test -->
                    <div class="col-6 ">
                        <div class="statusworkorder row">
                            <div class="row col-12" style="margin-bottom: 1rem">
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
                            </div>
                            <div class="row col-12" >
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
                                <div class="status column" >
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
                                <div class="titlediv">
                                    <strong>Work Order by Category</strong>
                                </div>

                                      <!-- <div style="width:100%" class="Chart">
                        <doughnut-chart styles="height: 40vh" ref="canvas"></doughnut-chart>
                    </div>  -->
                  
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
                    <div class="column" style="padding: 0 !important; margin-right:1.3rem;">
                        <div class="row3childs">
                            <div style="font-size:17px; margin:0.8rem 0rem 0.8rem 0rem;">
                                <strong>Maintain</strong>
                            </div>
                            <div class="row3child">                            
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
                            <div class="row3child">                            
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
                            <div class="row3child">                            
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
                            <div class="row3child">                            
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
// import PieChart from "../../components/chartTest/pie-chart.js.js";

export default {
  components: {
    BarChart
    // PieChart
  },
  created() {
    let URL = Server.DASHBOARD_API_PATH;
    this.axios.get(URL).then(res => {
      // alert("alao alo");
      let data = res.data;
      this.Dashboard = data.Dashboard;
    });
  },
  data() {
    return {
      Dashboard: null
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
  margin-top: 1rem;
  padding: 0rem;
}
.titlediv {
  font-size: 15px;
  margin-bottom: 0.3rem;
}
.status {
  /* width: 25%; */
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
  background: #212733;
  border-radius: 15px;
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
</style>
