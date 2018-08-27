<template>
    <div v-if="Dashboard">
        <div>
            <div class="row " style="width: 100%; margin-bottom: 1rem; margin-right: 0rem ; margin-left:0rem !important">
              <div class="col-8" style="padding-left:0Rem !important">
                <!-- line chart -->
                <div  class="Chart col-12">
                  <!-- <div class="select">
                    <select v-model="linechartOption" class="select">                      
                      <option value="order">Work aaa</option> 
                      <option value="eqt">Equipment</option>
                    </select>
                  </div>-->
                  <div>
                    <label class="radio" v-on:click="linechartOption = true">
                      <input type="radio" name="status" style="padding-right:0.5rem" :checked="linechartOption"> Completed Work Orders
                    </label>
                    <label class="radio" v-on:click="linechartOption = false">
                      <input type="radio" name="status" style="padding-right:0.5rem" :checked="!linechartOption"> Damaged and Lost Equipment
                    </label>
                  </div>
                    <bar-chart :chartData="lineChartData" ref="lineChart" :styles="{height: '40vh'}"  ></bar-chart>
                  <div style="margin-top: 1rem; color: #424242; font-size: 1rem; text-align: center; font-style: italic;">
                    <div v-if="linechartOption">
                      Number of Completed Work Orders chart from the past 1 year.
                    </div>
                    <div v-else>
                      Number of Damaged and Lost Equipment chart from the past 1 year.
                    </div>  
                  </div> 

                </div>
                <!-- line chart- end -->
              </div>
              <div class="col-4" style="padding:0rem !important">  
                <div id="header-mainCalen">
                  Maintenance Calendar
                </div>       
                <div>
                  <v-calendar :attributes='attrs' @dayclick='dayClicked' style="width: 100% !important; height:48vh">                    
                  </v-calendar>
                </div>                       
                    <!-- <doughnut-chart :data="doughnutChartData" styles="height: 36vh"></doughnut-chart> -->
              </div>                
              </div>
            </div> 
            <!-- <div class="col-12 row">
                <div class="col-6">&#8203</div>
                <div class="col-6" style="padding-left:2rem"><strong>Equipment items by status</strong></div>
            </div> -->
            <div>
                <div style="margin-top: 2rem !important;" class="row">
                    <!-- test -->
                    <div class="col-6 " style="padding-left: 0.3rem !important; padding-right: 0rem !important">

                            <!-- <div class="row col-12" style="margin-bottom: 1rem;padding-right: 0px; padding-left: 25px !important"> -->
                          <div class="row col-12" style="margin-bottom: 0.5rem;  padding-right: 0px; padding-left: 25px !important">
                            <div class="status column material-shadow-animate" @click="() => {
                                $store.state.workOrderPage.initialLoad = true;
                                $store.state.workOrderPage.statusFromDashBoard = 'Requested';
                                $store.state.workOrderPage.options = {
                                  priorities: [],
                                  status: []
                                };
                                $store.state.workOrderPage.filterOptionsValues = {
                                  priorities: [],
                                  status: []
                                };
                                $router.push('/work_order');
                              }">
                              <div class="headerstatus columns">
                                <div style="width:40%" class="column">
                                  <strong>Requested</strong>
                                </div>
                              </div>
                              <div class="contentstatus1" >
                                  <p style="color: #F44336; font-size:38px; text-align: center;font-weight: bold;">{{Dashboard.Requested}}</p>
                                  <p style="font-size:15px;" >Work Orders</p>
                              </div>
                            </div>
                            <div class="status column material-shadow-animate" style="margin-right: 0rem !important" @click="() => {
                                $store.state.workOrderPage.initialLoad = true;
                                $store.state.workOrderPage.statusFromDashBoard = 'Checked';
                                $store.state.workOrderPage.options = { 
                                  priorities: [],
                                  status: []
                                };
                                $store.state.workOrderPage.filterOptionsValues = {
                                  priorities: [],
                                  status: []
                                };
                                $router.push('/work_order');
                              }">
                              <div class="headerstatus columns">
                                <div style="width:40%" class="column">
                                  <strong>Checked</strong>
                                </div>
                              </div>
                              <div class="contentstatus1 ">
                                <p style="color: #1E88E5; font-size:38px; text-align: center;font-weight: bold;">{{Dashboard.Checked}}</p>
                                <p style="font-size:15px;">Work Orders</p>
                              </div>
                            </div>
                          </div>
                          <div class="row col-12" style="margin-bottom: 0.5rem;  padding-right: 0px; padding-left: 25px !important">
                            <div class="status column material-shadow-animate" @click="() => {
                                $store.state.workOrderPage.initialLoad = true;
                                $store.state.workOrderPage.statusFromDashBoard = 'Approved';
                                $store.state.workOrderPage.options = { 
                                  priorities: [],
                                  status: []
                                };
                                $store.state.workOrderPage.filterOptionsValues = {
                                  priorities: [],
                                  status: []
                                };
                                $router.push('/work_order');
                              }">
                              <div class="headerstatus columns">
                                <div style="width:40%" class="column">
                                  <strong>Approved</strong>
                                </div>
                              </div>
                              <div class="contentstatus1">
                                <p style="color: #00BFA5; font-size:38px; text-align: center;font-weight: bold;">{{Dashboard.Approve}}</p>
                                <p style="font-size:15px;">Work Orders</p>
                              </div>
                            </div>
                            <div class="status column material-shadow-animate" style="margin-right: 0rem !important" @click="() => {
                                $store.state.workOrderPage.initialLoad = true;
                                $store.state.workOrderPage.statusFromDashBoard = 'In Progress';
                                $store.state.workOrderPage.options = { 
                                  priorities: [],
                                  status: []
                                };
                                $store.state.workOrderPage.filterOptionsValues = {
                                  priorities: [],
                                  status: []
                                }
                                $router.push('/work_order');
                              }">
                              <div class="headerstatus columns">
                                <div style="width:40%" class="column">
                                  <strong>In Progress</strong>
                                </div>
                              </div>
                              <div class="contentstatus1" >
                                <p style="color: #673AB7; font-size:38px; text-align: center;font-weight: bold;">{{Dashboard.InProgress}}</p>
                                <p style="font-size:15px; ">Work Orders</p>
                              </div>
                            </div>
                          </div>                            
                        </div>

                    <!-- /test -->

                        <div class="col-6 " style="padding-left: 0rem !important">
                            <!-- <div class="workordergraph viewgraph"> -->
                                <!-- <div class="titlediv">
                                    <strong>Equipment items by status</strong>
                                </div> -->

                        <div style="width:100%" class="Chart1">
                            <strong>Equipment by status</strong>  
                            <pie-chart :styles="{height: '16rem'}" :chartData="pieChartData" :onClickChart="displayEquipmentStatusPopup" ></pie-chart>
                        </div>
                  
                        </div>
                </div >                
                <div v-if="authUser.Role == 'Equipment Staff' || authUser.Role == 'Manager' " class=" row" style="margin-top: 1.5rem">
                  <div class="col-6" style="margin-bottom: 0rem"><strong>Working Order</strong></div>
                  <div class="col-6" style="padding-left: 0; margin-bottom: 0rem"><strong>Maintenance Order</strong></div>
                  <div class="divrow3 columns " style="margin-right:0rem !important">
                    <div class="col-6" style="padding: 0 1rem 0 0.7rem  !important; margin-right: 0rem ">
                              <div class=" material-shadow-animate1" style="margin-bottom: 1rem; background-color:#F5F5F5 !important">                            
                                  <div class="headerstatus1 col-12 row"  style="padding: 0.5rem 0rem 0.5rem 0; margin-left:0px;">
                                      <div class="column is-10">
                                          <!-- <strong>Today: {{Dashboard.ReturnCountToday}} orders to be returned</strong> -->
                                          <strong>Today: {{Dashboard.ReturnCountTodayQItem}} equipment to be returned</strong>
                                      </div> 
                                      <div class="numItem column" style="text-align:right;">
                                          <strong>{{Dashboard.ReturnCountToday}}</strong> orders 
                                      </div>
                                  </div>
                                  <div class="contentstatus" style="padding: 0.2rem;" >
                                          <!-- chow- start -->
                                          <div class="order-blocks">
                                              <div>
                                          
                                                  <div class="emtpy-text" v-if="workOrdersWokingToday && workOrdersWokingToday.length == 0">
                                                      There is no orders to display.
                                                  </div>
                                                  <div v-else>                                                    
                                                      <order-block :key="'order' + order.Id" :order="order"  v-for="order in workOrdersWokingToday" @click.native="$router.push(`/work_order/${order.Id}`)" ></order-block>
                                                  </div>
                                              </div>
                                          </div>
                                          <!-- chow-end -->
                                  </div>  
                              </div>
                              <div class=" material-shadow-animate1" style="margin-bottom: 1rem; background-color:#F5F5F5 !important">                            
                                  <div class="headerstatus1 col-12 row"  style="padding: 0.5rem 0rem 0.5rem 0; margin-left:0px;">
                                      <div class=" column is-10">
                                          <!-- <strong>Tomorrow: {{Dashboard.ReturnCountTomorrow}} orders to be returned</strong> -->
                                          <strong>Tomorrow: {{Dashboard.ReturnCountTomorrowQItem}} equipment to be returned</strong>
                                      </div> 
                                      <div class="numItem column" style="text-align:right;">
                                          <strong>{{Dashboard.ReturnCountTomorrow}}</strong> orders 
                                      </div>
                                  </div>                                  
                                  <div class="contentstatus" style="padding: 0.2rem;" >                                    
                                          <div class="order-blocks">
                                              <div>
                                                  <div class="emtpy-text" v-if="workOrdersWokingTomorrow && workOrdersWokingTomorrow.length == 0">
                                              
                                                      There is no orders to display.
                                                  </div>
                                                  <div v-else>
                                                      <order-block :key="'order' + order.Id" :order="order"  v-for="order in workOrdersWokingTomorrow" @click.native="$router.push(`/work_order/${order.Id}`)"></order-block>
                                                  </div>
                                              </div>
                                          </div>
                                          <!-- chow-end -->
                                  </div>   
                              </div>
                      </div>
                      <div class="column " style="padding: 0 !important; " >

                          <div class="row3childs">
                          <!-- <div> -->
                              <!-- <div style="font-size:17px; margin:0.8rem 0rem">
                                  <strong>Maintain</strong>
                              </div> -->
                              <div class=" material-shadow-animate1 " style="margin-bottom: 1rem; margin-right: 0.9rem; background-color:#F5F5F5 !important">                            
                                  <div class="headerstatus1 col-12 row"  style="padding: 0.5rem 0rem 0.5rem 0; margin-left:0px;">
                                      <div class="column is-10">
                                          <!-- <strong>Today: {{Dashboard.MaintainCountToday}} order to be returned</strong> -->
                                          <strong>Today: {{Dashboard.MaintainCountTodayQItem}} equipment to be returned</strong>
                                      </div> 
                                      <div class="numItem column" style="text-align:right;">
                                          <strong>{{Dashboard.MaintainCountToday}}</strong> orders 
                                      </div>
                                  </div>                                  
                                  <div class="contentstatus" style="padding: 0.2rem;" >                                   
                                          <div class="order-blocks">
                                              <div>
                                                  <div class="emtpy-text" v-if="workOrders && workOrders.length == 0" >
                                                      There is no orders to display.
                                                  </div>
                                                  <div v-else>
                                                      <order-block :key="'order' + order.Id" :order="order"  v-for="order in workOrders" @click.native="$router.push(`/work_order/${order.Id}`)"></order-block>
                                                  </div>
                                              </div>
                                          </div>
                                          <!-- chow-end -->
                                  </div>    
                              </div>
                              <div class=" material-shadow-animate1" style="margin-bottom: 1rem; margin-right: 0.9rem; background-color:#F5F5F5 !important">                            
                                  <div class="headerstatus1 col-12 row"  style="padding: 0.5rem 0rem 0.5rem 0; margin-left:0px;">
                                      <div class="column is-10">
                                          <!-- <strong>Tomorrow: {{Dashboard.MaintainCountTomorrow}} order to be returned</strong> -->
                                          <strong>Tomorrow: {{Dashboard.MaintainCountTomorrowQItem}} equipment to be returned</strong>
                                      </div> 
                                      <div class="numItem column" style="text-align:right;">
                                          <strong>{{Dashboard.MaintainCountTomorrow}}</strong> orders
                                      </div>
                                  </div>                                  
                                  <div class="contentstatus" style="padding: 0.2rem;" >                                                                       
                                          <div class="order-blocks">
                                              <div>

                                                  <div class="emtpy-text" v-if="workOrdersMaintainTomorrow && workOrdersMaintainTomorrow.length == 0">
                                                      There is no orders to display.
                                                  </div>
                                                  <div v-else>
                                                      <order-block :key="'order' + order.Id" :order="order"  v-for="order in workOrdersMaintainTomorrow" @click.native="$router.push(`/work_order/${order.Id}`)"></order-block>
                                                  </div>
                                              </div>
                                          </div>
                                          <!-- chow-end -->
                                  </div>  
                              </div>
                          </div>
                      </div>
                  </div>                
                </div>  
            </div>
            <modal :width="600" v-model="addPopUp" v-if="this.maintainItems.length > 0" :styles="{top: '20px'}">
              <div slot="header" class="title-modal"> 
                List Of Maintain Equipment: {{this.selectedDay.day}}-{{this.selectedDay.month}}-{{this.selectedDay.year}}
              </div>
              <div style="max-height: 70vh; overflow-y: auto;">
                <table style="width:100%"> 
                  <thead>
                    <tr style="width:100%">
                      <th><strong>Equipment</strong></th>
                      <th><strong>Serial #</strong></th>   
                      <th><strong>Last MaintainDate</strong></th>                                            
                    </tr>                
                  </thead>
                  <tbody style="font-size:14px" >                
                    <tr :key="item.Id" v-for="item in maintainItems">
                      <td>{{item.Name}}</td>                                        
                      <td>{{item.SerialNumber}}</td>
                      <td>{{item.LastMaintainDate}}</td>
                    </tr>
                  </tbody>
              </table>   
              </div>

              <div slot="footer"><button class="button" v-on:click="addPopUp = false" style="background-color:var(--primary-color);color:white">OK</button></div>
            </modal>
            <modal style="font-size: 1rem !important;" :styles="equipmentByStatusList.length > 6 ? {top: '20px'} : {}" v-model="showEquipmentByStatusPopup">
              <div slot="header">
                <span v-if="equipmentStatusFromChart">{{ equipmentStatusFromChart }} equipment</span>
              </div>
              <div slot="footer">
                <button style="width: 4rem;" class="button btn-primary" @click="showEquipmentByStatusPopup = false">OK</button>
              </div>
              <div v-if="equipmentByStatusList && equipmentByStatusList.length" style="padding: 0 .5rem;" :style="equipmentByStatusList.length > 6 ? 'max-height: 70vh; overflow-y: auto;' : ''">
                <v-flex style="font-size: 1rem !important;">
                  <v-expansion-panel popout>
                    <v-expansion-panel-content v-for="equipment in equipmentByStatusList" :key="'equipment' + equipment.Id" v-if="equipment.EquipmentItems">
                      <div slot="header">
                        <div style="display: grid; grid-template-columns: 25% auto;">
                          <div style="display: flex">
                            <img v-show="equipment.Image" :src="equipment.Image" :alt="equipment.Name" style="width: 3rem; height: 3rem;">
                          </div>
                          <div style="display: grid; grid-template-rows: auto auto;">
                            <div>
                              {{ equipment.Name.trim() }}
                            </div>                                            
                            <div style="font-size: .9rem">
                              Quantity: {{ equipment.EquipmentItems.length }} {{ equipment.Unit }}
                            </div>
                          </div>
                        </div>
                      <div>
                    </div>
                  </div>
                  <v-card style="border: 0" v-for="item in equipment.EquipmentItems" :key="'equipmentItems' + item.Id">
                    <v-card-text style="font-size: .9rem">
                      <div>
                        Serial #: <strong>{{ item.SerialNumber }}</strong>, warehouse: <strong>{{ item.Warehouse.Name }}</strong>
                      </div>
                      <div v-if="authUser.Role == 'Manager' || authUser.Role == 'Equipment Staff'">
                          Current in: 
                        <span v-if="item.Position">
                            {{ item.Position.Location.Name }}
                            - Block {{ item.Position.Block }} - Floor {{ item.Position.Floor }}
                            - Tile {{ item.Position.Tile }}
                        </span>
                        <span v-else>undefined</span>
                      </div>
                    </v-card-text>
                  </v-card>
                </v-expansion-panel-content>
              </v-expansion-panel>
            </v-flex>
          </div>
        </modal>
      </div>                          
