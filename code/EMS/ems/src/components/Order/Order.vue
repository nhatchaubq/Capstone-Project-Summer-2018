<template>
    <div>        
        <div class="order-content">
            <!-- <div class="orders-view">                 -->
                <div class="">
                    <!-- <div style="width: 100%;">
                        Filter:
                    </div> -->
                  <div class="filter" style="width: 100%">
                      <!-- <div class="select">
                          <select v-model="selectedFilter">
                              <option disabled :value=null>Choose a filter</option>
                              <optgroup label="Status">
                                  <option :disabled="filterValues.includes(status)" :key="status.id" v-for="status in options.status" :value="status">{{ status.name }}</option>
                              </optgroup>
                              <optgroup label="Priorities">
                                  <option :disabled="filterValues.includes(priority)" :key="priority.id" v-for="priority in options.priorities" :value="priority">{{ priority.name }}</option>
                              </optgroup>
                          </select>
                      </div> -->
                      <div style="user-select: none">
                          Priority:
                          <label class="checkbox" :key="'priorOption' + priority.id" v-for="priority in options.priorities" style="margin-right: 1rem;">
                              <input type="checkbox" v-on:change="addFilter(priority, $event)">
                              {{ priority.name }}
                          </label>
                      </div>
                      <div style="user-select: none">
                          Status:
                          <label class="checkbox" :key="'statusOption' + status.id" v-for="status in options.status" style="margin-right: .5rem;">
                              <input type="checkbox" v-on:change="addFilter(status, $event)">
                              {{ status.name }}
                          </label>
                      </div>
                  </div>
                  <div style="width: 100%"></div>
                      <!-- <div class="filters-bar">
                          <span class="tag is-light" style="user-select: none; margin-right: .3rem; cursor: pointer;" :key="filter.id" v-on:click="removeFilter(filter)" v-for="filter in filterValues">
                              {{ filter.type == optionTypes.STATUS ? 'Status: ' : 'Priority: ' }} {{ filter.name }}
                              <i class="fa fa-times-circle"></i>
                          </span>
                      </div> -->
                  </div>
                <div v-show="searchMode" style="display: flex; justify-content: flex-end; align-content: center;">
                    <span><a v-on:click="clearSearch()">Clear search result</a></span>  
                </div>             
            <!-- </div>             -->
        </div>
        <div class="order-blocks">
            <div>
                <div class="emtpy-text" v-if="workOrders.length == 0">
                    There is no orders to display.
                </div>
                <div v-else>
                    <order-block :key="'order' + order.Id" :order="order" :class="isActive(order.Id)" v-for="(order, index) in workOrders" v-on:click.native="setSelectedOrder(order)"></order-block>
                </div>
            </div>
        </div>
        <div id="order-detail-view">
            <!-- <order-detail class="order-detail" :order="selectedOrder" :statusList="options.status"></order-detail> -->
            <div v-if="selectedOrder != null" class="order-detail material-box material-shadow">
              <div class="detail">
                  <div class="detail-header">
                      <div>
                          <span :style="`background-color: ${selectedOrder.PriorityColor}`" class="tag" style="position: relative; top: -.3rem; color: white">
                          {{ selectedOrder.Priority }}
                          </span>
                          <span class="detail-title">
                              {{ selectedOrder.Name }}
                          </span>
                      </div>
                      <!-- manager approve / reject -->
                      <div v-if="authUser.RoleID == 2 && selectedOrder.WorkOrderStatus == 'Checked'" style="margin-top: 1rem; width: 100%">
                            <div style="float: right; display: inline">
                                <button class="button btn-primary material-shadow-animate" style="margin-right: .5rem" v-on:click="() => {
                                    showApproveRejectDialog = true;
                                    approveWorkOrder = true;
                                }">Approve</button>
                                <button class="button btn-danger material-shadow-animate" v-on:click="() => {
                                    showApproveRejectDialog = true;
                                    approveWorkOrder = false;    
                                }">Reject</button>
                            </div>
                        </div> <!-- manager approve / reject -->
                        <!-- edit/cancel work order -->
                        <div style="position: relative; top: .8rem; display: grid; grid-template-rows: auto auto; grid-row-gap: .3rem; text-align: right; user-select: none;" >
                            <!-- edit work order -->
                            <!-- <div class="" v-if="authUser.RoleID == 4">
                                <a v-on:click="editMode = !editMode">
                                    <i class="fa" :class="{'fa-pencil-square-o': !editMode, 'fa-check-circle-o': editMode}" style=" font-size: 1rem; margin-right: 2px"></i>
                                    {{ editMode ? 'Done' : 'Edit' }}
                                </a>
                            </div> edit work order -->
                            <!-- cancel work order -->
                            <div class="" style="margin-bottom: 1rem;" v-if="selectedOrder.StatusID < 3 && authUser.Id == selectedOrder.RequestUserID">
                                <a v-on:click="showCancelDialog = true">Cancel this order</a>
                            </div> <!-- cancel work order -->
                        </div> <!-- edit/cancel work order -->
                  </div>
                  <div style="width: 100%">
                      <div class="detail-contents" style="margin-top: 1rem;">
                          <step-progress :workOrderStatus="{id: selectedOrder.StatusID, name: selectedOrder.WorkOrderStatus}" :statusList="options.status.slice(0, 5)"></step-progress>
                      </div>
                          <!-- <div v-if="editMode" style="margin-top: 1rem;">
                              <span class="detail-label" style="position: relative; top: .4rem; margin-right: 1rem;">Change status to:</span>
                              <div class="select">
                                  <select>
                                      <option :disabled="status.id <= selectedOrder.StatusID" :selected="status.id == (selectedOrder.StatusID)" :key="'editStatus' + status.id" value="" v-for="status in options.status">
                                          {{ status.name }}
                                      </option>
                                  </select>
                              </div>
                          </div> -->
                        <div class="detail-contents">
                            <div style="width: 100%; text-align: right;" v-if="authUser.RoleID == 4 && selectedOrder.WorkOrderStatus == 'Requested'">
                                <button class="button btn-blue material-shadow-animate" v-on:click="() => {
                                    newStatusId = 2;
                                    newStatusName = 'Checked';
                                    showChangeStatusDialog = true;
                                }">Change status to Checked</button>
                            </div>
                            <div style="width: 100%; text-align: right;" v-if="authUser.RoleID == 4 && selectedOrder.WorkOrderStatus == 'Approved'">
                                <button class="button btn-blue material-shadow-animate" v-on:click="() => {
                                    newStatusId = 4;
                                    newStatusName = 'In Progress';
                                    showChangeStatusDialog = true;
                                }">Change status to In Progress</button>
                            </div>
                            <div style="width: 100%; text-align: right;" v-if="authUser.RoleID == 4 && selectedOrder.WorkOrderStatus == 'In Progress'">
                                <button class="button btn-blue material-shadow-animate" v-on:click="() => {
                                    newStatusId = 5;
                                    newStatusName = 'Closed';
                                    showChangeStatusDialog = true;
                                }">Close this work order</button>
                            </div>
                      </div>
                      <div class="detail-contents" style="width: 100%;">
                          <span class="detail-label">Equipments:</span>
                          <v-flex>
                              <v-expansion-panel popout>
                                  <v-expansion-panel-content v-for="equipment in equipments" :key="'equipment' + equipment.Id">
                                      <div slot="header" style="display: grid; grid-template-columns: 25% auto;">
                                          <div style="display: flex">
                                              <img v-show="equipment.Image" :src="equipment.Image" :alt="equipment.Name" style="width: 3rem; height: 3rem;">
                                          </div>
                                          <div style="display: grid; grid-template-rows: auto auto;">
                                              <div>
                                                  {{ equipment.Name }}
                                              </div>                                            
                                              <div style="font-size: .9rem">
                                                  Quantity: {{ equipment.EquipmentItems.length }} {{ equipment.Unit }}
                                              </div>
                                          </div>
                                      </div>
                                      <v-card style="border: 0" v-for="item in equipment.EquipmentItems" :key="'item' + item.Id">
                                          <v-card-text style="font-size: .9rem">
                                              Serial #: <a v-on:click="showDetailPopup(item.Id)">{{ item.SerialNumber }}</a> | 
                                              <a>View position</a>
                                          </v-card-text>
                                      </v-card>
                                  </v-expansion-panel-content>
                              </v-expansion-panel>
                          </v-flex>
                      </div>
                      <div class="detail-contents">
                            <span class="detail-label">Location: {{ selectedOrder.Location.Name }} - {{ selectedOrder.Location.Address }}</span>
                            <!-- <img src="http://images.indianexpress.com/2016/11/hazaribagh-759.jpg" /> -->
                            <GmapMap
                                :center="{lat:selectedOrder.Location.Latitude, lng:selectedOrder.Location.Longitude}"
                                :zoom="16"
                                map-type-id="terrain"
                                style="width: 100%; height:25rem"
                            >
                            <GmapMarker
                                :position="google && new google.maps.LatLng(selectedOrder.Location.Latitude, selectedOrder.Location.Longitude)"
                                :clickable="true"
                                :draggable="true"
                                @click="showAlert(selectedOrder.Location.Name + ' - ' + selectedOrder.Location.Address)"
                                />
                            </GmapMap>
                      </div>
                  </div>
              </div>            
          </div>
        </div>
        <router-link to="/work_order/create" tag="button" id="btn-add-work-order" class="button is-primary material-shadow-animate">Add Work Order</router-link>
      <!-- equipment detail dialog -->
      <vodal height="500" :show="equipmentItem != null" @hide="equipmentItem = null" animation="slideUp">
        <equipment-detail-popup :equipment="equipmentItem" class=""></equipment-detail-popup>
      </vodal> <!-- equipment detail dialog -->
      <!-- cancel dialog -->
      <vodal :show="showCancelDialog" :height="170" @hide="showCancelDialog = false" animation="slideUp" :closeButton="false">
          <div v-if="selectedOrder">
              <div class="my-dialog">
                <div class="my-dialog-title">
                    Confirm
                </div>
                <div class="my-dialog-content">
                    <span>Are you sure to cancel this order #{{ selectedOrder.Id }} - {{ selectedOrder.Name }}?</span>
                    <button class="button vodal-cancel-btn" @click="showCancelDialog = false">No</button>
                    <button class="button btn-primary vodal-confirm-btn" @click="cancelOrder(selectedOrder.Id)">Yes</button>
                </div>
              </div>
          </div>
      </vodal> <!-- cancel dialog -->
      <!-- approve / reject dialog -->
      <vodal :show="showApproveRejectDialog" :height="170" @hide="showApproveRejectDialog = false" animation="slideUp" :closeButton="false">
          <div v-if="selectedOrder">
              <div class="my-dialog">
                <div class="my-dialog-title">
                    Confirm
                </div>
                <div class="my-dialog-content">
                    <span>Are you sure to {{ approveWorkOrder ? 'approve' : 'reject' }} this order #{{ selectedOrder.Id }} - {{ selectedOrder.Name }}?</span>
                    <button class="button vodal-cancel-btn" @click="showApproveRejectDialog = false">Cancel</button>
                    <button :class="{'btn-primary': approveWorkOrder, 'btn-danger': !approveWorkOrder}" class="button vodal-confirm-btn" @click="approveRejectWorkOrder(selectedOrder.Id)">{{ approveWorkOrder ? 'Approve' : 'Reject' }}</button>
                </div>
              </div>
          </div>
      </vodal> <!-- approve / reject dialog -->
      <!-- change status dialog -->
      <vodal :show="showChangeStatusDialog" :height="170" @hide="showChangeStatusDialog = false" animation="slideUp" :closeButton="false">
          <div v-if="selectedOrder">
              <div class="my-dialog">
                <div class="my-dialog-title">
                    Confirm
                </div>
                <div class="my-dialog-content">
                    <span v-if="newStatusName != 'Closed'">
                        Are you sure to change status of this order #{{ selectedOrder.Id }} - {{ selectedOrder.Name }} to {{ newStatusName }}?
                    </span>
                    <span v-else>
                        Are you sure to close this order #{{ selectedOrder.Id }} - {{ selectedOrder.Name }}?
                    </span>
                    <button class="button vodal-cancel-btn" @click="showChangeStatusDialog = false">No</button>
                    <button class="btn-primary button vodal-confirm-btn" @click="changeWorkOrderStatus(selectedOrder.Id, newStatusId, newStatusName)">Yes</button>
                </div>
              </div>
          </div>
      </vodal> <!-- change status dialog -->
    </div>
