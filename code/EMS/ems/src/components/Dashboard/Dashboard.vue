<template>
    <div>
        <div>
            <div class="viewgraph">
                <div class="titlediv">
                    <strong>Number of Work Order Completed</strong>
                </div>
                <div>
                    <img :src="require('@/assets/linegraph.png')" style="width:100%; height: 200px"/>
                </div>
            </div>
            <div class="statusworkorder columns">
                <div class="status column">
                    <div class="headerstatus columns">
                        <div style="width:40%" class="column">
                        <strong>Request</strong>
                        </div>
                        <div class="column" style="width:30%">
                            <div class="control">
                                <div class="select is-small">
                                <select class="is-hovered">
                            <option>All time</option>
                            <option>This year</option>
                            <option>This month</option>
                            <option>This week</option>
                            <option>Today</option>
                            <option>Yesterday</option>
                            <option>Last week</option>
                            <option>Last month</option>
                            <option>Last year</option>  
                                </select>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="contentstatus">
                        <p style="color: var(--status-request); font-size:38px; text-align: center;font-weight: bold;">3</p>
                        <p style="font-size:15px;" >Work Orders</p>
                    </div>
                </div>
                <div class="status column">
                    <div class="headerstatus columns">
                        <div style="width:40%" class="column">
                        <strong>Checked</strong>
                        </div>
                        <div class="column" style="width:30%">
                            <div class="control">
                                <div class="select is-small">
                                <select class="is-hovered">
                                <option>All time</option>
                            <option>This year</option>
                            <option>This month</option>
                            <option>This week</option>
                            <option>Today</option>
                            <option>Yesterday</option>
                            <option>Last week</option>
                            <option>Last month</option>
                            <option>Last year</option>  
                                </select>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="contentstatus">
                        <p style="color: var(--status-checked); font-size:38px; text-align: center;font-weight: bold;">3</p>
                        <p style="font-size:15px;">Work Orders</p>
                    </div>
                </div>
                <div class="status column">
                    <div class="headerstatus columns">
                        <div style="width:40%" class="column">
                        <strong>Approved</strong>
                        </div>
                        <div class="column" style="width:30%">
                            <div class="control">
                                <div class="select is-small">
                                <select class="is-hovered">
                                <option>All time</option>
                            <option>This year</option>
                            <option>This month</option>
                            <option>This week</option>
                            <option>Today</option>
                            <option>Yesterday</option>
                            <option>Last week</option>
                            <option>Last month</option>
                            <option>Last year</option>  
                                </select>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="contentstatus">
                        <p style="color: var(--status-approved); font-size:38px; text-align: center;font-weight: bold;">3</p>
                        <p style="font-size:15px;">Work Orders</p>
                    </div>
                </div>
                <div class="status column">
                    <div class="headerstatus columns">
                        <div style="width:40%;" class="column">
                        <strong>Delivered</strong>
                        </div>
                        <div class="column" style="width:30%">
                            <div class="control">
                                <div class="select is-small">
                                <select class="is-hovered">
                                <option>All time</option>
                            <option>This year</option>
                            <option>This month</option>
                            <option>This week</option>
                            <option>Today</option>
                            <option>Yesterday</option>
                            <option>Last week</option>
                            <option>Last month</option>
                            <option>Last year</option>  
                                </select>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="contentstatus">
                        <p style="color: var(--status-delivered); font-size:38px; text-align: center;font-weight: bold;">3</p>
                        <p style="font-size:15px;">Work Orders</p>
                    </div>
                </div>
                <div class="status column">
                    <div class="headerstatus columns">
                        <div style="width:40%" class="column">
                        <strong>Closed</strong>
                        </div>
                        <div class="column" style="width:30%">
                            <div class="control">
                                <div class="select is-small">
                                <select class="is-hovered">
                                <option>All time</option>
                            <option>This year</option>
                            <option>This month</option>
                            <option>This week</option>
                            <option>Today</option>
                            <option>Yesterday</option>
                            <option>Last week</option>
                            <option>Last month</option>
                            <option>Last year</option>  
                                </select>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="contentstatus">
                        <p style="color: var(--status-closed); font-size:38px; text-align: center;font-weight: bold;">3</p>
                        <p style="font-size:15px;">Work Orders</p>
                    </div>
                </div>
                
            </div>
            <div class="divrow3 columns" style="margin-right:0rem !important">
                <div class="workordergraph column">
                    <div class="titlediv">
                        <strong>Work Order by Category</strong>
                    </div>
                    <div>
                        <img :src="require('@/assets/piegraph.jpg')" style="width:100%; height: 200px"/>
                    </div>
                </div>
                <div class="column" style="padding: 0 !important">
                    <div class="row3childs">
                        <div class="row3child">
                            <div class="headerstatus" style="padding: 0.5rem 0 0.5rem 0">
                                <strong>Reservations</strong>
                            </div>
                            <div class="contentstatus" style="padding: 0.5rem">
                                <p style="color: var(--shadow); font-size:38px; text-align: center;font-weight: bold;">2</p>
                                <p style="font-size:15px;">Overdue</p>
                            </div>                    
                            <div class="contentstatus">
                                <p style="color: var(--status-approved); font-size:38px; text-align: center;font-weight: bold;">0</p>
                                <p style="font-size:15px;">Booked</p>
                            </div>
                        </div>
                        <div class="row3child">
                            <div class="headerstatus" style="padding: 0.5rem 0 0.5rem 0">
                                <strong>Check-out</strong>
                            </div>
                            <div class="contentstatus" style="padding: 0.5rem">
                                <p style="color: var(--shadow); font-size:38px; text-align: center;font-weight: bold;">5</p>
                                <p style="font-size:15px;">Overdue</p>
                            </div>                    
                            <div class="contentstatus">
                                <p style="color: var(--status-approved); font-size:38px; text-align: center;font-weight: bold;">0</p>
                                <p style="font-size:15px;">Closed</p>
                            </div>
                        </div>
                        <div class="row3child" style="margin-right: 0rem !important">
                            <div class="headerstatus" style="padding: 0.5rem 0 0.5rem 0">
                                <strong>Maintenance bookings</strong>
                            </div>
                            <div class="contentstatus" style="padding: 0.5rem">
                                <p style="color: var(--shadow); font-size:38px; text-align: center;font-weight: bold;">0</p>
                                <p style="font-size:15px;">In progress</p>
                            </div>                    
                            <div class="contentstatus">
                                <p style="color: var(--shadow); font-size:38px; text-align: center;font-weight: bold;">1</p>
                                <p style="font-size:15px;">Planned</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {};
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
  width: 18.7%;
  background-color: white;
  margin-right: 1.2rem;
}

.status:hover {
  cursor: pointer;
}
.headerstatus {
  border-bottom: 1px #cfd8dc solid;
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
  width: 10%;
  background-color: white;
  margin-right: 1rem;
  height: 250px !important;
}

.row3childs {
  display: grid;
  grid-template-columns: 31% 31% 38%;
}

.row3child {
  background-color: white;
  margin-right: 1rem;
  padding: 0.5rem;
  height: 250px !important;
}
</style>