</template>

<script>
import Server from "@/config/config.js";
import BarChart from "../../components/chartTest/bar-chart.js";
import PieChart from "../../components/chartTest/pie-chart.js";
// import DoughnutChart from "../../components/chartTest/Doughnut-chart.js";
import moment from "moment";
import OrderBlock from "../Dashboard/OrderBlock/OrderBlock";
import Vue from "vue";

export default {
  components: {
    BarChart,
    PieChart,
    OrderBlock

    // DoughnutChart
  },
  computed: {
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    }
  },
  data() {
    return {
      addPopUp: false,
      selectedDay: null,
      attrs: [],
      linechartOption: true,
      Dashboard: null,
      pieChartData: {
        labels: [],
        values: []
      },
      myoption: {
        onClick: function(evt) {
          alert("123");
        }
      },
      // doughnutChartData: {
      //   TodayLabels: [],
      //   TodayData: []
      // },
      lineChartData: {
        // workingLabel: "",
        // maintainLabel: "",
        labels: [],
        monthLabels: [],
        monthData: []
      },
      equipmentItems: [],
      workWoMonths: [],
      mainWoMonths: [],
      damaEqtMonths: [],
      lostEqtMonths: [],

      maintainItems: [],

      //cate start

      categories: [],
      tmpCategory: null,
      //cate end
      workOrders: [], // orders data to display in orderblocks <order-block></order-block>
      workOrdersMaintainTomorrow: [], // orders data to display in orderblocks <order-block></order-block>
      workOrdersWokingToday: [], // orders data to display in orderblocks <order-block></order-block>
      workOrdersWokingTomorrow: [], // orders data to display in orderblocks <order-block></order-block>

      equipmentStatusFromChart: "",
      equipmentByStatusList: [],
      showEquipmentByStatusPopup: false
    };
  },
  mounted() {
    // this.$refs.fullcalendar.height = "400px";
  },
  created() {
    // alert(moment(moment()).format("L"));
    let URL = Server.DASHBOARD_API_PATH;

    this.axios
      .get("http://localhost:3000/api/dashboard/maintainCalendar")
      .then(res => {
        if (res.status == 200) {
          let data = res.data;
          data.forEach(item => {
            let attr = {
              key: `today ${item.Id}`,
              highlight: {
                backgroundColor: "#ff8080"
                // Other properties are available too, like `height` & `borderRadius`
              },
              contentStyle: {
                color: "#fafafa"
              },
              // popover: {
              //   label: item
              // },
              // dot: {
              //   backgroundColor: "#26a69a"
              // },
              dates: [
                new Date(
                  moment(item.MaintainDate).year(),
                  moment(item.MaintainDate).month(),
                  moment(item.MaintainDate).date()
                )
              ]
            };
            this.attrs.push(attr);
            this.equipmentItems.push(item);
          });
          let today = {
            key: `today`,
            highlight: {
              backgroundColor: "#26a69a"
              // Other properties are available too, like `height` & `borderRadius`
            },
            contentStyle: {
              color: "#fafafa"
            },

            // popover: {
            //   label: ""
            // },
            dates: [new Date(moment(moment()).format("L"))]
          };
          this.attrs.push(today);
        }
      })
      .catch(error => {
        console.log(error);
      });
    this.axios.get(URL).then(res => {
      if (res.status == 200) {
        // alert("alao alo");
        let data = res.data;
        this.Dashboard = data.Dashboard;
        this.pieChartData.labels.push(data.PieChartData.Availble.Name);
        this.pieChartData.labels.push(data.PieChartData.WokingApproved.Name);
        this.pieChartData.labels.push(data.PieChartData.Working.Name);
        this.pieChartData.labels.push(data.PieChartData.Damaged.Name);
        this.pieChartData.labels.push(
          data.PieChartData.MaintainanceApproved.Name
        );
        this.pieChartData.labels.push(data.PieChartData.Maintaining.Name);
        this.pieChartData.labels.push(data.PieChartData.Lost.Name);
        this.pieChartData.labels.push(data.PieChartData.Archived.Name);

        this.pieChartData.values.push(data.PieChartData.Availble.Quantity);
        this.pieChartData.values.push(
          data.PieChartData.WorkingApproved.Quantity
        );
        this.pieChartData.values.push(data.PieChartData.Working.Quantity);
        this.pieChartData.values.push(data.PieChartData.Damaged.Quantity);
        this.pieChartData.values.push(
          data.PieChartData.MaintainanceApproved.Quantity
        );
        this.pieChartData.values.push(data.PieChartData.Maintaining.Quantity);
        this.pieChartData.values.push(data.PieChartData.Lost.Quantity);
        this.pieChartData.values.push(data.PieChartData.Archived.Quantity);

        // line chart data - start
        // this.lineChartData.labels.push(data.LineChart.WorkingName);
        // this.lineChartData.labels.push(data.LineChart.MaintainName);
        this.lineChartData.labels.push("Working");
        this.lineChartData.labels.push("Maintenance");

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

        this.lineChartData.monthData = [[], []];
        this.mainWoMonths.push(data.LineChart.Maintain.Last11Month);
        this.mainWoMonths.push(data.LineChart.Maintain.Last10Month);
        this.mainWoMonths.push(data.LineChart.Maintain.Last9Month);
        this.mainWoMonths.push(data.LineChart.Maintain.Last8Month);
        this.mainWoMonths.push(data.LineChart.Maintain.Last7Month);
        this.mainWoMonths.push(data.LineChart.Maintain.Last6Month);
        this.mainWoMonths.push(data.LineChart.Maintain.Last5Month);
        this.mainWoMonths.push(data.LineChart.Maintain.Last4Month);
        this.mainWoMonths.push(data.LineChart.Maintain.Last3Month);
        this.mainWoMonths.push(data.LineChart.Maintain.Last2Month);
        this.mainWoMonths.push(data.LineChart.Maintain.LastMonth);
        this.mainWoMonths.push(data.LineChart.Maintain.ThisMonth);

        this.workWoMonths.push(data.LineChart.Working.Last11Month);
        this.workWoMonths.push(data.LineChart.Working.Last10Month);
        this.workWoMonths.push(data.LineChart.Working.Last9Month);
        this.workWoMonths.push(data.LineChart.Working.Last8Month);
        this.workWoMonths.push(data.LineChart.Working.Last7Month);
        this.workWoMonths.push(data.LineChart.Working.Last6Month);
        this.workWoMonths.push(data.LineChart.Working.Last5Month);
        this.workWoMonths.push(data.LineChart.Working.Last4Month);
        this.workWoMonths.push(data.LineChart.Working.Last3Month);
        this.workWoMonths.push(data.LineChart.Working.Last2Month);
        this.workWoMonths.push(data.LineChart.Working.LastMonth);
        this.workWoMonths.push(data.LineChart.Working.ThisMonth);

        this.damaEqtMonths.push(data.LC.Damaged.Last11Month);
        this.damaEqtMonths.push(data.LC.Damaged.Last10Month);
        this.damaEqtMonths.push(data.LC.Damaged.Last9Month);
        this.damaEqtMonths.push(data.LC.Damaged.Last8Month);
        this.damaEqtMonths.push(data.LC.Damaged.Last7Month);
        this.damaEqtMonths.push(data.LC.Damaged.Last6Month);
        this.damaEqtMonths.push(data.LC.Damaged.Last5Month);
        this.damaEqtMonths.push(data.LC.Damaged.Last4Month);
        this.damaEqtMonths.push(data.LC.Damaged.Last3Month);
        this.damaEqtMonths.push(data.LC.Damaged.Last2Month);
        this.damaEqtMonths.push(data.LC.Damaged.LastMonth);
        this.damaEqtMonths.push(data.LC.Damaged.ThisMonth);

        this.lostEqtMonths.push(data.LC.Lost.Last11Month);
        this.lostEqtMonths.push(data.LC.Lost.Last10Month);
        this.lostEqtMonths.push(data.LC.Lost.Last9Month);
        this.lostEqtMonths.push(data.LC.Lost.Last8Month);
        this.lostEqtMonths.push(data.LC.Lost.Last7Month);
        this.lostEqtMonths.push(data.LC.Lost.Last6Month);
        this.lostEqtMonths.push(data.LC.Lost.Last5Month);
        this.lostEqtMonths.push(data.LC.Lost.Last4Month);
        this.lostEqtMonths.push(data.LC.Lost.Last3Month);
        this.lostEqtMonths.push(data.LC.Lost.Last2Month);
        this.lostEqtMonths.push(data.LC.Lost.LastMonth);
        this.lostEqtMonths.push(data.LC.Lost.ThisMonth);

        this.workWoMonths.forEach(quanWo =>
          this.lineChartData.monthData[0].push(quanWo)
        );
        this.mainWoMonths.forEach(quanMa =>
          this.lineChartData.monthData[1].push(quanMa)
        );
      }
    });
    let workOrderdb = "http://localhost:3000/api/dashboard/workorderdb";
    this.axios.get(workOrderdb).then(response => {
      let data = response.data.todayMaintainOrder;
      this.workOrders = data;
      let data2 = response.data.tomorrowMaintainOrder;
      this.workOrdersMaintainTomorrow = data2;
      let data1 = response.data.todayWokingOrder;
      this.workOrdersWokingToday = data1;
      let data3 = response.data.tomorrowWokingOrder;
      this.workOrdersWokingTomorrow = data3;
    });
    this.axios
      .get("http://localhost:3000/api/dashboard/getCategory")
      .then(res => {
        let data = res.data;
        data.forEach(category => {
          this.categories.push(category);
        });
      })
      .catch(error => {
        console.log(error);
      });
  },
  methods: {
    dayClicked(day) {
      this.selectedDay = day;
      // alert(JSON.stringify(this.selectedDay));
      // alert(day.day);
      this.maintainItems = [];
      this.equipmentItems.forEach(item => {
        if (
          moment(item.MaintainDate).date() == this.selectedDay.day &&
          moment(item.MaintainDate).month() + 1 == this.selectedDay.month &&
          moment(item.MaintainDate).year() == this.selectedDay.year
        ) {
          this.maintainItems.push(item);
          this.addPopUp = true;
        }
        // else {
        //   alert(moment(item.MaintainDate).date());
        //   alert(moment(item.MaintainDate).month());
        //   alert(moment(item.MaintainDate).year());
        // }
      });

      // if (this.selectedDay.attributes.length > 0) {
      //   // alert(JSON.stringify(this.selectedDay));
      //   // alert(
      //   //   JSON.stringify(
      //   //     this.selectedDay.attributes[0].popover.label.MaintainDate
      //   //   )
      //   // );
      //   this.maintainItems = [];
      //   this.selectedDay.attributes.forEach(tmp => {
      //     this.maintainItems.push(tmp.popover.label);
      //   });

      //   // alert(this.maintainItems[0].Name);

      // }
    },
    setShowDate(d) {
      this.showDate = d;
    },
    getFormatDate(date) {
      return moment(date).format("L");
    },
    getDay(date) {
      return moment(date).day;
    },
    getMonth(date) {
      return moment(date).month;
    },
    getYear(date) {
      return moment(date).year;
    },
    displayEquipmentStatusPopup(status) {
      this.axios
        .get(`http://localhost:3000/api/equipment/getItemsByStatus/${status}`)
        .then(res => {
          if (res.status == 200) {
            this.equipmentByStatusList = res.data;
            this.equipmentStatusFromChart = status;
            this.showEquipmentByStatusPopup = true;
          }
        })
        .catch(error => {
          console.log(error);
          this.$router.push("/500");
        });
    }
  },
  watch: {
    tmpCategory: function() {
      Vue.nextTick(() => {
        if (this.tmpCategory) {
          this.tmpEquipments = this.equipments.filter(
            equipment => equipment.CategoryID == this.tmpCategory.Id
          );
        }
      });
    },
    linechartOption: function() {
      Vue.nextTick(() => {
        if (this.linechartOption) {
          this.lineChartData.labels = [];
          this.lineChartData.monthData = [];

          this.lineChartData.labels.push("Working");
          this.lineChartData.labels.push("Maintenance");

          this.lineChartData.monthData = [[], []];
          this.workWoMonths.forEach(quanWo =>
            this.lineChartData.monthData[0].push(quanWo)
          );
          this.mainWoMonths.forEach(quanMa =>
            this.lineChartData.monthData[1].push(quanMa)
          );

          // alert(this.lineChartData.labels[0]);
        } else {
          this.lineChartData.labels = [];
          this.lineChartData.monthData = [];

          this.lineChartData.labels.push("Damaged");
          this.lineChartData.labels.push("Lost");

          this.lineChartData.monthData = [[], []];

          this.damaEqtMonths.forEach(quanDa =>
            this.lineChartData.monthData[0].push(quanDa)
          );
          this.lostEqtMonths.forEach(quanLo =>
            this.lineChartData.monthData[1].push(quanLo)
          );
          // alert(this.lineChartData.labels[0]);
        }
        this.$refs.lineChart.update(this.lineChartData);
      });
    }
  }
};
</script>

