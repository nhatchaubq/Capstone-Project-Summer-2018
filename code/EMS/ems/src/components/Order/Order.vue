<template>
    <div>        
        <div class="order-content">
            <!-- <div class="orders-view">                 -->
                <div class="">
                    <!-- <div style="width: 100%;">
                        Filter:
                    </div> -->
                  <div class="filter" style="width: 100%">
                      <div style="user-select: none; display: grid; grid-template-columns: 4rem auto;">
                            <div>Priority:</div>
                            <div>
                                <label class="checkbox" :key="'priorOption' + priority.id" v-for="priority in options.priorities" style="margin-right: .5rem;">
                                    <input type="checkbox" v-on:change="addFilter(priority, $event)">
                                    {{ priority.name }}
                                </label>                              
                            </div>                        
                      </div>
                      <div style="user-select: none; display: grid; grid-template-columns: 4rem auto;">
                            <div>Status:</div>
                            <div>
                                <label class="checkbox" :key="'statusOption' + status.id" v-for="status in options.status" style="margin-right: .5rem;">
                                    <input type="checkbox" v-on:change="addFilter(status, $event)">
                                    {{ status.name }}
                                </label>
                            </div>
                      </div>
                  </div>
                  <div v-if="authUser.Role == 'Staff' || authUser.Role == 'Maintainer'" style="width: 100%">
                      <div class="row" style="margin: 0 !important; margin-bottom: 1rem">
                          <div class="view-mode col-4" 
                                :class="{'view-mode-active': myWorkOrderViewMode}"
                                v-on:click="() => {myWorkOrderViewMode = true}">
                              My Work Orders
                          </div>
                          <div class="view-mode col-4" 
                                :class="{'view-mode-active': !myWorkOrderViewMode}"
                                v-on:click="() => {myWorkOrderViewMode = false}">
                              All
                          </div>
                      </div>
                  </div>
                </div>
                <div v-show="searchMode" style="display: flex; justify-content: flex-end; align-content: center;">
                    <span><a v-on:click="clearSearch()">Clear search result</a></span>  
                </div>             
            <!-- </div>             -->
        </div>
        <!-- order block -->
        <div class="order-blocks" :style="{'max-height': (authUser.Role == 'Staff' || authUser.Role == 'Maintainer') ? '65.5%' : '70.5%',
                                            'height': (authUser.Role == 'Staff' || authUser.Role == 'Maintainer') ? '65.5%' : '70.5%',}">
            <div class="emtpy-text" v-if="toDisplayWorkOrders.length == 0">
                There is no orders to display.
            </div>
            <div v-else>        
                <order-block :style="(index != toDisplayWorkOrders.length - 1) ? 'margin-bottom: 1rem;' : ''" :key="'order' + order.Id" :order="order" :class="isActive(order.Id)" v-for="(order, index) in toDisplayWorkOrders" v-on:click.native="setSelectedOrder(order)"></order-block>
            </div>
        </div><!-- order block -->
        <!-- order detail -->
        <div id="order-detail-view">
            <!-- <order-detail class="order-detail" :order="selectedOrder" :statusList="options.status"></order-detail> -->
            <div v-if="selectedOrder" class="order-detail material-box material-shadow"  
                    :style="{'max-height': (authUser.Role == 'Staff' || authUser.Role == 'Maintainer') ? '62%' : '68.5%',
                            'height': (authUser.Role == 'Staff' || authUser.Role == 'Maintainer') ? '62%' : '68.5%',}">
              <div class="detail">
                  <div class="detail-header" :style="(selectedOrder.StatusID < 3 && authUser.Id == selectedOrder.RequestUserID) ? 
                                                            'display: grid; grid-template-columns: auto 25%;' : ''">
                    <div>
                        <span :style="`background-color: ${selectedOrder.PriorityColor}`" class="tag" style="position: relative; top: -.3rem; color: white">
                        {{ selectedOrder.Priority }}
                        </span>
                        <span class="detail-title">
                            {{ selectedOrder.Name }}
                        </span>
                    </div>
                    <!-- edit/cancel work order -->
                    <div style="margin-top: .5rem; user-select: none; display: flex; justify-content: flex-end" v-if="selectedOrder.StatusID < 3 && authUser.Id == selectedOrder.RequestUserID">
                        <div class="" style="">
                            <!-- cancel work order -->
                            <a v-on:click="() => {
                                showChangeStatusDialog = true;
                                newStatusName = 'Cancelled';
                            }">Cancel</a> <!-- cancel work order -->
                            <span> | </span>
                            <!-- cancel work order -->
                            <a v-on:click="showEditDialog = true">Edit</a> <!-- cancel work order -->
                        </div> 
                    </div> <!-- edit/cancel work order -->
                  </div>
                  <div style="">                        
                        <div class="detail-contents" style="margin-top: 1rem;">
                            <step-progress :workOrderStatus="{id: selectedOrder.StatusID, name: selectedOrder.WorkOrderStatus}" :statusList="options.status.filter(status => status.name != 'Cancelled')"></step-progress>
                        </div>          
                          <!-- manager approve / reject -->
                        <div v-if="authUser.Role == 'Manager' && selectedOrder.WorkOrderStatus == 'Checked'" class="" style="margin-top: 1.5rem; margin-bottom: .5rem; display: flex; justify-content: flex-end; align-content: center">
                            <div>
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
                        <div class="detail-contents">
                            <div style="width: 100%; text-align: right;" v-if="authUser.Role === 'Equipment Staff' && selectedOrder.WorkOrderStatus == 'Requested'">
                                <button class="button btn-primary material-shadow-animate" v-on:click="() => {
                                    newStatusName = 'Checked';
                                    showChangeStatusDialog = true;
                                }">Change status to Checked</button>
                            </div>
                            <div style="width: 100%; text-align: right;" v-if="authUser.Role === 'Equipment Staff' && selectedOrder.WorkOrderStatus == 'Approved'">
                                <button class="button btn-primary material-shadow-animate" v-on:click="() => {
                                    newStatusName = 'In Progress';
                                    showChangeStatusDialog = true;
                                }">Change status to In Progress</button>
                            </div>
                            <div style="width: 100%; text-align: right;" v-if="authUser.Role === 'Equipment Staff' && selectedOrder.WorkOrderStatus == 'In Progress'">
                                <button class="button btn-primary material-shadow-animate" v-on:click="() => {
                                    newStatusName = 'Closed';
                                    showChangeStatusDialog = true;
                                }">Close this work order</button>
                            </div>
                      </div>
                      <!-- order detail view mode -->
                      <div style="display: grid; grid-template-columns: 50% 50%; margin: 2rem 0;">
                          <div class="view-mode" :class="{'view-mode-active': viewDetailMode}" v-on:click="viewDetailMode = true">Detail</div>
                          <div class="view-mode" :class="{'view-mode-active': !viewDetailMode}" v-on:click="viewDetailMode = false">History</div>                                    
                      </div><!-- order detail view mode -->
                      <!-- detail view mode -->
                      <div v-if="viewDetailMode">
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
                                                    <a v-on:click="() => {
                                                        showUpdateItemPosition = true;
                                                        toUpdatePositionItem = item;ss
                                                    }">Update position</a>
                                                    <span v-if="authUser.Role === 'Equipment Staff' && selectedOrder.WorkOrderStatus === 'In Progress'">
                                                         | 
                                                        <a v-on:click="() => {
                                                            workOrderIdOfToCloseWOD = selectedOrder.Id;
                                                            toCloseEquipment = equipment;
                                                            toCloseEquipmentItem = item;
                                                            showCloseWorkOrderDetailDialog = true;
                                                        }">Close</a>
                                                    </span>
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
                      </div><!-- detail view mode -->
                      <!-- history view mode -->
                      <div v-else>
                            <div class="detail-contents" v-if="selectedOrder.WorkOrderRecord">
                                <div style="font-size: .95rem;" :key="'orderRecord' + orderRecord.Id" v-for="(orderRecord, index) in selectedOrder.WorkOrderRecord">
                                    <span class="tag" :class="getStatusColorClass(orderRecord.NewStatus.Name)">{{ orderRecord.NewStatus.Name }}</span> 
                                        by <span class="tag">{{ orderRecord.ModifiedUser.Id == authUser.Id ? 'You' :  `${orderRecord.ModifiedUser.Role} ${orderRecord.ModifiedUser.Username}` }}</span> on {{ getFormatDate(orderRecord.ModifiedByDateTime) }}
                                        <div style="margin-left: 2rem; padding: 1rem 1rem;" :style="((index != (selectedOrder.WorkOrderRecord.length - 1)) || (index == (selectedOrder.WorkOrderRecord.length - 1) && orderRecord.Description)) ? 
                                                                                                    `border-left: 2px solid ${getStatusColor(orderRecord.NewStatus.Name)}` : ''">
                                            <span v-if="orderRecord.Description" class="quote">&ldquo;{{ orderRecord.Description }}&rdquo;</span>
                                        </div> 
                                </div>
                            </div>
                      </div><!-- history view mode -->
                  </div>
              </div>            
          </div>
        </div> <!-- order detail -->
        <router-link to="/work_order/create" v-if="authUser.Role === 'Staff' || authUser.Role === 'Maintainer'">
            <button id="btn-add-work-order" class="button is-primary material-shadow-animate">
                Add Work Order
            </button>
        </router-link>
      <!-- equipment detail dialog -->
      <vodal :height="500" :show="equipmentItem != null" @hide="equipmentItem = null" animation="slideUp">
        <equipment-detail-popup :equipment="equipmentItem" class=""></equipment-detail-popup>
      </vodal> <!-- equipment detail dialog -->

      <!-- approve / reject dialog -->
      <vodal :show="showApproveRejectDialog" :height="Errors.RejectedDescriptionNotProvided != '' ? 390 : 350" @hide="showApproveRejectDialog = false" animation="slideUp" :closeButton="false">
          <div v-if="selectedOrder">
              <div class="my-dialog">
                <div class="my-dialog-title">
                    Confirm
                </div>
                <div class="my-dialog-content">
                    <span>Are you sure to {{ approveWorkOrder ? 'approve' : 'reject' }} this order #{{ selectedOrder.Id }} - {{ selectedOrder.Name }}?</span>
                    <div style="font-size: .95rem; font-weight: 500; margin-top: 1.5rem; margin-bottom: .5rem">
                        <span v-if="approveWorkOrder">Description (optional)</span>
                        <span v-else>Describe the reason you reject this order (required)</span>
                    </div>
                    <textarea v-model="changeStatusDescription" class="input" style="min-height: 7rem; max-height: 7rem; overflow-y: auto" cols="30" rows="10"></textarea>
                    <div style="color: var(--danger-color); font-weight: 500; font-size: .95rem; margin-top: 1rem" 
                            v-if="Errors.RejectedDescriptionNotProvided != ''">
                        {{ Errors.RejectedDescriptionNotProvided }}
                    </div>
                    <button class="button vodal-cancel-btn" @click="showApproveRejectDialog = false">Cancel</button>
                    <button :class="{'btn-primary': approveWorkOrder, 'btn-danger': !approveWorkOrder}" 
                            class="button vodal-confirm-btn" 
                            @click="approveRejectWorkOrder(selectedOrder.Id)">
                        {{ approveWorkOrder ? 'Approve' : 'Reject' }}
                    </button>
                </div>
              </div>
          </div>
      </vodal> <!-- approve / reject dialog -->
      <!-- change status dialog -->
      <vodal :show="showChangeStatusDialog" :height="350" @hide="showChangeStatusDialog = false" animation="slideUp" :closeButton="false">
          <div v-if="selectedOrder">
              <div class="my-dialog">
                <div class="my-dialog-title">
                    Confirm
                </div>
                <div class="my-dialog-content">
                    <div v-if="newStatusName != 'Closed'">
                        <span v-if="newStatusName != 'Cancelled'">Are you sure to change status of this order #{{ selectedOrder.Id }} - {{ selectedOrder.Name }} to {{ newStatusName }}?</span>
                        <span v-if="newStatusName == 'Cancelled'">Are you sure to cancel this order #{{ selectedOrder.Id }} - {{ selectedOrder.Name }}?</span>
                        <div style="font-size: .95rem; font-weight: 500; margin-top: 1.5rem; margin-bottom: .5rem">
                            Description (optional):
                        </div>
                        <textarea v-model="changeStatusDescription" class="input" style="min-height: 7rem; max-height: 7rem; overflow-y: auto" cols="30" rows="10"></textarea>
                    </div>
                    <div v-else>
                        <div>
                            Please recheck the equipments' status of this order #{{ selectedOrder.Id }} - {{ selectedOrder.Name }} before closing
                        </div>
                    </div>
                    <button class="button vodal-cancel-btn" @click="showChangeStatusDialog = false">No</button>
                    <button class="btn-primary button vodal-confirm-btn" @click="changeWorkOrderStatus(selectedOrder.Id, newStatusName)">Yes</button>
                </div>
              </div>
          </div>
      </vodal> <!-- change status dialog -->
      <modal v-if="selectedOrder" v-model="showEditDialog" @on-ok="showEditDialog = false" @on-cancel="showEditDialog = false"
        ok-text="Save changes" cancel-text="Cancel">
          <div slot="header">
              <span :style="{
                  'background-color': selectedOrder.PriorityColor,
                  'color': 'white',                  
                  'margin-right': '0.5rem',
                  'position': 'relative',
                  'top': '-.2rem'
                  }" class="tag">{{selectedOrder.Priority}}</span> <span style="font-size: 1.5rem;">{{ selectedOrder.Name }}</span>
          </div>
          <div :style="{
              'max-height': '50vh',
              'overflow-y': 'auto',
          }">
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
      </modal>
      <!-- close work detail dialog -->
      <!-- <modal v-if="toCloseEquipment && toCloseEquipmentItem" v-model="showCloseWorkOrderDetailDialog" 
                @on-ok="showCloseWorkOrderDetailDialog = false" >
          <div slot="header">
              Close Order Detail
          </div>
          <div :style="{
              'font-size': '1rem', 
              'max-height': '50vh',
              'overflow-y': 'auto',
          }">
            <div style="font-size: 0.95rem; margin-bottom: 1rem; display: grid; grid-template-columns: 55% 15% 15% 15%;">
                <div>Equipment Item</div>
                <div style="text-align: center">Good</div>
                <div style="text-align: center">Damaged</div>
                <div style="text-align: center">Lost</div>
            </div>
            <div style="display: grid; grid-template-columns: 15% 40% 15% 15% 15%;">
                <div style="display: flex">
                    <img v-show="toCloseEquipment.Image" :src="toCloseEquipment.Image" :alt="toCloseEquipment.Name" style="width: 3rem; height: 3rem;">
                </div>
                <div style="display: grid; grid-template-rows: auto auto;">
                    <div>
                        {{ toCloseEquipment.Name }}
                    </div>                                            
                    <div style="font-size: .9rem">
                        Serial #: <strong>{{ toCloseEquipmentItem.SerialNumber }}</strong>
                    </div>
                </div>
                <div style="text-align: center">
                    <input type="radio" checked :name="`${toCloseEquipment.Name}${toCloseEquipmentItem.Id}`">
                </div>
                <div style="text-align: center">
                    <input type="radio" :name="`${toCloseEquipment.Name}${toCloseEquipmentItem.Id}`">
                </div>
                <div style="text-align: center">
                    <input type="radio" :name="`${toCloseEquipment.Name}${toCloseEquipmentItem.Id}`">
                </div>
            </div>
          </div>
          <div slot="footer">
              <button v-on:click="showCloseWorkOrderDetailDialog = false" 
                        class="button">Cancel</button>
              <button class="button btn-primary" 
                        v-on:click="closeWorkOrderDetail(selectedOrder.Id, toCloseEquipmentItem.Id, newItemStatus)">Close Order Detail</button>
          </div>
      </modal>  -->
      <!-- close work detail dialog -->
      <modal v-if="mapViewSelectedLocation" v-model="showUpdateItemPosition" 
            @on-ok="showUpdateItemPosition = false" @on-cancel="showUpdateItemPosition = false"
            ok-text="Save changes" cancel-text="Cancel">
          <div slot="header">
              <span>Update Equipment Item Position</span>
          </div>
          <div :style="{
              'max-height': '50vh',
              'overflow-y': 'auto',
          }">
          <div class="select">
            <select v-model="updateBlock">
                <option :key="'updateBlock' + block.Id" v-for="block in mapViewSelectedLocation.Blocks"></option>
            </select>
            <select v-model="updateFloor">
                <option :key="'updateFloor' + floor.Id" v-for="floor in updateBlock.Floors"></option>
            </select>
            <select v-model="updateTile">
                <option :key="'updaupdateTileteFloor' + tile.Id" v-for="tile in updateFloor.Tiles"></option>
            </select>

          </div>
          </div>
      </modal>
    </div>
