<template>
    <div>
        <div>
            <div class="viewgraph columns">
                <div class=" workordergraph column">
                <div class="titlediv">
                    <strong>Number of Work Order Completed</strong>
                    <strong> {{Dashboard.Requested}}</strong>
                </div>
                <div>
                    <img :src="require('@/assets/linegraph.png')" style="width:100%; height: 200px"/>
                </div>
                </div>
                <div class="workordergraph column">
                    <div class="titlediv">
                        <strong>Work Order by Category</strong>
                    </div>
                    <div>
                        <img :src="require('@/assets/piegraph.jpg')" style="width:100%; height: 200px"/>
                    </div>
                </div>
            </div>
            <div class="statusworkorder columns">
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
                        <p style="color: var(--status-checked); font-size:38px; text-align: center;font-weight: bold;">{{Dashboard.Approve}}</p>
                        <p style="font-size:15px;">Work Orders</p>
                    </div>
                </div>
                                <div class="status column">
                    <div class="headerstatus columns">
                        <div style="width:40%" class="column">
                        <strong>In Progress</strong>
                        </div>

                    </div>
                    <div class="contentstatus">
                        <p style="color: var(--status-checked); font-size:38px; text-align: center;font-weight: bold;">{{Dashboard.InProgress}}</p>
                        <p style="font-size:15px;">Work Orders</p>
                    </div>
                </div>
                <div class="status column">
                    <div class="headerstatus columns">
                        <div style="width:40%" class="column">
                        <strong>Closed</strong>
                        </div>

                    </div>
                    <div class="contentstatus">
                        <p style="color: var(--status-approved); font-size:38px; text-align: center;font-weight: bold;">{{Dashboard.Closed}}</p>
                        <p style="font-size:15px;">Work Orders</p>
                    </div>
                </div>
                <div class="status column">
                    <div class="headerstatus columns">
                        <div style="width:40%;" class="column">
                        <strong>Rejected</strong>
                        </div>


                    </div>
                    <div class="contentstatus">
                        <p style="color: var(--status-delivered); font-size:38px; text-align: center;font-weight: bold;">{{Dashboard.Rejected}}</p>
                        <p style="font-size:15px;">Work Orders</p>
                    </div>
                </div>
                <div class="status column" style="margin-right:0 !important">
                    <div class="headerstatus columns">
                        <div style="width:40%" class="column">
                        <strong>Cancelled</strong>
                        </div>

                    </div>
                    <div class="contentstatus">
                        <p style="color: var(--status-closed); font-size:38px; text-align: center;font-weight: bold;">{{Dashboard.Cancelled}}</p>
                        <p style="font-size:15px;">Work Orders</p>
                    </div>
                </div>
                
            </div>
            <div class="divrow3 columns" style="margin-right:0rem !important">
                <div class="column" style="padding: 0 !important; margin-right:1.3rem;">
                    <div class="row3childs">
                        <div style="font-size:17px; margin:0.8rem 0rem 0.8rem 0rem;">
                            <strong>Maintain</strong>
                        </div>
                        <div class="row3child">                            
                            <div class="headerstatus columns"  style="padding: 0.5rem 0 0.5rem 0">
                                <div class="column">
                                    <strong>Today: 2 maintain order</strong>
                                </div> 
                                <div class="numItem column" style="text-align:right;">
                                    <strong>5</strong> items
                                </div>
                            </div>
                            
                            <div class="contentstatus" style="padding: 0.5rem">
                                
                            </div>    
                        </div>
                         <div class="row3child">                            
                            <div class="headerstatus columns"  style="padding: 0.5rem 0 0.5rem 0">
                                <div class="column">
                                    <strong>Tomorrow: 2 maintain order</strong>
                                </div> 
                                <div class="numItem column" style="text-align:right;">
                                    <strong>4</strong> items
                                </div>
                            </div>
                            
                            <div class="contentstatus" style="padding: 0.5rem">
                                
                            </div>    
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
                                    <strong>Today: 2 orders to be returned</strong>
                                </div> 
                                <div class="numItem column" style="text-align:right;">
                                    <strong>5</strong> items
                                </div>
                            </div>
                            
                            <div class="contentstatus" style="padding: 0.5rem">
                                
                            </div>    
                        </div>
                         <div class="row3child">                            
                            <div class="headerstatus columns"  style="padding: 0.5rem 0 0.5rem 0">
                                <div class=" column is-9">
                                    <strong>Tomorrow: 2 orders to be returned</strong>
                                </div> 
                                <div class="numItem column" style="text-align:right;">
                                    <strong>4</strong> items
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
</template>

<script>
import Server from "@/config/config.js";
export default {
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
  width: 14.28%;
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
</style>