<style scoped>
.title-modal {
  font-size: 24px;
  font-weight: bold;
}
#calendar {
  /* font-family: "Avenir", Helvetica, Arial, sans-serif;
  color: #2c3e50;
  padding-top: 7px;
  /* height: 37vh; */
  /* width: 32.1vw;  */
  /* height: 1000px; */
}
#header-mainCalen {
  text-align: center;
  height: 50px;
  line-height: 50px;
  color: var(--dark-background);
  font-size: 20px;
  font-weight: bold;

  background-color: #eeeeee;
}
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
.headerstatus1 {
  border-bottom: 1px #cfd8dc solid;
  background-color: #eeeeee;
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
  /* display: grid; */
  /* grid-row-gap: 1rem; */
}

.row3child {
  background-color: white;
  padding: 0.7rem 1rem 0.3rem 1rem;
  margin-bottom: 2rem;
  max-height: 25rem !important;
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
/* .material-shadow-animate {
  box-shadow: 0px 2px 15px rgba(25, 25, 25, 0.27) !important;
  transition: all 0.2s ease-in-out;
}
.material-shadow-animate:hover {
  box-shadow: 1px 4px 30px rgba(25, 25, 25, 0.27) !important;
} */
.material-shadow-animate1 {
  box-shadow: 0px 2px 15px rgba(25, 25, 25, 0.27) !important;
  transition: all 0.2s ease-in-out;
}

/* chow- start*/
.filter {
  display: grid;
  /* grid-template-columns: 18% auto; */
  grid-template-rows: auto auto;
  margin-bottom: 1rem;
}

.tag i {
  color: #757575;
  margin-left: 0.3rem;
  font-size: 1rem;
  transition: all 0.1s ease-in-out;
  display: none;
}

.tag:hover i {
  display: block;
}

.tag i:hover {
  color: #9e9e9e;
}

.tag i:active {
  color: #616161;
}

.filters-bar {
  width: 100%;
  padding-top: 0.7rem;
}

.order-navigator-buttons > button {
  width: 7rem;
  margin: 0 1rem 0 1rem;
  padding: 0.5rem 0 0.5rem 0;
  /* background-color: aqua; */
  font-size: 1.2rem;
}

.is-active {
  border-bottom: 1px solid black;
  font-weight: bold;
}

#btn-add-work-order {
  position: fixed;
  right: 3rem;
  bottom: 2rem;
  background-color: var(--primary-color);
  /* padding: 13px;
        color: white;
        border-radius: 10px; */
  z-index: 99;
  transition: all 0.2s ease-in-out;
}