</template>

<script>
// import Vue from "vue";
import { sync } from "vuex-pathify";
import moment from 'moment';
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
    this.getWorkOrders();
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
        myWorkOrderViewMode: true,
        toDisplayWorkOrders: [],
        myWorkOrders: [],
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
        showCloseWorkOrderDialog: false,
        newStatusId: -1,
        newStatusName: '',
        approveWorkOrder: false,
        changeStatusDescription: '',
        viewDetailMode: true,
        Errors: {
            RejectedDescriptionNotProvided: '',
        },
        showEditDialog: false,
        showUpdateItemPosition: false,
        showCloseWorkOrderDetailDialog: false,        
        workOrderIdOfToCloseWOD: null,
        toCloseEquipment: null,
        toCloseEquipmentItem: null,
        mapViewSelectedLocation: null,

        toUpdatePositionItem: null,
        updateBlock: null,
        updateFloor: null,
        updateTile: null,
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
            if (response.data.WorkOrders) {
                let data = response.data.WorkOrders;
                this.$store.state.workOrderPage.orders = data;
                this.workOrders = data;
                if (this.authUser.Role === 'Staff' || this.authUser.Role === 'Maintainer') {
                    this.myWorkOrders = data.filter(order => order.RequestUserID == this.authUser.Id);
                    this.toDisplayWorkOrders = this.myWorkOrders;
                    this.myWorkOrderViewMode = true;
                } else {
                    this.toDisplayWorkOrders = this.workOrders;
                    this.myWorkOrderViewMode = false;
                }
                if (this.selectedOrder) {
                    this.selectedOrder = data.filter(order => order.Id == this.selectedOrder.Id)[0];
                }
            }
        });
    },
    setSelectedOrder(order) {
      if (this.selectedOrder == order) {
        this.selectedOrder = null;
      } else {
        // this.viewDetailMode = true;
        this.selectedOrder = order;
        // get equipments in the selected work order - start
        this.equipments = [];
        let equipmentsUrl = `${Server.WORKORDER_API_PATH}/${this.selectedOrder.Id}/equipments`;
        this.axios.get(equipmentsUrl)
            .then((res) => {
                let data = res.data;
                data.forEach(equipment => {
                    this.equipments.push(equipment);
                });
            })
            .catch((error) => {
                console.log(error);
            })
        this.mapViewSelectedLocation = null;
        let positionUrl = `${Server.LOCATION_BLOCK_FLOOR_TILE_API_PATH}/${this.selectedOrder.Location.Id}`;
        this.axios.get(positionUrl)
            .then((res) => {
                if (res.data) {
                    this.mapViewSelectedLocation = res.data;
                }
            });
        // get equipments in the selected work order - end
      }
    },
    // when click on an orderblock, add 'is-active-block' class to it
    isActive(orderId) {
      if (this.selectedOrder && orderId != this.selectedOrder.Id) {
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
        this.toDisplayWorkOrders = this.tempValues;
      }
    },
    filterOrders() {
      if (this.tempValues == null) {
        this.tempValues = this.toDisplayWorkOrders;
      }
      this.toDisplayWorkOrders = []; // reset orders before applying new filters
      this.selectedOrder = null;
      if (this.filterOptionsValues.status.length > 0) {
        this.filterOptionsValues.status.forEach(status => {
          this.toDisplayWorkOrders = this.toDisplayWorkOrders.concat(this.tempValues.filter(order => order.WorkOrderStatus == status.name));
        });
      } else {
          this.toDisplayWorkOrders = this.tempValues;
      }
      if (this.filterOptionsValues.priorities.length > 0) {
        var tempValues = [];
        this.filterOptionsValues.priorities.forEach(priority => {
          tempValues = tempValues.concat(this.toDisplayWorkOrders.filter(order => order.Priority == priority.name));
        });
        this.toDisplayWorkOrders = tempValues;
      }
      this.toDisplayWorkOrders = this.sortOrdersByDate(this.toDisplayWorkOrders);
    //   this.selectedFilter = null;
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
        this.changeWorkOrderStatus(orderId, 'Cancelled');
    },
    approveRejectWorkOrder(orderId) {
        if (!this.approveWorkOrder && this.changeStatusDescription == '') {
            this.Errors.RejectedDescriptionNotProvided = 'You must explain why you reject this order';
        } else {
            let newStatusName = this.approveWorkOrder ? 'Approved' : 'Rejected';
            this.changeWorkOrderStatus(orderId, newStatusName);
        }
    },
    changeWorkOrderStatus(orderId, newOrderStatusName) {
        let url = `${Server.WORKORDER_API_PATH}/status/${orderId}`;
        this.axios.put(url, {
            userId: this.authUser.Id,
            newStatusName: newOrderStatusName,
            description: this.changeStatusDescription != '' ? this.changeStatusDescription : null
        })
            .then((res) => {
                if (res.status == 200) {
                    if (newOrderStatusName == 'Approved' 
                            || newOrderStatusName == 'In Progress' 
                            || newOrderStatusName == 'Closed') {
                        let newItemStatusName = '';
                        if (newOrderStatusName == 'Approved') {
                            newItemStatusName = 'Working Requested';
                        } else if (newOrderStatusName == 'In Progress') {
                            newItemStatusName = 'Working';
                        } else if (newOrderStatusName == 'Closed') {
                            newItemStatusName = 'Available';
                        }
                        this.selectedOrder.WorkOrderDetails.forEach(async orderDetail => {
                            let equipmentStatusApi = `http://localhost:3000/api/equipmentItem/status/${orderDetail.EquipmentItem.Id}`;
                            await this.axios.put(equipmentStatusApi, {
                                userId: this.authUser.Id,
                                newStatusName: newItemStatusName,
                                description: null,
                            })
                        });
                    }
                    this.showCancelDialog = false;
                    this.showApproveRejectDialog = false;
                    this.showChangeStatusDialog = false;
                    this.getWorkOrders();
                    // this.selectedOrder.StatusID = newStatusId;
                    // this.selectedOrder.WorkOrderStatus = `${newStatusName}`;
                    // if (newStatusName == 'Closed' || newStatusId == 'Cancelled') {
                    //     url = `${Server.EQUIPMENTITEM_API_PATH}/status/${}`
                    // }
                }
            })
            .catch((error) => {
                console.log(error);
            })
    },
    getStatusColorClass(statusName) {
        switch(statusName) {
            case 'Requested': return 'requested';
            case 'Checked': return 'checked';
            case 'Approved': return 'approved';
            case 'Rejected': return 'rejected';
            case 'In Progress': return 'in-progress';
            case 'Closed': return 'closed';
            case 'Cancelled': return 'cancelled';
        }
    },
    getStatusColor(statusName) {
        switch(statusName) {
            case 'Requested': return 'var(--status-requested)';
            case 'Checked': return 'var(--status-checked)';
            case 'Approved': return 'var(--status-approved)';
            case 'Rejected': return 'var(--status-rejected)';
            case 'In Progress': return 'var(--status-in-progress)';
            case 'Closed': return 'var(--status-closed)';
            case 'Cancelled': return 'var(--status-cancelled)';
        }
    },
    getFormatDate(date) {
        return moment(date).format('L');
    },
    updateItemPosition(itemId, tileId) {
        let url = `${Server.EQUIPMENTITEM_API_PATH}/position/tile/${itemId}`;
        this.axios.put(url, {
            tileId: tileId,
        }).then((res) => {
            if (res.status == 200) {
                this.getWorkOrders();
                this.showUpdateItemPosition = false;
            }
        });
    }
    // closeWorkOrderDetail(selectedOrderId, itemId) {

    // }
  },
  watch: {
    changeStatusDescription: function() {
        if (this.showApproveRejectDialog && !this.approveWorkOrder && this.changeStatusDescription != '') {
            this.Errors.RejectedDescriptionNotProvided = '';
        }
    },
    myWorkOrderViewMode: function() {
        this.selectedOrder = null;
        this.toDisplayWorkOrders = [];
        if (this.myWorkOrderViewMode) {
            this.toDisplayWorkOrders = this.myWorkOrders;
        } else {
            this.toDisplayWorkOrders = this.workOrders;
        }
        this.filterOrders();
    }, 
    showUpdateItemPosition: function() {
        if (this.showUpdateItemPosition) {
            
        }
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
    height: 65.5%;
    max-height: 65.5%;
    padding-right: 0.5rem;
    width: 38%;
    overflow-y: auto;
    padding-bottom: .5rem;
}

.order-detail {
  position: fixed;
  left: 60%;
  height: 62%;
  max-height: 62%;
  overflow-y: auto;
  width: 38%;
  z-index: 2;
}

.detail {
    padding: .5rem 1rem;
}

.detail-header {
    
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

.view-mode {
    text-align: center;
    background-color: white;
    padding: 0.2rem 0.6rem;
    font-size: .95rem;
    color: var(--primary-color);
    border-top: 1px solid var(--primary-color);
    border-bottom: 1px solid var(--primary-color);
}

.view-mode:first-child {
    border-left: 1px solid var(--primary-color);
    border-radius: 5px 0 0 5px;
}

.view-mode:last-child {
    border-right: 1px solid var(--primary-color);
    border-radius: 0 5px 5px 0;
}

.view-mode:hover {
    color: #263238;
    background-color: #80cbc4;
    cursor: pointer;
}

.view-mode-active {
    color: white;
    background-color: #26a69a;
}

</style>
