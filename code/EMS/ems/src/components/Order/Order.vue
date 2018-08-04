<template>
    <div>        
        <div class="order-content">
            <!-- <div class="orders-view">                 -->
                <div class="">
                  <div class="filter" style="width: 100%; display: grid; grid-template-columns: 6% auto">
                        <div style="font-weight: bold">
                            Filter:
                        </div>
                        <div>
                            <div style="width: 100%; display: grid; grid-template-rows: auto auto,">
                                <div style="user-select: none; display: grid; grid-template-columns: 4rem auto;">
                                        <div>Priority:</div>
                                        <div>
                                            <label class="checkbox" :key="'priorOption' + priority.id" v-for="priority in options.priorities" style="margin-right: .5rem;">
                                                <input type="checkbox" v-on:change="addFilter(priority, $event)" :checked="filterOptionsValues.priorities.includes(priority)">
                                                {{ priority.name }}
                                            </label>                              
                                        </div>                        
                                </div>
                                <div style="user-select: none; display: grid; grid-template-columns: 4rem auto;">
                                        <div>Status:</div>
                                        <div>
                                            <label class="checkbox" :key="'statusOption' + status.id" v-for="status in options.status" style="margin-right: .5rem;">
                                                <input type="checkbox" v-on:change="addFilter(status, $event)" :checked="filterOptionsValues.status.includes(status)">
                                                {{ status.name }}
                                            </label>
                                        </div>
                                </div>

                            </div>
                        </div>
                  </div>
                  <div v-if="authUser.Role == 'Manager' || authUser.Role == 'Equipment Staff'" style="width: 60%; user-select: none">
                      <div class="row" style="margin: 0 !important; margin-bottom: 1rem">
                          <div class="view-mode col-4" 
                                :class="{'view-mode-active': workingOrderViewMode}"
                                v-on:click="() => {$store.state.workOrderPage.workingOrderViewMode = true}">
                              Working Orders
                          </div>
                          <div class="view-mode col-4" 
                                :class="{'view-mode-active': !workingOrderViewMode}"
                                v-on:click="() => {$store.state.workOrderPage.workingOrderViewMode = false}">
                              Maintaining Orders
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
        <div class="order-blocks" :style="{'max-height': (authUser.Role == 'Staff' || authUser.Role == 'Maintainer') ? '79.5%' : '73%',
                                            'min-height': (authUser.Role == 'Staff' || authUser.Role == 'Maintainer') ? '79.5%' : '73%',}">
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
                    :style="{'max-height': (authUser.Role == 'Staff' || authUser.Role == 'Maintainer') ? '76%' : '69.5%',
                            'min-height': (authUser.Role == 'Staff' || authUser.Role == 'Maintainer') ? '76%' : '69.5%',}">
              <div class="detail">
                  <div class="detail-header" style="display: grid" :style="((selectedOrder.WorkOrderStatus == 'Requested'|| selectedOrder.WorkOrderStatus == 'Checked' || selectedOrder.WorkOrderStatus == 'Rejected') && authUser.Id == selectedOrder.RequestUserID) ? 
                                                            'grid-template-columns: 16% 63% 21%;' : 'grid-template-columns: 16% 84%'">
                    <div style="padding-top: .5rem; padding-right: .5rem">
                        <span :style="`background-color: ${selectedOrder.PriorityColor}`" class="tag" style="color: white; width: 100%">
                            {{ selectedOrder.Priority }}
                        </span>
                    </div>                        
                    <div>
                        <span class="detail-title">
                            {{ selectedOrder.Name }}
                        </span>
                    </div>
                    <!-- edit/cancel work order -->
                    <div style="margin-top: .5rem; user-select: none; display: flex; justify-content: flex-end" v-if="authUser.Id == selectedOrder.RequestUserID">
                        <!-- cancel work order -->
                        <a  v-if="selectedOrder.WorkOrderStatus == 'Requested' || selectedOrder.WorkOrderStatus == 'Checked' || selectedOrder.WorkOrderStatus == 'Rejected'"
                            v-on:click="() => {
                                showChangeStatusDialog = true;
                                newStatusName = 'Cancelled';
                            }">Cancel</a> <!-- cancel work order -->
                        <span v-if="selectedOrder.WorkOrderStatus == 'Requested' || selectedOrder.WorkOrderStatus == 'Rejected'">
                            <span>&nbsp;|&nbsp;</span>
                            <!-- cancel work order -->
                            <a v-on:click="$router.push(`/work_order/edit/${selectedOrder.Id}`)">Edit</a> <!-- cancel work order -->
                        </span>
                    </div> <!-- edit/cancel work order -->
                  </div>
                  <div style="">                        
                        <div class="detail-contents" style="margin-top: 1rem;">
                            <step-progress :workOrderStatus="{id: selectedOrder.StatusID, name: selectedOrder.WorkOrderStatus}" :lastOrderStatus="selectedOrder.WorkOrderRecord[0].OldStatus" :statusList="options.status.filter(status => status.name != 'Cancelled')"></step-progress>
                        </div>          
                          <!-- manager approve / reject -->
                        <div v-if="authUser.Role == 'Manager' && selectedOrder.WorkOrderStatus == 'Checked'" class="" style="margin-top: 1.5rem; margin-bottom: .5rem; display: flex; justify-content: center; align-content: center">
                            <div>
                                <button class="button btn-primary material-shadow-animate" style="margin-right: .5rem; width: 5rem" v-on:click="() => {
                                    showApproveRejectDialog = true;
                                    approveWorkOrder = true;
                                }">Approve</button>
                                <button class="button btn-danger material-shadow-animate" style="width: 5rem;" v-on:click="() => {
                                    showApproveRejectDialog = true;
                                    approveWorkOrder = false;    
                                }">Reject</button>
                            </div>
                        </div> <!-- manager approve / reject -->   
                        <div class="detail-contents">
                            <div style="width: 100%; display: flex; justify-content: center; align-content: center" v-if="authUser.Role === 'Equipment Staff' && selectedOrder.WorkOrderStatus == 'Requested'" >
                                <button class="button btn-primary material-shadow-animate" style="margin-right: .5rem; width: 5rem;" v-on:click="() => {
                                    newStatusName = 'Checked';
                                    showChangeStatusDialog = true;
                                }">Checked</button>
                                <button class="button btn-danger material-shadow-animate" style="width: 5rem;" v-on:click="() => {
                                    showApproveRejectDialog = true;
                                    approveWorkOrder = false;    
                                }">Reject</button>
                            </div>
                            <div style="width: 100%; text-align: right" v-if="authUser.Role === 'Equipment Staff' && selectedOrder.WorkOrderStatus == 'Approved'">
                                <button class="button btn-primary material-shadow-animate" v-on:click="() => {
                                    newStatusName = 'In Progress';
                                    showChangeStatusDialog = true;
                                }">Change status to In Progress</button>
                            </div>
                            <div style="width: 100%; text-align: right" v-if="authUser.Role === 'Equipment Staff' && selectedOrder.WorkOrderStatus == 'In Progress'">
                                <button class="button btn-primary material-shadow-animate" v-on:click="() => {
                                    toCloseEquipments = []; 
                                    equipments.forEach(equipment => {
                                        equipment.EquipmentItems.forEach(item => {
                                            if (!item.DetailReturn) {
                                                toCloseEquipments.push({
                                                    equipment: equipment,
                                                    item: item,
                                                    status: 'Available',
                                                    description: '',
                                                    locationOption: null,
                                                    blockOption: null,
                                                    floorOption: null,
                                                    tileOption: null,
                                                    blockError: '',
                                                    floorError: '',
                                                    tileError: '',
                                                    descriptionError: '',
                                                    cost: 0,
                                                });
                                            }
                                        })
                                    })
                                    showCloseWorkOrderDetailDialog = true;
                                    newStatusName = 'Closed';
                                }">Close work order</button>
                            </div>
                      </div>
                      <!-- order detail view mode -->
                      <div style="display: grid; grid-template-columns: 50% 50%; margin: 2rem 4rem;">
                          <div class="view-mode" :class="{'view-mode-active': viewDetailMode}" v-on:click="viewDetailMode = true">Detail</div>
                          <div class="view-mode" :class="{'view-mode-active': !viewDetailMode}" v-on:click="viewDetailMode = false">History</div>                                    
                      </div><!-- order detail view mode -->
                      <!-- detail view mode -->
                      <div v-if="viewDetailMode">
                            <!-- <div class="detail-contents" style="width: 100%;">                                    
                                <span class="detail-label">Created on: </span><span>{{ getDateWithTime(selectedOrder.CreateDate) }}</span>
                            </div>
                            <div class="detail-contents" style="width: 100%;">                                    
                                <span class="detail-label">Requested by: </span><span> <router-link :to="`/account/${selectedOrder.RequestUserID}`">{{ selectedOrder.RequestUserID == authUser.Id ? 'You' : selectedOrder.RequestUsername }}</router-link>. </span><span class="detail-label">Team: </span><span> <router-link :to="`/team/${selectedOrder.Team.Id}`">{{ selectedOrder.Team.Name }}</router-link></span>
                            </div> -->
                            <div class="detail-contents" style="width: 100%;" v-if="selectedOrder.WorkOrderStatus != 'Cancelled'">                                    
                                <div v-if="!selectedOrder.ClosedDate">
                                    <span class="detail-label">Planning to start on </span><span>{{ getDate(selectedOrder.ExpectingStartDate) }}</span><span class="detail-label"> and will close on </span><span>{{ getDate(selectedOrder.ExpectingCloseDate) }}.</span>
                                </div>
                                <div v-if="selectedOrder.StartDate || selectedOrder.ClosedDate" style="margin-top: .5rem">
                                    <span class="detail-label">Started on </span><span>{{ getDateWithTime(selectedOrder.StartDate) }}.</span><span v-if="selectedOrder.ClosedDate"><span class="detail-label"> Closed on </span><span>{{ getDateWithTime(selectedOrder.ClosedDate) }}</span></span>
                                </div>
                            </div>
                            <div class="detail-contents" style="width: 100%;">
                                <div>
                                    <span class="detail-label">Equipments: </span><span v-if="authUser.Id == selectedOrder.RequestUserID && selectedOrder.WorkOrderStatus == 'In Progress' && selectedOrder.Category == 'Working'"><a v-on:click="showUpdateAllEquipmentPostionDialog = true">update equipments' position</a></span>
                                </div>
                                <v-flex>
                                    <v-expansion-panel popout v-model="equipmentPanelIndex">
                                        <v-expansion-panel-content v-for="equipment in equipments" :key="'equipment' + equipment.Id">
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
                                            <v-card style="border: 0" v-for="item in equipment.EquipmentItems" :key="'item' + item.Id">
                                                <v-card-text style="font-size: .9rem">
                                                    <div>
                                                        Serial #: <strong>{{ item.SerialNumber }}</strong><span v-if="!item.DetailReturn && selectedOrder.WorkOrderStatus != 'Cancelled'"> (status: <strong>{{ item.Status.toLowerCase() }}</strong>)</span>
                                                        <span v-if="(authUser.Role == 'Staff')
                                                                    && selectedOrder.WorkOrderStatus == 'In Progress' 
                                                                    && !item.DetailReturn
                                                                    && selectedOrder.Category == 'Working'" >
                                                             | 
                                                            <a v-on:click="() => {
                                                                showUpdateItemPosition = true;
                                                                toUpdatePositionItem = item;
                                                            }">Update position</a>
                                                        </span>
                                                        <span v-if="(authUser.Role === 'Equipment Staff' && selectedOrder.WorkOrderStatus === 'In Progress')
                                                                        && !item.DetailReturn">
                                                            | 
                                                            <a v-on:click="() => {
                                                                //toCloseEquipment = equipment;
                                                                //toCloseEquipmentItem = item;
                                                                toCloseEquipments = [];                                                                
                                                                toCloseEquipments.push({
                                                                    equipment: equipment,
                                                                    item: item,
                                                                    status: 'Available',
                                                                    description: '',
                                                                    locationOption: null,
                                                                    blockOption: null,
                                                                    floorOption: null,
                                                                    tileOption: null,
                                                                    blockError: '',
                                                                    floorError: '',
                                                                    tileError: '',
                                                                    descriptionError: '',
                                                                    cost: 0,
                                                                });

                                                                showCloseWorkOrderDetailDialog = true;
                                                            }">Close</a>
                                                        </span>
                                                        <span v-if="item.DetailReturn"> - Closed at <strong>{{ getDateWithTime(item.DetailReturn.DateTime) }}</strong> with status <strong>{{ item.DetailReturn.ReturnedStatusName == 'Available' ? 'OK' : item.DetailReturn.ReturnedStatusName }}</strong></span>
                                                    </div>
                                                    <div v-if="selectedOrder.WorkOrderStatus != 'Cancelled' 
                                                                && selectedOrder.WorkOrderStatus != 'Closed'
                                                                && !item.DetailReturn
                                                                && selectedOrder.Category == 'Working'">
                                                        Current in: 
                                                        <span v-if="item.BlockFloorTile && selectedOrder.Category == 'Working'">
                                                            {{ item.BlockFloorTile.Location.Name }}
                                                            - Block {{ item.BlockFloorTile.BlockName }} - Floor {{ item.BlockFloorTile.FloorName }}
                                                            - Tile {{ item.BlockFloorTile.TileName }}
                                                        </span>
                                                        <span v-else>undefined</span>
                                                    </div>
                                                </v-card-text>
                                            </v-card>
                                        </v-expansion-panel-content>
                                    </v-expansion-panel>
                                </v-flex>
                            </div>                            
                            <div class="detail-contents" v-if="selectedOrder.Category == 'Working' && selectedOrder.TeamLocation">
                                    <span class="detail-label">Location: </span><span>{{ selectedOrder.TeamLocation.Location.Name }} - {{ selectedOrder.TeamLocation.Location.Address }}</span>
                                    <!-- <img src="http://images.indianexpress.com/2016/11/hazaribagh-759.jpg" /> -->
                                    <GmapMap
                                        :center="{lat:selectedOrder.TeamLocation.Location.Latitude, lng:selectedOrder.TeamLocation.Location.Longitude}"
                                        :zoom="16"
                                        map-type-id="terrain"
                                        style="width: 100%; height:25rem"
                                        :options="{gestureHandling: 'cooperative'}"
                                    >
                                    <GmapMarker
                                        :position="google && new google.maps.LatLng(selectedOrder.TeamLocation.Location.Latitude, selectedOrder.TeamLocation.Location.Longitude)"
                                        :clickable="true"
                                    >
                                        <GmapInfoWindow v-if="(selectedOrder)"
                                                    :position="google && new google.maps.LatLng(selectedOrder.TeamLocation.Location.Latitude, 
                                                                selectedOrder.TeamLocation.Location.Longitude)">
                                        {{ selectedOrder.TeamLocation.Location.Name }} - {{ selectedOrder.TeamLocation.Location.Address }}
                                        </GmapInfoWindow>
                                    </GmapMarker>
                                    </GmapMap>
                            </div>
                      </div><!-- detail view mode -->
                      <!-- history view mode -->
                      <div v-else>
                            <div class="detail-contents" v-if="selectedOrder.WorkOrderRecord">
                                <div style="font-size: .95rem;" :key="'orderRecord' + orderRecord.Id" v-for="(orderRecord, index) in selectedOrder.WorkOrderRecord">
                                    <span class="tag" style="width: 5rem;" :class="getStatusColorClass(orderRecord.NewStatus.Name)">{{ orderRecord.NewStatus.Name }}</span> 
                                        by <span class="tag">{{ orderRecord.ModifiedUser.Id == authUser.Id ? 'You' :  `${orderRecord.ModifiedUser.Role} ${orderRecord.ModifiedUser.Username}` }}</span> on {{ getDate(orderRecord.ModifiedByDateTime) }}
                                        <div style="margin-left: 2.5rem; padding: 1rem 1rem;" :style="((index != (selectedOrder.WorkOrderRecord.length - 1)) || (index == (selectedOrder.WorkOrderRecord.length - 1) && orderRecord.Description)) ? 
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
        <router-link :to="{name: 'create_work_order'}" v-if="authUser.Role === 'Staff' || authUser.Role === 'Maintainer'">
            <button id="btn-add-work-order" class="button is-primary material-shadow-animate">
                Add Work Order
            </button>
        </router-link>

      <!-- equipment detail dialog -->
      <vodal :height="500" :show="equipmentItem != null" @hide="equipmentItem = null" animation="slideUp">
        <equipment-detail-popup :equipment="equipmentItem" class=""></equipment-detail-popup>
      </vodal> <!-- equipment detail dialog -->

      <!-- approve / reject dialog -->
      <modal v-model="showApproveRejectDialog" style="font-family: Roboto" @on-cancel="() => {
            Errors.RejectedDescriptionNotProvided = '';
            showApproveRejectDialog = false
          }" :mask-closable="false">
            <div slot="header" style="font-weight: bold">
                Confirm
            </div>
            <div v-if="selectedOrder" style="font-size: 1rem">
                <span>Are you sure to <span style="font-weight: bold;" :style="{color: approveWorkOrder ? 'var(--primary-color)' : 'var(--danger-color)'}">{{ approveWorkOrder ? 'approve' : 'reject' }}</span> this order <strong>#{{ selectedOrder.Id }} - {{ selectedOrder.Name }}</strong>?</span>
                <div style="font-size: .95rem; font-weight: 500; margin-top: 1.5rem; margin-bottom: .5rem">
                    <span v-if="approveWorkOrder">Description (optional)</span>
                    <span v-else>Why do you reject this order? (required)</span>
                </div>
                <textarea v-model="changeStatusDescription" class="input" style="min-height: 7rem; max-height: 7rem; overflow-y: auto" cols="30" rows="10"></textarea>
                <div class="error-text" style="font-weight: bold !importa3nt"
                        v-if="Errors.RejectedDescriptionNotProvided != ''">
                    {{ Errors.RejectedDescriptionNotProvided }}
                </div>
            </div>
            <div slot="footer">
                <button style="width: 5rem" class="button" @click="showApproveRejectDialog = false">No</button>
                <button class="button btn-primary" style="width: 5rem"
                        :style="Errors.RejectedDescriptionNotProvided != '' ? 'cursor: not-allowed' : ''"
                        @click="approveRejectWorkOrder(selectedOrder.Id)">Yes</button>
            </div>
      </modal> <!-- approve / reject dialog -->

      <!-- change status dialog -->
      <modal v-model="showChangeStatusDialog" @on-cancel="showChangeStatusDialog = false" :mask-closable="false" style="font-family: Roboto">
          <div slot="header" style="font-weight: bold">
                Confirm
            </div>
            <div v-if="selectedOrder" style="font-size: 1rem">
                <div v-if="newStatusName != 'Closed'">
                    <span v-if="newStatusName != 'Cancelled'">Are you sure to change status of this order <strong style="font-style: italic">#{{ selectedOrder.Id }} - {{ selectedOrder.Name }}</strong> to <strong style="font-style: italic">{{ newStatusName }}</strong>?</span>
                    <span v-if="newStatusName == 'Cancelled'">Are you sure to cancel this order <strong style="font-style: italic">#{{ selectedOrder.Id }} - {{ selectedOrder.Name }}</strong>?</span>
                    <div style="font-size: .95rem; font-weight: 500; margin-top: 1.5rem; margin-bottom: .5rem">
                        Description (optional):
                    </div>
                    <textarea v-model="changeStatusDescription" class="input" style="min-height: 7rem; max-height: 7rem; overflow-y: auto" cols="30" rows="10"></textarea>
                </div>
            </div>
            <div slot="footer">
                <button style="width: 5rem" class="button" v-on:click="showChangeStatusDialog = false">
                    No
                </button>
                <button style="width: 5rem" class="button btn-primary" v-on:click="changeWorkOrderStatus(selectedOrder.Id, newStatusName)">
                    Yes
                </button>
            </div>
      </modal> <!-- change status dialog -->

        <!-- change all equipments position -->
        <modal v-model="showUpdateAllEquipmentPostionDialog" @on-cancel="showUpdateAllEquipmentPostionDialog = false" style="font-family: Roboto">
            <div slot="header" style="font-weight: bold">
                    Change equipments' position
            </div>
            <div v-if="selectedOrder && authUser.Role == 'Staff'" style="font-size: 1rem">
                You are about to change all equipments of work order <strong>{{ selectedOrder.Name }}</strong> to location <strong>{{ selectedOrder.TeamLocation.Location.Name }}.</strong>
            </div>
            <div v-if="Errors.errorInvalidPosition != ''" class="error-text">
                {{ Errors.errorInvalidPosition }}
            </div>
            <div slot="footer">
                <button style="" class="button" v-on:click="showUpdateAllEquipmentPostionDialog = false">
                    Cancel
                </button>
                <button style="width: 5rem"
                        :style="{cursor: Errors.errorInvalidPosition != '' ? 'not-allowed' : ''}"
                        class="button btn-primary"
                        v-on:click="changeEquipmentPosition()">
                    Confirm
                </button>
            </div>
        </modal><!-- change all equipments position -->

      <!-- close work detail dialog -->
      <modal :width="selectedOrder && selectedOrder.Category == 'Working' ? 900 : 1000" v-model="showCloseWorkOrderDetailDialog" style="font-family: Roboto" :mask-closable="false">
          <div slot="header" style="font-weight: bold;">
              <span v-if="toCloseEquipments.length > 0 && selectedOrder">
                    {{ toCloseEquipments.length == selectedOrder.WorkOrderDetails.length ? 'Close Order' : 'Close Order Detail' }}
              </span>
          </div>
          <div :style="{
              'font-size': '1rem', 
              'max-height': '50vh',
              'overflow-y': 'auto',
          }">
            <div v-if="closeOrderDetailStep == 0">
                <div style="font-weight: bold; font-size: 0.95rem; margin-bottom: 2rem; display: grid;"
                    :style="{'grid-template-columns': (selectedOrder && selectedOrder.Category == 'Working') ? '40% 10% 10% 10% 29%' : '30% 8% 8% 8% 16% 30%'}">
                    <div>Equipments</div>
                    <div style="text-align: center">Good</div>
                    <div style="text-align: center">Damaged</div>
                    <div style="text-align: center">Lost</div>
                    <div v-if="selectedOrder && selectedOrder.Category == 'Maintain'" style="text-align: center; margin-right: 1rem;">Cost (VND)</div>
                    <div>Description</div>
                </div>
                <div v-if="toCloseEquipments.length > 0" style="display: grid; padding: .5rem;"
                        :style="{'background': (value.status == 'Damaged' ? '#fff1b5' : (value.status == 'Lost' ? '#FF9898' : '')),
                                'grid-template-columns': (selectedOrder && selectedOrder.Category == 'Working') ? '10% 30% 10% 10% 10% 29%' : '7% 23% 8% 8% 8% 16% 30%'}"
                        :key="'toCloseItem' + index" v-for="(value, index) in toCloseEquipments">
                    <div style="display: flex">
                        <img v-show="value.equipment.Image" :src="value.equipment.Image" :alt="value.equipment.Name" style="width: 3rem; height: 3rem;">
                    </div>
                    <div style="display: grid; grid-template-rows: auto auto;">
                        <div style="font-size: .95rem">
                            {{ value.equipment.Name.trim() }}
                        </div>                                            
                        <div style="font-size: .9rem">
                            Serial #: <strong>{{ value.item.SerialNumber }}</strong>
                        </div>
                    </div>
                    <div style="text-align: center">
                        <label class="radio">
                            <input type="radio" :checked="value.status == 'Available'"
                                    :name="`${value.equipment.Name}${value.item.Id}`"
                                    v-on:click="() => {
                                        value.status = 'Available';
                                        value.descriptionError = '';
                                        let check = true;
                                        for (let i = 0; i < toCloseEquipments.length; i++) {
                                            let value =  toCloseEquipments[i];
                                            if ((value.status == 'Damaged' || value.status == 'Lost') && value.description.length < 5) {
                                                value.descriptionError = 'You must provide description for this equipment.';
                                                check = false;
                                            } else {
                                                value.descriptionError = '';
                                            }
                                        }
                                        if (check) {
                                            Errors.closeOrderDamagedLostItemMustProvideDescription = '';
                                        } else {
                                            Errors.closeOrderDamagedLostItemMustProvideDescription = ErrorString.closeOrderDamagedLostItemMustProvideDescription;
                                        }
                                    }">
                        </label>
                    </div>
                    <div style="text-align: center">
                        <label class="radio">
                            <input type="radio" :checked="value.status == 'Damaged'"
                                :name="`${value.equipment.Name}${value.item.Id}`"
                                v-on:click="value.status = 'Damaged'">
                        </label>
                    </div>
                    <div style="text-align: center">
                        <label class="radio">
                            <input type="radio" :checked="value.status == 'Lost'"
                                :name="`${value.equipment.Name}${value.item.Id}`"
                                v-on:click="value.status = 'Lost'">
                        </label>
                    </div>
                    <div style="margin-right: 1rem;" v-if="selectedOrder && selectedOrder.Category == 'Maintain'">
                        <input style="text-align: right;" class="input" type="text" v-model.trim="value.cost" v-on:input="() => {
                            if (value.cost < 0 || value.cost == '') {
                                value.cost = 0;
                            } else if (value.cost.length > 12) {
                                value.cost = '9,999,999,999';
                            }
                            value.cost = getNumberFormattedThousand(value.cost);
                        }">
                    </div>
                    <div>
                        <textarea class="input" cols="30" rows="10" 
                                v-model.trim="value.description"
                                :style="value.descriptionError != '' ? 'border: 1px solid var(--danger-color);' : ''"
                                style="width: 100%; min-height: 3rem; max-height: 3rem"
                                v-on:input="() => {
                                    if (value.description.length >= 5) {
                                        let checkDescriptionDamagedLost = true;
                                        let checkDescriptionMaintain = true;
                                        for (let i = 0; i < toCloseEquipments.length; i++) {
                                            let value =  toCloseEquipments[i];
                                            if ((value.status == 'Damaged' || value.status == 'Lost') && value.description.length < 5) {
                                                value.descriptionError = 'You must provide description for this equipment.';
                                                checkDescriptionDamagedLost = false;
                                            } else if (selectedOrder && selectedOrder.Category == 'Maintain' && value.description.length < 5) {
                                                value.descriptionError = 'You must provide description for this equipment.';
                                                checkDescriptionMaintain = false;
                                            }
                                            else {
                                                value.descriptionError = '';
                                            }
                                        }
                                        if (checkDescriptionMaintain && checkDescriptionDamagedLost) {
                                            Errors.closeOrderDamagedLostItemMustProvideDescription = '';
                                            Errors.closeOrderMaintenanceMustProvideDescription = '';
                                        }
                                        if (!checkDescriptionDamagedLost) {
                                            Errors.closeOrderDamagedLostItemMustProvideDescription = ErrorString.closeOrderDamagedLostItemMustProvideDescription;
                                        }
                                        if (!checkDescriptionMaintain) {
                                            Errors.closeOrderMaintenanceMustProvideDescription = ErrorString.closeOrderMaintenanceMustProvideDescription;
                                        }
                                    }
                                }"></textarea>
                    </div>
                </div>
            </div>
            <div v-if="closeOrderDetailStep == 1">                
                <div style="font-weight: bold; font-size: 0.95rem; margin-bottom: 2rem; display: grid; grid-template-columns: 40% 20% 20% 20%;">
                    <div>Equipment Item</div>
                    <div style="margin: 0 .5rem">Block</div>
                    <div style="margin: 0 .5rem">Floor</div>
                    <div style="margin: 0 .5rem">Tile</div>
                </div>
                <div v-if="toCloseEquipments.length > 0" style="display: grid; grid-template-columns: 10% 30% 20% 20% 20%; padding: .5rem;"
                        :style="{'background': value.status == 'Damaged' ? '#fff1b5' : (value.status == 'Lost' ? '#FF9898' : '')}"
                        :key="'toCloseItem' + index" 
                        v-for="(value, index) in toCloseEquipments">
                    <div style="display: flex">
                        <img v-show="value.equipment.Image" :src="value.equipment.Image" :alt="value.equipment.Name" style="width: 3rem; height: 3rem;">
                    </div>
                    <div style="display: grid; grid-template-rows: auto auto;">
                        <div style="font-size: .95rem">
                            {{ value.equipment.Name.trim() }}
                        </div>                                            
                        <div style="font-size: .9rem">
                            Serial #: <strong>{{ value.item.SerialNumber }}</strong>
                        </div>
                    </div>
                    <div>
                        <div class="select" style="margin: 0 .5rem; width: 95%"
                            v-if="value.locationOption && value.locationOption.blockOptions.length > 0 && value.status != 'Lost'">
                            <select :disabled="value.status == 'Lost'" style="width: 100%" 
                                    :style="value.blockError != '' ? 'border: 1px solid var(--danger-color); border-radius: 5px;' : ''" 
                                    v-model="value.blockOption"
                                    v-on:change="() => {
                                        if (value.blockOption.totalFloor && value.blockOption.floorOptions.length > 0) {
                                            let groundIndex = value.blockOption.totalFloor - 1;
                                            value.floorOption = value.blockOption.floorOptions[groundIndex];
                                            value.floorError = '';
                                            if (value.floorOption.tileOptions.length > 0) {
                                                value.tileOption = value.floorOption.tileOptions[0];
                                                value.tileError = '';
                                            } else {
                                                value.tileOption = null;
                                            }
                                        } else {
                                            value.floorOption = null;
                                            value.tileOption = null;
                                        }
                                        value.blockError = '';
                                    }">
                                <option disabled :value="null">Select a block</option>
                                <option :value="blockOption" 
                                        :key="'blockOption' + value.item.Id + blockOption.value" 
                                        v-for="blockOption in value.locationOption.blockOptions" >{{ blockOption.text }}</option>
                            </select>
                        </div>
                        <div class="select" style="margin: 0 .5rem; width: 95%" v-else>
                            <select :disabled="value.status == 'Lost'" style="width: 100%" 
                                    :style="value.blockError != '' ? 'border: 1px solid var(--danger-color); border-radius: 5px;' : ''" 
                                    v-model="value.blockOption">
                                <option disabled :value="null">Select a block</option>                                
                            </select>
                        </div>
                    </div>
                    <div>
                        <div class="select" style="margin: 0 .5rem; width: 95%"
                            v-if="value.blockOption && value.blockOption.floorOptions.length > 0 && value.status != 'Lost'">
                            <select :disabled="value.status == 'Lost'" style="width: 100%" 
                                    :style="value.floorError != '' ? 'border: 1px solid var(--danger-color); border-radius: 5px;' : ''" 
                                    v-model="value.floorOption"
                                    v-on:change="() => {
                                        if (value.floorOption.tileOptions.length > 0) {
                                            value.tileOption = value.floorOption.tileOptions[0];
                                            value.tileError = '';
                                        }
                                        value.floorError = '';
                                    }">
                                <option disabled :value="null">Select a floor</option>
                                <option :value="floorOption" 
                                        :key="'floorOption' + value.item.Id + floorOption.value" 
                                        v-for="floorOption in value.blockOption.floorOptions" >{{ floorOption.text }}</option>
                            </select>
                        </div>
                        <div class="select" style="margin: 0 .5rem; width: 95%"  v-else>
                            <select :disabled="value.status == 'Lost'" style="width: 100%" 
                                    :style="value.floorError != '' ? 'border: 1px solid var(--danger-color); border-radius: 5px;' : ''" 
                                    v-model="value.floorOption">
                                <option disabled :value="null">Select a floor</option>                                
                            </select>
                        </div>
                    </div>
                    <div>
                        <div class="select" style="margin-left: .5rem; width: 95%"                             
                            v-if="value.floorOption && value.floorOption.tileOptions.length > 0 && value.status != 'Lost'">
                            <select :disabled="value.status == 'Lost'" style="width: 100%"
                                    :style="value.tileError != '' ? 'border: 1px solid var(--danger-color); border-radius: 5px;' : ''"
                                    v-model="value.tileOption" 
                                    v-on:change="() => {
                                        value.tileError = '';
                                    }">
                                <option disabled :value="null">Select a tile</option>
                                <option :value="tileOption" 
                                        :key="'tileOption' + value.item.Id + tileOption.value" 
                                        v-for="tileOption in value.floorOption.tileOptions" >{{ tileOption.text }}</option>
                            </select>
                        </div>
                        <div class="select" style="margin-left: .5rem;; width: 95%" v-else>
                            <select :disabled="value.status == 'Lost'" style="width: 100%" 
                                    :style="value.tileError != '' ? 'border: 1px solid var(--danger-color); border-radius: 5px;' : ''" 
                                    v-model="value.tileOption" >
                                <option disabled :value="null">Select a tile</option>                                
                            </select>
                        </div>
                    </div>
                </div>
            </div>
          </div>
          <div slot="footer">
              <div class="row col-12" style="margin: 0; padding: 0; width: 100%">
                <div v-if="closeOrderDetailStep == 0 && (Errors.closeOrderDamagedLostItemMustProvideDescription != '' || Errors.closeOrderMaintenanceMustProvideDescription != '')"
                    class="row col-8" style="margin: 0; padding: 0; width: 60%">
                    <div class="error-text" v-if="Errors.closeOrderDamagedLostItemMustProvideDescription != ''">{{ Errors.closeOrderDamagedLostItemMustProvideDescription }}</div>
                    <div class="error-text" v-if="Errors.closeOrderMaintenanceMustProvideDescription != ''">{{ Errors.closeOrderMaintenanceMustProvideDescription }}</div>
                </div>
                <div v-else class="row col-8" style="margin: 0; padding: 0; width: 60%">
                    <!-- this is dummy div for creating empty space --> 
                </div>
                <div v-if="closeOrderDetailStep == 1" class="row col-8" style="margin: 0; padding: 0; width: 60%">
                    <div style="margin: 0; padding: 0; text-align: left" class="col-2">
                        <span style="font-weight: bold; font-size: 0.95rem; margin-right: 1rem; position: relative; top: .5rem">Location: </span>
                    </div>
                    <div style="width: 100%; margin: 0; padding: 0;" class="col-8">
                        <basic-select :options="locationOptions"
                            :selected-option="selectedLocationOption"
                            :style="selectedLocationOptionError != '' ? 'border: 1px solid var(--danger-color)' : ''"
                            placeholder="Select a location" 
                            :isDisabled="checkLostItemEqualItemToClose()"
                            @select="locationOption => {
                                selectedLocationOptionError = '';
                                selectedLocationOption = locationOption;
                                    toCloseEquipments.forEach(value => {
                                        if (value.status != 'Lost') {
                                            value.locationOption = locationOption; // detect the ground floor and select its first tile
                                            if (locationOption && locationOption.blockOptions.length > 0) { // check if location has blocks
                                                value.blockOption = locationOption.blockOptions[0]; // select first block
                                                if (value.blockOption.totalFloor && value.blockOption.floorOptions.length > 0) { // check if the block has floors
                                                    let groundIndex = value.blockOption.totalFloor - 1;
                                                    value.floorOption = value.blockOption.floorOptions[groundIndex]; // get the ground floor
                                                    if (value.floorOption.tileOptions.length > 0) { // check if the floor has tiles
                                                        value.tileOption = value.floorOption.tileOptions[0];
                                                        value.tileError = '';
                                                    } else {
                                                        value.tileOption = null;
                                                    } // check if the floor has tiles - end
                                                    value.floorError = '';
                                                } else {
                                                    value.floorOption = null;
                                                    value.tileOption = null;
                                                } // check if the block has floors - end
                                                value.blockError = '';
                                            } else {
                                                value.blockOption = null;
                                                value.floorOption = null;
                                                value.tileOption = null;
                                            } // check if location has blocks - end
                                        }
                                    })
                            }"></basic-select>
                            <div class="error-text" style="text-align: left" v-if="selectedLocationOptionError != ''">
                                {{ selectedLocationOptionError }}
                            </div>
                    </div>
                </div>
                <div v-else class="row col-8" style="margin: 0; padding: 0; width: 60%">
                    <!-- this is dummy div for creating empty space -->
                </div>
                <div class="col-4" style="margin: 0; padding: 0; width: 100%">
                    <button v-if="closeOrderDetailStep == 1" v-on:click="closeOrderDetailStep = 0" 
                                class="button">Back</button>
                    <button class="button btn-primary"
                            :style="(Errors.closeOrderDamagedLostItemMustProvideDescription != '' || Errors.closeOrderMaintenanceMustProvideDescription != '') ? 
                                        'cursor: not-allowed' : ''"
                            @click="() => {
                                if (closeOrderDetailStep == 0) {
                                    let checkDescriptionDamagedLost = true;
                                    let checkDescriptionMaintain = true;
                                    Errors.closeOrderDamagedLostItemMustProvideDescription = '';
                                    Errors.closeOrderMaintenanceMustProvideDescription = '';
                                    for (let i = 0; i < toCloseEquipments.length; i++) {
                                        let value =  toCloseEquipments[i];
                                        if ((value.status == 'Damaged' || value.status == 'Lost') && value.description.length < 5) {
                                            value.descriptionError = 'You must provide description for this equipment.';
                                            checkDescriptionDamagedLost = false;
                                        } else if (selectedOrder && selectedOrder.Category == 'Maintain' && value.description.length < 5) {
                                            value.descriptionError = 'You must provide description for this equipment.';
                                            checkDescriptionMaintain = false;
                                        }
                                        else {
                                            value.descriptionError = '';
                                        }
                                    }
                                    if (checkDescriptionMaintain && checkDescriptionDamagedLost) {
                                        if (selectedOrder && selectedOrder.Category == 'Working') {
                                            closeOrderDetailStep = 1;
                                        } else if (selectedOrder && selectedOrder.Category == 'Maintain') {
                                            closeWorkOrderDetails();
                                        }
                                        Errors.closeOrderDamagedLostItemMustProvideDescription = '';
                                        Errors.closeOrderMaintenanceMustProvideDescription = '';
                                    }
                                    if (!checkDescriptionDamagedLost) {
                                        Errors.closeOrderDamagedLostItemMustProvideDescription = ErrorString.closeOrderDamagedLostItemMustProvideDescription;
                                    }
                                    if (!checkDescriptionMaintain) {
                                        Errors.closeOrderMaintenanceMustProvideDescription = ErrorString.closeOrderMaintenanceMustProvideDescription;
                                    }
                                } else if (closeOrderDetailStep == 1) {
                                    if (!selectedLocationOption.value && !checkLostItemEqualItemToClose()) {
                                        selectedLocationOptionError = 'You must select a location';
                                    } else {
                                        closeWorkOrderDetails();
                                    }
                                }
                            }">
                        {{ (closeOrderDetailStep == 0 && (selectedOrder && selectedOrder.Category == 'Working')) ? 
                            'Next: Update Position' : ((selectedOrder && (toCloseEquipments.length == selectedOrder.WorkOrderDetails.length)) ? 'Close Order' : 'Close Order Detail') }}
                            <i v-show="closeOrderDetailStep == 1 && sending" class="fa fa-circle-o-notch fa-spin"></i>
                    </button>
                </div>
              </div>
          </div>
      </modal> <!-- close work detail dialog -->
      
      <modal v-model="showUpdateItemPosition" style="font-family: Roboto">
            <div slot="header" style="font-weight: bold">
                <span>Update Position</span>
            </div>
            <div :style="{
                'max-height': '50vh',
                'overflow-y': 'auto',
                'font-size': '.95rem',
            }">
                <div v-if="toUpdateSelectedLocation">
                    {{toUpdateSelectedLocation.Name}} - {{toUpdateSelectedLocation.Address}}
                </div>
                <div style="display: grid; grid-template-columns: 30% 30% 30%; grid-column-gap: 5%; margin: 2rem 0;" v-if="toUpdateSelectedLocation">
                    <div style="width: 100%">
                            <div style="width: 100%" class="select">
                                <select style="width: 100%" v-model="updateBlock">
                                    <option disabled :value="null">Select a block</option>
                                    <option :value="block" :key="'updateBlock' + block.Id" v-for="block in toUpdateSelectedLocation.Blocks">
                                        Block {{ block.Name }}
                                    </option>
                                </select>
                            </div>
                    </div>
                    <div style="width: 100%">
                            <div style="width: 100%" class="select" v-if="updateBlock && updateBlock.Floors">
                                <select style="width: 100%" v-model="updateFloor">
                                    <option disabled :value="null">Select a floor</option>
                                    <option :value="floor" :key="'updateFloor' + floor.Id" v-for="floor in updateBlock.Floors">
                                        Floor {{ floor.Name }}
                                    </option>
                                </select>
                            </div>                   
                    </div>
                    <div style="width: 100%">
                            <div style="width: 100%" class="select" v-if="updateFloor && updateFloor.Tiles">
                                <select style="width: 100%" v-model="updateTile">
                                    <option disabled :value="null">Select a tile</option>
                                    <option :value="tile" :key="'updateTileFloor' + tile.Id" v-for="tile in updateFloor.Tiles">
                                        Tile {{ tile.Name }}
                                    </option>
                                </select>
                            </div>
                    </div>
                </div>
                <div v-if="Errors.errorUpdatePosition != ''" style="margin-top: 1rem;">
                    <span class="error-text" style="font-weight: 500 !important">{{ Errors.errorUpdatePosition }}</span>
                </div>
            </div>
            <div slot="footer">
                    <button class="button" 
                        v-on:click="() => {
                            showUpdateItemPosition = false;
                            toUpdatePositionItem = null;
                            updateBlock = null;
                            updateFloor = null;
                            updateTile = null;
                        }">Cancel</button>
                    <button class="button btn-primary" 
                        v-on:click="() => {
                            if (!updateBlock || !updateFloor || !updateTile) {
                                Errors.errorUpdatePosition = ErrorString.errorUpdatePosition;
                            }
                            if (Errors.errorUpdatePosition == '' && updateTile) {
                                updateItemPosition(toUpdatePositionItem.Id, updateTile.Id);
                            }
                    }">Save changes</button>
            </div>
      </modal>
    </div>