</template>

<script>
// import Vue from "vue";
import { sync } from "vuex-pathify";
import Server from "@/config/config.js";
import OrderBlock from "./OrderBlock/OrderBlock";
import StepProgress from '@/components/StepProgress/StepProgress.vue';
// import OrderDetail from "./OrderDetailComponent/OrderDetail";
import "vodal/common.css";
import "vodal/slide-up.css";
import EquipmentDetailPopup from '@/components/Equipment/EquipmentDetailPopup';
import Vodal from 'vodal';
import {gmapApi} from 'vue2-google-maps';

export default {
  components: {
    // OrderDetail,
    OrderBlock,
    Vodal,
    EquipmentDetailPopup,
    StepProgress
  },
  created() {
    // this.sortOrdersByDate(this.orders);
    // alert(this.$store.state.workOrderPage.orders.length);
    if (this.$store.state.workOrderPage.searchValues.length != 0) {
        this.workOrders = this.$store.state.workOrderPage.searchValues;
    } else {
      this.getWorkOrders();
    }
    this.axios.get(Server.WORKORDER_STATUS_API_PATH).then(response => {
      let data = response.data;
      data.forEach(element => {
        let status = {
          id: element.Id,
          name: element.Name,
          type: this.optionTypes.STATUS
        };
        this.options.status.push(status);
      });
    });
    this.axios.get(Server.WORKORDER_PRIORITIES_API_PATH).then(response => {
      let data = response.data;
      data.forEach(element => {
        let priority = {
          id: element.Id,
          name: element.Name,
          type: this.optionTypes.PRIORITY
        };
        this.options.priorities.push(priority);
      });
    });
  },
  data() {
    return {
        tempValues: null, // to hold the original orders when apply filters
        workOrders: [], // orders data to display in orderblocks <order-block></order-block>
        selectedOrder: null, // to provide order to OrderDetail component <order-detail></order-detail>
        equipments: [], // to hold equipments in the selected work order
        editMode: false, // edit work order detail
        equipmentItem: null, // when select an item in the list of equipment of selected order
        selectedFilter: null, // to hold the selected value when change in <select></select>
        searchMode: false, // flag to display the "Clear search result"
        options: { 
            priorities: [],
            status: []
        },
        // filterValues: [],
        filterOptionsValues: {
            priorities: [],
            status: []
        },
        optionTypes: {
            STATUS: 0,
            PRIORITY: 1
        },
        showCancelDialog: false,
        showApproveRejectDialog: false,
        showChangeStatusDialog: false,
        newStatusId: -1,
        newStatusName: '',
        approveWorkOrder: false,
    };
  },
  computed: {
    searchValues: sync("workOrderPage.searchValues"),
    authUser() {
        return JSON.parse(window.localStorage.getItem('user'));
    },
    google: gmapApi,
  },
  methods: {
    getWorkOrders() {
        this.axios.get(Server.WORKORDER_API_PATH).then(response => {
            let data = response.data.WorkOrders;
            this.$store.state.workOrderPage.orders = data;
            this.workOrders = data;
        });
    },
    setSelectedOrder(order) {
      if (this.selectedOrder == order) {
        this.selectedOrder = null;
      } else {
        this.selectedOrder = order;
        // get equipments in the selected work order - start
        this.equipments = [];
        let url = `${Server.WORKORDER_API_PATH}/${this.selectedOrder.Id}/equipments`;
        this.axios.get(url)
            .then((res) => {
                let data = res.data;
                data.forEach(equipment => {
                    this.equipments.push(equipment);
                });
            })
            .catch((error) => {
                console.log(error);
            })
        // get equipments in the selected work order - end
      }
    },
    // when click on an orderblock, add 'is-active-block' class to it
    isActive(orderId) {
      if (this.selectedOrder != null && orderId === this.selectedOrder.Id) {
        return "is-active-block";
      }
      return "";
    },
    removeFilter(filter) {
      // the lamda below will iterate the filterValues to find if any elements in it match the condition, then return the result array.
      // in this case it will find if any elements in filterValues match the filter we provided.
      // it is the same as we make a for loop then find the needed elements by using if, then return it as an array. all of those steps in one line of code if we use lamda.
      // this.filterValues = this.filterValues.filter(value => value != filter);
      switch(filter.type) {
          case this.optionTypes.STATUS: {
              this.filterOptionsValues.status = this.filterOptionsValues.status.filter(status => filter.id != status.id);
              break;
          }
          case this.optionTypes.PRIORITY: {
              this.filterOptionsValues.priorities = this.filterOptionsValues.priorities.filter(priority => filter.id != priority.id);
              break;
          }
      }
      this.filterOrders();
      if (this.filterOptionsValues.status.length == 0 && this.filterOptionsValues.priorities.length == 0) {
        this.selectedFilter = null;
        this.workOrders = this.tempValues;
      }
    },
    filterOrders() {
      if (this.tempValues == null) {
        this.tempValues = this.workOrders;
      }
      this.workOrders = []; // reset orders before applying new filters
      this.selectedOrder = null;
      if (this.filterOptionsValues.status.length > 0) {
        this.filterOptionsValues.status.forEach(status => {
          this.workOrders = this.workOrders.concat(this.tempValues.filter(order => order.WorkOrderStatus == status.name));
        });
      } else {
          this.workOrders = this.tempValues;
      }
      if (this.filterOptionsValues.priorities.length > 0) {
        var tempValues = [];
        this.filterOptionsValues.priorities.forEach(priority => {
          tempValues = tempValues.concat(this.workOrders.filter(order => order.Priority == priority.name));
        });
        this.workOrders = tempValues;
      }
      this.workOrders = this.sortOrdersByDate(this.workOrders);
      this.selectedFilter = null;
      // for (var i = 0; i < this.filterValues.length; i++) {
      //     this.orders = this.sortOrdersByDate(this.orders);
      // }
    },
    sortOrdersByDate(orders) {
        return orders.sort((order1, order2) => {
            var date1 = parseInt(new Date(order1.CreateDate).getTime());
            var date2 = parseInt(new Date(order2.CreateDate).getTime());
            // alert(order1.Id + ' ' + order2.Id + ' ' + order2.PriorityId  + ' ' + order1.PriorityId);
            var result = date2 - date1;
            return (result > 0) ? 1 : (result < 0) ? -1 : (order2.PriorityID - order1.PriorityID);
        });
    },
    addFilter(filter, event) {
      if (event.target.checked) {
        // this.filterValues.push(this.selectedFilter);
        switch (filter.type) {
          case this.optionTypes.STATUS: {
            this.filterOptionsValues.status.push(filter);
            break;
          }
          case this.optionTypes.PRIORITY: {
            this.filterOptionsValues.priorities.push(filter);
            break;
          }
        }
        // tempValues is null means that no filters yet.                                                                                                                                                                                                                                    
        this.filterOrders();
      } else {
        this.removeFilter(filter);
      }
    },
    reset() {
      this.filterValues = [];
      this.filterOptionsValues.status = [];
      this.filterValues.priorities = [];
      this.selectedOrder = null;
    },
    clearSearch() {
      this.$store.state.searchValue = "";
      this.$store.state.workOrderPage.searchValues = [];
    },
    showDetailPopup(equipmentItemId) {
        let url = `${Server.EQUIPMENTITEM_API_PATH}/chau/${equipmentItemId}`;
        this.axios.get(url)
            .then((res) => {
                if(res.data) {
                    this.equipmentItem = res.data;
                }
            })
    },
    showAlert(msg) {
        alert(msg);
    },
    cancelOrder(orderId) {
        this.changeWorkOrderStatus(orderId, 1002, 'Cancelled');
    },
    approveRejectWorkOrder(orderId) {
        let newStatusId = this.approveWorkOrder ? 3 : 6;
        let newStatusName = this.approveWorkOrder ? 'Approved' : 'Rejected';

        this.changeWorkOrderStatus(orderId, newStatusId, newStatusName);
        // let authUser = JSON.parse(window.localStorage.getItem('user'));
        
    },
    changeWorkOrderStatus(orderId, newStatusId, newStatusName) {
        let url = `${Server.WORKORDER_API_PATH}/status/${orderId}`;
        this.axios.put(url, {
            userId: this.authUser.Id,
            oldWorkOrderStatusId: this.selectedOrder.StatusID,
            newWorkOrderStatusId: newStatusId,
        })
            .then((res) => {
                if (res.status == 200) {
                    this.showCancelDialog = false;
                    this.showApproveRejectDialog = false;
                    this.showChangeStatusDialog = false;
                    this.selectedOrder.StatusID = newStatusId;
                    this.selectedOrder.WorkOrderStatus = `${newStatusName}`;
                    // if (newStatusName == 'Closed' || newStatusId == 'Cancelled') {
                    //     url = `${Server.EQUIPMENTITEM_API_PATH}/status/${}`
                    // }
                }
            })
            .catch((error) => {
                console.log(error);
            })
    }
  },
  watch: {
    // this 'watch' is used when we need to monitor changes of some variables, if they changes value then the function in this 'watch' will be triggered.
    // selectedFilter: function() {
    //   Vue.nextTick(() => {
    //     if (this.selectedFilter != null &&
    //       !this.filterValues.includes(this.selectedFilter)
    //     ) {
    //       this.filterValues.push(this.selectedFilter);
    //       switch (this.selectedFilter.type) {
    //         case this.optionTypes.STATUS: {
    //           this.filterOptionsValues.status.push(this.selectedFilter);
    //           break;
    //         }
    //         case this.optionTypes.PRIORITY: {
    //           this.filterOptionsValues.priorities.push(this.selectedFilter);
    //           break;
    //         }
    //       }
    //       // tempValues is null means that no filters yet.
    //       if (this.tempValues == null) {
    //         this.tempValues = this.workOrders;
    //       }
    //       this.filterOrders();
    //     } else {
    //       this.selectedFilter = null;
    //     }
    //   });
    // },
    searchValues: function() {
      if (this.searchValues.length == 0) {
        this.getWorkOrders();
        this.searchMode = false;
      } else {
        this.workOrders = this.searchValues;
        this.searchMode = true;
      }
      this.reset();
    }
  }
};
</script>

