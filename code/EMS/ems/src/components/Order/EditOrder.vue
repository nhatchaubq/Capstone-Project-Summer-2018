<template>
    <div class="form" v-if="editWorkOrder">
        <simplert :useRadius="true" :useIcon="true" ref="simplert"></simplert>
        <div class="form-title">
            <div class="form-title-start">
                Edit Work Order {{ editWorkOrder.Name }}
            </div>
            <div class="form-title-end">
                <!-- <button id="btn-cancel" class="button" style="" v-on:click="cancel">Cancel</button> -->
                <button class="button" style="margin-right: .5rem" v-on:click="cancel()">Cancel</button>
                <!-- <button id="btn-add" class="button is-primary">Create Work Order</button> -->
                <button class="button is-primary" v-on:click="updateWorkOrder()">Save changes <i v-show="sending" class="fa fa-circle-o-notch fa-spin"></i></button>
            </div>
        </div>
        <div class="form-content">
            <div class="form-field is-horizonal" style="margin-top: 1rem;">
                <div class="form-field-title" style="margin-right: 1rem">Priority:</div> 
                <label class="radio" :key="'priority' + priority.Id" v-for="priority in priorities" v-on:click="workOrderPriority = priority.Id" style="margin-right: 1rem; user-select: none;">
                    <input type="radio" name="priority" :checked="priority.Id == workOrderPriority" style="margin-right: .3rem;">
                    <span class="tag" style="color: white" :style="`background-color: ${priority.TagHexColor}`">{{ priority.Name }}</span>
                </label>
            </div>
            <!-- select location -->
            <div class="form-field" v-if="authUser.Role == 'Staff'">
                <div class="form-field-title">
                    Choose a location for this work order (required)
                    <span v-if="CreateWorkOrderErrors.NoLocation != ''">. <span class="error-text">{{ CreateWorkOrderErrors.NoLocation }}</span></span>
                </div>
                <div class="form-field-input">
                    <model-select :style="CreateWorkOrderErrors.NoLocation != '' ?
                                   'border: 1px solid var(--danger-color)' : ''" :options="locationOptions" v-model.trim="selectedLocation" placeholder="Select a location" style="width: 40%"></model-select>
                </div>
            </div> <!-- select location -->
            <!-- select team from selected location -->
            <div class="form-field" v-if="selectedLocation.value != '' && authUser.Role == 'Staff'">
                <div v-if="teamOptions.length > 0">
                    <div class="form-field-title">
                        Pick a team from the selected location (required)
                        <span v-if="CreateWorkOrderErrors.NoTeam != ''">. <span class="error-text">{{ CreateWorkOrderErrors.NoTeam }}</span></span>
                    </div>
                    <div class="form-field-input">
                        <model-select :style="CreateWorkOrderErrors.NoTeam != '' ?
                                   'border: 1px solid var(--danger-color)' : ''" 
                                   :options="teamOptions" v-model.trim="selectedTeam" 
                                   placeholder="Select a team" style="width: 40%"></model-select>
                    </div>
                </div>
                <div v-else-if="teamOptions.length == 0">
                    <div class="error-text">{{ CreateWorkOrderErrors.NoTeam }}</div>
                    You are not a team leader of any teams in <strong style="font-style: italic">{{ selectedLocation.text }}</strong>
                </div>
            </div> <!-- select team from selected location -->
            <div class="form-field">
                <div class="form-field-title">
                    Choose a start date and close date for this Work Order  <span v-if="config" style="font-style: italic;" :style="errorOrderDurationIsLongerThanMaximum ? 'color: var(--danger-color)' : ''">(maximum duration is {{ config.createWorkOrder.maximumWorkOrderDuration }} {{ config.createWorkOrder.maximumWorkOrderDurationType }}<span v-if="config.createWorkOrder.maximumWorkOrderDuration > 1">s</span>)</span><span v-if="CreateWorkOrderErrors.NoWorkOrderDateRange != ''">. <span class="error-text">{{ CreateWorkOrderErrors.NoWorkOrderDateRange }}</span></span>
                </div>
                <div class="form-field-input">
                    <date-picker v-model="workOrderDateRange" :not-before="new Date()" :editable="false" 
                              style="width: 40%; font-size: 1rem" :shortcuts="false" range lang="en" format="MM/DD/YYYY" 
                              range-separator="-" 
                              :style="(CreateWorkOrderErrors.NoWorkOrderDateRange != '' || errorOrderDurationIsLongerThanMaximum) ? 'border: 1px solid var(--danger-color); border-radius: 5px' : ''"></date-picker>
                </div>
            </div>
            <div v-if="currentCreateOrderConfigPreset && currentCreateOrderConfigPreset.runtimeFactor != currentCreateOrderConfigPreset.distanceFactor" class="form-field" style="padding-bottom: 0 !important">
                <span style="font-style: italic; font-weight: 500">* Base on the expecting start date, equipment that has <span v-if="currentCreateOrderConfigPreset.runtimeFactor > currentCreateOrderConfigPreset.distanceFactor">fewer runtime days</span><span v-if="currentCreateOrderConfigPreset.runtimeFactor < currentCreateOrderConfigPreset.distanceFactor">a shorter distance from its warehouse to work order location</span> would have more priority in the equipment list.</span>
            </div>
            <!-- select equipments - start -->
            <div class="form-field" style="padding-bottom: 0 !important">
              <div class="form-field-title">
                <span style="position: relative; top: .5rem; margin-right: .2rem;">Choose equipment(s) (press </span><button style="border-radius: 50% !important; z-index: 1;" class="button btn-primary material-shadow-animate"><i class="fa fa-plus"></i></button><span style="position: relative; top: .5rem; margin-left: .2rem"> in the panel below after select to add equipment) (required)</span>
                <span style="position: relative; top: .5rem;" v-if="CreateWorkOrderErrors.NoEquipmentSelected != ''">. <span class="error-text">{{ CreateWorkOrderErrors.NoEquipmentSelected }}</span></span>
              </div>
            </div>
            <div class="">
              <!-- header -->
              <div class="form-field" style="display: grid; grid-template-columns: 40% 10% 10%;; grid-column-gap: 1%; margin-bottom: .5rem; padding-top: 0; padding-bottom: 0;">
                <div>Equipment</div>
                <div style="width: 100%; text-align: center">Quantity</div>
                <div></div>
              </div> <!-- header -->
              <div v-if="loadEditOrder" class="form-field" style="width: 60%; text-align: center; font-size: 1.1rem">
                <i class="fa fa-circle-o-notch fa-spin"></i>
              </div> <!-- header -->
              <!-- display selected equipment items -->
              <div :key="'selectedEquipment' + selectedEquipment.id" v-for="selectedEquipment in selectedEquipments">
                <!-- display errors -->
                <div class="form-field" style="display: grid; grid-template-columns: 40% 10% 10%; grid-column-gap: 1%; margin-bottom: 1rem; padding-top: 0; padding-bottom: 0;">
                  <div></div>
                  <div></div>
                  <div></div>
                </div><!-- display errors -->
                <!-- display equipments -->
                <div class="form-field" style="display: grid; grid-template-columns: 40% 10% 10%;; grid-column-gap: 1%; margin-bottom: 1rem;">
                  <div style="display: grid; grid-template-columns: 5rem auto; grid-column-gap: 1rem;">
                    <img style="width: 100%; height: 5rem;" :src="selectedEquipment.image" alt="">
                    <div style="">
                        {{ selectedEquipment.name }}
                    </div>
                  </div>
                  <div style="width: 100%; text-align: center">
                    <input class="input" :disabled="!selectedEquipment.editMode"
                            :style="selectedEquipment.addEquipmentWarnings.SelectedEquipmentQuantityIsZero != '' ?
                                    'border: 1px solid var(--danger-color)' : ''"
                            type="number" min="0" :max="selectedEquipment.totalQuantity" 
                            v-model.trim="selectedEquipment.quantity" 
                            v-on:input="() => {
                                if (selectedEquipment.quantity === '') {
                                    selectedEquipment.quantity = 0;
                                    selectedEquipment.equipmentItemIds = [];
                                    selectedEquipment.conflictItems = [];
                                    selectedEquipment.unableSelectItems = [];
                                    selectedEquipment.indeterminate = false;
                                    selectedEquipment.checkAllItems = false;

                                    selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                                    selectedEquipment.addEquipmentWarnings.SelectedEquipmentQuantityIsZero = ErrorStrings.SelectedEquipmentQuantityIsZero;
                                } else {
                                  //if (this.selectedEquipment.value != '' && this.selectedEquipment.totalQuantity > 0) {
                                    let equipmentTotalQuantity = parseInt(selectedEquipment.totalQuantity);
                                    if (parseInt(selectedEquipment.quantity) < 0) {
                                      selectedEquipment.quantity = 0;
                                    } else if (parseInt(selectedEquipment.quantity) > equipmentTotalQuantity) {
                                      selectedEquipment.quantity = equipmentTotalQuantity;
                                    }

                                    // if the selectedEquipmentQuantity = 0, we should display a warning to user
                                    if (parseInt(selectedEquipment.quantity) == 0) {
                                      selectedEquipment.addEquipmentWarnings.SelectedEquipmentQuantityIsZero = ErrorStrings.SelectedEquipmentQuantityIsZero;
                                      selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                                      selectedEquipment.equipmentItemIds = [];
                                      selectedEquipment.conflictItems = [];
                                      selectedEquipment.unableSelectItems = [];
                                      selectedEquipment.itemIdConflictNextMaintenanceDate = [];
                                      selectedEquipment.itemIdMaximumConflictWorkOrder = [];
                                      checkItemsIsSafeToSelect(selectedEquipment.equipmentItemIds, selectedEquipment.equipmentItemList, 
                                                                selectedEquipment.conflictItems, selectedEquipment.unableSelectItems,
                                                                selectedEquipment.itemIdConflictNextMaintenanceDate,
                                                                selectedEquipment.itemIdMaximumConflictWorkOrder,
                                                                selectedEquipment.addEquipmentWarnings);
                                      selectedEquipment.indeterminate = false;
                                      selectedEquipment.checkAllItems = false;
                                    } else {
                                      selectedEquipment.addEquipmentWarnings.SelectedEquipmentQuantityIsZero = '';
                                      selectedEquipment.indeterminate = true;
                                      // if the selectedEquipmentQuantity is greater than selectedEquipmentItemIds.length
                                      //, it means we should add the next item to selectedEquipmentItemIds
                                      if (parseInt(selectedEquipment.quantity) > selectedEquipment.equipmentItemIds.length) {
                                        while(selectedEquipment.equipmentItemIds.length != parseInt(selectedEquipment.quantity)) {
                                          let tempItems = selectedEquipment.equipmentItemList;
                                          selectedEquipment.equipmentItemIds.forEach(itemId => {
                                            tempItems = tempItems.filter(item => item.Id != itemId);
                                          })
                                          selectedEquipment.equipmentItemIds.push(tempItems[0].Id);
                                        }
                                        if (selectedEquipment.equipmentItemIds.length == selectedEquipment.totalQuantity) {
                                          selectedEquipment.indeterminate = false;
                                          selectedEquipment.checkAllItems = true;
                                        } 
                                      } else if (parseInt(selectedEquipment.quantity) < selectedEquipment.equipmentItemIds.length) {
                                        // the code below will simply pop the last id out of the list, so if user has pick an equipment by hand (not using the number input)
                                        // and then use the number input, the item is not automatically calculate to choose the best ideal one
                                        // in other words, the order of item will not be the best ideal order the algorithm should give out
                                        // then the user would see item unchecks in the incorrect descending order
                                        // but i think we should respect the user's choice
                                        while(selectedEquipment.equipmentItemIds.length != parseInt(selectedEquipment.quantity)) {
                                          selectedEquipment.equipmentItemIds.pop();
                                        }
                                      }
                                      selectedEquipment.conflictItems = [];
                                      selectedEquipment.unableSelectItems = [];
                                      selectedEquipment.itemIdConflictNextMaintenanceDate = [];
                                      selectedEquipment.itemIdMaximumConflictWorkOrder = [];
                                      checkItemsIsSafeToSelect(selectedEquipment.equipmentItemIds, selectedEquipment.equipmentItemList, 
                                                                selectedEquipment.conflictItems, selectedEquipment.unableSelectItems, 
                                                                selectedEquipment.itemIdConflictNextMaintenanceDate,
                                                                selectedEquipment.itemIdMaximumConflictWorkOrder,
                                                                selectedEquipment.addEquipmentWarnings);
                                    }          
                                  //}
                                }
                    }">
                  </div>
                  <div style="padding-top: .5rem; text-align: center;">
                    <a v-on:click="selectedEquipment.editMode = !selectedEquipment.editMode">{{ selectedEquipment.editMode ? 'Done' : 'Edit' }}</a>
                    <span> | </span>
                    <a v-on:click="removeEquipment(selectedEquipment)">Remove</a>
                  </div>
                </div>
                <!-- display warning -->
                <div class="form-field" v-if="selectedEquipment.editMode" style="padding-top: 0; padding-bottom: 0">
                    <div v-if="selectedEquipment.addEquipmentWarnings.SelectedEquipmentQuantityIsZero != ''" 
                            class="error-text">
                        {{ selectedEquipment.addEquipmentWarnings.SelectedEquipmentQuantityIsZero }}
                    </div>
                    <div v-if="selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders != ''" 
                            class="warning-text" v-html="selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders">
                    </div>
                    <div v-if="selectedEquipment.addEquipmentWarnings.UnableToSelectItem != ''" class="error-text">
                        {{ selectedEquipment.addEquipmentWarnings.UnableToSelectItem }}
                    </div>
                    <div v-if="selectedEquipment.addEquipmentWarnings.ConflictMaintenanceDate != ''" 
                            class="error-text" v-html="selectedEquipment.addEquipmentWarnings.ConflictMaintenanceDate">
                    </div>
                    <div v-if="selectedEquipment.addEquipmentWarnings.ErrorMaximumConflictWorkOrder != ''" class="error-text" >
                        {{ selectedEquipment.addEquipmentWarnings.ErrorMaximumConflictWorkOrder }}
                    </div>
                </div> <!-- display warning -->
                <!-- display equipment item table for editing -->
                <div v-if="selectedEquipment.editMode" style="margin-bottom: 2rem">
                  <table :style="{width: '100%'}">
                    <thead>
                      <tr>
                        <th style="padding-left: 2rem !important">
                          <Checkbox :indeterminate="selectedEquipment.indeterminate" :value="selectedEquipment.checkAllItems" @click.prevent.native="() => {
                                if (selectedEquipment.indeterminate) {
                                    selectedEquipment.checkAllItems = false;
                                } else {
                                    selectedEquipment.checkAllItems = !selectedEquipment.checkAllItems;
                                }

                                selectedEquipment.indeterminate = false;
                                if (selectedEquipment.checkAllItems) {
                                    selectedEquipment.addEquipmentWarnings.SelectedEquipmentQuantityIsZero = '';
                                    selectedEquipment.equipmentItemIds = [];
                                    selectedEquipment.equipmentItemList.forEach(item => selectedEquipment.equipmentItemIds.push(item.Id));
                                    selectedEquipment.quantity = selectedEquipment.equipmentItemList.length;

                                    selectedEquipment.conflictItems = [];
                                    selectedEquipment.unableSelectItems = [];
                                    selectedEquipment.itemIdConflictNextMaintenanceDate = [];
                                    selectedEquipment.itemIdMaximumConflictWorkOrder = [];
                                    checkItemsIsSafeToSelect(selectedEquipment.equipmentItemIds, selectedEquipment.equipmentItemList, 
                                                            selectedEquipment.conflictItems, selectedEquipment.unableSelectItems, 
                                                            selectedEquipment.itemIdConflictNextMaintenanceDate,
                                                            selectedEquipment.itemIdMaximumConflictWorkOrder,
                                                            selectedEquipment.addEquipmentWarnings);
                                } else {
                                    selectedEquipment.equipmentItemIds = [];
                                    selectedEquipment.conflictItems = [];
                                    selectedEquipment.unableSelectItems = [];
                                    selectedEquipment.itemIdConflictNextMaintenanceDate = [];
                                    selectedEquipment.itemIdMaximumConflictWorkOrder = [];
                                    checkItemsIsSafeToSelect(selectedEquipment.equipmentItemIds, selectedEquipment.equipmentItemList, 
                                                            selectedEquipment.conflictItems, selectedEquipment.unableSelectItems, 
                                                            selectedEquipment.itemIdConflictNextMaintenanceDate,
                                                            selectedEquipment.itemIdMaximumConflictWorkOrder,
                                                            selectedEquipment.addEquipmentWarnings);
                                    selectedEquipment.quantity = 0;
                                    //selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                                    selectedEquipment.addEquipmentWarnings.SelectedEquipmentQuantityIsZero = ErrorStrings.SelectedEquipmentQuantityIsZero;
                                }                           
                            }"></Checkbox>
                        </th>
                        <th>Serial #</th>
                        <th>Status</th>
                        <th>In WO</th>
                        <th>From</th>
                        <th>To</th>
                        <th>Runtime Days</th>
                        <th>Next Maintaince</th>
                        <th>Distance</th>
                        <th>Warehouse</th>
                      </tr>
                    </thead>
                    <tbody v-on:click="() => {
                              //if (equipmentItem.Status != 'Working Requested' && equipmentItem.Status != 'Maintain Requested') {
                                selectedEquipment.indeterminate = true;
                                selectedEquipment.checkAllItems = false;
                                // if selectedEquipmentItemIds already has equipmentItemId, we decrease the selectedEquipmentQuantity, then remove the equipmentItemId from the selectedEquipmentItemIds
                                if (selectedEquipment.equipmentItemIds.includes(equipmentItem.Id)) {
                                    selectedEquipment.quantity = parseInt(selectedEquipment.quantity) - 1;
                                    selectedEquipment.equipmentItemIds = selectedEquipment.equipmentItemIds.filter(itemId => itemId != equipmentItem.Id);
                                    if (selectedEquipment.equipmentItemIds.length == 0) {
                                        selectedEquipment.indeterminate = false;
                                        selectedEquipment.checkAllItems = false;
                                        selectedEquipment.addEquipmentWarnings.SelectedEquipmentQuantityIsZero = ErrorStrings.SelectedEquipmentQuantityIsZero;
                                    }
                                } 
                                else {
                                    selectedEquipment.addEquipmentWarnings.SelectedEquipmentQuantityIsZero = '';
                                    selectedEquipment.quantity = parseInt(selectedEquipment.quantity) + 1;
                                    selectedEquipment.equipmentItemIds.push(equipmentItem.Id);
                                    if (selectedEquipment.equipmentItemIds.length == selectedEquipment.equipmentItemList.length) {
                                        selectedEquipment.indeterminate = false;
                                        selectedEquipment.checkAllItems = true;
                                    }
                                }
                                selectedEquipment.conflictItems = [];
                                selectedEquipment.unableSelectItems = [];
                                selectedEquipment.itemIdConflictNextMaintenanceDate = [];
                                selectedEquipment.itemIdMaximumConflictWorkOrder = [];
                                checkItemsIsSafeToSelect(selectedEquipment.equipmentItemIds, selectedEquipment.equipmentItemList,
                                                            selectedEquipment.conflictItems, selectedEquipment.unableSelectItems, 
                                                            selectedEquipment.itemIdConflictNextMaintenanceDate, 
                                                            selectedEquipment.itemIdMaximumConflictWorkOrder, 
                                                            selectedEquipment.addEquipmentWarnings);
                              //}
                            }" :class="{'row-even': (itemIndex + 1) % 2 == 0,
                                        'row-odd': (itemIndex + 1) % 2 != 0}"
                                        v-for="(equipmentItem, itemIndex) in selectedEquipment.equipmentItemList" :key="equipmentItem.Id + 'equipmentItemListData' + itemIndex">
                      <!-- if equipment item is in some work order -->
                      <tr :style="{cursor: ((equipmentItem.Status != 'Working Requested' && equipmentItem.Status != 'Maintain Requested') ?
                                      'pointer !important' : 'not-allowed !important')}" v-if="equipmentItem.WorkOrders != null">
                        <!-- check box -->
                        <td :rowspan="equipmentItem.WorkOrders.length + 1" style="padding-left: 2rem !important">
                          <Checkbox :value="selectedEquipment.equipmentItemIds.includes(equipmentItem.Id)"></Checkbox>
                        </td><!-- check box -->
                        <!-- equipment item serial number -->
                        <td :rowspan="equipmentItem.WorkOrders.length + 1">{{ equipmentItem.SerialNumber }}</td>
                        <!-- equipment item status -->
                        <td :rowspan="equipmentItem.WorkOrders.length + 1">{{ equipmentItem.Status }}</td>
                      </tr>
                      <!-- work order detail -->
                      <tr :style="{cursor: ((equipmentItem.Status != 'Working Requested' && equipmentItem.Status != 'Maintain Requested') ?
                                      'pointer !important' : 'not-allowed !important')}" 
                              :key="'dataworkorder' + workOrder.Id" v-for="(workOrder, workOrderIndex) in equipmentItem.WorkOrders" v-if="equipmentItem.WorkOrders != null">
                        <td :style="workOrder.Id == editWorkOrder.Id ? 'font-weight: bold; font-style: italic' : ''"
                            :class="{'row-warning-light': (((itemIndex + 1) % 2 != 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems)),
                                 'row-warning-dark': (((itemIndex + 1) % 2 == 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems)),
                                 'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, selectedEquipment.unableSelectItems)),
                                 'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, selectedEquipment.unableSelectItems)),
                                 'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemExcessMaximumConflictWorkOrder(equipmentItem.Id, selectedEquipment.itemIdMaximumConflictWorkOrder)),
                                 'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemExcessMaximumConflictWorkOrder(equipmentItem.Id, selectedEquipment.itemIdMaximumConflictWorkOrder))}"> <!-- work order name -->
                          {{ editWorkOrder.Id == workOrder.Id ? 'This work order' : workOrder.Name }}
                          <span>[{{ workOrder.Status }}]</span>
                        </td>
                        <td :class="{'row-warning-light': (((itemIndex + 1) % 2 != 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems)),
                                 'row-warning-dark': (((itemIndex + 1) % 2 == 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems)),
                                 'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, selectedEquipment.unableSelectItems)),
                                 'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, selectedEquipment.unableSelectItems))}">{{ getDate(workOrder.ExpectingStartDate) }}</td> <!-- work order detail from date -->
                        <td :class="{'row-warning-light': (((itemIndex + 1) % 2 != 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems)),
                                    'row-warning-dark': (((itemIndex + 1) % 2 == 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems)),
                                    'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, selectedEquipment.unableSelectItems)),
                                    'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, selectedEquipment.unableSelectItems))}">{{ getDate(workOrder.ExpectingCloseDate) }}</td> <!-- work order detail to date -->
                        <!-- equipment item runtime days -->
                        <td v-if="workOrderIndex == 0" :rowspan="equipmentItem.WorkOrders.length + 1"> 
                          {{ equipmentItem.RuntimeDays }}
                        </td>
                        <!-- equipment item next maintaince date -->
                        <td v-if="workOrderIndex == 0" :rowspan="equipmentItem.WorkOrders.length + 1"
                            :class="{'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemConflictNextMaintenanceDate(equipmentItem.Id, selectedEquipment.itemIdConflictNextMaintenanceDate)),
                                    'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemConflictNextMaintenanceDate(equipmentItem.Id, selectedEquipment.itemIdConflictNextMaintenanceDate))}"> 
                          {{ equipmentItem.NextMaintainDate ? getDate(equipmentItem.NextMaintainDate) : 'n/a' }}
                        </td>
                        <!-- distance -->
                        <td v-if="workOrderIndex == 0" :rowspan="equipmentItem.WorkOrders.length + 1"> 
                            {{ equipmentItem.Distance.value ? equipmentItem.Distance.text : 'n/a' }}
                        </td>
                        <!-- warehouse -->
                        <td v-if="workOrderIndex == 0" :rowspan="equipmentItem.WorkOrders.length + 1"> 
                            {{ equipmentItem.Warehouse.Name }}
                        </td>
                      </tr> <!-- work order detail --> <!-- if equipment item is in some work order -->
                      <!-- else -->
                      <tr :style="{cursor: 'pointer'}" v-if="equipmentItem.WorkOrders == null">
                        <td style="padding-left: 2rem !important">
                          <Checkbox :value="selectedEquipment.equipmentItemIds.includes(equipmentItem.Id)"></Checkbox>
                        </td>
                        <td>{{ equipmentItem.SerialNumber }}</td>
                        <td>{{ equipmentItem.Status }}</td>
                        <td>-</td>
                        <td>-</td>
                        <td>-</td>
                        <td>{{ equipmentItem.RuntimeDays }}</td>
                        <td :class="{'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemConflictNextMaintenanceDate(equipmentItem.Id, selectedEquipment.itemIdConflictNextMaintenanceDate)),
                                'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemConflictNextMaintenanceDate(equipmentItem.Id, selectedEquipment.itemIdConflictNextMaintenanceDate))}">
                            {{ equipmentItem.NextMaintainDate ? getDate(equipmentItem.NextMaintainDate) : 'n/a' }}
                        </td>
                        <td>{{ equipmentItem.Distance.value ? equipmentItem.Distance.text : 'n/a' }}</td>
                        <td>{{ equipmentItem.Warehouse.Name }}</td>
                      </tr> <!-- else -->
                    </tbody>
                  </table>
                </div> <!-- display equipment item table for editing -->              
              </div> <!-- display equipments -->
              <!-- display selected equipment items - end -->                           
            </div> 
            <!-- display errors -->
            <div class="form-field" style="padding-bottom: 0; margin-bottom: 0rem; display: grid; grid-template-columns: 40% 10% 10%; grid-column-gap: 1%;">   
              <div>
              <!-- display error for not select equipment -->
                <div class="strong-warning-text">{{ AddEquipmentWarnings.MustSelectEquipment }}</div>
                <div class="strong-warning-text">{{ AddEquipmentWarnings.AvailableQuantityIsZero }}</div>
              </div>
              <div></div>
              <div></div>
            </div> <!-- display errors --> 
            <!-- add equipment panel -->
            <div style="background: #eee;">
              <div class="form-field" style="display: grid; grid-template-columns: 40% 10% 10%;; grid-column-gap: 1%;">                
                <div class="form-field-input">
                  <div style="width: 100%">
                    <model-select :style="(AddEquipmentWarnings.MustSelectEquipment != '' 
                                          || AddEquipmentWarnings.AvailableQuantityIsZero != '') ?
                                            'border: 1px solid var(--strong-warning-color)' : ''" 
                                            :options="toDisplayEquipmentOptions" placeholder="Select an equipment" v-model.trim="selectedEquipment"></model-select>
                  </div>
                </div>  
                <div class="form-field-input">
                    <input :style="AddEquipmentWarnings.SelectedEquipmentQuantityIsZero != '' ? 'border: 1px solid var(--warning-color)' : ''"
                        type="number" :disabled="selectedEquipment.totalQuantity == 0" min="0" :max="selectedEquipment.totalQuantity" class="input" v-model.trim="selectedEquipmentQuantity">
                </div>
                <div>
                  <button v-on:click="addEquipment(false, selectedEquipment, selectedEquipmentQuantity, selectedEquipmentItemIds, indeterminate, checkAllItems, equipmentTable, conflictItems, unableSelectItems, itemIdConflictNextMaintenanceDate, itemIdMaximumConflictWorkOrder, AddEquipmentWarnings)" style="margin-left: .5rem; border-radius: 50% !important;" class="button btn-primary material-shadow-animate"><i class="fa fa-plus"></i></button>
                  <button v-on:click="() => {
                      selectedEquipment = {
                        text: '',
                        value: '',
                        image: '',
                        totalQuantity: 0
                      };
                      resetEquipmentSelection();
                    }" style="margin-left: 1rem; border-radius: 50% !important;" class="button btn-danger material-shadow-animate"><i class="fa fa-times"></i></button>
                  <!-- <a v-on:click="() => {
                      selectedEquipment = {
                        text: '',
                        value: '',
                        image: '',
                        totalQuantity: 0
                      };
                      resetEquipmentSelection();
                    }" 
                    style="margin-left: 1.1rem; position: relative; top: .5rem; user-select: none;">Clear</a> -->
                </div>
              </div>
            </div> <!-- add equipment panel -->
            <!-- select equipments - end -->            
            <div style="padding-top: 0; padding-bottom: 0; background: #eee;" class="form-field">
                <div v-if="AddEquipmentWarnings.SelectedEquipmentQuantityIsZero != ''" class="strong-warning-text">{{ AddEquipmentWarnings.SelectedEquipmentQuantityIsZero }}</div>
                <div v-if="AddEquipmentWarnings.SelectedDateConflictWorkOrders != ''" 
                    class="warning-text" v-html="AddEquipmentWarnings.SelectedDateConflictWorkOrders">
                </div>
                <div v-if="AddEquipmentWarnings.UnableToSelectItem != ''" class="error-text">
                    {{ AddEquipmentWarnings.UnableToSelectItem }}
                </div>
                <div v-if="AddEquipmentWarnings.ConflictMaintenanceDate != ''" 
                    class="error-text" v-html="AddEquipmentWarnings.ConflictMaintenanceDate">
                </div>
                <div v-if="AddEquipmentWarnings.ErrorMaximumConflictWorkOrder != ''" class="error-text">
                    {{ AddEquipmentWarnings.ErrorMaximumConflictWorkOrder }}
                </div>
            </div>

            <!-- display equipment items table to let user pick the desire item -->
            <div class="" v-if="equipmentTable && equipmentTable.length > 0">
              <table :style="{width: '100%'}">
                <thead>
                  <tr>
                    <th style="padding-left: 2rem !important">
                      <Checkbox :indeterminate="indeterminate" :value="checkAllItems" @click.prevent.native="handleCheckAllItems()"></Checkbox>
                    </th>
                    <th>Serial #</th>
                    <th>Status</th>
                    <th>In WO</th>
                    <th>From</th>
                    <th>To</th>
                    <th>Runtime Days</th>
                    <th>Next Maintaince</th>
                    <th>Distance</th>
                    <th>Warehouse</th>
                  </tr>
                </thead>
                <tbody v-on:click="() => {
                          //if (equipmentItem.Status != 'Working Requested' && equipmentItem.Status != 'Maintain Requested') {
                            checkItemFromTable(equipmentItem.Id);
                          //}
                        }" :class="{'row-even': (itemIndex + 1) % 2 == 0,
                                    'row-odd': (itemIndex + 1) % 2 != 0}"
                                    v-for="(equipmentItem, itemIndex) in equipmentTable" :key="'data' + itemIndex">
                  <!-- if equipment item is in some work order -->
                  <tr :style="{cursor: ((equipmentItem.Status != 'Working Requested' && equipmentItem.Status != 'Maintain Requested') ?
                                   'pointer !important' : 'not-allowed !important')}" v-if="equipmentItem.WorkOrders != null">
                    <!-- check box -->
                    <td :rowspan="equipmentItem.WorkOrders.length + 1" style="padding-left: 2rem !important">
                      <Checkbox :value="selectedEquipmentItemIds.includes(equipmentItem.Id)" v-on:change="checkItemFromTable(equipmentItem.Id)"></Checkbox>
                    </td><!-- check box -->
                    <!-- equipment item serial number -->
                    <td :rowspan="equipmentItem.WorkOrders.length + 1">{{ equipmentItem.SerialNumber }}</td>
                    <!-- equipment item status -->
                    <td :rowspan="equipmentItem.WorkOrders.length + 1">{{ equipmentItem.Status }}</td>
                  </tr>
                  <!-- work order detail -->
                  <tr :style="{cursor: ((equipmentItem.Status != 'Working Requested' && equipmentItem.Status != 'Maintain Requested') ?
                                   'pointer !important' : 'not-allowed !important')}" 
                          :key="'dataworkorder' + workOrder.Id" v-for="(workOrder, workOrderIndex) in equipmentItem.WorkOrders" v-if="equipmentItem.WorkOrders != null">
                    <td :style="workOrder.Id == editWorkOrder.Id ? 'font-weight: bold; font-style: italic' : ''"
                        :class="{'row-warning-light': (((itemIndex + 1) % 2 != 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, conflictItems)),
                                 'row-warning-dark': (((itemIndex + 1) % 2 == 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, conflictItems)),
                                 'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, unableSelectItems)),
                                 'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, unableSelectItems)),
                                 'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemExcessMaximumConflictWorkOrder(equipmentItem.Id, itemIdMaximumConflictWorkOrder)),
                                 'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemExcessMaximumConflictWorkOrder(equipmentItem.Id, unableSelectItems))}"> <!-- work order name -->
                      {{ editWorkOrder.Id == workOrder.Id ? 'This work order' : workOrder.Name }}
                      <span>[{{ workOrder.Status }}]</span>
                    </td>
                    <td :class="{'row-warning-light': (((itemIndex + 1) % 2 != 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, conflictItems)),
                                 'row-warning-dark': (((itemIndex + 1) % 2 == 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, conflictItems)),
                                 'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, unableSelectItems)),
                                 'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, unableSelectItems))}">{{ getDate(workOrder.ExpectingStartDate) }}</td> <!-- work order detail from date -->
                    <td :class="{'row-warning-light': (((itemIndex + 1) % 2 != 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, conflictItems)),
                                 'row-warning-dark': (((itemIndex + 1) % 2 == 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, conflictItems)),
                                 'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, unableSelectItems)),
                                 'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, unableSelectItems))}">{{ getDate(workOrder.ExpectingCloseDate) }}</td> <!-- work order detail to date -->
                    <!-- equipment item runtime days -->
                    <td v-if="workOrderIndex == 0" :rowspan="equipmentItem.WorkOrders.length + 1"> 
                      {{ equipmentItem.RuntimeDays }}
                    </td>
                    <!-- equipment item next maintaince date -->
                    <td v-if="workOrderIndex == 0" :rowspan="equipmentItem.WorkOrders.length + 1"
                      :class="{'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemConflictNextMaintenanceDate(equipmentItem.Id, itemIdConflictNextMaintenanceDate)),
                                'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemConflictNextMaintenanceDate(equipmentItem.Id, itemIdConflictNextMaintenanceDate))}">                      
                      {{ equipmentItem.NextMaintainDate ? getDate(equipmentItem.NextMaintainDate) : 'n/a' }}
                    </td>
                    <!-- distance -->
                    <td v-if="workOrderIndex == 0" :rowspan="equipmentItem.WorkOrders.length + 1"> 
                      {{ equipmentItem.Distance.value ? equipmentItem.Distance.text : 'n/a' }}
                    </td>
                    <!-- warehouse -->
                    <td v-if="workOrderIndex == 0" :rowspan="equipmentItem.WorkOrders.length + 1"> 
                      {{ equipmentItem.Warehouse.Name }}
                    </td>
                  </tr> <!-- work order detail --> <!-- if equipment item is in some work order -->
                  <!-- else -->
                  <tr :style="{cursor: 'pointer'}" v-if="equipmentItem.WorkOrders == null">
                    <td style="padding-left: 2rem !important">
                      <Checkbox :value="selectedEquipmentItemIds.includes(equipmentItem.Id)"></Checkbox>
                    </td>
                    <td>{{ equipmentItem.SerialNumber }}</td>
                    <td>{{ equipmentItem.Status }}</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td>{{ equipmentItem.RuntimeDays }}</td>
                    <td :class="{'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemConflictNextMaintenanceDate(equipmentItem.Id, itemIdConflictNextMaintenanceDate)),
                                'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemConflictNextMaintenanceDate(equipmentItem.Id, itemIdConflictNextMaintenanceDate))}">
                            {{ equipmentItem.NextMaintainDate ? getDate(equipmentItem.NextMaintainDate) : 'n/a' }}
                    </td>
                    <td>{{ equipmentItem.Distance.value ? equipmentItem.Distance.text : 'n/a' }}</td>
                    <td>{{ equipmentItem.Warehouse.Name }}</td>
                  </tr> <!-- else -->
                </tbody>
              </table>
              <!-- </div> -->
                <div v-if="itemsLoading" style="margin-top: 1rem; text-align: center;">
                    <div style="font-size: 1.1rem"><i class="fa fa-circle-o-notch fa-spin"></i></div>
                    <div>Getting equipment info...</div>
                </div> 
            </div> <!-- display equipment items table to let user pick the desire item -->
            <!-- describe work order -->
            <div class="form-field" style="margin-bottom: 1rem;">
                <div class="form-field-title">
                    Describe this work order (optional)
                </div>
                <div class="form-field-input">
                    <textarea class="input" rows="5" v-model.trim="description"></textarea>
                </div>
            </div> <!-- describe work order -->
        </div>
    </div>
