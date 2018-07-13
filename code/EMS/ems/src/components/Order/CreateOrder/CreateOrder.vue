<template>
    <div class="form">
        <div class="form-title">
            <div class="form-title-start">
                Add New Work Order
            </div>            
            <div class="form-title-end">
                <!-- <button id="btn-cancel" class="button" style="" v-on:click="cancel">Cancel</button> -->
                <button class="button" style="margin-right: .5rem" v-on:click="cancel()">Cancel</button>
                <!-- <button id="btn-add" class="button is-primary">Create Work Order</button> -->
                <button class="button is-primary" v-on:click="createWorkOrder()"><i v-show="sending" class="fa fa-circle-o-notch fa-spin"></i>Create Work Order</button>
            </div>
        </div>
        <div class="form-content">
            <div class="form-field is-horizonal">
                <div class="form-field-title">Category: </div>
                <label class="radio" :key="'category' + category.Id" v-for="category in categories" style="margin-right: 1rem;">
                    <input required type="radio" name="category" 
                    :disabled="authUser.RoleID == 6 && category.Name != 'Maintain'
                              || authUser.RoleID == 5 && category.Name != 'Working'"
                    :checked="authUser.RoleID == 6 && category.Name == 'Maintain' 
                              || authUser.RoleID == 5 && category.Name == 'Working'">
                    {{ category.Name }}
                </label>
            </div>
            <div class="form-field is-horizonal">
                <div class="form-field-title" style="margin-right: 1rem">Priority:</div> 
                <label class="radio" :key="'priority' + priority.Id" v-for="priority in priorities" v-on:click="workOrderPriority = priority.Id" style="margin-right: 1rem; user-select: none;">
                    <input type="radio" name="priority" :checked="priority.Id == workOrderPriority" style="margin-right: .3rem;">
                    <span class="tag" style="color: white" :style="`background-color: ${priority.TagHexColor}`">{{ priority.Name }}</span>
                </label>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Title this Work Order (required)<span v-if="CreateWorkOrderErrors.NoTitle != ''">. <span class="error-text">{{ CreateWorkOrderErrors.NoTitle }}</span></span>
                </div>
                <div class="form-field-input">
                    <input :style="CreateWorkOrderErrors.NoTitle != '' ?
                                   'border: 1px solid var(--danger-color)' : ''" v-model="workOrderTitle" 
                                   type="text" class="input" required placeholder="Công trình dự án Vinhomes">
                </div>
            </div>
            <!-- select location -->
            <div class="form-field">
                <div class="form-field-title">
                    Choose a location for this work order (required)
                    <span v-if="CreateWorkOrderErrors.NoLocation != ''">. <span class="error-text">{{ CreateWorkOrderErrors.NoLocation }}</span></span>
                </div>
                <div class="form-field-input">
                    <model-select :style="CreateWorkOrderErrors.NoLocation != '' ?
                                   'border: 1px solid var(--danger-color)' : ''" :options="locationOptions" v-model="selectedLocation" placeholder="Select a location" style="width: 40%"></model-select>
                </div>
            </div> <!-- select location -->
            <!-- select team from selected location -->
            <div class="form-field" v-if="selectedLocation.value != ''">
                <div v-if="teamOptions.length > 0">
                    <div class="form-field-title">
                        Pick a team from the selected location (required)
                        <span v-if="CreateWorkOrderErrors.NoTeam != ''">. <span class="error-text">{{ CreateWorkOrderErrors.NoTeam }}</span></span>
                    </div>
                    <div class="form-field-input">
                        <model-select :style="CreateWorkOrderErrors.NoTeam != '' ?
                                   'border: 1px solid var(--danger-color)' : ''" :options="teamOptions" v-model="selectedTeam" placeholder="Select a team" style="width: 40%"></model-select>
                    </div>
                </div>
                <div class="form-field-title" v-else-if="teamOptions.length == 0">
                    <div class="error-text">{{ CreateWorkOrderErrors.NoTeam }}</div>
                    There is no team in <strong>{{ selectedLocation.text }}</strong>
                </div>
            </div> <!-- select team from selected location -->
            <!-- select equipments - start -->
            <div class="form-field" style="padding-bottom: 0 !important">
              <div class="form-field-title">
                <span style="position: relative; top: .5rem; margin-right: .2rem;">Choose equipment(s) (required) (press </span><button style="border-radius: 50% !important; z-index: 1;" class="button btn-primary material-shadow-animate"><i class="fa fa-plus"></i></button><span style="position: relative; top: .5rem; margin-left: .2rem"> after select)</span>
                <span style="position: relative; top: .5rem;" v-if="CreateWorkOrderErrors.NoEquipmentSelected != ''">. <span class="error-text">{{ CreateWorkOrderErrors.NoEquipmentSelected }}</span></span>
              </div>
            </div>
            <div class="form-field">
              <!-- header -->
              <div class="" style="display: grid; grid-template-columns: 40% 10% 17% 17% 10%; grid-column-gap: 1%; margin-bottom: .5rem">
                <div>Equipment</div>
                <div style="width: 100%; text-align: center">Quantity</div>
                <div>From</div>
                <div>To</div>
                <div></div>
              </div> <!-- header -->
              <!-- display selected equipment items -->
              <div :key="'selectedEquipment' + selectedEquipment.id" v-for="selectedEquipment in selectedEquipments">
                <!-- display errors -->
                <div style="display: grid; grid-template-columns: 40% 10% 17% 17% 10%; grid-column-gap: 1%; margin-bottom: 1rem;">
                  <div></div>
                  <div></div>
                  <div>
                    <span class="error-text" v-if="getMilis(selectedEquipment.fromDate) > getMilis(selectedEquipment.toDate)">
                      {{ ErrorStrings.FromDateIsLargerThanToDate }}
                    </span>
                  </div>
                  <div></div>
                  <div></div>
                </div><!-- display errors -->
                <!-- display equipments -->
                <div style="display: grid; grid-template-columns: 40% 10% 17% 17% 10%; grid-column-gap: 1%; margin-bottom: 1rem;">
                  <div style="padding-left: 1rem; display: grid; grid-template-columns: 5rem auto; grid-column-gap: 1rem;">
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
                            v-model="selectedEquipment.quantity" 
                            v-on:change="() => {
                              if (selectedEquipment.quantity === '') {
                                  selectedEquipment.quantity = 0;
                                  selectedEquipment.equipmentItemIds = [];
                                  selectedEquipment.conflictItems = [];
                                  selectedEquipment.indeterminate = false;
                                  selectedEquipment.checkAllItems = false;

                                  selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                                  selectedEquipment.addEquipmentWarnings.SelectedEquipmentQuantityIsZero = ErrorStrings.SelectedEquipmentQuantityIsZero;
                                } else {
                                  //if (this.selectedEquipment.value != '' && this.selectedEquipment.totalQuantity > 0) {
                                    var currentQuantity = parseInt(selectedEquipment.quantity);
                                    let equipmentQuantity = parseInt(selectedEquipment.totalQuantity);
                                    if (currentQuantity < 0) {
                                      selectedEquipment.quantity = 0;
                                    } else if (currentQuantity > equipmentQuantity) {
                                      selectedEquipment.quantity = equipmentQuantity;
                                    }

                                    // if the selectedEquipmentQuantity = 0, we should display a warning to user
                                    if (currentQuantity == 0) {
                                      selectedEquipment.addEquipmentWarnings.SelectedEquipmentQuantityIsZero = ErrorStrings.SelectedEquipmentQuantityIsZero;
                                      selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                                      selectedEquipment.equipmentItemIds = [];
                                      selectedEquipment.conflictItems = [];
                                      selectedEquipment.indeterminate = false;
                                      selectedEquipment.checkAllItems = false;
                                    } else {
                                      selectedEquipment.addEquipmentWarnings.SelectedEquipmentQuantityIsZero = '';
                                      selectedEquipment.indeterminate = true;
                                      // if the selectedEquipmentQuantity is greater than selectedEquipmentItemIds.length
                                      //, it means we should add the next item to selectedEquipmentItemIds
                                      if (currentQuantity > selectedEquipment.equipmentItemIds.length) {
                                        while(selectedEquipment.equipmentItemIds.length != currentQuantity) {
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
                                      } else if (currentQuantity < selectedEquipment.equipmentItemIds.length) {
                                        // the code below will simply pop the last id out of the list, so if user has pick an equipment by hand (not using the number input)
                                        // and then use the number input, the item is not automatically calculate to choose the best ideal one
                                        // in other words, the order of item will not be the best ideal order the algorithm should give out
                                        // then the user would see item unchecks in the incorrect descending order
                                        // but i think we should respect the user's choice
                                        while(selectedEquipment.equipmentItemIds.length != currentQuantity) {
                                          selectedEquipment.equipmentItemIds.pop();
                                        }
                                      }
                                      selectedEquipment.conflictItems = [];
                                      // check if from date conflicts any item in work orders
                                      let tempItems = [];
                                      // get the selected items in equipmentTable to tempItems
                                      selectedEquipment.equipmentItemIds.forEach(itemId => {
                                        tempItems = tempItems.concat(selectedEquipment.equipmentItemList.filter(item => item.Id == itemId));
                                      })
                                      // get the selected items in equipmentTable to tempItems
                                      checkSelectedItemDateConflict(tempItems, selectedEquipment.conflictItems, 
                                                    getMilis(selectedEquipment.fromDate), getMilis(selectedEquipment.toDate));
                                      if (selectedEquipment.conflictItems.length == 0) {
                                        selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                                      } else {
                                        selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = ErrorStrings.SelectedDateConflictWorkOrders;
                                      }
                                    }          
                                  //}
                                }
                    }">
                  </div>
                  <div>
                    <input :disabled="!selectedEquipment.editMode" type="date" 
                            :style="(selectedEquipment.addEquipmentWarnings.FromDateIsLargerThanToDate != '') ?
                                'border: 1px solid var(--danger-color)' : (selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders != '') ? 
                                'border: 1px solid var(--warning-color)' : ''" 
                            class="input" v-model="selectedEquipment.fromDate"
                            v-on:change="() => {
                      if (selectedEquipment.fromDate === '') {
                        selectedEquipment.fromDate = this.getToday();
                      } else {
                        let fromDate = getMilis(selectedEquipment.fromDate);
                        let toDate = getMilis(selectedEquipment.toDate);
                        if (fromDate > toDate) {
                          selectedEquipment.addEquipmentWarnings.FromDateIsLargerThanToDate = ErrorStrings.FromDateIsLargerThanToDate;
                        } else if (fromDate <= toDate) {
                          selectedEquipment.addEquipmentWarnings.FromDateIsLargerThanToDate = '';
                          selectedEquipment.conflictItems = [];
                          // check if from date conflicts any item in work orders
                          let tempItems = [];
                          // get the selected items in equipmentTable to tempItems
                          selectedEquipment.equipmentItemIds.forEach(itemId => {
                            tempItems = tempItems.concat(selectedEquipment.equipmentItemList.filter(item => item.Id == itemId));
                          })
                          // get the selected items in equipmentTable to tempItems
                          checkSelectedItemDateConflict(tempItems, selectedEquipment.conflictItems, fromDate, toDate);
                          if (selectedEquipment.conflictItems.length == 0) {
                            selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                          } else {
                            selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = ErrorStrings.SelectedDateConflictWorkOrders;
                          }
                        }
                      }
                    }">
                  </div>
                  <div>
                    <input :disabled="!selectedEquipment.editMode" type="date" 
                            :style="(selectedEquipment.addEquipmentWarnings.FromDateIsLargerThanToDate != '') ?
                                'border: 1px solid var(--danger-color)' : (selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders != '') ? 
                                'border: 1px solid var(--warning-color)' : ''" 
                            class="input" v-model="selectedEquipment.toDate" 
                            v-on:change="() => {
                      if (selectedEquipment.toDate === '') {
                        selectedEquipment.toDate = this.getToday();
                      } else {
                        let fromDate = getMilis(selectedEquipment.fromDate);
                        let toDate = getMilis(selectedEquipment.toDate);
                        if (fromDate > toDate) {
                          selectedEquipment.addEquipmentWarnings.FromDateIsLargerThanToDate = ErrorStrings.FromDateIsLargerThanToDate;
                        } else if (fromDate <= toDate) {
                          selectedEquipment.addEquipmentWarnings.FromDateIsLargerThanToDate = '';
                          selectedEquipment.conflictItems = [];
                          // check if from date conflicts any item in work orders
                          let tempItems = [];
                          // get the selected items in equipmentTable to tempItems
                          selectedEquipment.equipmentItemIds.forEach(itemId => {
                            tempItems = tempItems.concat(selectedEquipment.equipmentItemList.filter(item => item.Id == itemId));
                          })
                          // get the selected items in equipmentTable to tempItems
                          checkSelectedItemDateConflict(tempItems, selectedEquipment.conflictItems, fromDate, toDate);
                          if (selectedEquipment.conflictItems.length == 0) {
                            selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                          } else {
                            selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = ErrorStrings.SelectedDateConflictWorkOrders;
                          }
                        }
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
                <div v-if="selectedEquipment.editMode" style="padding: 0 !important">
                  <span v-if="selectedEquipment.addEquipmentWarnings.SelectedEquipmentQuantityIsZero != ''" 
                        class="error-text">
                    {{ selectedEquipment.addEquipmentWarnings.SelectedEquipmentQuantityIsZero }}
                  </span>
                  <pre style="padding: 0; font-family: roboto; background: transparent;" 
                        v-if="selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders != ''" 
                        class="warning-text">
{{ selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders }}
                  </pre>
                </div> <!-- display warning -->
                <!-- display equipment item table for editing -->
                <div v-if="selectedEquipment.editMode" style="margin-bottom: 2rem">
                  {{ selectedEquipment.equipmentItemIds }}
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
                                selectedEquipment.equipmentItemIds = [];
                                selectedEquipment.equipmentItemList.forEach(item => selectedEquipment.equipmentItemIds.push(item.Id));
                                selectedEquipment.quantity = selectedEquipment.equipmentItemList.length;

                                selectedEquipment.conflictItems = [];
                                  // check if from date conflicts any item in work orders
                                let tempItems = [];
                                selectedEquipment.equipmentItemIds.forEach(itemId => {
                                  tempItems = tempItems.concat(selectedEquipment.equipmentItemList.filter(item => item.Id == itemId));
                                })
                                // get the selected items in equipmentItemList to tempItems
                                checkSelectedItemDateConflict(tempItems, selectedEquipment.conflictItems, 
                                                  getMilis(selectedEquipment.fromDate), getMilis(selectedEquipment.toDate));
                                if (selectedEquipment.conflictItems.length == 0) {
                                  selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                                } else {
                                  selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = ErrorStrings.SelectedDateConflictWorkOrders;
                                }
                              } else {
                                selectedEquipment.equipmentItemIds = [];
                                selectedEquipment.quantity = 0;
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
                        <th>Last Maintaince</th>
                        <th>Next Maintaince</th>
                        <th style="max-width: 10rem; min-width: 10rem">Current In</th>
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
                                // check if from date conflicts any item in work orders
                                let tempItems = [];
                                // get the selected items in equipmentItemList to tempItems
                                selectedEquipment.equipmentItemIds.forEach(itemId => {
                                  tempItems = tempItems.concat(selectedEquipment.equipmentItemList.filter(item => item.Id == itemId));
                                })
                                // get the selected items in equipmentItemList to tempItems
                                checkSelectedItemDateConflict(tempItems, selectedEquipment.conflictItems, 
                                              getMilis(selectedEquipment.fromDate), getMilis(selectedEquipment.toDate));
                                if (selectedEquipment.conflictItems.length == 0) {
                                  selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                                } else {
                                  selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = ErrorStrings.SelectedDateConflictWorkOrders;
                                }
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
                        <td :class="{'row-warning-light': (((itemIndex + 1) % 2 != 0) 
                                                && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems)),
                                    'row-warning-dark': (((itemIndex + 1) % 2 == 0) 
                                                && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems))}"> <!-- work order name -->
                          {{ workOrder.Name }}
                          <span>[{{ workOrder.Status }}]</span>
                        </td>
                        <td :class="{'row-warning-light': (((itemIndex + 1) % 2 != 0) 
                                                && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems)),
                                    'row-warning-dark': (((itemIndex + 1) % 2 == 0) 
                                                && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems))}">
                            {{ getDate(workOrder.Detail.StartDate) }}
                        </td> <!-- work order detail from date -->
                        <td :class="{'row-warning-light': (((itemIndex + 1) % 2 != 0) 
                                                && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems)),
                                    'row-warning-dark': (((itemIndex + 1) % 2 == 0) 
                                                && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems))}">
                            {{ getDate(workOrder.Detail.FinishedDate) }}
                        </td> <!-- work order detail to date -->
                        <!-- equipment item runtime days -->
                        <td v-if="workOrderIndex == 0" :rowspan="equipmentItem.WorkOrders.length + 1"> 
                          {{ equipmentItem.RuntimeDays ? equipmentItem.RuntimeDays : 'n/a' }}
                        </td>
                        <!-- equipment item last maintaince date -->
                        <td v-if="workOrderIndex == 0" :rowspan="equipmentItem.WorkOrders.length + 1"> 
                          {{ equipmentItem.LastMaintainDate ? getDate(equipmentItem.LastMaintainDate) : 'n/a' }}
                        </td>
                        <!-- equipment item next maintaince date -->
                        <td v-if="workOrderIndex == 0" :rowspan="equipmentItem.WorkOrders.length + 1"> 
                          {{ equipmentItem.NextMaintainDate ? getDate(equipmentItem.NextMaintainDate) : 'n/a' }}
                        </td>
                        <!-- equipment item locatoin -->
                        <td v-if="workOrderIndex == 0" :rowspan="equipmentItem.WorkOrders.length + 1"> 
                          {{ equipmentItem.Location ? equipmentItem.Location : 'n/a' }}
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
                        <td>{{ equipmentItem.RuntimeDays ? equipmentItem.RuntimeDays : 'n/a' }}</td>
                        <td>{{ equipmentItem.LastMaintainDate ? getDate(equipmentItem.LastMaintainDate) : 'n/a' }}</td>
                        <td>{{ equipmentItem.NextMaintainDate ? getDate(equipmentItem.NextMaintainDate) : 'n/a' }}</td>
                        <td>{{ equipmentItem.Location ? equipmentItem.Location : 'n/a' }}</td>
                      </tr> <!-- else -->
                    </tbody>
                  </table>
                </div> <!-- display equipment item table for editing -->              
              </div> <!-- display equipments -->
              <!-- display selected equipment items - end -->                           
            </div> 
            <!-- display errors -->
            <div class="form-field" style="padding-bottom: 0; margin-bottom: 0rem; display: grid; grid-template-columns: 40% 10% 17% 17% 10%; grid-column-gap: 1%;">   
              <div>
              <!-- display error for not select equipment -->
                <div class="strong-warning-text">{{ AddEquipmentWarnings.MustSelectEquipment }}</div>
                <div class="strong-warning-text">{{ AddEquipmentWarnings.AvailableQuantityIsZero }}</div>
              </div>
              <div></div>
              <div>
                <span class="strong-warning-text">{{ AddEquipmentWarnings.FromDateIsLargerThanToDate }}</span>
              </div>
              <div></div>
              <div></div>
            </div> <!-- display errors --> 
            <!-- add equipment panel -->
            <div style="">
              <div class="form-field" style="display: grid; grid-template-columns: 40% 10% 17% 17% 10%; grid-column-gap: 1%;">                
                <div class="form-field-input">
                  <div style="width: 100%">
                    <model-select :style="(AddEquipmentWarnings.MustSelectEquipment != '' 
                                          || AddEquipmentWarnings.AvailableQuantityIsZero != '') ?
                                            'border: 1px solid var(--strong-warning-color)' : ''" :options="equipmentOptions" placeholder="Select an equipment" v-model="selectedEquipment"></model-select>
                  </div>
                </div>  
                <div class="form-field-input">
                    <input :style="AddEquipmentWarnings.SelectedEquipmentQuantityIsZero != '' ? 'border: 1px solid var(--warning-color)' : ''"
                    style="text-align: center" type="number" :disabled="selectedEquipment.totalQuantity == 0" min="0" :max="selectedEquipment.totalQuantity" class="input" v-model="selectedEquipmentQuantity">
                </div>
                <div>
                  <input :style="(AddEquipmentWarnings.FromDateIsLargerThanToDate != '') ? 'border: 1px solid var(--strong-warning-color)' :
                                      (AddEquipmentWarnings.SelectedDateConflictWorkOrders != '') ? 'border: 1px solid var(--warning-color)'
                                      : ''" class="input" type="date" v-model="selectedEquipmentFromDate">
                </div>
                <div>
                  <input :style="(AddEquipmentWarnings.FromDateIsLargerThanToDate != '') ? 'border: 1px solid var(--strong-warning-color)' :
                                      (AddEquipmentWarnings.SelectedDateConflictWorkOrders != '') ? 'border: 1px solid var(--warning-color)'
                                      : ''" class="input" type="date" v-model="selectedEquipmentToDate">
                </div>
                <div>
                  <!-- <a v-on:click="addEquipment()" style="position: relative; top: .5rem;" class="btn-plus"><i class="fa fa-plus"></i></a> -->
                  <button v-on:click="addEquipment()" style="margin-left: .5rem; border-radius: 50% !important;" class="button btn-primary material-shadow-animate"><i class="fa fa-plus"></i></button>
                  <a v-on:click="() => {
                      selectedEquipment = {
                        text: '',
                        value: '',
                        image: '',
                        totalQuantity: 0
                      };
                      resetEquipmentSelection();
                    }" 
                    style="margin-left: 1.1rem; position: relative; top: .5rem; user-select: none;">Clear</a>
                </div>
              </div>
            </div> <!-- add equipment panel -->
            <!-- select equipments - end -->            
            <div style="padding-top: 0; padding-bottom: 0" class="form-field">
              <span v-if="AddEquipmentWarnings.SelectedEquipmentQuantityIsZero != ''" style="color: var(--strong-warning-color)">{{ AddEquipmentWarnings.SelectedEquipmentQuantityIsZero }}</span>
              <pre style="padding: 0; font-family: roboto; background: transparent;" 
                    v-if="AddEquipmentWarnings.SelectedDateConflictWorkOrders != ''" 
                    class="warning-text">
{{ AddEquipmentWarnings.SelectedDateConflictWorkOrders }}
              </pre>
            </div>

            <!-- display equipment items table to let user pick the desire item -->
            <div class="form-field" v-if="equipmentTable && equipmentTable.length > 0">
              {{ selectedEquipmentItemIds }}
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
                    <th>Last Maintaince</th>
                    <th>Next Maintaince</th>
                    <th style="max-width: 10rem; min-width: 10rem">Current In</th>
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
                    <td :class="{'row-warning-light': (((itemIndex + 1) % 2 != 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, conflictItems)),
                                 'row-warning-dark': (((itemIndex + 1) % 2 == 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, conflictItems))}"> <!-- work order name -->
                      {{ workOrder.Name }}
                      <span>[{{ workOrder.Status }}]</span>
                    </td>
                    <td :class="{'row-warning-light': (((itemIndex + 1) % 2 != 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, conflictItems)),
                                 'row-warning-dark': (((itemIndex + 1) % 2 == 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, conflictItems))}">{{ getDate(workOrder.Detail.StartDate) }}</td> <!-- work order detail from date -->
                    <td :class="{'row-warning-light': (((itemIndex + 1) % 2 != 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, conflictItems)),
                                 'row-warning-dark': (((itemIndex + 1) % 2 == 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, conflictItems))}">{{ getDate(workOrder.Detail.FinishedDate) }}</td> <!-- work order detail to date -->
                    <!-- equipment item runtime days -->
                    <td v-if="workOrderIndex == 0" :rowspan="equipmentItem.WorkOrders.length + 1"> 
                      {{ equipmentItem.RuntimeDays ? equipmentItem.RuntimeDays : 'n/a' }}
                    </td>
                    <!-- equipment item last maintaince date -->
                    <td v-if="workOrderIndex == 0" :rowspan="equipmentItem.WorkOrders.length + 1"> 
                      {{ equipmentItem.LastMaintainDate ? getDate(equipmentItem.LastMaintainDate) : 'n/a' }}
                    </td>
                    <!-- equipment item next maintaince date -->
                    <td v-if="workOrderIndex == 0" :rowspan="equipmentItem.WorkOrders.length + 1"> 
                      {{ equipmentItem.NextMaintainDate ? getDate(equipmentItem.NextMaintainDate) : 'n/a' }}
                    </td>
                    <!-- equipment item locatoin -->
                    <td v-if="workOrderIndex == 0" :rowspan="equipmentItem.WorkOrders.length + 1"> 
                      {{ equipmentItem.Location ? equipmentItem.Location : 'n/a' }}
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
                    <td>{{ equipmentItem.RuntimeDays ? equipmentItem.RuntimeDays : 'n/a' }}</td>
                    <td>{{ equipmentItem.LastMaintainDate ? getDate(equipmentItem.LastMaintainDate) : 'n/a' }}</td>
                    <td>{{ equipmentItem.NextMaintainDate ? getDate(equipmentItem.NextMaintainDate) : 'n/a' }}</td>
                    <td>{{ equipmentItem.Location ? equipmentItem.Location : 'n/a' }}</td>
                  </tr> <!-- else -->
                </tbody>
              </table>
            </div> <!-- display equipment items table to let user pick the desire item -->
            <!-- describe work order -->
            <div class="form-field">
                <div class="form-field-title">
                    Describe this work order (optional)
                </div>
                <div class="form-field-input">
                    <textarea class="input" rows="5" v-model="workOrderDescription"></textarea>
                </div>
            </div> <!-- describe work order -->
        </div>
    </div>