<style scoped>
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

.order-blocks {
  position: fixed;
  height: 77%;
  padding-right: 0.5rem;
  width: 38%;
  overflow-y: auto;
}

.is-active-block {
  background-color: #e0e0e0 !important;
  border: 1px solid #e0e0e0 !important;
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
    padding: .5rem 1rem;
}

.detail-header {
    display: grid;
    grid-template-columns: 55% 45%;
}

.detail-title {
    font-size: 2rem;
}

.detail-label {
    font-size: .98rem;
}

.detail-contents {
    margin-bottom: 1rem;
}

.vodal-confirm-btn {
    position: absolute;
    bottom: 1rem;
    right: 1rem;
    width: 4rem;
    font-size: .9rem;
}

.vodal-cancel-btn {
    position: absolute;
    bottom: 1rem;
    right: 5.5rem;
    width: 4rem;
    font-size: .9rem;
}


.my-dialog-title {
    padding: .7rem 1rem .5rem 1rem;
    border-bottom: 1px solid #e0e0e0;
    font-weight: 500;
}

.my-dialog-content {
    padding: 1rem;
}

.chip-btn {
    text-align: center;
    padding: .2rem .25rem .1rem .25rem;
    border-radius: 20px;
    background-color: #f5f5f5;
}
</style>