</template>

<script>
import Server from "@/config/config.js";
import Utils from "@/utils.js";
import moment from "moment";
import { ModelSelect } from "vue-search-select";
import Simplert from "vue2-simplert";
import DatePicker from 'vue2-datepicker';
import { sync } from 'vuex-pathify';

export default {
    components: {
        ModelSelect, Simplert, DatePicker
    },
    data() {
        return {
            loadEditOrder: true,
            editWorkOrder: null,
            sending: false,
            ErrorStrings: {
                InvalidTitleLength: 'Title must be from 6 to 50 characters',
                MustSelectEquipment: 'You must select an equipment',
                AvailableQuantityIsZero: 'This equipment has no available units',
                NoTitle: 'You must provide a title for this order',
                NoEquipmentSelected: 'You must select at least one equipment',
                NoLocation: 'You must select a location',
                NoTeam: 'You must select a team in the selected location',
                SelectedEquipmentQuantityIsZero: 'You must choose at least 1 equipment item from the table below',
                SelectedDateConflictWorkOrders: 'Start date or end date has conflict with some work orders.',
                UnableToSelectItem: "You can not select items that are in work orders with status 'Approved' or 'In Progress' between your from date and to date.",
                NoWorkOrderDateRange: 'You must select expecting start date and expecting end date of this work order',
                ConflictMaintenanceDate: 'You can not select equipment whose maintenance date has conflict with the start date and end date of this work order.',
            },
            AddEquipmentWarnings: {
                MustSelectEquipment: '',
                AvailableQuantityIsZero: '',
                SelectedEquipmentQuantityIsZero: '',
                SelectedDateConflictWorkOrders: '',
                UnableToSelectItem: '',
                ConflictMaintenanceDate: '',
                ErrorMaximumConflictWorkOrder: '',
            },
            CreateWorkOrderErrors: {
                NoTitle: '',
                InvalidTitleLength: '',
                NoEquipmentSelected: '',
                NoWorkOrderDateRange: '',
                EquipmentErrors: [],
                NoLocation: "",
                NoTeam: ""
            },
            workOrderPriority: 1,
            workOrderDateRange: [null, null],
            selectedEquipmentQuantity: 0,
            selectedEquipments: [],
            toDisplayEquipmentOptions: [],
            selectedLocation: {
                text: "",
                value: ""
            },
            selectedTeam: {
                text: "",
                value: ""
            },
            selectedEquipment: {
                text: "",
                value: "",
                image: "",
                totalQuantity: 0
            },
            categories: [],
            priorities: [],
            equipmentOptions: [],
            locationOptions: [],
            teamOptions: [],
            equipmentTable: [],
            selectedEquipmentItemIds: [],
            checkAllItems: false,
            indeterminate: true,
            conflictItems: [],
            unableSelectItems: [],
            description: '',

            itemIdConflictNextMaintenanceDate: [],
            itemIdMaximumConflictWorkOrder: [],
            errorOrderDurationIsLongerThanMaximum: false,

            itemsLoading: false,
            distancesCache: [],
        };
    },
    computed: {
        authUser() {
            return JSON.parse(window.localStorage.getItem("user"));
        },
        workOrderCategory() {
            if (this.authUser.Role == 'Staff') {
                return 'Working'; // working order
            } else if (this.authUser.Role == 'Maintainer') {
                return 'Maintain'; // maintain order
            }
        },
        config: sync('config'),
    },
    async created() {
        //get work order to edit
        let context = this;
       await context.axios(`${Server.WORKORDER_API_PATH}/id/${context.$route.params.orderId}`)
            .then(async (res) => {
                if (res.status == 200) {
                    context.editWorkOrder = res.data;
                    if (context.editWorkOrder.RequestUserID != context.authUser.Id
                        || (context.editWorkOrder.WorkOrderStatus != 'Requested'
                            && context.editWorkOrder.WorkOrderStatus != 'Rejected')) {
                        context.$router.replace('/work_order');
                    } else {
                        context.workOrderDateRange[0] = context.editWorkOrder.ExpectingStartDate;
                        context.workOrderDateRange[1] = context.editWorkOrder.ExpectingCloseDate;
                        // get work order priorities
                        await context.axios.get(Server.WORKORDER_PRIORITIES_API_PATH).then(async res => {
                            if (res.data) {
                                context.priorities = res.data;
                                context.workOrderPriority = context.editWorkOrder.PriorityID;
                                // get locations
                                if (context.authUser.Role == 'Staff') {
                                    await context.axios.get(`${Server.LOCATION_API_PATH}/getLocation/${this.authUser.Id}`).then(async res => {
                                        if (res.data) {
                                            let data = res.data;
                                            for (const location of data) {
                                                if (location.IsActive) {
                                                    let option = {
                                                        value: location.Id,
                                                        text: `${location.Name} - ${location.Address}`,
                                                        latitude: location.Latitude,
                                                        longitude: location.Longitude,
                                                    };
                                                    context.locationOptions.push(option);
                                                }
                                            }
                                            context.selectedLocation = context.locationOptions.filter(op => parseInt(op.value) == context.editWorkOrder.Location.Id)[0];
                                            //get team in selected location
                                            context.teamOptions = [];
                                            let url = `${Server.LOCATION_API_PATH}/${
                                                context.selectedLocation.value
                                                }/team/${context.authUser.Id}`;
                                            await context.axios.get(url).then(async res => {
                                                if (res.data) {
                                                    let data = res.data;
                                                    for (const element of data) {
                                                        let option = {
                                                            value: element.Team.Id,
                                                            text: element.Team.Name
                                                        };
                                                        context.teamOptions.push(option);
                                                    }
                                                    context.selectedTeam = context.teamOptions.filter(op => parseInt(op.value) == parseInt(context.editWorkOrder.Team.Id))[0];
                                                }
                                            });
                                        }
                                    });
                                }
    
                                // get all equipments to display options
                                await context.axios.get(Server.EQUIPMENT_API_PATH).then(async res => {
                                    if (res.data) {
                                        let data = res.data;
                                        for (const element of data) {
                                            let quantity = parseInt(element.Equipment.Quantity);
                                            let option = {
                                                text: `${element.Equipment.Name}, quantity: ${quantity} ${quantity > 0 ? element.Equipment.Unit.Name : 'unit'}`,
                                                value: element.Equipment.Id,
                                                image: element.Equipment.Image,
                                                totalQuantity: quantity,
                                                maintenancePeriodInMonths: element.Equipment.MaintenanceDuration.Month
                                            };
                                            context.equipmentOptions.push(option);
                                        }
                                        context.toDisplayEquipmentOptions = context.equipmentOptions;
                                        
                                        for (const eq of context.editWorkOrder.Equipments) {
                                            let equipmentOption = context.equipmentOptions.filter(op => parseInt(op.value) == parseInt(eq.Id))[0];
                                            let itemQuantity = eq.EquipmentItems.length;
                                            let selectedItemIds = [];
                                            for (const item of eq.EquipmentItems) {
                                                selectedItemIds.push(item.Id);
                                            }
                                            let equipmentTable = [];
                                            for (const eqi of eq.Table) {
                                                // alert(`Warehouse ${JSON.stringify(eqi.Warehouse)}, ${JSON.stringify(context.selectedLocation)}`)
                                                let distance = {text: 'n/a', value: 1};
                                                if (equipmentOption && equipmentOption.value != '') {
                                                    if (context.selectedLocation && context.selectedLocation.value != '') {
                                                        distance = await context.getDistance(eqi.Warehouse, context.selectedLocation)
                                                    }
                                                    let item = {
                                                        "Id": eqi.Id,
                                                        "EquipmentID": eqi.EquipmentID,
                                                        "SerialNumber": eqi.SerialNumber,
                                                        "WarrantyDuration": eqi.WarrantyDuration,
                                                        "RuntimeDays": eqi.RuntimeDays,
                                                        "TileID": eqi.TileID,
                                                        "Price": eqi.Price,
                                                        "ImportDate": eqi.ImportDate,
                                                        "NextMaintainDate": eqi.NextMaintainDate,
                                                        "StatusId": eqi.StatusId,
                                                        "Description": eqi.Description,
                                                        "Status": eqi.Status,
                                                        "Warehouse": eqi.Warehouse,
                                                        "WorkOrders": eqi.WorkOrders,
                                                        "Distance": distance,
                                                    };
                                                    equipmentTable.push(item);
                                                }
                                                // alert(JSON.stringify(distance))
                                            }
                                            if (context.authUser.Role == 'Staff' && context.selectedLocation.value != '') {
                                                context.sortItems(equipmentTable);
                                            }
                                            let indeterminate = selectedItemIds.length > 0 && selectedItemIds.length < equipmentTable.length;
                                            let checkAllItems = selectedItemIds.length == equipmentTable.length;
                                            let addEquipmentWarnings = {
                                                MustSelectEquipment: '',
                                                AvailableQuantityIsZero: '',
                                                SelectedEquipmentQuantityIsZero: '',
                                                SelectedDateConflictWorkOrders: '',
                                                UnableToSelectItem: '',
                                                ConflictMaintenanceDate: '',
                                                ErrorMaximumConflictWorkOrder: '',
                                            };
                                            // check if from date conflicts any item in work orders - start
                                            let conflictItems = [];
                                            let unableSelectItems = [];
                                            let itemIdConflictNextMaintenanceDate = [];
                                            let itemIdMaximumConflictWorkOrder = [];
                                            context.checkItemsIsSafeToSelect(selectedItemIds, equipmentTable, conflictItems, unableSelectItems, itemIdConflictNextMaintenanceDate, itemIdMaximumConflictWorkOrder, addEquipmentWarnings);
                                            
                                            context.addEquipment(true, equipmentOption, itemQuantity, selectedItemIds, indeterminate, checkAllItems, equipmentTable, conflictItems, unableSelectItems, itemIdConflictNextMaintenanceDate, itemIdMaximumConflictWorkOrder, addEquipmentWarnings);
                                        }
                                        context.loadEditOrder = false;
                                    }
                                });// get all equipments to display options
                            }
                        });
                    }
                }
            });               
    },
    methods: {
        cancel() {
            this.$router.push("/work_order");
        },
        addEquipment(editOrder, equipmentOption, itemQuantity, selectedItemIds, indeterminate, checkAllItems, equipmentTable, conflictItems, unableSelectItems, itemIdConflictNextMaintenanceDate, itemIdMaximumConflictWorkOrder, addEquipmentWarnings) {
            if (equipmentOption.value == "") {
                this.AddEquipmentWarnings.MustSelectEquipment = this.ErrorStrings.MustSelectEquipment;
            } 
            if (this.selectedEquipmentQuantity == 0) {
                this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = this.ErrorStrings.SelectedEquipmentQuantityIsZero;
            }
            if (this.validateAddEquipment() || editOrder) {
                if (equipmentOption.value != "" &&
                        equipmentOption.totalQuantity > 0) {
                    let index = this.selectedEquipments.findIndex(
                        equipment => equipment.id == equipmentOption.value
                    );
                    // this equipment is not yet selected, so add to the list
                    var warningOb = JSON.stringify(addEquipmentWarnings);
                    warningOb = JSON.parse(warningOb);
                    if (index < 0) {
                        let equipment = {
                            id: parseInt(equipmentOption.value),
                            name: equipmentOption.text,
                            quantity: parseInt(itemQuantity),
                            image: equipmentOption.image,
                            totalQuantity: parseInt(
                                equipmentOption.totalQuantity
                            ),
                            equipmentItemIds: selectedItemIds,
                            editMode: false,
                            indeterminate: indeterminate,
                            checkAllItems: checkAllItems,
                            equipmentItemList: equipmentTable,
                            conflictItems: conflictItems,                            
                            unableSelectItems: unableSelectItems,
                            itemIdConflictNextMaintenanceDate: itemIdConflictNextMaintenanceDate,
                            itemIdMaximumConflictWorkOrder: itemIdMaximumConflictWorkOrder,
                            addEquipmentWarnings: warningOb,
                            maintenancePeriodInMonths: equipmentOption.maintenancePeriodInMonths,
                        };
                        this.selectedEquipments.push(equipment);
                    } else { // this equipment is already added to the list, so modified the quantity
                        // TODO
                    }
                    this.toDisplayEquipmentOptions = this.toDisplayEquipmentOptions.filter(option => parseInt(option.value) != parseInt(equipmentOption.value));
            
                    // reset values
                    this.selectedEquipment = {
                        text: "",
                        value: "",
                        image: "",
                        totalQuantity: 0
                    };
                    this.resetEquipmentSelection();
                }
            } 
        },
        removeEquipment(equipment) {
            this.selectedEquipments = this.selectedEquipments.filter(
                e => e.id != equipment.id
            );
            this.toDisplayEquipmentOptions = this.equipmentOptions;
            this.selectedEquipments.forEach(equipment => {
                this.toDisplayEquipmentOptions = this.toDisplayEquipmentOptions.filter(option => parseInt(option.value) != parseInt(equipment.id));
            })
        },
        getToday() {
            return moment().format("YYYY-MM-DD");
        },
        async updateWorkOrder() {
            if (this.selectedEquipments.length == 0) {
                this.CreateWorkOrderErrors.NoEquipmentSelected = this.ErrorStrings.NoEquipmentSelected;
            }
            if (this.selectedLocation.value === '' && this.authUser.Role == 'Staff') {
                this.CreateWorkOrderErrors.NoLocation = this.ErrorStrings.NoLocation;
            }
            if (this.selectedTeam.value === '' && this.authUser.Role == 'Staff') {
                this.CreateWorkOrderErrors.NoTeam = this.ErrorStrings.NoTeam;
            }
            if (this.validateUpdateOrder()) {
                let context = this;
                context.sending = true;
                // first, delete all work order details
                let deleteDetailApi = `${Server.WORKORDER_API_PATH}/detail/${context.editWorkOrder.Id}`;
                context.axios.delete(deleteDetailApi)
                    .then(async (res) => {
                        if (res.status == 200) {
                            let teamLocationId = null;
                            if (this.authUser.Role == 'Staff') {
                                let teamLocationApi = `${Server.TEAM_LOCATION_API_PATH}/${this.selectedLocation.value}/${this.selectedTeam.value}`;
                                await this.axios.get(teamLocationApi)
                                    .then(async function(res) {
                                        if (res.data.Id) {
                                            teamLocationId = res.data.Id;
                                            // update team location                                            
                                        }
                                })
                                .catch(error => {
                                    alert(
                                    "Create work order: " + error
                                    );
                                });
                            }

                            if (this.authUser.Role == 'Maintainer' || (this.authUser.Role == 'Staff' && teamLocationId)) {
                                context.axios.put(`http://localhost:3000/api/work_order/${context.editWorkOrder.Id}`, {
                                                teamLocationId: teamLocationId,
                                                expectingStartDate: moment(context.workOrderDateRange[0]).format('MM-DD-YYYY'),
                                                expectingCloseDate: moment(context.workOrderDateRange[1]).format('MM-DD-YYYY'), 
                                            });
                                let url = `${Server.WORKORDER_API_PATH}/status/${context.editWorkOrder.Id}`;
                                context.axios
                                    .put(url, {
                                        userId: context.authUser.Id,
                                        newStatusName: 'Requested',
                                        description: context.description.trim() == '' ? null : context.description.trim(),
                                    });

                                // add updated work order details
                                var check = true;
                                for (const equipment of context.selectedEquipments) {
                                    for (const itemId of equipment.equipmentItemIds) {
                                        try {
                                            const response = await context.axios
                                                                    .post(Server.WORKORDER_DETAIL_API_PATH, {
                                                                        workOrderId: context.editWorkOrder.Id,
                                                                        equipmentItemId: itemId,
                                                                        startDate: equipment.fromDate,
                                                                        dueDate: equipment.toDate,
                                                                        maintainceCost: null,
                                                                        description: null
                                                                    });
                                            if (response.status == 200) {
                                                check = true;
                                            }
                                        } catch(error) {
                                            console.log(error);
                                            check = false;
                                        }
                                    }
                                }
                                context.sending = false;
                                if (check) {
                                    const notificationContent = `<strong>${context.authUser.Username}</strong> updated work order <strong>${context.editWorkOrder.Name}</strong>`;
                                    let metaData = {
                                        page: 'work_order',
                                        elementId: context.editWorkOrder.Id,
                                    };
                                    await context.axios.post(`${Server.NOTIFICATION_API_PATH}/accounts`, {
                                        notificationContent: notificationContent,
                                        userRole: 'Equipment Staff',
                                        metaData: metaData,
                                    }).then(async (res) => {
                                        if (res.status == 200) {
                                            context.$socket.emit('NEW_NOTIFICATION', {needToUpdateNotification: {roles: ['Equipment Staff'],}});
                                        }
                                    });
                                    await context.axios.post(`${Server.NOTIFICATION_API_PATH}/accounts`, {
                                        notificationContent: notificationContent,
                                        userRole: 'Manager',
                                        metaData: metaData,
                                    }).then(async (res) => {
                                        if (res.status == 200) {
                                            context.$socket.emit('NEW_NOTIFICATION', {needToUpdateNotification: {roles: ['Manager'],}});
                                        }
                                    });

                                    context.$socket.emit('NEW_WORK_ORDER_CREATED', {message: 'Created Work Order'});

                                    let obj = {
                                        message: "Work Order updated successfully",
                                        type: "success",
                                        hideAllButton: true,
                                        showXclose: false,
                                    };
                                    context.$refs.simplert.openSimplert(obj);
                                    await Utils.sleep(500);
                                    context.$router.push(`/work_order/${context.editWorkOrder.Id}`);
                                } else {
                                    alert('Error');
                                }    
                                
                            }
                        }
                    })
                    .catch((error) => {
                        console.log(error);
                    })
            }
        },
        validateAddEquipment() {
            return this.AddEquipmentWarnings.MustSelectEquipment === '' && this.AddEquipmentWarnings.AvailableQuantityIsZero === '' 
                    && this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero === '' && this.AddEquipmentWarnings.UnableToSelectItem === ''
                    && this.AddEquipmentWarnings.ErrorMaximumConflictWorkOrder === '';
        },
        validateUpdateOrder() {  
            var checkSelectedItems = true; // check if currently there is no error messages of items are displaying
            for (var i = 0; i < this.selectedEquipments.length; i++) {
                let selectedEquipment = this.selectedEquipments[i];
                if (selectedEquipment.addEquipmentWarnings.SelectedEquipmentQuantityIsZero != ''
                        || selectedEquipment.addEquipmentWarnings.UnableToSelectItem != ''
                        || selectedEquipment.addEquipmentWarnings.ConflictMaintenanceDate != ''
                        || selectedEquipment.addEquipmentWarnings.ErrorMaximumConflictWorkOrder != '') {
                checkSelectedItems = false;
                selectedEquipment.editMode = true;
                }
            }
            return this.CreateWorkOrderErrors.NoEquipmentSelected === ''
                    && this.CreateWorkOrderErrors.NoLocation === '' && this.CreateWorkOrderErrors.NoTeam === ''
                    && this.CreateWorkOrderErrors.NoWorkOrderDateRange === ''
                    && checkSelectedItems && !this.errorOrderDurationIsLongerThanMaximum;
        },
        getMilis(date) {
            return moment(date).startOf('day').valueOf();
        },
        getDate(date) {
            return moment(date).format("L");
        },
        checkItemFromTable(equipmentItemId) {
            this.indeterminate = true;
            this.checkAllItems = false;
      
            // if selectedEquipmentItemIds already has equipmentItemId, we decrease the selectedEquipmentQuantity, then remove the equipmentItemId from the selectedEquipmentItemIds
            if (this.selectedEquipmentItemIds.includes(equipmentItemId)) {
                this.selectedEquipmentQuantity = parseInt(this.selectedEquipmentQuantity) - 1;
                this.selectedEquipmentItemIds = this.selectedEquipmentItemIds.filter(itemId => itemId != equipmentItemId);
                if (this.selectedEquipmentItemIds.length == 0) {
                    this.indeterminate = false;
                    this.checkAllItems = false;
                    this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = this.ErrorStrings.SelectedEquipmentQuantityIsZero;
                }
            } else {
                this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = "";
                this.selectedEquipmentQuantity =
                parseInt(this.selectedEquipmentQuantity) + 1;
                this.selectedEquipmentItemIds.push(equipmentItemId);
                if (this.selectedEquipmentItemIds.length == this.equipmentTable.length) {
                    this.indeterminate = false;
                    this.checkAllItems = true;
                }
            }
        },
        handleCheckAllItems() {
            if (this.indeterminate) {
                this.checkAllItems = false;
            } else {
                this.checkAllItems = !this.checkAllItems;
            }
            this.conflictItems = [];
            this.unableSelectItems = [];
            this.indeterminate = false;
            if (this.checkAllItems) {
                this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = '';
                this.selectedEquipmentItemIds = [];
                this.equipmentTable.forEach(item =>
                this.selectedEquipmentItemIds.push(item.Id)
                );
                this.selectedEquipmentQuantity = this.equipmentTable.length;
            } else {        
                this.selectedEquipmentItemIds = [];
                this.selectedEquipmentQuantity = 0;
                this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                this.AddEquipmentWarnings.UnableToSelectItem = '';
                this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = this.ErrorStrings.SelectedEquipmentQuantityIsZero;
            }
        },
        resetEquipmentSelection() {
            this.equipmentTable = [];
            this.indeterminate = false;
            this.checkAllItems = false;

            this.selectedEquipmentItemIds = [];
            this.selectedEquipmentQuantity = 0;
            this.selectedEquipmentFromDate = this.getToday();
            this.selectedEquipmentToDate = this.getToday();

            this.conflictItems = [];
            this.unableSelectItems = [];
            this.AddEquipmentWarnings.MustSelectEquipment = '';
            this.AddEquipmentWarnings.NoEquipmentSelected = '';
            this.AddEquipmentWarnings.AvailableQuantityIsZero = '';
            this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = '';
            this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = '';
            this.AddEquipmentWarnings.UnableToSelectItem = '';
            this.AddEquipmentWarnings.ConflictMaintenanceDate = '';
        },
        isItemConflicted(itemId, workOrderId, conflictItems) {
            for (var i = 0; i < conflictItems.length; i++) {
                let item = conflictItems[i];
                if (item.itemId == itemId && item.workOrderId == workOrderId) {
                    return true;
                }
            }
            return false;
        },
        isItemUnableToSelect(itemId, workOrderId, unableSelectItems) {
            for (var i = 0; i < unableSelectItems.length; i++) {
                let item = unableSelectItems[i];
                if (workOrderId != this.editWorkOrder.Id
                    && item.itemId == itemId 
                    && item.workOrderId == workOrderId) {
                    return true;
                }
            }
            return false;
        },
        isItemConflictNextMaintenanceDate(itemId, itemIdConflictNextMaintenanceDate) {
            for (const id of itemIdConflictNextMaintenanceDate) {
                if (id == itemId) {
                    return true;
                }
            }
            return false;
        },
        isItemExcessMaximumConflictWorkOrder(itemId, itemIdMaximumConflictWorkOrder) {
            return itemIdMaximumConflictWorkOrder.includes(itemId);
        },
        checkSelectedItemDateConflict(items, conflictItems, unableSelectItems, itemIdConflictNextMaintenanceDate, itemIdMaximumConflictWorkOrder) {
            if (items.length > 0 && (this.workOrderDateRange[0] && this.workOrderDateRange[1])) {
                let workOrderStartDate = moment(this.workOrderDateRange[0]).format('YYYY-MM-DD').valueOf();
                let workOrderCloseDate = moment(this.workOrderDateRange[1]).format('YYYY-MM-DD').valueOf();
                items.forEach(item => {
                    if (this.authUser.Role == 'Staff' 
                        && (moment(item.NextMaintainDate).format('YYYY-MM-DD').valueOf() >= workOrderStartDate 
                            && moment(item.NextMaintainDate).format('YYYY-MM-DD').valueOf() <= workOrderCloseDate)) {
                        itemIdConflictNextMaintenanceDate.push(item.Id);
                    }
                    if (item.WorkOrders) {
                        let numOfConflictOrders = 0;
                        item.WorkOrders.forEach(order => {
                            let itemFromDate = moment(order.ExpectingStartDate).format('YYYY-MM-DD').valueOf();
                            let itemToDate = moment(order.ExpectingCloseDate).format('YYYY-MM-DD').valueOf();
                            if ((order.Id != this.editWorkOrder.Id) 
                                && ((workOrderStartDate >= itemFromDate && workOrderStartDate <= itemToDate)  
                                    || (workOrderCloseDate >= itemFromDate && workOrderCloseDate <= itemToDate)
                                    || (workOrderStartDate < itemFromDate && workOrderCloseDate > itemToDate))) {
                                ++numOfConflictOrders;
                                if (numOfConflictOrders > this.config.createWorkOrder.maximumConflictWorkOrders) {
                                    itemIdMaximumConflictWorkOrder.push(item.Id);
                                } else {
                                    if (order.Status == 'Approved' || order.Status == 'In Progress') {
                                        unableSelectItems.push({itemId: item.Id, workOrderId: order.Id});
                                    } else {
                                        conflictItems.push({itemId: item.Id, workOrderId: order.Id});
                                    }
                                }
                            }
                        });
                    }
                });
            }
        },
        checkItemsIsSafeToSelect(itemIds, itemTable, conflictItems, unableSelectItems, itemIdConflictNextMaintenanceDate, itemIdMaximumConflictWorkOrder, addEquipmentWarnings) {
            // check if from date conflicts any item in work orders
            let tempItems = [];
            // get the selected items in equipmentTable to tempItems
            itemIds.forEach(itemId => {
                tempItems = tempItems.concat(
                itemTable.filter(item => item.Id == itemId)
                );
            });
            // get the selected items in equipmentTable to tempItems          
            this.checkSelectedItemDateConflict(tempItems, conflictItems, unableSelectItems, itemIdConflictNextMaintenanceDate, itemIdMaximumConflictWorkOrder);
            if (conflictItems.length == 0) {
                addEquipmentWarnings.SelectedDateConflictWorkOrders = "";
            } else {
                addEquipmentWarnings.SelectedDateConflictWorkOrders = this.ErrorStrings.SelectedDateConflictWorkOrders;
            }
            if (unableSelectItems.length == 0) {
                addEquipmentWarnings.UnableToSelectItem = '';
            } else {
                addEquipmentWarnings.UnableToSelectItem = this.ErrorStrings.UnableToSelectItem;
            }
            if (itemIdConflictNextMaintenanceDate.length == 0) {
                addEquipmentWarnings.ConflictMaintenanceDate = '';
            } else {
                addEquipmentWarnings.ConflictMaintenanceDate = this.ErrorStrings.ConflictMaintenanceDate;
            }
            if (itemIdMaximumConflictWorkOrder.length == 0) {
                addEquipmentWarnings.ErrorMaximumConflictWorkOrder = '';
            } else {
                if (this.config.createWorkOrder.maximumConflictWorkOrders == 0) {
                    addEquipmentWarnings.ErrorMaximumConflictWorkOrder = 'You cannot select equipment that is currently in another work order';
                } else {
                    addEquipmentWarnings.ErrorMaximumConflictWorkOrder = `You cannot select equipment that is currently in more than ${this.config.createWorkOrder.maximumConflictWorkOrders} other order${this.config.createWorkOrder.maximumConflictWorkOrders > 1 ? 's' : ''}`;
                }
            }
        },
        sortItems(items) {
            let context = this;
            // determine sorting preset - start
            const durationFromCreateDate = moment(this.workOrderDateRange[0]).diff(moment(), 'days') + 1;
            this.currentCreateOrderConfigPreset = this.config.createWorkOrder.presets.filter(preset => preset.name == 'Normal')[0];
            if (this.workOrderDateRange[0]) {
                const presets = this.config.createWorkOrder.presets;
                for (let i = 1; i < presets.length; i++) {
                let durationFromCreatePreset1 = presets[i].durationFromCreateDate;
                switch (presets[i].durationFromCreateDateType) {
                    case 'month': {
                    durationFromCreatePreset1 *= 30;
                    break;
                    }
                    case 'year': {
                    durationFromCreatePreset1 *= 30 * 12;
                    break;
                    }
                }
                if (i < presets.length - 1) {
                    let durationFromCreatePreset2 = presets[i + 1].durationFromCreateDate;
                    switch (presets[i + 1].durationFromCreateDateType) {
                    case 'month': {
                        durationFromCreatePreset2 *= 30;
                        break;
                    }
                    case 'year': {
                        durationFromCreatePreset2 *= 30 * 12;
                        break;
                    }
                    }
                    if (durationFromCreateDate <= durationFromCreatePreset1 && durationFromCreateDate <= durationFromCreatePreset2) {
                    this.currentCreateOrderConfigPreset = presets[i];
                    break;
                    }
                } else if (i == presets.length - 1) {
                    if (durationFromCreateDate <= durationFromCreatePreset1) {
                    this.currentCreateOrderConfigPreset = presets[i];
                    break;
                    }
                }
                } 
            } // determine sorting preset - end
            return items.sort(function(item1, item2) {
                var notAllowFactor_Item1 = 1;
                var notAllowFactor_Item2 = 1;

                if ((context.getMilis(item1.NextMaintainDate) >= context.getMilis(context.workOrderDateRange[0]) 
                    && context.getMilis(item1.NextMaintainDate) <= context.getMilis(context.workOrderDateRange[1]))) {
                    notAllowFactor_Item1 = 0.0000001;
                }
                if (context.getMilis(item2.NextMaintainDate) >= context.getMilis(context.workOrderDateRange[0]) 
                    && context.getMilis(item2.NextMaintainDate) <= context.getMilis(context.workOrderDateRange[1])) {
                    notAllowFactor_Item2 = 0.0000001;
                }

                let A0_Item1 = Math.abs(moment(item1.ImportDate).diff(moment(), 'days')) + 1;
                let A_Item1 = parseFloat(item1.RuntimeDays);
                let B_Item1 = parseFloat(item1.Distance.value) / 1000;

                let A0_Item2 = Math.abs(moment(item2.ImportDate).diff(moment(), 'days')) + 1;
                let A_Item2 = parseFloat(item2.RuntimeDays);
                let B_Item2 = parseFloat(item2.Distance.value) / 1000;

                var C_Item1 = 0;
                if (item1.WorkOrders) {
                    for (const order of item1.WorkOrders) {
                        if (context.editWorkOrder.Id != order.Id
                            && ((context.getMilis(context.workOrderDateRange[0]) >= context.getMilis(order.ExpectingStartDate) 
                                    && context.getMilis(context.workOrderDateRange[0]) <= context.getMilis(order.ExpectingCloseDate))
                                || (context.getMilis(context.workOrderDateRange[1]) >= context.getMilis(order.ExpectingStartDate)
                                    && context.getMilis(context.workOrderDateRange[1]) <= context.getMilis(order.ExpectingCloseDate))
                                || (context.getMilis(context.workOrderDateRange[0]) < context.getMilis(order.ExpectingStartDate)
                                    && context.getMilis(context.workOrderDateRange[1]) > context.getMilis(order.ExpectingCloseDate)))) {
                            ++C_Item1;
                            if (C_Item1 > context.config.createWorkOrder.maximumConflictWorkOrders) {
                                notAllowFactor_Item1 = 0.0000001;
                            } else {
                                if (order.Status == 'Requested' || order.Status == 'Checked') {
                                    notAllowFactor_Item1 = 0.0000005;
                                } else if (order.Status == 'Approved' || order.Status == 'In Progress') {
                                    notAllowFactor_Item1 = 0.0000001;
                                }
                            }
                        }
                    }
                }
                var C_Item2 = 0;
                if (item2.WorkOrders) {
                    for (const order of item2.WorkOrders) {
                        if (context.editWorkOrder.Id != order.Id
                            && ((context.getMilis(context.workOrderDateRange[0]) >= context.getMilis(order.ExpectingStartDate) 
                                    && context.getMilis(context.workOrderDateRange[0]) <= context.getMilis(order.ExpectingCloseDate))
                                || (context.getMilis(context.workOrderDateRange[1]) >= context.getMilis(order.ExpectingStartDate)
                                    && context.getMilis(context.workOrderDateRange[1]) <= context.getMilis(order.ExpectingCloseDate))
                                || (context.getMilis(context.workOrderDateRange[0]) < context.getMilis(order.ExpectingStartDate)
                                    && context.getMilis(context.workOrderDateRange[1]) > context.getMilis(order.ExpectingCloseDate)))) {
                            ++C_Item2;
                            if (C_Item2 > context.config.createWorkOrder.maximumConflictWorkOrders) {
                                notAllowFactor_Item2 = 0.0000001;
                            } else {
                                if (order.Status == 'Requested' || order.Status == 'Checked') {
                                notAllowFactor_Item2 = 0.0000005;
                                } else if (order.Status == 'Approved' || order.Status == 'In Progress') {
                                notAllowFactor_Item2 = 0.0000001;
                                }
                            }
                        }
                    }
                }
                let result1 = notAllowFactor_Item1 * (context.currentCreateOrderConfigPreset.runtimeFactor*((A0_Item1 - A_Item1)/A0_Item1) + context.currentCreateOrderConfigPreset.distanceFactor*(Math.abs(Math.sin(Math.sqrt(B_Item1)/2.5) / (Math.sqrt(B_Item1 + 0.1)/2.5)))) * (1 / (C_Item1 + 1));
                let result2 = notAllowFactor_Item2 * (context.currentCreateOrderConfigPreset.runtimeFactor*((A0_Item2 - A_Item2)/A0_Item2) + context.currentCreateOrderConfigPreset.distanceFactor*(Math.abs(Math.sin(Math.sqrt(B_Item2)/2.5) / (Math.sqrt(B_Item2 + 0.1)/2.5)))) * (1 / (C_Item2 + 1));
                const result = result2 - result1;
                return result;
            });
        },
        getDistance(warehouseLocation, workOrderLocationOption) {
            let context = this;
            return new Promise(async (resolve, reject) => {
                let distance = null;
                for (const value of context.distancesCache) {
                    if (value.warehouseId == warehouseLocation.Id && value.locationId == parseInt(workOrderLocationOption.value)) {
                        distance = value.distance;
                        break;
                    }
                }
                if (!distance) {
                    await context.axios.post(`${Server.SERVER_DEFAULT}/map/distancematrix`, {
                        origins: [`${workOrderLocationOption.latitude}, ${workOrderLocationOption.longitude}`,],
                        destinations: [`${warehouseLocation.Latitude}, ${warehouseLocation.Longitude}`,],
                        travelMode: '',
                        }).then((res) => {
                            if (res.data) {
                                distance = res.data[0].elements[0].distance;
                                context.distancesCache.push({
                                    warehouseId: warehouseLocation.Id,
                                    locationId: parseInt(workOrderLocationOption.value),
                                    distance: distance,
                                });
                            }
                        }).catch((error) => {
                            console.log(error);
                            reject(error);
                        })
                }
                resolve(distance);
            });
        },
    },
    watch: {
        'selectedEquipment': async function() {
            // selecte another equipment
            if (this.selectedEquipment.value != "") {
                this.resetEquipmentSelection(); // reset after selected another equipment
                if (this.AddEquipmentWarnings.MustSelectEquipment != "") {
                    // error 'Must select equipment' displaying
                    this.AddEquipmentWarnings.MustSelectEquipment = "";
                }
                // check if selected equipment has equipment item(s)
                if (this.selectedEquipment.totalQuantity == 0) {
                    this.AddEquipmentWarnings.AvailableQuantityIsZero = this.ErrorStrings.AvailableQuantityIsZero;
                } else {
                    this.itemsLoading = true;
                    this.AddEquipmentWarnings.AvailableQuantityIsZero = ""; // set warning to empty text

                    // get all the equipment items with work order detail info (if available)
                    let url = `${Server.WORKORDER_API_PATH}/get_equipment_detail/${
                        this.selectedEquipment.value
                    }`;
                    this.axios.get(url).then(async (res) => {
                        if (res.status == 200 && res.data) {
                            this.equipmentTable = [];
                            let tempItems = [];
                            for (const eqi of res.data) {
                                let distance = {text: 'n/a', value: 1};
                                if (this.selectedLocation && this.selectedLocation.value != '') {
                                    distance = await this.getDistance(eqi.Warehouse, this.selectedLocation);
                                }
                                let item = {
                                    "Id": eqi.Id,
                                    "EquipmentID": eqi.EquipmentID,
                                    "SerialNumber": eqi.SerialNumber,
                                    "WarrantyDuration": eqi.WarrantyDuration,
                                    "RuntimeDays": eqi.RuntimeDays,
                                    "TileID": eqi.TileID,
                                    "Price": eqi.Price,
                                    "ImportDate": eqi.ImportDate,
                                    "NextMaintainDate": eqi.NextMaintainDate,
                                    "StatusId": eqi.StatusId,
                                    "Description": eqi.Description,
                                    "Status": eqi.Status,
                                    "Warehouse": eqi.Warehouse,
                                    "WorkOrders": eqi.WorkOrders,
                                    "Distance": distance,
                                };
                                tempItems.push(item);
                            }
                            if (this.authUser.Role == 'Staff') {
                                this.equipmentTable = this.sortItems(tempItems);
                            } else {
                                this.equipmentTable = tempItems;
                            }
                            this.itemsLoading = false;
                            // this.selectedEquipmentItemIds.push(this.equipmentTable[0].Id);
                            this.selectedEquipmentQuantity = 0;
                            // this.selectedEquipmentQuantity = 1;
                            // this.indeterminate = true;
                            this.indeterminate = false;
                            this.checkAllItems = false;
                        }
                    });
                }
            }
        },
        'selectedEquipments': function() {
            if (this.selectedEquipments.length > 0) {
                this.CreateWorkOrderErrors.NoEquipmentSelected = '';
            }
        },
        'selectedLocation': async function() {
            this.teamOptions = [];
            this.selectedTeam = {
                text: "",
                value: ""
            };
            if (this.selectedLocation.value != "") {
                if (this.CreateWorkOrderErrors.NoLocation != "") {
                    this.CreateWorkOrderErrors.NoLocation = "";
                }
                // change distance of equipment
                for (const equipment of this.selectedEquipments) {
                    for (const item of equipment.equipmentItemList) {
                        item.Distance = await this.getDistance(item.Warehouse, this.selectedLocation);
                    }
                    if (this.authUser.Role == 'Staff') {
                        equipment.equipmentItemList = this.sortItems(equipment.equipmentItemList);
                    }
                }
                if (this.equipmentTable && this.equipmentTable.length) {
                    for (const item of this.equipmentTable) {
                        item.Distance = await this.getDistance(item.Warehouse, this.selectedLocation);
                    }
                    if (this.authUser.Role == 'Staff') {
                        this.equipmentTable = this.sortItems(this.equipmentTable);
                    }
                }

                // alert('in 2')
                let url = `${Server.LOCATION_API_PATH}/${
                this.selectedLocation.value
                }/team/${this.authUser.Id}`;
                await this.axios.get(url).then(res => {
                    if (res.data) {
                        let data = res.data;
                        data.forEach(element => {
                            let option = {
                                value: element.Team.Id,
                                text: element.Team.Name
                            };
                            this.teamOptions.push(option);
                        });
                    }
                });
            }
        },
        'workOrderDateRange': function() {
            if (this.workOrderDateRange[0] && this.workOrderDateRange[1]) {
                this.CreateWorkOrderErrors.NoWorkOrderDateRange = '';
                const workOrderDuration = moment(this.workOrderDateRange[1]).diff(moment(this.workOrderDateRange[0]), 'days') + 1;
                let maximumDurationFromConfig = this.config.createWorkOrder.maximumWorkOrderDuration;
                switch(this.config.createWorkOrder.maximumWorkOrderDurationType) {
                    case 'month': {
                        maximumDurationFromConfig *= 30;
                        break;
                    }
                    case 'year': {
                        maximumDurationFromConfig *= 30 * 12;
                        break;
                    }
                }
                if (workOrderDuration > maximumDurationFromConfig) {
                    this.errorOrderDurationIsLongerThanMaximum = true;
                } else {
                    this.errorOrderDurationIsLongerThanMaximum = false;
                }
                if (this.authUser.Role == 'Staff') {
                    this.equipmentTable = this.sortItems(this.equipmentTable);
                }
                if (this.selectedEquipmentItemIds.length > 0) {
                    this.conflictItems = [];
                    this.unableSelectItems = [];
                    this.itemIdConflictNextMaintenanceDate = [];
                    this.itemIdMaximumConflictWorkOrder = [];
                    this.checkItemsIsSafeToSelect(this.selectedEquipmentItemIds, this.equipmentTable, 
                                        this.conflictItems, this.unableSelectItems, this.itemIdConflictNextMaintenanceDate,
                                        this.itemIdMaximumConflictWorkOrder,
                                        this.AddEquipmentWarnings);
                }
                if (this.selectedEquipments.length > 0) {
                    for (const eq of this.selectedEquipments) {
                        if (this.authUser.Role == 'Staff') {
                            eq.equipmentItemList = this.sortItems(eq.equipmentItemList);
                        }
                        eq.conflictItems = [];
                        eq.unableSelectItems = [];
                        eq.itemIdConflictNextMaintenanceDate = [];
                        eq.itemIdMaximumConflictWorkOrder = [];
                        this.checkItemsIsSafeToSelect(eq.equipmentItemIds, eq.equipmentItemList, 
                                        eq.conflictItems, eq.unableSelectItems, eq.itemIdConflictNextMaintenanceDate, 
                                        eq.itemIdMaximumConflictWorkOrder,
                                        eq.addEquipmentWarnings);
                        if (eq.conflictItems.length > 0 || eq.unableSelectItems.length > 0 || eq.itemIdConflictNextMaintenanceDate.length > 0) {
                            eq.editMode = true;
                        }
                    }
                }
            }
        },
        'selectedEquipmentQuantity': function() {
            if (this.selectedEquipmentQuantity === "") {
                this.selectedEquipmentQuantity = 0;
                this.selectedEquipmentItemIds = [];
                this.conflictItems = [];
                this.indeterminate = false;
                this.checkAllItems = false;
                this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = "";
                this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = this.ErrorStrings.SelectedEquipmentQuantityIsZero;
            } else {
                if (this.selectedEquipment.value != "" && this.selectedEquipment.totalQuantity > 0) {
                        this.selectedEquipmentQuantity = parseInt(this.selectedEquipmentQuantity);
                        let equipmentTotalQuantity = parseInt(this.selectedEquipment.totalQuantity);
                    if (parseInt(this.selectedEquipmentQuantity) < 0) {
                        this.selectedEquipmentQuantity = 0;
                    } else if (parseInt(this.selectedEquipmentQuantity) > equipmentTotalQuantity) {
                        this.selectedEquipmentQuantity = equipmentTotalQuantity;
                    }

                    // if the selectedEquipmentQuantity = 0, we should display a warning to user
                    if (parseInt(this.selectedEquipmentQuantity) == 0) {
                        this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = this.ErrorStrings.SelectedEquipmentQuantityIsZero;
                        this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = "";
                        this.selectedEquipmentItemIds = [];
                        // this.conflictItems = [];
                        this.indeterminate = false;
                        this.checkAllItems = false;
                    } else {
                        this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = "";
                        this.indeterminate = true;
                        // if the selectedEquipmentQuantity is greater than selectedEquipmentItemIds.length
                        //, it means we should add the next item to selectedEquipmentItemIds
                        if (parseInt(this.selectedEquipmentQuantity) >= this.selectedEquipmentItemIds.length) {
                            while (this.selectedEquipmentItemIds.length != parseInt(this.selectedEquipmentQuantity)) {
                                let tempItems = this.equipmentTable;
                                this.selectedEquipmentItemIds.forEach(itemId => {
                                tempItems = tempItems.filter(item => item.Id != itemId);
                                });
                                this.selectedEquipmentItemIds.push(tempItems[0].Id);
                            }
                            if (this.selectedEquipmentItemIds.length == this.equipmentTable.length) {
                                this.indeterminate = false;
                                this.checkAllItems = true;
                            }
                        } else if (parseInt(this.selectedEquipmentQuantity) < this.selectedEquipmentItemIds.length) {
                            // the code below will simply pop the last id out of the list, so if user has pick an equipment by hand (not using the number input)
                            // and then use the number input, the item is not automatically calculate to choose the best ideal one
                            // in other words, the order of item will not be the best ideal order the algorithm should give out
                            // then the user would see item unchecks in the incorrect descending order
                            // but i think we should respect the user's choice
                            while (this.selectedEquipmentItemIds.length != parseInt(this.selectedEquipmentQuantity)) {
                                this.selectedEquipmentItemIds.pop();
                            }
                        }
                        // this.conflictItems = [];
                        // this.unableSelectItems = [];
                        // this.checkItemsIsSafeToSelect(this.selectedEquipmentItemIds, this.equipmentTable, this.conflictItems, this.unableSelectItems, this.AddEquipmentWarnings);
                    }        
                }
            }
        },
        'selectedTeam': function() {
            if (this.selectedTeam.value != '' && this.CreateWorkOrderErrors.NoTeam != '') {
                this.CreateWorkOrderErrors.NoTeam = '';
            }
        },
        'selectedEquipmentItemIds': function() {
            if (this.selectedEquipmentItemIds.length >= 0 && (this.workOrderDateRange[0] && this.workOrderDateRange[1])) {
                this.conflictItems = [];
                this.unableSelectItems = [];
                this.itemIdConflictNextMaintenanceDate = [];
                this.itemIdMaximumConflictWorkOrder = [];
                this.checkItemsIsSafeToSelect(this.selectedEquipmentItemIds, this.equipmentTable, 
                                            this.conflictItems, this.unableSelectItems, this.itemIdConflictNextMaintenanceDate,
                                            this.itemIdMaximumConflictWorkOrder,
                                            this.AddEquipmentWarnings);
            }
        },
        'config': function() {
            if (this.authUser.Role == 'Staff') {
                if (this.config) {
                    let obj = {
                        title: "Website's configuration has been changed",
                        message: "The display order of equipment may be different",
                        type: "warning",
                    };
                    this.$refs.simplert.openSimplert(obj);
                    if (this.currentCreateOrderConfigPreset) {
                        if (this.authUser.Role == 'Staff') {
                            this.equipmentTable = this.sortItems(this.equipmentTable);
                        }
                        if (this.selectedEquipmentItemIds.length > 0) {
                            this.conflictItems = [];
                            this.unableSelectItems = [];
                            this.itemIdConflictNextMaintenanceDate = [];
                            this.itemIdMaximumConflictWorkOrder = [];
                            this.checkItemsIsSafeToSelect(this.selectedEquipmentItemIds, this.equipmentTable, 
                                                this.conflictItems, this.unableSelectItems, this.itemIdConflictNextMaintenanceDate,
                                                this.itemIdMaximumConflictWorkOrder,
                                                this.AddEquipmentWarnings);
                        }
                        if (this.selectedEquipments.length > 0) {
                            for (const eq of this.selectedEquipments) {
                                if (this.authUser.Role == 'Staff') {
                                eq.equipmentItemList = this.sortItems(eq.equipmentItemList);
                                }
                                eq.conflictItems = [];
                                eq.unableSelectItems = [];
                                eq.itemIdConflictNextMaintenanceDate = [];
                                eq.itemIdMaximumConflictWorkOrder = [];
                                this.checkItemsIsSafeToSelect(eq.equipmentItemIds, eq.equipmentItemList, 
                                                eq.conflictItems, eq.unableSelectItems, eq.itemIdConflictNextMaintenanceDate, 
                                                eq.itemIdMaximumConflictWorkOrder,
                                                eq.addEquipmentWarnings);
                                if (eq.conflictItems.length > 0 || eq.unableSelectItems.length > 0) {
                                eq.editMode = true;
                                }
                            }
                        }
                    }
                    // check valid maximum conflict work order

                    // check valid work order duration
                    const workOrderDuration = moment(this.workOrderDateRange[1]).diff(moment(this.workOrderDateRange[0]), 'days') + 1;
                    let maximumDurationFromConfig = this.config.createWorkOrder.maximumWorkOrderDuration;
                    switch(this.config.createWorkOrder.maximumWorkOrderDurationType) {
                        case 'month': {
                            maximumDurationFromConfig *= 30;
                            break;
                        }
                        case 'year': {
                            maximumDurationFromConfig *= 30 * 12;
                            break;
                        }
                    }
                    if (workOrderDuration > maximumDurationFromConfig) {
                        this.errorOrderDurationIsLongerThanMaximum = true;
                    } else {
                        this.errorOrderDurationIsLongerThanMaximum = false;
                    }
                }
            }
        },
    }
};
</script>

