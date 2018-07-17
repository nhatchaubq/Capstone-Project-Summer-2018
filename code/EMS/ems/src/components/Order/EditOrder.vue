<template>
    <div class="form" v-if="editWorkOrder">
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
            <div class="form-field is-horizonal">
                <div class="form-field-title">Category: </div>
                <!-- <label class="radio" :key="'category' + category.Id" v-for="category in categories" style="margin-right: 1rem;">
                    <input required type="radio" name="category" 
                    :disabled="authUser.RoleID == 6 && category.Name != 'Maintain'
                              || authUser.RoleID == 5 && category.Name != 'Working'"
                    :checked="authUser.RoleID == 6 && category.Name == 'Maintain' 
                              || authUser.RoleID == 5 && category.Name == 'Working'">
                    {{ category.Name }}
                </label> -->
                <RadioGroup v-model="workOrderCategory" type="button" style="user-select: none">
                  <Radio :disabled="authUser.Role != 'Staff'" label="Working"></Radio>
                  <Radio :disabled="authUser.Role != 'Maintainer'" label="Maintain"></Radio>
                </RadioGroup>
            </div>
            <div class="form-field is-horizonal">
                <div class="form-field-title" style="margin-right: 1rem">Priority:</div> 
                <label class="radio" :key="'priority' + priority.Id" v-for="priority in priorities" v-on:click="workOrderPriority = priority.Id" style="margin-right: 1rem; user-select: none;">
                    <input type="radio" name="priority" :checked="priority.Id == workOrderPriority" style="margin-right: .3rem;">
                    <span class="tag" style="color: white" :style="`background-color: ${priority.TagHexColor}`">{{ priority.Name }}</span>
                </label>
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
                                   'border: 1px solid var(--danger-color)' : ''" 
                                   :options="teamOptions" v-model="selectedTeam" 
                                   placeholder="Select a team" style="width: 40%"></model-select>
                    </div>
                </div>
                <div v-else-if="teamOptions.length == 0">
                    <div class="error-text">{{ CreateWorkOrderErrors.NoTeam }}</div>
                    You are not a team leader of any teams in <strong style="font-style: italic">{{ selectedLocation.text }}</strong>
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
              <div class="" style="display: grid; grid-template-columns: 40% 8% 18% 18% 10%; grid-column-gap: 1%; margin-bottom: .5rem">
                <div>Equipment</div>
                <div style="width: 100%; text-align: center">Quantity</div>
                <div>From</div>
                <div>To</div>
                <div></div>
              </div> <!-- header -->
              <!-- display selected equipment items -->
              <div :key="'selectedEquipment' + selectedEquipment.id" v-for="selectedEquipment in selectedEquipments">
                <!-- display errors -->
                <div style="display: grid; grid-template-columns: 40% 8% 18% 18% 10%; grid-column-gap: 1%; margin-bottom: 1rem;">
                  <div></div>
                  <div></div>
                  <div>
                    <div class="error-text" v-if="selectedEquipment.addEquipmentWarnings.FromDateIsLargerThanToDate != ''">
                      {{ selectedEquipment.addEquipmentWarnings.FromDateIsLargerThanToDate }}
                    </div>
                    <div class="error-text" v-if="selectedEquipment.addEquipmentWarnings.FromDateIsFromThePast != ''">
                      {{ selectedEquipment.addEquipmentWarnings.FromDateIsFromThePast }}
                    </div>
                  </div>
                  <div></div>
                  <div></div>
                </div><!-- display errors -->
                <!-- display equipments -->
                <div style="display: grid; grid-template-columns: 40% 8% 18% 18% 10%; grid-column-gap: 1%; margin-bottom: 1rem;">
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
                                      selectedEquipment.unableSelectItems = [];
                                      // check if from date conflicts any item in work orders
                                      let tempItems = [];
                                      // get the selected items in equipmentTable to tempItems
                                      selectedEquipment.equipmentItemIds.forEach(itemId => {
                                        tempItems = tempItems.concat(selectedEquipment.equipmentItemList.filter(item => item.Id == itemId));
                                      })
                                      // get the selected items in equipmentTable to tempItems
                                      checkSelectedItemDateConflict(tempItems, selectedEquipment.conflictItems, selectedEquipment.unableSelectItems,
                                                    getMilis(selectedEquipment.fromDate), getMilis(selectedEquipment.toDate));
                                      if (selectedEquipment.conflictItems.length == 0) {
                                        selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                                      } else {
                                        selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = ErrorStrings.SelectedDateConflictWorkOrders;
                                      }
                                      if (selectedEquipment.unableSelectItems.length == 0) {
                                        selectedEquipment.addEquipmentWarnings.UnableToSelectItem = '';
                                      } else {
                                        selectedEquipment.addEquipmentWarnings.UnableToSelectItem = ErrorStrings.UnableToSelectItem;
                                      }
                                    }          
                                  //}
                                }
                    }">
                  </div>
                  <div>
                    <input :disabled="!selectedEquipment.editMode" type="date" 
                            :style="(selectedEquipment.addEquipmentWarnings.FromDateIsLargerThanToDate != '') 
                                  || (selectedEquipment.addEquipmentWarnings.FromDateIsFromThePast != '') 
                                  || (selectedEquipment.addEquipmentWarnings.UnableToSelectItem != '') ?
                                'border: 1px solid var(--danger-color)' : (selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders != '') ? 
                                'border: 1px solid var(--warning-color)' : ''" 
                            class="input" v-model="selectedEquipment.fromDate"
                            v-on:change="() => {
                      if (selectedEquipment.fromDate === '') {
                        selectedEquipment.fromDate = this.getToday();
                      } else {
                        let fromDate = getMilis(selectedEquipment.fromDate);
                        let toDate = getMilis(selectedEquipment.toDate);
                        if (fromDate < getMilis(getToday())) {
                          selectedEquipment.addEquipmentWarnings.FromDateIsFromThePast = ErrorStrings.FromDateIsFromThePast;
                        } else {
                          selectedEquipment.addEquipmentWarnings.FromDateIsFromThePast = '';
                        }
                        if (fromDate > toDate) {
                          selectedEquipment.addEquipmentWarnings.FromDateIsLargerThanToDate = ErrorStrings.FromDateIsLargerThanToDate;
                        } else if (fromDate <= toDate) {
                          selectedEquipment.addEquipmentWarnings.FromDateIsLargerThanToDate = '';

                          selectedEquipment.conflictItems = [];
                          selectedEquipment.unableSelectItems = [];
                          // check if from date conflicts any item in work orders
                          let tempItems = [];
                          // get the selected items in equipmentTable to tempItems
                          selectedEquipment.equipmentItemIds.forEach(itemId => {
                            tempItems = tempItems.concat(selectedEquipment.equipmentItemList.filter(item => item.Id == itemId));
                          })
                          // get the selected items in equipmentTable to tempItems
                          checkSelectedItemDateConflict(tempItems, selectedEquipment.conflictItems, selectedEquipment.unableSelectItems,
                                        getMilis(selectedEquipment.fromDate), getMilis(selectedEquipment.toDate));
                          if (selectedEquipment.conflictItems.length == 0) {
                            selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                          } else {
                            selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = ErrorStrings.SelectedDateConflictWorkOrders;
                          }
                          if (selectedEquipment.unableSelectItems.length == 0) {
                            selectedEquipment.addEquipmentWarnings.UnableToSelectItem = '';
                          } else {
                            selectedEquipment.addEquipmentWarnings.UnableToSelectItem = ErrorStrings.UnableToSelectItem;
                          }
                        }
                      }
                    }">
                  </div>
                  <div>
                    <input :disabled="!selectedEquipment.editMode" type="date" 
                            :style="(selectedEquipment.addEquipmentWarnings.FromDateIsLargerThanToDate != '') 
                                  || (selectedEquipment.addEquipmentWarnings.UnableToSelectItem != '') ?
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
                          selectedEquipment.unableSelectItems = [];
                          // check if from date conflicts any item in work orders
                          let tempItems = [];
                          // get the selected items in equipmentTable to tempItems
                          selectedEquipment.equipmentItemIds.forEach(itemId => {
                            tempItems = tempItems.concat(selectedEquipment.equipmentItemList.filter(item => item.Id == itemId));
                          })
                          // get the selected items in equipmentTable to tempItems
                          checkSelectedItemDateConflict(tempItems, selectedEquipment.conflictItems, selectedEquipment.unableSelectItems,
                                        getMilis(selectedEquipment.fromDate), getMilis(selectedEquipment.toDate));
                          if (selectedEquipment.conflictItems.length == 0) {
                            selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                          } else {
                            selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = ErrorStrings.SelectedDateConflictWorkOrders;
                          }
                          if (selectedEquipment.unableSelectItems.length == 0) {
                            selectedEquipment.addEquipmentWarnings.UnableToSelectItem = '';
                          } else {
                            selectedEquipment.addEquipmentWarnings.UnableToSelectItem = ErrorStrings.UnableToSelectItem;
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
                  <span v-if="selectedEquipment.addEquipmentWarnings.UnableToSelectItem != ''" class="error-text">
                    {{ selectedEquipment.addEquipmentWarnings.UnableToSelectItem }}
                  </span>
                  <pre style="padding: 0; font-family: roboto; background: transparent;" 
                        v-if="selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders != ''" 
                        class="warning-text">
{{ selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders }}
                  </pre>
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
                                // check if from date conflicts any item in work orders
                                let tempItems = [];
                                // get the selected items in equipmentTable to tempItems
                                selectedEquipment.equipmentItemIds.forEach(itemId => {
                                  tempItems = tempItems.concat(selectedEquipment.equipmentItemList.filter(item => item.Id == itemId));
                                })
                                // get the selected items in equipmentTable to tempItems
                                checkSelectedItemDateConflict(tempItems, selectedEquipment.conflictItems, selectedEquipment.unableSelectItems,
                                              getMilis(selectedEquipment.fromDate), getMilis(selectedEquipment.toDate));
                                if (selectedEquipment.conflictItems.length == 0) {
                                  selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                                } else {
                                  selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = ErrorStrings.SelectedDateConflictWorkOrders;
                                }
                                if (selectedEquipment.unableSelectItems.length == 0) {
                                  selectedEquipment.addEquipmentWarnings.UnableToSelectItem = '';
                                } else {
                                  selectedEquipment.addEquipmentWarnings.UnableToSelectItem = ErrorStrings.UnableToSelectItem;
                                }
                              } else {
                                selectedEquipment.conflictItems = [];
                                selectedEquipment.equipmentItemIds = [];
                                selectedEquipment.quantity = 0;
                                selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = '';
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
                                selectedEquipment.unableSelectItems = [];
                                // check if from date conflicts any item in work orders
                                let tempItems = [];
                                // get the selected items in equipmentTable to tempItems
                                selectedEquipment.equipmentItemIds.forEach(itemId => {
                                  tempItems = tempItems.concat(selectedEquipment.equipmentItemList.filter(item => item.Id == itemId));
                                })
                                // get the selected items in equipmentTable to tempItems
                                checkSelectedItemDateConflict(tempItems, selectedEquipment.conflictItems, selectedEquipment.unableSelectItems,
                                              getMilis(selectedEquipment.fromDate), getMilis(selectedEquipment.toDate));
                                if (selectedEquipment.conflictItems.length == 0) {
                                  selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                                } else {
                                  selectedEquipment.addEquipmentWarnings.SelectedDateConflictWorkOrders = ErrorStrings.SelectedDateConflictWorkOrders;
                                }
                                if (selectedEquipment.unableSelectItems.length == 0) {
                                  selectedEquipment.addEquipmentWarnings.UnableToSelectItem = '';
                                } else {
                                  selectedEquipment.addEquipmentWarnings.UnableToSelectItem = ErrorStrings.UnableToSelectItem;
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
                        <td :class="{'row-warning-light': (((itemIndex + 1) % 2 != 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems)),
                                 'row-warning-dark': (((itemIndex + 1) % 2 == 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems)),
                                 'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, selectedEquipment.unableSelectItems)),
                                 'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, selectedEquipment.unableSelectItems))}"> <!-- work order name -->
                          {{ workOrder.Id == editWorkOrder.Id ? 'This order' : workOrder.Name }}
                          <span>[{{ workOrder.Status }}]</span>
                        </td>
                        <td :class="{'row-warning-light': (((itemIndex + 1) % 2 != 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems)),
                                 'row-warning-dark': (((itemIndex + 1) % 2 == 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems)),
                                 'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, selectedEquipment.unableSelectItems)),
                                 'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, selectedEquipment.unableSelectItems))}">{{ getDate(workOrder.Detail.ExpectingStartDate) }}</td> <!-- work order detail from date -->
                        <td :class="{'row-warning-light': (((itemIndex + 1) % 2 != 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems)),
                                    'row-warning-dark': (((itemIndex + 1) % 2 == 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, selectedEquipment.conflictItems)),
                                    'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, selectedEquipment.unableSelectItems)),
                                    'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, selectedEquipment.unableSelectItems))}">{{ getDate(workOrder.Detail.ExpectingDueDate) }}</td> <!-- work order detail to date -->
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
            <div class="form-field" style="padding-bottom: 0; margin-bottom: 0rem; display: grid; grid-template-columns: 40% 8% 18% 18% 10%; grid-column-gap: 1%;">   
              <div>
              <!-- display error for not select equipment -->
                <div class="strong-warning-text">{{ AddEquipmentWarnings.MustSelectEquipment }}</div>
                <div class="strong-warning-text">{{ AddEquipmentWarnings.AvailableQuantityIsZero }}</div>
              </div>
              <div></div>
              <div>
                <div class="strong-warning-text">{{ AddEquipmentWarnings.FromDateIsLargerThanToDate }}</div>
                <div class="strong-warning-text">{{ AddEquipmentWarnings.FromDateIsFromThePast }}</div>
              </div>
              <div></div>
              <div></div>
            </div> <!-- display errors --> 
            <!-- add equipment panel -->
            <div style="background: #eee">
              <div class="form-field" style="display: grid; grid-template-columns: 40% 8% 18% 18% 10%; grid-column-gap: 1%;">                
                <div class="form-field-input">
                  <div style="width: 100%">
                    <model-select :style="(AddEquipmentWarnings.MustSelectEquipment != '' 
                                          || AddEquipmentWarnings.AvailableQuantityIsZero != '') ?
                                            'border: 1px solid var(--strong-warning-color)' : ''" :options="toDisplayEquipmentOptions" placeholder="Select an equipment" v-model="selectedEquipment"></model-select>
                  </div>
                </div>  
                <div class="form-field-input">
                    <input :style="AddEquipmentWarnings.SelectedEquipmentQuantityIsZero != '' ? 'border: 1px solid var(--warning-color)' : ''"
                        type="number" :disabled="selectedEquipment.totalQuantity == 0" min="0" :max="selectedEquipment.totalQuantity" class="input" v-model="selectedEquipmentQuantity">
                </div>
                <div>
                  <input :style="(AddEquipmentWarnings.FromDateIsLargerThanToDate != '') 
                                  || (AddEquipmentWarnings.FromDateIsFromThePast != '') 
                                  || (AddEquipmentWarnings.UnableToSelectItem != '') ? 'border: 1px solid var(--strong-warning-color)' :
                                      (AddEquipmentWarnings.SelectedDateConflictWorkOrders != '') ? 'border: 1px solid var(--warning-color)'
                                      : ''" class="input" type="date" v-model="selectedEquipmentFromDate">
                </div>
                <div>
                  <input :style="(AddEquipmentWarnings.FromDateIsLargerThanToDate != '') 
                                  || (AddEquipmentWarnings.UnableToSelectItem != '')? 'border: 1px solid var(--strong-warning-color)' :
                                      (AddEquipmentWarnings.SelectedDateConflictWorkOrders != '') ? 'border: 1px solid var(--warning-color)'
                                      : ''" class="input" type="date" v-model="selectedEquipmentToDate">
                </div>
                <div>
                  <button v-on:click="addEquipment(false, selectedEquipment, selectedEquipmentQuantity, selectedEquipmentFromDate, selectedEquipmentToDate, selectedEquipmentItemIds, indeterminate, checkAllItems, equipmentTable, conflictItems, unableSelectItems, AddEquipmentWarnings)" 
                        style="margin-left: .5rem; border-radius: 50% !important;" class="button btn-primary material-shadow-animate"><i class="fa fa-plus"></i></button>
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
            <div style="padding-top: 0; padding-bottom: 0" class="form-field">
              <span v-if="AddEquipmentWarnings.SelectedEquipmentQuantityIsZero != ''" class="strong-warning-text">{{ AddEquipmentWarnings.SelectedEquipmentQuantityIsZero }}</span>
              <span v-if="AddEquipmentWarnings.UnableToSelectItem != ''" class="error-text">
                    {{ AddEquipmentWarnings.UnableToSelectItem }}
                  </span>
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
                                 'row-warning-dark': (((itemIndex + 1) % 2 == 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, conflictItems)),
                                 'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, unableSelectItems)),
                                 'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, unableSelectItems))}"> <!-- work order name -->
                      {{ workOrder.Id == editWorkOrder.Id ? 'This order' : workOrder.Name }}
                      <span>[{{ workOrder.Status }}]</span>
                    </td>
                    <td :class="{'row-warning-light': (((itemIndex + 1) % 2 != 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, conflictItems)),
                                 'row-warning-dark': (((itemIndex + 1) % 2 == 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, conflictItems)),
                                 'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, unableSelectItems)),
                                 'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, unableSelectItems))}">{{ getDate(workOrder.Detail.ExpectingStartDate) }}</td> <!-- work order detail from date -->
                    <td :class="{'row-warning-light': (((itemIndex + 1) % 2 != 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, conflictItems)),
                                 'row-warning-dark': (((itemIndex + 1) % 2 == 0) && isItemConflicted(equipmentItem.Id, workOrder.Id, conflictItems)),
                                 'row-danger-light': (((itemIndex + 1) % 2 != 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, unableSelectItems)),
                                 'row-danger-dark': (((itemIndex + 1) % 2 == 0) && isItemUnableToSelect(equipmentItem.Id, workOrder.Id, unableSelectItems))}">{{ getDate(workOrder.Detail.ExpectingDueDate) }}</td> <!-- work order detail to date -->
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
            loadEditOrder: true,
            editWorkOrder: null,
            sending: false,
            ErrorStrings: {
                MustSelectEquipment: 'You must select an equipment',
                FromDateIsLargerThanToDate: 'From date is larger than to date',
                AvailableQuantityIsZero: 'This equipment has no available units',
                NoEquipmentSelected: 'You must select at least one equipment',
                NoLocation: 'You must select a location',
                NoTeam: 'You must select a team in the selected location',
                SelectedEquipmentQuantityIsZero: 'You must choose at least 1 equipment item from the table below',
                SelectedDateConflictWorkOrders: 'From date or to date has conflict with some work orders. '
                                                    + '\nPlease reconsider choosing another date or the managers may reject your order.',
                FromDateIsFromThePast: 'From date can not be in the past',
                UnableToSelectItem: "You can not select items that are in work orders with status 'Approved' or 'In Progress' between your from date and to date",
            },
            AddEquipmentWarnings: {
                MustSelectEquipment: '',
                FromDateIsLargerThanToDate: '',
                AvailableQuantityIsZero: '',
                SelectedEquipmentQuantityIsZero: '',
                SelectedDateConflictWorkOrders: '',
                FromDateIsFromThePast: '',
                UnableToSelectItem: '',
            },
            CreateWorkOrderErrors: {
                NoEquipmentSelected: '',
                EquipmentErrors: [],
                NoLocation: '',
                NoTeam: '',
            },
            workOrderTitle: "",
            workOrderDescription: "",
            workOrderPriority: 1,
            selectedEquipmentQuantity: 0,
            selectedEquipmentFromDate: "",
            selectedEquipmentToDate: "",
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
    },
    created() {
        //get work order to edit
        let context = this;
        context.axios(`${Server.WORKORDER_API_PATH}/id/${context.$route.params.orderId}`)
            .then((res) => {
                if (res.status == 200) {
                    context.editWorkOrder = res.data;
                    // get work order priorities
                    context.axios.get(Server.WORKORDER_PRIORITIES_API_PATH).then(res => {
                        if (res.data) {
                            context.priorities = res.data;
                            context.workOrderPriority = context.editWorkOrder.PriorityID;
                        }
                    });
                    // get locations
                    context.axios.get(Server.LOCATION_API_PATH).then(res => {
                        if (res.data) {
                            let data = res.data;
                            data.forEach(location => {
                                let option = {
                                    value: location.Id,
                                    text: `${location.Name} - ${location.Address}`
                                };
                                context.locationOptions.push(option);
                            });
                            context.selectedLocation = context.locationOptions.filter(op => parseInt(op.value) == context.editWorkOrder.Location.Id)[0];
                            //get team in selected location
                            context.teamOptions = [];
                            let url = `${Server.LOCATION_API_PATH}/${
                            context.selectedLocation.value
                            }/team/${context.authUser.Id}`;
                            context.axios.get(url).then(res => {
                                if (res.data) {
                                    let data = res.data;
                                    data.forEach(element => {
                                        let option = {
                                            value: element.Team.Id,
                                            text: element.Team.Name
                                        };
                                        context.teamOptions.push(option);
                                    });
                                    context.loadEditOrder = false;
                                    context.selectedTeam = context.teamOptions.filter(op => parseInt(op.value) == parseInt(context.editWorkOrder.Team.Id))[0];
                                }
                            });
                        }
                    });
                    // get all equipments to display options
                    context.axios.get(Server.EQUIPMENT_API_PATH).then(res => {
                        if (res.data) {
                            let data = res.data;
                            data.forEach(element => {
                                let quantity = parseInt(element.Equipment.Quantity);
                                let option = {
                                    text: `${element.Equipment.Name}, quantity: ${quantity} ${quantity > 0 ? element.Equipment.Unit : ''}`,
                                    value: element.Equipment.Id,
                                    image: element.Equipment.Image,
                                    totalQuantity: quantity
                                };
                                context.equipmentOptions.push(option);
                            });
                            context.toDisplayEquipmentOptions = context.equipmentOptions;
                            
                            context.editWorkOrder.Equipments.forEach(eq => {
                                let equipmentOption = context.equipmentOptions.filter(op => parseInt(op.value) == parseInt(eq.Id))[0];
                                let itemQuantity = eq.EquipmentItems.length;
                                let fromDate = moment(eq.OrderDetail.ExpectingStartDate).format('YYYY-MM-DD');
                                let toDate = moment(eq.OrderDetail.ExpectingDueDate).format('YYYY-MM-DD');
                                let selectedItemIds = [];
                                eq.EquipmentItems.forEach(item => {
                                    selectedItemIds.push(item.Id);
                                });
                                let equipmentTable = eq.Table;
                                let indeterminate = selectedItemIds.length > 0 && selectedItemIds.length < equipmentTable.length;
                                let checkAllItems = selectedItemIds.length == equipmentTable.length;
                                let addEquipmentWarnings = {
                                    MustSelectEquipment: '',
                                    FromDateIsLargerThanToDate: '',
                                    AvailableQuantityIsZero: '',
                                    SelectedEquipmentQuantityIsZero: '',
                                    SelectedDateConflictWorkOrders: '',
                                    FromDateIsFromThePast: '',
                                    UnableToSelectItem: '',
                                };
                                // check if from date conflicts any item in work orders - start
                                let conflictItems = [];
                                let unableSelectItems = [];
                                let tempItems = [];
                                selectedItemIds.forEach(itemId => {
                                    tempItems = tempItems.concat(equipmentTable.filter(item => item.Id == itemId));
                                })
                                // get the selected items in equipmentTable to tempItems
                                context.checkSelectedItemDateConflict(tempItems, conflictItems, unableSelectItems,
                                                    context.getMilis(eq.OrderDetail.ExpectingStartDate), context.getMilis(eq.OrderDetail.ExpectingDueDate));
                                if (conflictItems.length == 0) {
                                    addEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                                } else {
                                    addEquipmentWarnings.SelectedDateConflictWorkOrders = context.ErrorStrings.SelectedDateConflictWorkOrders;
                                }
                                if (unableSelectItems.length == 0) {
                                    addEquipmentWarnings.UnableToSelectItem = '';
                                } else {
                                    addEquipmentWarnings.UnableToSelectItem = context.ErrorStrings.UnableToSelectItem;
                                } // check if from date conflicts any item in work orders - end
                                
                                context.addEquipment(true, equipmentOption, itemQuantity, fromDate, toDate, selectedItemIds, indeterminate, checkAllItems, equipmentTable, conflictItems, unableSelectItems, addEquipmentWarnings);
                            })
                        }
                    });// get all equipments to display options
                }
            });       
        
        this.selectedEquipmentFromDate = this.getToday();
        this.selectedEquipmentToDate = this.getToday();
    },
    methods: {
        cancel() {
            this.$router.push("/work_order");
        },
        addEquipment(editOrder, equipmentOption, itemQuantity, fromDate, toDate, selectedItemIds, indeterminate, checkAllItems, equipmentTable, conflictItems, unableSelectItems, addEquipmentWarnings) {
            if (equipmentOption.value == "") {
                this.AddEquipmentWarnings.MustSelectEquipment = this.ErrorStrings.MustSelectEquipment;
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
                            fromDate: fromDate,
                            toDate: toDate,
                            equipmentItemIds: selectedItemIds,
                            editMode: false,
                            indeterminate: indeterminate,
                            checkAllItems: checkAllItems,
                            equipmentItemList: equipmentTable,
                            conflictItems: conflictItems,
                            unableSelectItems: unableSelectItems,
                            addEquipmentWarnings: warningOb,
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
        updateWorkOrder() {
            if (this.selectedEquipments.length == 0) {
                this.CreateWorkOrderErrors.NoEquipmentSelected = this.ErrorStrings.NoEquipmentSelected;
            }
            if (this.selectedLocation.value === '') {
                this.CreateWorkOrderErrors.NoLocation = this.ErrorStrings.NoLocation;
            }
            if (this.selectedTeam.value === '') {
                this.CreateWorkOrderErrors.NoTeam = this.ErrorStrings.NoTeam;
            }
            if (this.validateUpdateOrder()) {
                let context = this;
                context.sending = true;
                // first, delete all work order details
                let deleteDetailApi = `${Server.WORKORDER_API_PATH}/detail/${context.editWorkOrder.Id}`;
                context.axios.delete(deleteDetailApi)
                    .then((res) => {
                        if (res.status == 200) {
                            let teamLocationApi = `${Server.TEAM_LOCATION_API_PATH}/${this.selectedLocation.value}/${this.selectedTeam.value}`;
                            this.axios.get(teamLocationApi)
                                .then(function(res) {
                                    if (res.data.Id) {
                                        let result = res.data.Id;
                                        // update team location
                                        context.axios.put(`http://localhost:3000/api/work_order/team_location/${context.editWorkOrder.Id}`, {
                                            teamLocationId: result
                                        });
                                        let url = `${Server.WORKORDER_API_PATH}/status/${context.editWorkOrder.Id}`;
                                        context.axios
                                            .put(url, {
                                                userId: context.authUser.Id,
                                                newStatusName: 'Requested',
                                                description: context.workOrderDescription.trim(),
                                            });

                                        // add updated work order details
                                        var check = true;
                                        context.selectedEquipments.forEach(equipment => {
                                            equipment.equipmentItemIds.forEach(async itemId => {
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
                                            })
                                        })
                                        context.sending = false;
                                        if (check) {
                                            context.$router.push(`/work_order/${context.editWorkOrder.Id}`);
                                        } else {
                                            alert('Error');
                                        }    
                                    }
                            })
                            .catch(error => {
                                alert(
                                "Create work order: " + error
                                );
                            });
                        }
                    })
                    .catch((error) => {
                        console.log(error);
                    })
            }
        },
        validateAddEquipment() {
            return this.AddEquipmentWarnings.MustSelectEquipment === '' && this.AddEquipmentWarnings.FromDateIsLargerThanToDate === ''
                    && this.AddEquipmentWarnings.AvailableQuantityIsZero === '' && this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero === ''
                    && this.AddEquipmentWarnings.FromDateIsFromThePast === '' && this.AddEquipmentWarnings.UnableToSelectItem === '';
        },
        validateUpdateOrder() {  
            var checkSelectedItems = true; // check if currently there is no error messages of items are displaying
            for (var i = 0; i < this.selectedEquipments.length; i++) {
                let selectedEquipment = this.selectedEquipments[i];
                if (selectedEquipment.addEquipmentWarnings.SelectedEquipmentQuantityIsZero != '' 
                    || selectedEquipment.addEquipmentWarnings.FromDateIsLargerThanToDate != ''
                    || selectedEquipment.addEquipmentWarnings.UnableToSelectItem != '') {
                    checkSelectedItems = false;
                    break;
                }
            }
            return this.CreateWorkOrderErrors.NoEquipmentSelected === ''
                    && this.CreateWorkOrderErrors.NoLocation === '' && this.CreateWorkOrderErrors.NoTeam === ''
                    && checkSelectedItems;
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
            } 
            else {
                this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = '';
                this.selectedEquipmentQuantity = parseInt(this.selectedEquipmentQuantity) + 1;
                this.selectedEquipmentItemIds.push(equipmentItemId);
                if (this.selectedEquipmentItemIds.length == this.equipmentTable.length) {
                    this.indeterminate = false;
                    this.checkAllItems = true;
                }
            }
            
            this.conflictItems = [];
            this.unableSelectItems = [];
                // check if from date conflicts any item in work orders
            let tempItems = [];
            this.selectedEquipmentItemIds.forEach(itemId => {
                tempItems = tempItems.concat(this.equipmentTable.filter(item => item.Id == itemId));
            })
            // get the selected items in equipmentTable to tempItems
            this.checkSelectedItemDateConflict(tempItems, this.conflictItems, this.unableSelectItems,
                                this.getMilis(this.selectedEquipmentFromDate), this.getMilis(this.selectedEquipmentToDate));
            if (this.conflictItems.length == 0) {
                this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = '';
            } else {
                this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = this.ErrorStrings.SelectedDateConflictWorkOrders;
            }
            if (this.unableSelectItems.length == 0) {
                this.AddEquipmentWarnings.UnableToSelectItem = '';
            } else {
                this.AddEquipmentWarnings.UnableToSelectItem = this.ErrorStrings.UnableToSelectItem;
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
            this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = '';
            this.selectedEquipmentItemIds = [];
            this.equipmentTable.forEach(item => this.selectedEquipmentItemIds.push(item.Id));
            this.selectedEquipmentQuantity = this.equipmentTable.length;

            this.conflictItems = [];
            this.unableSelectItems = [];
            // check if from date conflicts any item in work orders
            let tempItems = [];
            this.selectedEquipmentItemIds.forEach(itemId => {
            tempItems = tempItems.concat(this.equipmentTable.filter(item => item.Id == itemId));
            })
            // get the selected items in equipmentTable to tempItems
            this.checkSelectedItemDateConflict(tempItems, this.conflictItems, this.unableSelectItems,
                            this.getMilis(this.selectedEquipmentFromDate), this.getMilis(this.selectedEquipmentToDate));
            if (this.conflictItems.length == 0) {
                this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = '';
            } else {
                this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = this.ErrorStrings.SelectedDateConflictWorkOrders;
            }
            if (this.unableSelectItems.length == 0) {
                this.AddEquipmentWarnings.UnableToSelectItem = '';
            } else {
                this.AddEquipmentWarnings.UnableToSelectItem = this.ErrorStrings.UnableToSelectItem;
            }
        } else {
            this.conflictItems = [];
            this.selectedEquipmentItemIds = [];
            this.selectedEquipmentQuantity = 0;
            this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = '';
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
            this.AddEquipmentWarnings.MustSelectEquipment = '';
            this.AddEquipmentWarnings.NoEquipmentSelected = '';
            this.AddEquipmentWarnings.AvailableQuantityIsZero = '';
            this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = '';
            this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = '';
            this.AddEquipmentWarnings.FromDateIsLargerThanToDate = '';
            this.AddEquipmentWarnings.UnableToSelectItem = '';
        },
        isItemConflicted(itemId, workOrderId, conflictItems) {
            for (var i = 0; i < conflictItems.length; i++) {
                let item = conflictItems[i];
                if (workOrderId != this.editWorkOrder.Id
                    && item.itemId == itemId 
                    && item.workOrderId == workOrderId) {
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
        checkSelectedItemDateConflict(items, conflictItems, unableSelectItems, fromDate, toDate) {
            items.forEach(item => {
                if (item.WorkOrders) {
                    item.WorkOrders.forEach(order => {
                        let itemFromDate = this.getMilis(order.Detail.ExpectingStartDate);
                        let itemToDate = this.getMilis(order.Detail.ExpectingDueDate);
                        if (order.Id != this.editWorkOrder.Id 
                            && ((fromDate >= itemFromDate && fromDate <= itemToDate)  
                                || (toDate >= itemFromDate && toDate <= itemToDate)
                                || (fromDate < itemFromDate && fromDate < itemToDate && toDate > itemFromDate && toDate > itemToDate))) {
                            if (order.Status == 'Approved' || order.Status == 'In Progress') {
                                unableSelectItems.push({itemId: item.Id, workOrderId: order.Id});
                            } else {
                                conflictItems.push({itemId: item.Id, workOrderId: order.Id});
                            }
                        }
                    })
                }
            });          
        },
    },
    watch: {
        'selectedEquipment': function() {
        // selecte another equipment
            if (this.selectedEquipment.value != '') {
                this.resetEquipmentSelection(); // reset after selected another equipment 
                if (this.AddEquipmentWarnings.MustSelectEquipment != '') { // error 'Must select equipment' displaying
                    this.AddEquipmentWarnings.MustSelectEquipment = '';
                }
                // check if selected equipment has equipment item(s)
                if (this.selectedEquipment.totalQuantity == 0) {
                    this.AddEquipmentWarnings.AvailableQuantityIsZero = this.ErrorStrings.AvailableQuantityIsZero;
                } else {
                this.AddEquipmentWarnings.AvailableQuantityIsZero = ''; // set warning to empty text         

                // get all the equipment items with work order detail info (if available)
                let url = `${Server.WORKORDER_API_PATH}/get_equipment_detail/${this.selectedEquipment.value}`;
                this.axios.get(url)
                    .then((res) => {
                        if (res.status == 200 && res.data) {
                            this.equipmentTable = res.data;
                            this.selectedEquipmentItemIds.push(res.data[0].Id);
                            this.selectedEquipmentQuantity = 1;
                            this.indeterminate = true;
                            this.selectedEquipmentFromDate = this.getToday();
                            this.selectedEquipmentToDate = this.getToday();
                        }
                    })
                }
            }
        },
        'selectedEquipments': function() {
            if (this.selectedEquipments.length > 0) {
                this.CreateWorkOrderErrors.NoEquipmentSelected = '';
            }
        },
        'selectedLocation': function() {
            if (!this.loadEditOrder) {
                this.teamOptions = [];
                this.selectedTeam = {
                    text: "",
                    value: ""
                };
                if (this.selectedLocation.value != '') {
                    if (this.CreateWorkOrderErrors.NoLocation != '') {
                        this.CreateWorkOrderErrors.NoLocation = '';
                    }
                    // alert('in 2')
                    let url = `${Server.LOCATION_API_PATH}/${
                    this.selectedLocation.value
                    }/team/${this.authUser.Id}`;
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
            }
        },
        'selectedEquipmentFromDate': function() {
            if (this.selectedEquipmentFromDate === '') {
                this.selectedEquipmentFromDate = this.getToday();
            } else {
                let fromDate = this.getMilis(this.selectedEquipmentFromDate);
                let toDate = this.getMilis(this.selectedEquipmentToDate);
                if (fromDate < this.getMilis(this.getToday())) {
                    this.AddEquipmentWarnings.FromDateIsFromThePast = this.ErrorStrings.FromDateIsFromThePast;
                } else {
                    this.AddEquipmentWarnings.FromDateIsFromThePast = '';
                }
                if (fromDate > toDate) {
                    this.AddEquipmentWarnings.FromDateIsLargerThanToDate = this.ErrorStrings.FromDateIsLargerThanToDate;
                } else if (fromDate <= toDate) {
                    this.AddEquipmentWarnings.FromDateIsLargerThanToDate = '';
                    this.conflictItems = [];
                    this.unableSelectItems = [];
                        // check if from date conflicts any item in work orders
                    let tempItems = [];
                    this.selectedEquipmentItemIds.forEach(itemId => {
                        tempItems = tempItems.concat(this.equipmentTable.filter(item => item.Id == itemId));
                    })
                    // get the selected items in equipmentTable to tempItems
                    this.checkSelectedItemDateConflict(tempItems, this.conflictItems, this.unableSelectItems,
                                        this.getMilis(this.selectedEquipmentFromDate), this.getMilis(this.selectedEquipmentToDate));
                    if (this.conflictItems.length == 0) {
                        this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                    } else {
                        this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = this.ErrorStrings.SelectedDateConflictWorkOrders;
                    }
                    if (this.unableSelectItems.length == 0) {
                        this.AddEquipmentWarnings.UnableToSelectItem = '';
                    } else {
                        this.AddEquipmentWarnings.UnableToSelectItem = this.ErrorStrings.UnableToSelectItem;
                    }
                }
            }
        },
        'selectedEquipmentToDate': function() {
            if (this.selectedEquipmentToDate === '') {
                this.selectedEquipmentToDate = this.getToday();
            } else {
                let fromDate = moment(this.selectedEquipmentFromDate).valueOf();
                let toDate = moment(this.selectedEquipmentToDate).valueOf();
                if (fromDate > toDate) {
                    this.AddEquipmentWarnings.FromDateIsLargerThanToDate = this.ErrorStrings.FromDateIsLargerThanToDate;
                } else if (fromDate <= toDate){
                    this.AddEquipmentWarnings.FromDateIsLargerThanToDate = '';

                    this.conflictItems = [];
                    this.unableSelectItems = [];
                    // check if from date conflicts any item in work orders
                    let tempItems = [];
                    // get the selected items in equipmentTable to tempItems
                    this.selectedEquipmentItemIds.forEach(itemId => {
                        tempItems = tempItems.concat(this.equipmentTable.filter(item => item.Id == itemId));
                    })
                    // get the selected items in equipmentTable to tempItems
                    this.checkSelectedItemDateConflict(tempItems, this.conflictItems, this.unableSelectItems, fromDate, toDate);
                    if (this.conflictItems.length == 0) {
                        this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                    } else {
                        this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = this.ErrorStrings.SelectedDateConflictWorkOrders;
                    }
                    if (this.unableSelectItems.length == 0) {
                        this.AddEquipmentWarnings.UnableToSelectItem = '';
                    } else {
                        this.AddEquipmentWarnings.UnableToSelectItem = this.ErrorStrings.UnableToSelectItem;
                    }
                }
            }
        },
        'selectedEquipmentQuantity': function() {
            if (this.selectedEquipmentQuantity === '') {
                this.selectedEquipmentQuantity = 0;
                this.selectedEquipmentItemIds = [];
                this.conflictItems = [];
                this.indeterminate = false;
                this.checkAllItems = false;
                this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = this.ErrorStrings.SelectedEquipmentQuantityIsZero;
            } else {
                if (this.selectedEquipment.value != '' && this.selectedEquipment.totalQuantity > 0) {
                    var currentQuantity = parseInt(this.selectedEquipmentQuantity);
                    let equipmentQuantity = parseInt(this.selectedEquipment.totalQuantity);
                    if (currentQuantity < 0) {
                        this.selectedEquipmentQuantity = 0;
                    } else if (currentQuantity > equipmentQuantity) {
                        this.selectedEquipmentQuantity = equipmentQuantity;
                    }

                    // if the selectedEquipmentQuantity = 0, we should display a warning to user
                    if (currentQuantity == 0) {
                        this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = this.ErrorStrings.SelectedEquipmentQuantityIsZero;
                        this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                        this.selectedEquipmentItemIds = [];
                        this.conflictItems = [];
                        this.indeterminate = false;
                        this.checkAllItems = false;
                    } else {
                        this.AddEquipmentWarnings.SelectedEquipmentQuantityIsZero = '';
                        this.indeterminate = true;
                        // if the selectedEquipmentQuantity is greater than selectedEquipmentItemIds.length
                        //, it means we should add the next item to selectedEquipmentItemIds
                        if (currentQuantity >= this.selectedEquipmentItemIds.length) {
                            while(this.selectedEquipmentItemIds.length != parseInt(this.selectedEquipmentQuantity)) {
                                let tempItems = this.equipmentTable;
                                this.selectedEquipmentItemIds.forEach(itemId => {
                                    tempItems = tempItems.filter(item => item.Id != itemId);
                                })
                                this.selectedEquipmentItemIds.push(tempItems[0].Id);
                            }
                            if (this.selectedEquipmentItemIds.length == this.equipmentTable.length) {
                                this.indeterminate = false;
                                this.checkAllItems = true;
                            } 
                        } else if (currentQuantity < this.selectedEquipmentItemIds.length) {
                        // the code below will simply pop the last id out of the list, so if user has pick an equipment by hand (not using the number input)
                        // and then use the number input, the item is not automatically calculate to choose the best ideal one
                        // in other words, the order of item will not be the best ideal order the algorithm should give out
                        // then the user would see item unchecks in the incorrect descending order
                        // but i think we should respect the user's choice
                            while(this.selectedEquipmentItemIds.length != parseInt(this.selectedEquipmentQuantity)) {
                                this.selectedEquipmentItemIds.pop();
                            }
                        }
                        this.conflictItems = [];
                        this.unableSelectItems = [];
                        // check if from date conflicts any item in work orders
                        let tempItems = [];
                        // get the selected items in equipmentTable to tempItems
                        this.selectedEquipmentItemIds.forEach(itemId => {
                        tempItems = tempItems.concat(this.equipmentTable.filter(item => item.Id == itemId));
                        })
                        // get the selected items in equipmentTable to tempItems
                        this.checkSelectedItemDateConflict(tempItems, this.conflictItems, this.unableSelectItems,
                                    this.getMilis(this.selectedEquipmentFromDate), this.getMilis(this.selectedEquipmentToDate));
                        if (this.conflictItems.length == 0) {
                            this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = '';
                        } else {
                            this.AddEquipmentWarnings.SelectedDateConflictWorkOrders = this.ErrorStrings.SelectedDateConflictWorkOrders;
                        }
                        if (this.unableSelectItems.length == 0) {
                            this.AddEquipmentWarnings.UnableToSelectItem = '';
                        } else {
                            this.AddEquipmentWarnings.UnableToSelectItem = this.ErrorStrings.UnableToSelectItem;
                        }
                    }          
                }
            }
        },
        'selectedTeam': function() {
            if (this.selectedTeam.value != '' && this.CreateWorkOrderErrors.NoTeam != '') {
                this.CreateWorkOrderErrors.NoTeam = '';
            }
        }
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

.row-warning-light {
  background: #FFF1B5 !important;
}

.row-even {
  background: #eeeeee;
}
.row-warning-dark {
  background: #FFE99E !important;
}
</style>