</template>

<script>
// import Vue from "vue";
import Vue from "vue";
import { sync } from "vuex-pathify";
import moment from "moment";
import Server from "@/config/config.js";
import OrderBlock from "./OrderBlock/OrderBlock";
import StepProgress from "@/components/StepProgress/StepProgress.vue";
// import OrderDetail from "./OrderDetailComponent/OrderDetail";
import "vodal/common.css";
import "vodal/slide-up.css";
import EquipmentDetailPopup from "@/components/Equipment/EquipmentDetailPopup";
import Vodal from "vodal";
import { gmapApi } from "vue2-google-maps";
import { BasicSelect } from "vue-search-select";
import io from "socket.io-client";
import Utils from "@/utils.js";
import numeral from 'numeral';


export default {
  components: {
    // OrderDetail,
    OrderBlock,
    Vodal,
    EquipmentDetailPopup,
    StepProgress,
    BasicSelect
  },
  sockets: {
        NEW_WORK_ORDER_CREATED: function() {
            this.getWorkOrders();
            // this.filterOrders();
        },
        ORDER_STATUS_CHANGED: function() {
            this.getWorkOrders();
            // this.filterOrders();
        }
  },
  async created() {
    await this.axios
      .get(Server.WORKORDER_STATUS_API_PATH)
      .then(response => {
        let data = response.data;
        for (const element of data) {
          let status = {
            id: element.Id,
            name: element.Name,
            type: this.optionTypes.STATUS
          };
          this.options.status.push(status);
          if (status.name != "Cancelled" && status.name != "Closed") {
            this.filterOptionsValues.status.push(status);
          }
        }
      })
      .catch(error => {
        if (error == "Request failed with status code 500") {
          this.$router.push("/500");
        }
      });
    await this.axios
      .get(Server.WORKORDER_PRIORITIES_API_PATH)
      .then(response => {
        let data = response.data;
        for (const element of data) {
          let priority = {
            id: element.Id,
            name: element.Name,
            type: this.optionTypes.PRIORITY
          };
          this.options.priorities.push(priority);
          this.filterOptionsValues.priorities.push(priority);
        }
      })
      .catch(error => {
        if (error == "Request failed with status code 500") {
          this.$router.push("/500");
        }
      });

    this.getWorkOrders();
    this.getBlockFloorTile();
  },
  data() {
    return {
        // socket: io(`http://localhost:3000`),
        ErrorString: {
            errorInvalidPosition: 'The location has invalid positions (missing blocks or floors or tiles).',
            closeOrderDamagedLostItemMustProvideDescription: 'You must provide description for the damaged/lost equipments.',
            errorUpdatePosition: 'You must select block, floor and tile to update position.',
            closeOrderMaintenanceMustProvideDescription: 'You must provide description for maintained equipments.',
        },
        Errors: {
            RejectedDescriptionNotProvided: '',
            closeOrderDamagedLostItemMustProvideDescription: '',
            errorUpdatePosition: '',
            errorInvalidPosition: '',
            closeOrderMaintenanceMustProvideDescription: '',
        },
        tempValues: null, // to hold the original orders when apply filters
        toDisplayWorkOrders: [],
        workingOrders: [],
        maintainingOrders: [],
        workOrders: [], // orders data to display in orderblocks <order-block></order-block>
        selectedOrder: null, // to provide order to OrderDetail component <order-detail></order-detail>
        equipments: [], // to hold equipments in the selected work order
        equipmentPanelIndex: [true, ],
        selectedEquipmentPanelIndex: -1,
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
        showUpdateItemPosition: false,
        
        blockFloorTiles: [],
        toUpdateSelectedLocation: null,
        locationOptions: [],        


      toUpdatePositionItem: null,
      updateBlock: null,
      updateFloor: null,
      updateTile: null,

      showCloseWorkOrderDetailDialog: false,
      toCloseEquipment: null,
      toCloseEquipmentItem: null,
      toCloseItemStatus: "Available",
      toCloseItemDescription: "",
      toCloseEquipments: [],
      closeOrderDetailStep: 0,
      selectedLocationOptionError: "",


        showUpdateAllEquipmentPostionDialog: false,

        selectedLocationOption: {},
        sending: false,
    };
  },
  computed: {
    workingOrderViewMode: sync("workOrderPage.workingOrderViewMode"),
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    },
    google: gmapApi,
  },
  methods: {
    getWorkOrders() {
        this.axios.get(Server.WORKORDER_API_PATH).then((response) => {
            if (response.data.WorkOrders) {
                let data = response.data.WorkOrders;
                this.tempValues = null;
                this.workOrders = data;
                if (this.authUser.Role == 'Manager' || this.authUser.Role == 'Equipment Staff') {
                    this.workingOrders = data.filter(order => order.Category == 'Working');
                    this.maintainingOrders = data.filter(order => order.Category == 'Maintain');
                    if (this.workingOrderViewMode) {
                        this.toDisplayWorkOrders = data.filter(order => order.Category == 'Working');
                    } else {
                        this.toDisplayWorkOrders = data.filter(order => order.Category == 'Maintain');
                    }
                } else {
                    this.toDisplayWorkOrders = data.filter(order => order.RequestUserID == this.authUser.Id);
                }
                if (this.selectedOrder) {
                    let order = this.toDisplayWorkOrders.filter(o => o.Id == this.selectedOrder.Id)[0];
                    if (order) {
                        this.selectedOrder = order;
                        this.getEquipmentsOfWorkOrder(order);
                        if (order.TeamLocation && order.Category == 'Working') {
                            this.toUpdateSelectedLocation = this.blockFloorTiles.filter(location => location.Id == order.TeamLocation.Location.Id)[0];
                        }
                    } else {
                        this.selectedOrder = null;
                        this.$router.replace('/work_order');
                    }
                } else if (this.$route.params && this.$route.params.orderId) {
                    let order = this.toDisplayWorkOrders.filter(o => o.Id == this.$route.params.orderId)[0];
                    if (order) {
                        this.selectedOrder = order;
                        this.getEquipmentsOfWorkOrder(order);
                        if (order.TeamLocation && order.Category == 'Working') {
                            this.toUpdateSelectedLocation = this.blockFloorTiles.filter(location => location.Id == order.TeamLocation.Location.Id)[0];
                        }
                    } else {
                        this.selectedOrder = null;
                        this.$router.replace('/work_order');
                    }
                } 
                this.filterOrders();
            }
        }).catch(error => {
            console.log(error);
            this.$router.push('/500');

        });
    },
    getBlockFloorTile() {
      let url = `${Server.LOCATION_BLOCK_FLOOR_TILE_API_PATH}`;
      this.axios.get(url).then(res => {
        if (res.status == 200) {
          this.blockFloorTiles = res.data;
          this.blockFloorTiles.forEach(location => {
            let blockOptions = [];
            if (location.Blocks) {
              location.Blocks.forEach(block => {
                let floorOptions = [];
                if (block.Floors) {
                  block.Floors.forEach(floor => {
                    let tileOptions = [];
                    if (floor.Tiles) {
                      floor.Tiles.forEach(tile => {
                        let tileOption = {
                          value: parseInt(tile.Id),
                          text: tile.Name
                        };
                        tileOptions.push(tileOption);
                      });
                    }

                    let floorOption = {
                      value: parseInt(floor.Id),
                      text: floor.Name,
                      tileOptions: tileOptions
                    };
                    floorOptions.push(floorOption);
                  });
                }

                let blockOption = {
                  value: parseInt(block.Id),
                  text: block.Name,
                  floorOptions: floorOptions,
                  totalFloor: block.TotalFloor,
                  totalBasementFloor: block.TotalBasementFloor
                };
                blockOptions.push(blockOption);
              });
            }

            let locationOption = {
              value: parseInt(location.Id),
              text: `${location.Name} - ${location.Address}`,
              blockOptions: blockOptions
            };
            this.locationOptions.push(locationOption);
          });
        }
      });
    },
    setSelectedOrder(order) {
        // this.equipmentPanelIndex = -1;
        if (this.$route.params && (this.$route.params.orderId == order.Id)) {
            this.$router.replace('/work_order');
            this.selectedOrder = null;
        } else {
            // this.viewDetailMode = true;
            this.$router.replace(`/work_order/${order.Id}`)
            // this.selectedOrder = order;
            // get equipments in the selected work order - start
            // this.getEquipmentsOfWorkOrder(order);
            // this.toUpdateSelectedLocation = this.blockFloorTiles.filter(location => location.Id == order.Location.Id)[0];
            // get equipments in the selected work order - end
        }
    },
    async getEquipmentsOfWorkOrder(workOrder) {
      this.equipments = [];
      let equipmentsUrl = `${Server.WORKORDER_API_PATH}/${
        workOrder.Id
      }/equipments`;
      await this.axios
        .get(equipmentsUrl)
        .then(res => {
          this.equipments = res.data;
        })
        .catch(error => {
          console.log(error);
        });
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
      switch (filter.type) {
        case this.optionTypes.STATUS: {
          this.filterOptionsValues.status = this.filterOptionsValues.status.filter(
            status => filter.id != status.id
          );
          break;
        }
        case this.optionTypes.PRIORITY: {
          this.filterOptionsValues.priorities = this.filterOptionsValues.priorities.filter(
            priority => filter.id != priority.id
          );
          break;
        }
      }
      this.filterOrders();
      if (
        this.filterOptionsValues.status.length == 0 &&
        this.filterOptionsValues.priorities.length == 0
      ) {
        this.selectedFilter = null;
        this.toDisplayWorkOrders = this.tempValues;
      }
    },
    filterOrders() {
      if (
        this.filterOptionsValues.status.length > 0 ||
        this.filterOptionsValues.priorities.length > 0
      ) {
        if (this.tempValues == null) {
          this.tempValues = this.toDisplayWorkOrders;
        }
        this.toDisplayWorkOrders = []; // reset orders before applying new filters
        // this.selectedOrder = null;
        // this.$router.replace('/work_order');
        if (this.filterOptionsValues.status.length > 0) {
          this.filterOptionsValues.status.forEach(status => {
            this.toDisplayWorkOrders = this.toDisplayWorkOrders.concat(
              this.tempValues.filter(
                order => order.WorkOrderStatus == status.name
              )
            );
          });
        } else {
          this.toDisplayWorkOrders = this.tempValues;
        }
        if (this.filterOptionsValues.priorities.length > 0) {
          let tempValues = [];
          this.filterOptionsValues.priorities.forEach(priority => {
            tempValues = tempValues.concat(
              this.toDisplayWorkOrders.filter(
                order => order.Priority == priority.name
              )
            );
          });
          this.toDisplayWorkOrders = tempValues;
        }
        this.toDisplayWorkOrders = this.sortOrdersByDate(
          this.toDisplayWorkOrders
        );

        if (this.selectedOrder) {
            let order = this.toDisplayWorkOrders.filter(o => o.Id == this.selectedOrder.Id)[0];
            if (!order) {
                this.selectedOrder = null;
                this.$router.replace('/work_order');
            }
        }
        //   this.selectedFilter = null;
        // for (var i = 0; i < this.filterValues.length; i++) {
        //     this.orders = this.sortOrdersByDate(this.orders);
        // }
      }
    },
    sortOrdersByDate(orders) {
      return orders.sort((order1, order2) => {
        let date1 = parseInt(new Date(order1.CreateDate).getTime());
        let date2 = parseInt(new Date(order2.CreateDate).getTime());
        // alert(order1.Id + ' ' + order2.Id + ' ' + order2.PriorityId  + ' ' + order1.PriorityId);
        let result = date2 - date1;
        return result > 0
          ? 1
          : result < 0 ? -1 : order2.PriorityID - order1.PriorityID;
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
      this.axios.get(url).then(res => {
        if (res.data) {
          this.equipmentItem = res.data;
        }
      });
    },
    showAlert(msg) {
      alert(msg);
    },
    cancelOrder(orderId) {
      this.changeWorkOrderStatus(orderId, "Cancelled");
    },
    approveRejectWorkOrder(orderId) {
      if (!this.approveWorkOrder && this.changeStatusDescription == "") {
        this.Errors.RejectedDescriptionNotProvided =
          "You must explain why you reject this order";
      } else {
        let newStatusName = this.approveWorkOrder ? "Approved" : "Rejected";
        this.changeWorkOrderStatus(orderId, newStatusName);
      }
    },
    async changeWorkOrderStatus(orderId, newOrderStatusName) {
      let url = `${Server.WORKORDER_API_PATH}/status/${orderId}`;
      this.axios
        .put(url, {
          userId: this.authUser.Id,
          newStatusName: newOrderStatusName,
          description:
            this.changeStatusDescription != ""
              ? this.changeStatusDescription
              : null,
          noNeedToRefreshWorkOrderUserId: this.authUser.Id
        })
        .then(async res => {
          if (res.status == 200) {
            if (
              newOrderStatusName == "Approved" ||
              newOrderStatusName == "In Progress" ||
              newOrderStatusName == "Closed") {
                let newItemStatusName = "";
                if (newOrderStatusName == "Approved") {
                    if (this.selectedOrder.Category == 'Working') {
                        newItemStatusName = "Working Approved";
                    } else if (this.selectedOrder.Category == 'Maintain') {
                        newItemStatusName = "Maintainance Approved";
                    }
                } else if (newOrderStatusName == "In Progress") {
                    if (this.selectedOrder.Category == 'Working') {
                        newItemStatusName = "Working";
                    } else if (this.selectedOrder.Category == 'Maintain') {
                        newItemStatusName = "Maintaining";
                    }
                }
                for (const orderDetail of this.selectedOrder.WorkOrderDetails) {
                    let equipmentStatusApi = `http://localhost:3000/api/equipmentItem/status/chau/${orderDetail.EquipmentItem.Id}`;
                    await this.axios.put(equipmentStatusApi, {
                        userId: this.authUser.Id,
                        newStatusName: newItemStatusName,
                        description: null
                    });
                }
            }
            this.$socket.emit("ORDER_STATUS_CHANGED", {});

            // make new notification
            let teamLeaderNotiContent = '';
            let managerNotiContent = '';
            let metaData = {
              page: "work_order",
              elementId: this.selectedOrder.Id
            };
            // prepare notification content - start
            if (newOrderStatusName == "Checked" 
                || newOrderStatusName == 'Approved' 
                || newOrderStatusName == 'Rejected') {
                teamLeaderNotiContent = `${this.authUser.Role} <strong>${this.authUser.Username}</strong> has <strong>${newOrderStatusName.toLowerCase()}</strong> your work order <strong>${this.selectedOrder.Name}</strong>`;
                if ((newOrderStatusName == "Checked" || newOrderStatusName == 'Rejected') && this.authUser.Role == 'Equipment Staff') {
                    managerNotiContent = `${this.authUser.Role} <strong>${this.authUser.Username}</strong> has <strong>${newOrderStatusName.toLowerCase()}</strong> work order <strong>${this.selectedOrder.Name}</strong>`;
                }
            } else if (newOrderStatusName == 'In Progress' && this.selectedOrder.Category == 'Working') {
                teamLeaderNotiContent = `Your work order <strong>${this.selectedOrder.Name}</strong> has changed status to <strong>In Progress</strong>. Please remember to change new position for equipments.`;
            } // prepare notification content - end
            
            if (newOrderStatusName != 'Closed') {
                // notification for managers and equipment staff - start
                if ((newOrderStatusName == 'Checked' || newOrderStatusName == 'Rejected') && this.authUser.Role == 'Equipment Staff') {
                    await this.axios.post(`${Server.NOTIFICATION_API_PATH}/accounts`, {
                        notificationContent: managerNotiContent,
                        userRole: 'Manager',
                        metaData: JSON.stringify(metaData),
                    }).then((res) => {
                        if (res.status == 200) {
                            this.$socket.emit('NEW_NOTIFICATION', {});
                        }
                    });
                } else if (newOrderStatusName == 'Cancelled') {
                    await this.axios.post(`${Server.NOTIFICATION_API_PATH}/accounts`, {
                        notificationContent: `${this.authUser.Role} <strong>${this.authUser.Username}</strong> has cancelled work order <strong>${this.selectedOrder.Name}</strong>`,
                        userRole: 'Equipment Staff',
                        metaData: JSON.stringify(metaData),
                    }).then((res) => {
                        if (res.status == 200) {
                            this.$socket.emit('NEW_NOTIFICATION', {});
                        }
                    });
                    await this.axios.post(`${Server.NOTIFICATION_API_PATH}/accounts`, {
                        notificationContent: `${this.authUser.Role} <strong>${this.authUser.Username}</strong> has cancelled work order <strong>${this.selectedOrder.Name}</strong>`,
                        userRole: 'Manager',
                        metaData: JSON.stringify(metaData),
                    }).then((res) => {
                        if (res.status == 200) {
                            this.$socket.emit('NEW_NOTIFICATION', {});
                        }
                    });
                } // notification for managers and equipment staff - end
                // notification for teamleader and maintainer - start
                if (newOrderStatusName == 'Checked'
                    || newOrderStatusName == 'Approved'
                    || newOrderStatusName == 'Rejected'
                    || (newOrderStatusName == 'In Progress' && this.selectedOrder.Category == 'Working')) {
                    await this.axios.post(`${Server.NOTIFICATION_API_PATH}/userid/${this.selectedOrder.RequestUserID}`, {
                        notificationContent: teamLeaderNotiContent,
                        metaData: JSON.stringify(metaData),
                    }).then((res) => {
                        if (res.status == 200) {
                            this.$socket.emit('NEW_NOTIFICATION', {});
                        }
                      });
                    }
                  });
              }
              // notification for teamleader and maintainer - end
            }
            // await Utils.sleep(500);
            this.changeStatusDescription = "";
            this.showCancelDialog = false;
            this.showApproveRejectDialog = false;
            this.showChangeStatusDialog = false;
            this.newStatusName = null;
            this.getWorkOrders();
            // this.$router.replace('/work_order');
          }
        })
        .catch(error => {
          console.log(error);
          this.$router.push('/500');
        });
    },
    getStatusColorClass(statusName) {
      switch (statusName) {
        case "Requested":
          return "requested";
        case "Checked":
          return "checked";
        case "Approved":
          return "approved";
        case "Rejected":
          return "rejected";
        case "In Progress":
          return "in-progress";
        case "Closed":
          return "closed";
        case "Cancelled":
          return "cancelled";
      }
    },
    getStatusColor(statusName) {
      switch (statusName) {
        case "Requested":
          return "var(--status-requested)";
        case "Checked":
          return "var(--status-checked)";
        case "Approved":
          return "var(--status-approved)";
        case "Rejected":
          return "var(--status-rejected)";
        case "In Progress":
          return "var(--status-in-progress)";
        case "Closed":
          return "var(--status-closed)";
        case "Cancelled":
          return "var(--status-cancelled)";
      }
    },

    getDate(date) {
      return moment(date).format("L");
    },
    getDateWithTime(date) {
      return moment(date).format("LLL");
    },
    async updateItemPosition(itemId, tileId) {
      this.equipmentPanelIndex = -1;
      let url = `${Server.EQUIPMENTITEM_API_PATH}/position/tile/${itemId}`;
      this.axios
        .put(url, {
          tileId: tileId
        })
        .then(async res => {
          if (res.status == 200) {
            if (this.showUpdateItemPosition) {
              // if update item position dialog is displaying
              this.toUpdatePositionItem = null;
              this.updateBlock = null;
              this.updateFloor = null;
              this.updateTile = null;
              this.showUpdateItemPosition = false;

              await this.getEquipmentsOfWorkOrder(this.selectedOrder);
              // this.equipmentPanelIndex = this.selectedEquipmentPanelIndex;
            }
          }
        });
    },
    async closeWorkOrderDetails() {
        if (this.validateCloseWorkOrder()) {
            this.sending = true;
            let check = true;
            for (const value of this.toCloseEquipments) {
                let workOrderDetail = null;
                for (const detail of this.selectedOrder.WorkOrderDetails) {
                    if (detail.EquipmentItemID == value.item.Id) {
                        workOrderDetail = detail;
                        break;
                    }
                }
                let url = `${Server.WORKORDER_API_PATH}/close_detail/${workOrderDetail.Id}`;
                await this.axios.post(url, {                
                    userId: this.authUser.Id,
                    itemId: value.item.Id,
                    newItemStatus: value.status,
                    description: value.description,
                    cost: this.selectedOrder.Category == 'Maintain' ? value.cost : null,
                }).then(async (response) => {
                    if (response.status == 200) {
                        let tileId = null;
                        if (this.selectedOrder.Category == 'Working') {
                            tileId = parseInt(value.tileOption.value);
                        }
                        if (this.selectedOrder.Category == 'Working') {
                            let equipmentItemRuntimeDaysApi = `${Server.EQUIPMENTITEM_API_PATH}/runtimedays/${value.item.Id}`;
                            await this.axios.put(equipmentItemRuntimeDaysApi, {
                                workOrderId: this.selectedOrder.Id
                            });
                        }
                        if (this.selectedOrder.Category == 'Working' || value.status == 'Lost') {
                            let equipmentItemTileApi = `${Server.EQUIPMENTITEM_API_PATH}/position/tile/${value.item.Id}`;
                            await this.axios.put(equipmentItemTileApi, {
                                tileId: tileId,
                            });
                        }
                        if (this.selectedOrder.Category == 'Maintain') {
                            let equipmentItemMaintenanceApi = `${Server.EQUIPMENTITEM_API_PATH}/maintenance/${value.item.Id}`;
                            await this.axios.put(equipmentItemMaintenanceApi, {
                                nextMaintainDate: moment().add(value.item.MaintenanceDurationInMonths, 'M').format('MM-DD-YYYY'),
                            });
                        }
                    } else {
                        check = false;
                    }
                }).catch(error => {
                    console.log(error);
                    this.$router.push('/500');
                    check = false;
                })
            }
            // await Utils.sleep(500);
            this.sending = false;
            if (check) {
                // awthis.updateItemPosition(parseInt(value.item.Id), tileId);   
                this.$socket.emit('CLOSE_WORK_ORDER_DETAIL', {});
                this.getWorkOrders();
                // this.getEquipmentsOfWorkOrder(this.selectedOrder);
                this.showCloseWorkOrderDetailDialog = false;
            } else {
                alert('Error occured!')
            }
          }
          let url = `${Server.WORKORDER_API_PATH}/close_detail/${
            workOrderDetail.Id
          }`;
          await this.axios
            .post(url, {
              userId: this.authUser.Id,
              itemId: value.item.Id,
              newItemStatus: value.status,
              description: value.description
            })
            .then(response => {
              if (response.status == 200) {
                check = true;
                var tileId = null;
                if (value.status != "Lost") {
                  tileId = parseInt(value.tileOption.value);
                }
              } else {
                check = false;
              }
            })
            .catch(error => {
              console.log(error);
              check = false;
            });
        }
        // await Utils.sleep(500);
        this.sending = false;
        if (check) {
          // awthis.updateItemPosition(parseInt(value.item.Id), tileId);
          this.$socket.emit("CLOSE_WORK_ORDER_DETAIL", {
            noNeedToRefreshWorkOrderUserId: this.authUser.Id
          });
          this.getWorkOrders();
          // this.getEquipmentsOfWorkOrder(this.selectedOrder);
          this.showCloseWorkOrderDetailDialog = false;
        } else {
          alert("Error occured!");
        }
      }
    },
    validateCloseWorkOrder() {
        let check = true;
        if (this.selectedOrder.Category == 'Working') {
            this.toCloseEquipments.forEach(value => {
                if (value.status != 'Lost') {
                    if (!value.blockOption) {
                        value.blockError = 'You must select a block';
                        check = false;
                    }
                    if (!value.floorOption) {
                        value.floorError = 'You must select a floor';
                        check = false;
                    }
                    if (!value.tileOption) {
                        value.tileError = 'You must select a tile';
                        check = false;
                    }
                }
            });
        }
        return check;
    },
    async changeEquipmentPosition() {
        let tileId = -1;
        if (this.toUpdateSelectedLocation 
            && (this.toUpdateSelectedLocation.Blocks && this.toUpdateSelectedLocation.Blocks.length > 0) 
            && (this.toUpdateSelectedLocation.Blocks[0].Floors && this.toUpdateSelectedLocation.Blocks[0].Floors.length > 0)
            && (this.toUpdateSelectedLocation.Blocks[0].Floors[this.toUpdateSelectedLocation.Blocks[0].TotalFloor - 1].Tiles 
                && this.toUpdateSelectedLocation.Blocks[0].Floors[this.toUpdateSelectedLocation.Blocks[0].TotalFloor - 1].Tiles.length > 0)) {
            tileId = this.toUpdateSelectedLocation.Blocks[0].Floors[this.toUpdateSelectedLocation.Blocks[0].TotalFloor - 1].Tiles[0].Id;
        } else {                    
            this.Errors.errorInvalidPosition = this.ErrorString.errorInvalidPosition;
        }
        // console.log(tileId)
        if (tileId != -1) {
            for (const equipment of this.equipments) {
                for (const item of equipment.EquipmentItems) {
                    let url = `${Server.EQUIPMENTITEM_API_PATH}/position/tile/${item.Id}`;
                    await this.axios.put(url, {
                        tileId: tileId,
                    });
                }
            }
            this.showUpdateAllEquipmentPostionDialog = false;
            this.getWorkOrders();
        }
    },
    checkLostItemEqualItemToClose() {
        let count = 0;
        for (const value of this.toCloseEquipments) {
            if (value.status == 'Lost') {
                ++count;
            }
        }
        return count == this.toCloseEquipments.length;
    },
    getNumberFormattedThousand(str) {
        let value = numeral(str).value();
        return numeral(value).format('0,0');
    },
  },
  watch: {
    showCloseWorkOrderDetailDialog: function() {
      if (!this.showCloseWorkOrderDetailDialog) {
        this.toCloseEquipments = [];
        this.selectedLocationOption = {};
        this.closeOrderDetailStep = 0;
        this.newStatusName = null;
      }
    },
    showApproveRejectDialog: function() {
      this.Errors.RejectedDescriptionNotProvided = "";
    },
    changeStatusDescription: function() {
      if (
        this.showApproveRejectDialog &&
        !this.approveWorkOrder &&
        this.changeStatusDescription != ""
      ) {
        this.Errors.RejectedDescriptionNotProvided = "";
      }
    },
    'workingOrderViewMode': function() {
        this.selectedOrder = null;
        this.$route.params.orderId = null;
        this.toDisplayWorkOrders = [];
        this.$router.replace('/work_order');
        if (this.authUser.Role == 'Manager' || this.authUser.Role == 'Equipment Staff') {
            if (this.workingOrderViewMode) {
                this.toDisplayWorkOrders = this.workingOrders;
            } else {
                this.toDisplayWorkOrders = this.maintainingOrders;
            }
        } else {
            this.toDisplayWorkOrders = this.workOrders.filter(order => order.RequestUserID == this.authUser.Id);
        }
        this.tempValues = null;
        this.filterOrders();
    },
    'updateTile': function() {
        Vue.nextTick(() => {
            if (this.updateTile && this.updateTile.Id == this.toUpdatePositionItem.TileID) {
                this.Errors.errorUpdatePosition = 'This item is already in this position';
            } else if (this.updateTile) {
                this.Errors.errorUpdatePosition = '';
            }
        })
    },
    updateTile: function() {
      Vue.nextTick(() => {
        if (
          this.updateTile &&
          this.updateTile.Id == this.toUpdatePositionItem.TileID
        ) {
          this.errorUpdatePosition = "This item is already in this position";
        } else if (this.updateTile) {
          this.errorUpdatePosition = "";
        }
      });
    },
    '$route.params': function() {
        if (this.$route.params.orderId) {
            let toSelectOrder = this.toDisplayWorkOrders.filter(order => order.Id == this.$route.params.orderId)[0];
            if (toSelectOrder) {
                this.selectedOrder = toSelectOrder;
                this.getEquipmentsOfWorkOrder(toSelectOrder);
                if (toSelectOrder.TeamLocation && toSelectOrder.Category == 'Working') {
                    this.toUpdateSelectedLocation = this.blockFloorTiles.filter(location => location.Id == toSelectOrder.TeamLocation.Location.Id)[0];
                }
            }
            // }
        }
    },
    'showUpdateAllEquipmentPostionDialog': function() {
        if (!this.showUpdateAllEquipmentPostionDialog) {
            this.Errors.errorInvalidPosition = '';
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
  display: grid;
  grid-template-columns: 80% 20%;
}

.orders-view {
  width: 30rem !important;
  /* z-index: 2; */
}

.order-blocks {
  position: fixed;
  min-height: 79%;
  max-height: 79%;
  padding-right: 0.5rem;
  width: 38%;
  overflow-y: auto;
  padding-bottom: 0.5rem;
}

.order-detail {
  position: fixed;
  left: 59.5%;
  min-height: 75.5%;
  max-height: 75.5%;
  overflow-y: auto;
  width: 39%;
  z-index: 2;
}

.detail {
  padding: 0.5rem 1rem;
}

.detail-title {
  font-size: 1.7rem;
}

.detail-label {
  font-size: 0.95rem;
  font-weight: bold;
}

.detail-contents {
  font-size: 0.95rem;
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

.view-mode {
  text-align: center;
  background-color: white;
  padding: 0.2rem 0.6rem;
  font-size: 0.95rem;
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