<style scoped>
input[type="number"] {
  text-align: right;
}

.form {
  /* background-color: white; */
  padding: 0 !important;
}
.form-title {
  display: grid;
  grid-template-columns: 65% 35%;
  border-bottom: 1px solid #e0e0e0;
  padding: .5rem 2rem;
  box-shadow: 0px 3px 5px var(--shadow);
  z-index: 5;
}

.form-title-start {
  position: relative;
  top: 10px;
  font-weight: bold;
  font-size: 20px;
  color: #616161;
}

.form-title-end {
  width: 100%;
  display: flex;
  justify-content: flex-end;
  /* align-content: center; */
}

.form-title-end button {
  /* font-weight: bold;
        color: white;
        border: 1px solid transparent;
        border-radius: 10px;
        padding: .6rem 1.5rem; */
}

#btn-cancel {
  background-color: #bdbdbd;
  color: white;
  margin-right: 0.6rem;
}

#btn-add {
  background-color: var(--primary-color);
  color: white;
}

.form-content {
  font-size: 0.9rem;
  position: fixed;
  max-height: 82.5%;
  width: 82%;
  overflow-y: auto;
  /* display: flex;
        flex-direction: column;  */
}

.form-field {
  /* margin-bottom: 5px; */
  width: 100%;
  padding: 1rem 2rem;
}

.form-field input[type="text"],
.form-field textarea {
  width: 40%;
}

.form-field textarea {
  min-height: 5rem;
  max-height: 10rem;
}

.form-field-title {
  margin-bottom: 0.5rem;
  font-weight: 500;
}

.btn-plus {
  color: black;
}

.box-danger {
  border: 1px solid var(--danger-color) !important;
}

thead {
  cursor: default;
  user-select: none;
  background: #eeeeee;
  border-bottom: 2px solid #e0e0e0;
}

th {
  font-size: .95rem !important;
  font-weight: 450 !important;
  height: 3rem;
  padding: 0 .5rem;
  vertical-align: middle !important;
}

tr {
  cursor: pointer;
}

td {
  height: 3rem;
  padding: .8rem .5rem 0 .5rem;
}

.row-odd {
  background: white;
}

.row-even {
  background: #eeeeee;
}

.row-warning-light {
  background: #fff1b5 !important;
}

.row-warning-dark {
  background: #ffe99e !important;
}

.row-danger-light {
  background: #FF7D7D !important;
}

.row-danger-dark {
  background: #EF6565 !important;
}
</style>