#btn-add-work-order:hover {
  cursor: pointer;
  background-color: var(--lighten-primary-color);
}

#btn-add-work-order:active {
  background-color: var(--darken-primary-color);
  box-shadow: 1px 1px 1px var(--shadow) !important;
}

.order-content {
  margin-top: 1rem;
  display: grid;
  grid-template-columns: 50% 50%;
}

.orders-view {
  width: 30rem !important;
  /* z-index: 2; */
}

.is-active-block {
  /* background-color: #e0e0e0 !important; */
  background-color: #bdbdbd !important;
  /* border: 1px solid #e0e0e0 !important; */
  border: 1px solid #bdbdbd !important;
  box-shadow: 1px 1px 1px #bdbdbd !important;
}

.order-detail {
  position: fixed;
  left: 60%;
  max-height: 77%;
  overflow-y: auto;
  width: 38%;
  z-index: 2;
}

.detail {
  padding: 0.5rem 1rem;
}

.detail-header {
  display: grid;
  grid-template-columns: 55% 45%;
}

.detail-title {
  font-size: 2rem;
}

.detail-label {
  font-size: 0.98rem;
}

.detail-contents {
  margin-bottom: 1rem;
}

.vodal-confirm-btn {
  position: absolute;
  bottom: 1rem;
  right: 1rem;
  width: 4rem;
  font-size: 0.9rem;
}

.vodal-cancel-btn {
  position: absolute;
  bottom: 1rem;
  right: 5.5rem;
  width: 4rem;
  font-size: 0.9rem;
}

.my-dialog-title {
  padding: 0.7rem 1rem 0.5rem 1rem;
  border-bottom: 1px solid #e0e0e0;
  font-weight: 500;
}

.my-dialog-content {
  padding: 1rem;
}

.chip-btn {
  text-align: center;
  padding: 0.2rem 0.25rem 0.1rem 0.25rem;
  border-radius: 20px;
  background-color: #f5f5f5;
}
.contentstatus {
  max-height: 20rem;
  width: 100%;
  overflow-y: auto;
  overflow-x: hidden;
  padding: 0 1rem;
}
/*Chow- end */
/* .order-block :hover {
  background-color: silver;
} */
</style>