</template>

<script>
import Server from "@/config/config.js";

import moment from "moment";
import { ModelSelect } from "vue-search-select";

export default {
  components: {
    ModelSelect
  },
  data() {
    return {
      sending: false,
      ErrorStrings: {
        MustSelectEquipment: "You must select an equipment",
        FromDateIsLargerThanToDate: "From date is larger than to date",
        AvailableQuantityIsZero: "This equipment has no available units",
        NoTitle: "You must provide a title for this order",
        NoEquipmentSelected: "You must select at least one equipment",
        NoLocation: "You must select a location",
        NoTeam: "You must select a team in the selected location",
        SelectedEquipmentQuantityIsZero:
          "You must choose at least 1 equipment item from the table below",
        SelectedDateConflictWorkOrders:
          "From date or to date has conflict with some work orders. " +
          "\nPlease reconsider choosing another date or the managers may reject your order."
      },
      AddEquipmentWarnings: {
        MustSelectEquipment: "",
        FromDateIsLargerThanToDate: "",
        AvailableQuantityIsZero: "",
        SelectedEquipmentQuantityIsZero: "",
        SelectedDateConflictWorkOrders: ""
      },
      CreateWorkOrderErrors: {
        NoTitle: "",
        NoEquipmentSelected: "",
        EquipmentErrors: [],
        NoLocation: "",
        NoTeam: ""
      },
      workOrderTitle: "",
      workOrderDescription: "",
      workOrderPriority: 1,
      selectedEquipmentQuantity: 0,
      selectedEquipmentFromDate: "",
      selectedEquipmentToDate: "",
      selectedEquipments: [],
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
      conflictItems: []
    };
  },
  computed: {
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    },
    workOrderCategory() {
      if (this.authUser.RoleID == 5) {
        return 2; // working order
      } else if (this.authUser.RoleID == 6) {
        return 1; // maintain order
      }
    }
  },
  created() {
    this.axios.get(Server.WORKORDER_CATEGORIES_API_PATH).then(res => {
      if (res.data) {
        let data = res.data;
        this.categories = data;
        // this.workOrderCategory = data[0].Id;
      }
    });
    this.axios.get(Server.EQUIPMENT_API_PATH).then(res => {
      if (res.data) {
        let data = res.data;
        data.forEach(element => {
          let quantity = parseInt(element.Equipment.Quantity);
          let option = {
            text: `${element.Equipment.Name}, quantity: ${quantity} ${
              quantity > 0 ? element.Equipment.Unit : ""
            }`,
            value: element.Equipment.Id,
            image: element.Equipment.Image,
            totalQuantity: quantity
          };
          this.equipmentOptions.push(option);
        });
      }
    });
    this.axios.get(Server.WORKORDER_PRIORITIES_API_PATH).then(res => {
      if (res.data) {
        this.priorities = res.data;
        this.workOrderPriority = this.priorities[0].Id;
      }
    });
    this.axios.get(Server.LOCATION_API_PATH).then(res => {
      if (res.data) {
        let data = res.data;
        data.forEach(location => {
          let option = {
            value: location.Id,
            text: `${location.Name} - ${location.Address}`
          };
          this.locationOptions.push(option);
        });
      }
    });
    this.selectedEquipmentFromDate = this.getToday();
    this.selectedEquipmentToDate = this.getToday();
  },
  methods: {
    cancel() {
      this.$router.push("/work_order");
    },
    addEquipment() {
      if (this.selectedEquipment.value == "") {
        this.AddEquipmentWarnings.MustSelectEquipment = this.ErrorStrings.MustSelectEquipment;
      }
      if (this.validateAddEquipment()) {
        if (
          this.selectedEquipment.value != "" &&
          this.selectedEquipment.totalQuantity > 0
        ) {
          let index = this.selectedEquipments.findIndex(
            equipment => equipment.id == this.selectedEquipment.value
          );
          // this equipment is not yet selected, so add to the list
          var warningOb = JSON.stringify(this.AddEquipmentWarnings);
          warningOb = JSON.parse(warningOb);
          if (index < 0) {
            let equipment = {
              id: parseInt(this.selectedEquipment.value),
              name: this.selectedEquipment.text,
              quantity: parseInt(this.selectedEquipmentQuantity),
              image: this.selectedEquipment.image,
              totalQuantity: parseInt(this.selectedEquipment.totalQuantity),
              fromDate: this.selectedEquipmentFromDate,
              toDate: this.selectedEquipmentToDate,
              equipmentItemIds: this.selectedEquipmentItemIds,
              editMode: false,
              indeterminate: this.indeterminate,
              checkAllItesm: this.checkAllItems,
              equipmentItemList: this.equipmentTable,
              conflictItems: this.conflictItems,
              addEquipmentWarnings: warningOb
            };
            this.selectedEquipments.push(equipment);
          } else {
            // this equipment is already added to the list, so modified the quantity
            // TODO
          }

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
    },
    getToday() {
      return moment().format("YYYY-MM-DD");
    },
    createWorkOrder() {
      if (this.workOrderTitle === "") {
        this.CreateWorkOrderErrors.NoTitle = this.ErrorStrings.NoTitle;
      }
      if (this.selectedEquipments.length == 0) {
        this.CreateWorkOrderErrors.NoEquipmentSelected = this.ErrorStrings.NoEquipmentSelected;
      }
      if (this.selectedLocation.value === "") {
        this.CreateWorkOrderErrors.NoLocation = this.ErrorStrings.NoLocation;
      }
      if (this.selectedTeam.value === "") {
        this.CreateWorkOrderErrors.NoTeam = this.ErrorStrings.NoTeam;
      }
      if (this.validateCreateOrder()) {
        let context = this;
        context.sending = true;
        let teamLocationApi = `${Server.TEAM_LOCATION_API_PATH}/${
          this.selectedLocation.value
        }/${this.selectedTeam.value}`;
        this.axios
          .get(teamLocationApi)
          .then(function(res) {
            if (res.data.Id) {
              let result = res.data.Id;
              let workOrderApi = Server.WORKORDER_API_PATH;

              context.axios
                .post(workOrderApi, {
                  name: context.workOrderTitle,
                  description: context.workOrderDescription,
                  requestUserId: context.authUser.Id,
                  createDate: new Date(),
                  priorityId: context.workOrderPriority,
                  statusId: 1,
                  categoryId: context.workOrderCategory,
                  teamLocationId: result
                })
                .then(function(res) {
                  if (res.data.NewWorkOrderId) {
                    let newWorkOrderId = res.data.NewWorkOrderId;
                    var check = true;
                    context.selectedEquipments.forEach(equipment => {
                      equipment.equipmentItemIds.forEach(async itemId => {
                        try {
                          const response = await context.axios.post(
                            Server.WORKORDER_DETAIL_API_PATH,
                            {
                              workOrderId: newWorkOrderId,
                              equipmentItemId: itemId,
                              startDate: equipment.fromDate,
                              dueDate: equipment.toDate,
                              maintainceCost: null,
                              description: null
                            }
                          );
                          if (response.status == 200) {
                            check = true;
                          }
                        } catch (error) {
                          console.log(error);
                          check = false;
                        }
                      });
                    });
                    context.sending = false;
                    if (check) {
                      context.$router.push("/work_order");
                    } else {
                      alert("Error");
                    }
                  } else {
                    alert("No new work order id returned");
                  }
                })
                .catch(error => {
                  alert("Create work order detail: " + error);
                });
            }
          })
          .catch(error => {
            alert("Create work order: " + error);
          });
      }
    },
    validateAddEquipment() {
      return (
        this.AddEquipmentWarnings.MustSelectEquipment === "" &&
        this.AddEquipmentWarnings.FromDateIsLargerThanToDate === "" &&
        this.AddEquipmentWarnings.AvailableQuantityIsZero === "" &&
        this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero === ""
      );
    },
    validateCreateOrder() {
      var checkSelectedItems = true; // check if currently there is no error messages of items are displaying
      for (var i = 0; i < this.selectedEquipments.length; i++) {
        let selectedEquipment = this.selectedEquipments[i];
        if (
          selectedEquipment.addEquipmentWarnings
            .SelectedEquipmentQuantityIsZero != "" ||
          selectedEquipment.addEquipmentWarnings.FromDateIsLargerThanToDate !=
            ""
        ) {
          checkSelectedItems = false;
          break;
        }
      }
      return (
        this.CreateWorkOrderErrors.NoTitle === "" &&
        this.CreateWorkOrderErrors.NoEquipmentSelected === "" &&
        this.CreateWorkOrderErrors.NoLocation === "" &&
        this.CreateWorkOrderErrors.NoTeam === "" &&
        checkSelectedItems
      );
    },
    getMilis(date) {
      return moment(date).valueOf();
    },
    getDate(date) {
      return moment(date).format("L");
    },
    myconsole(obj) {
      console.log(obj);
    },
    checkItemFromTable(equipmentItemId) {
      this.indeterminate = true;
      this.checkAllItems = false;
      // if selectedEquipmentItemIds already has equipmentItemId, we decrease the selectedEquipmentQuantity, then remove the equipmentItemId from the selectedEquipmentItemIds
      if (this.selectedEquipmentItemIds.includes(equipmentItemId)) {
        this.selectedEquipmentQuantity =
          parseInt(this.selectedEquipmentQuantity) - 1;
        this.selectedEquipmentItemIds = this.selectedEquipmentItemIds.filter(
          itemId => itemId != equipmentItemId
        );
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
        if (
          this.selectedEquipmentItemIds.length == this.equipmentTable.length
        ) {
          this.indeterminate = false;
          this.checkAllItems = true;
        }
      }

      this.conflictItems = [];
      // check if from date conflicts any item in work orders
      let tempItems = [];
      // get the selected items in equipmentTable to tempItems
      this.selectedEquipmentItemIds.forEach(itemId => {
        tempItems = tempItems.concat(
          this.equipmentTable.filter(item => item.Id == itemId)
        );
      });
      // get the selected items in equipmentTable to tempItems
      this.checkSelectedItemDateConflict(
        tempItems,
        this.conflictItems,
        this.getMilis(this.selectedEquipmentFromDate),
        this.getMilis(this.selectedEquipmentToDate)
      );
      if (this.conflictItems.length == 0) {
        this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = "";
      } else {
        this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = this.ErrorStrings.SelectedDateConflictWorkOrders;
      }
    },
    handleCheckAllItems() {
      if (this.indeterminate) {
        this.checkAllItems = false;
      } else {
        this.checkAllItems = !this.checkAllItems;
      }

      this.indeterminate = false;
      if (this.checkAllItems) {
        this.selectedEquipmentItemIds = [];
        this.equipmentTable.forEach(item =>
          this.selectedEquipmentItemIds.push(item.Id)
        );
        this.selectedEquipmentQuantity = this.equipmentTable.length;

        this.conflictItems = [];
        // check if from date conflicts any item in work orders
        let tempItems = [];
        this.selectedEquipmentItemIds.forEach(itemId => {
          tempItems = tempItems.concat(
            this.equipmentTable.filter(item => item.Id == itemId)
          );
        });
        // get the selected items in equipmentTable to tempItems
        this.checkSelectedItemDateConflict(
          tempItems,
          this.conflictItems,
          this.getMilis(this.selectedEquipmentFromDate),
          this.getMilis(this.selectedEquipmentTODate)
        );
        if (this.conflictItems.length == 0) {
          this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = "";
        } else {
          this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = this.ErrorStrings.SelectedDateConflictWorkOrders;
        }
      } else {
        this.selectedEquipmentItemIds = [];
        this.selectedEquipmentQuantity = 0;
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
      this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = "";
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
    checkSelectedItemDateConflict(items, conflictItems, fromDate, toDate) {
      items.forEach(item => {
        if (item.WorkOrders) {
          item.WorkOrders.forEach(order => {
            let itemFromDate = this.getMilis(order.Detail.StartDate);
            let itemToDate = this.getMilis(order.Detail.FinishedDate);
            if (
              (fromDate >= itemFromDate && fromDate <= itemToDate) ||
              (toDate >= itemFromDate && toDate <= itemToDate) ||
              (fromDate < itemFromDate &&
                fromDate < itemToDate &&
                toDate > itemFromDate &&
                toDate > itemToDate)
            ) {
              conflictItems.push({ itemId: item.Id, workOrderId: order.Id });
            }
          });
        }
      });
    }
  },
  watch: {
    workOrderTitle: function() {
      if (
        this.workOrderTitle != "" &&
        this.CreateWorkOrderErrors.NoTitle != ""
      ) {
        this.CreateWorkOrderErrors.NoTitle = "";
      }
    },
    selectedEquipment: function() {
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
          this.AddEquipmentWarnings.AvailableQuantityIsZero = ""; // set warning to empty text

          // get all the equipment items with work order detail info (if available)
          let url = `${Server.WORKORDER_API_PATH}/get_equipment_detail/${
            this.selectedEquipment.value
          }`;
          this.axios.get(url).then(res => {
            if (res.status == 200 && res.data) {
              this.equipmentTable = res.data;
              this.selectedEquipmentItemIds.push(res.data[0].Id);
              this.selectedEquipmentQuantity = 1;
              this.indeterminate = true;
              this.selectedEquipmentFromDate = this.getToday();
              this.selectedEquipmentToDate = this.getToday();
            }
          });
        }
      }
    },
    selectedEquipments: function() {
      if (this.selectedEquipments.length > 0) {
        this.CreateWorkOrderErrors.NoEquipmentSelected = "";
      }
    },
    selectedLocation: function() {
      this.teamOptions = [];
      this.selectedTeam = {
        text: "",
        value: ""
      };
      if (this.selectedLocation.value != "") {
        if (this.CreateWorkOrderErrors.NoLocation != "") {
          this.CreateWorkOrderErrors.NoLocation = "";
        }
        // alert('in 2')
        let url = `${Server.LOCATION_API_PATH}/${
          this.selectedLocation.value
        }/team`;
        this.axios.get(url).then(res => {
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
    selectedEquipmentFromDate: function() {
      if (this.selectedEquipmentFromDate === "") {
        this.selectedEquipmentFromDate = this.getToday();
      } else {
        let fromDate = this.getMilis(this.selectedEquipmentFromDate);
        let toDate = this.getMilis(this.selectedEquipmentToDate);
        if (fromDate > toDate) {
          this.AddEquipmentWarnings.FromDateIsLargerThanToDate = this.ErrorStrings.FromDateIsLargerThanToDate;
        } else if (fromDate <= toDate) {
          this.AddEquipmentWarnings.FromDateIsLargerThanToDate = "";
          this.conflictItems = [];
          // check if from date conflicts any item in work orders
          let tempItems = [];
          // get the selected items in equipmentTable to tempItems
          this.selectedEquipmentItemIds.forEach(itemId => {
            tempItems = tempItems.concat(
              this.equipmentTable.filter(item => item.Id == itemId)
            );
          });
          // get the selected items in equipmentTable to tempItems
          this.checkSelectedItemDateConflict(
            tempItems,
            this.conflictItems,
            fromDate,
            toDate
          );
          if (this.conflictItems.length == 0) {
            this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = "";
          } else {
            this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = this.ErrorStrings.SelectedDateConflictWorkOrders;
          }
        }
      }
    },
    selectedEquipmentToDate: function() {
      if (this.selectedEquipmentToDate === "") {
        this.selectedEquipmentToDate = this.getToday();
      } else {
        let fromDate = moment(this.selectedEquipmentFromDate).valueOf();
        let toDate = moment(this.selectedEquipmentToDate).valueOf();
        if (fromDate > toDate) {
          this.AddEquipmentWarnings.FromDateIsLargerThanToDate = this.ErrorStrings.FromDateIsLargerThanToDate;
        } else if (fromDate <= toDate) {
          this.AddEquipmentWarnings.FromDateIsLargerThanToDate = "";

          this.conflictItems = [];
          // check if from date conflicts any item in work orders
          let tempItems = [];
          // get the selected items in equipmentTable to tempItems
          this.selectedEquipmentItemIds.forEach(itemId => {
            tempItems = tempItems.concat(
              this.equipmentTable.filter(item => item.Id == itemId)
            );
          });
          // get the selected items in equipmentTable to tempItems
          this.checkSelectedItemDateConflict(
            tempItems,
            this.conflictItems,
            fromDate,
            toDate
          );
          if (this.conflictItems.length == 0) {
            this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = "";
          } else {
            this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = this.ErrorStrings.SelectedDateConflictWorkOrders;
          }
        }
      }
    },
    selectedEquipmentQuantity: function() {
      if (this.selectedEquipmentQuantity === "") {
        this.selectedEquipmentQuantity = 0;
        this.selectedEquipmentItemIds = [];
        this.conflictItems = [];
        this.indeterminate = false;
        this.checkAllItems = false;
        this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = "";
        this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = this.ErrorStrings.SelectedEquipmentQuantityIsZero;
      } else {
        if (
          this.selectedEquipment.value != "" &&
          this.selectedEquipment.totalQuantity > 0
        ) {
          var currentQuantity = parseInt(this.selectedEquipmentQuantity);
          let equipmentQuantity = parseInt(
            this.selectedEquipment.totalQuantity
          );
          if (currentQuantity < 0) {
            this.selectedEquipmentQuantity = 0;
          } else if (currentQuantity > equipmentQuantity) {
            this.selectedEquipmentQuantity = equipmentQuantity;
          }

          // if the selectedEquipmentQuantity = 0, we should display a warning to user
          if (currentQuantity == 0) {
            this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = this.ErrorStrings.SelectedEquipmentQuantityIsZero;
            this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = "";
            this.selectedEquipmentItemIds = [];
            this.conflictItems = [];
            this.indeterminate = false;
            this.checkAllItems = false;
          } else {
            this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = "";
            this.indeterminate = true;
            // if the selectedEquipmentQuantity is greater than selectedEquipmentItemIds.length
            //, it means we should add the next item to selectedEquipmentItemIds
            if (currentQuantity >= this.selectedEquipmentItemIds.length) {
              while (
                this.selectedEquipmentItemIds.length !=
                parseInt(this.selectedEquipmentQuantity)
              ) {
                let tempItems = this.equipmentTable;
                this.selectedEquipmentItemIds.forEach(itemId => {
                  tempItems = tempItems.filter(item => item.Id != itemId);
                });
                this.selectedEquipmentItemIds.push(tempItems[0].Id);
              }
              if (
                this.selectedEquipmentItemIds.length ==
                this.equipmentTable.length
              ) {
                this.indeterminate = false;
                this.checkAllItems = true;
              }
            } else if (currentQuantity < this.selectedEquipmentItemIds.length) {
              // the code below will simply pop the last id out of the list, so if user has pick an equipment by hand (not using the number input)
              // and then use the number input, the item is not automatically calculate to choose the best ideal one
              // in other words, the order of item will not be the best ideal order the algorithm should give out
              // then the user would see item unchecks in the incorrect descending order
              // but i think we should respect the user's choice
              while (
                this.selectedEquipmentItemIds.length !=
                parseInt(this.selectedEquipmentQuantity)
              ) {
                this.selectedEquipmentItemIds.pop();
              }
            }
            this.conflictItems = [];
            // check if from date conflicts any item in work orders
            let tempItems = [];
            // get the selected items in equipmentTable to tempItems
            this.selectedEquipmentItemIds.forEach(itemId => {
              tempItems = tempItems.concat(
                this.equipmentTable.filter(item => item.Id == itemId)
              );
            });
            // get the selected items in equipmentTable to tempItems
            this.checkSelectedItemDateConflict(
              tempItems,
              this.conflictItems,
              this.getMilis(this.selectedEquipmentFromDate),
              this.getMilis(this.selectedEquipmentToDate)
            );
            if (this.conflictItems.length == 0) {
              this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = "";
            } else {
              this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = this.ErrorStrings.SelectedDateConflictWorkOrders;
            }
          }
        }
      }
    },
    selectedTeam: function() {
      if (
        this.selectedTeam.value != "" &&
        this.CreateWorkOrderErrors.NoTeam != ""
      ) {
        this.CreateWorkOrderErrors.NoTeam = "";
      }
    }
  }
};
</script>

<style scoped>
input {
  outline: 0 !important;
}

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
  padding: 1rem 2rem;
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
  font-size: 0.95rem !important;
  font-weight: 450 !important;
  height: 3rem;
  padding: 0 0.5rem;
  vertical-align: middle !important;
}

tr {
  cursor: pointer;
}

td {
  height: 3rem;
  padding: 0.8rem 0.5rem 0 0.5rem;
}

.row-odd {
  background: white;
}

.row-warning-light {
  background: #fff1b5 !important;
}

.row-even {
  background: #eeeeee;
}
.row-warning-dark {
  background: #ffe99e !important;
}
</style>
