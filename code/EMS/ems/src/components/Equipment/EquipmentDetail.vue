<template>
<div> 
  <simplert :useRadius="true" :useIcon="true" ref="simplert"></simplert>
  <div style="padding: 0rem 2rem 0rem 1rem">
    <router-link to='/equipment'>
        <a><span class="fa fa-chevron-left"></span> Back to Equipment </a>
    </router-link>
  </div>
  <div>
        <div class="field" style=" display: grid; grid-template-columns: 45% 55%; width: 100;">
            <div class="left" style="padding-top:0.5rem; padding-left:1rem ">
                <img :src= "this.EquimentByID.Image" style="width: 400px; height: 400px; ">
            </div>
            <div class="">
              <div class="field" style=" display: grid; grid-template-columns: 70% 20% 10%;">
                  <strong style="text-transform: uppercase;  font-size: 20px; color: #26a69a">{{equipmentName}}</strong>
                  <div>
                    <button v-if="!addItemMode && authUser.Role=='Equipment Staff' && EquimentByID.Status" class="btn-Add"   v-on:click="addItem">Add Item</button>
                  </div>
                  <!-- <div class="" v-else ><button  class="btn-Add" style="color: white;border-bottom: 1px solid black;background-color: #26a69a;border-radius: 5px" >Add Item</button></div> -->
                  <div>
                    <button v-if="!editMode && authUser.Role=='Equipment Staff'" class="btn-edit"  v-on:click="editMode = !editMode">Edit</button> 
                  </div>
                  <!-- <div class="" v-else><button class="btn-edit" style="color: white;border-bottom: 1px solid black;background-color: #26a69a;border-radius: 5px" :class="{'is-active-option': editMode}">Edit</button> </div> -->
             </div>
              <span v-if="editMode"  style="color:red; font-size:14px">* is required, please input these fields</span>
              <div class="row" style="height:36px" >
                  <div class="" style="margin-top:0.5rem" >
                      Name:  <span v-if="editMode" style="color:red; font-size:18px">*</span>
                  </div>
                  <input v-if="!editMode" v-model="EquimentByID.Name" class="input col-7 " type="text" disabled="disabled"> 
                  <input v-else v-model="EquimentByID.Name" class="input col-7 " type="text"  >
              </div>
              <div class="row" style="height:36px" >
                  <div class="" style="margin-top:0.5rem" >
                      Vendor:  <span v-if="editMode" style="color:red; font-size:18px">*</span>
                  </div>
                  <input v-if="!editMode" v-model="EquimentByID.Vendor.Name" class="input col-7 " type="text" disabled="disabled"> 
                  <div class="select" v-else>
                    <select class="" style="border: 1px #9e9e9e solid; padding-left: 1rem; width:100%"  v-model="EquimentByID.VendorId">
                              <option style="width:100%" :key="'equipmentVendor' + vendor.Id" v-for="vendor in vendorOptions"
                                :selected="EquimentByID.VendorId == vendor.Id "                    
                                v-bind:value="vendor.Id">{{vendor.BusinessName}}</option>
                    </select>
                  </div>
              </div> 
              <div  class="row" style="height:36px" >
                  <div class="" style="margin-top:0.5rem" >
                      Made In:  
                  </div>
                  <input v-if="!editMode" v-model="EquimentByID.MadeIn" class="input col-7 " type="text" disabled="disabled"> 
                  <input v-else v-model="EquimentByID.MadeIn" class="input col-7 " type="text" >
              </div>
              <div  class="row" style="height:36px" >
                  <div class="" style="margin-top:0.5rem" >
                      Category:  <span v-if="editMode" style="color:red; font-size:18px">*</span>
                  </div>
                  <input v-if="!editMode" v-model="EquimentByID.Category.Name" class="input col-7 " type="text" disabled="disabled"> 
                  <div class="select" v-else>
                    <select class="" style="border: 1px #9e9e9e solid; padding-left: 1rem; width:100%"  v-model="EquimentByID.CategoryId">
                              <option :key="'equipmentCate' + cate.Id" v-for="cate in categoryOptions"
                                :selected="EquimentByID.CategoryId == cate.Id "                    
                                v-bind:value="cate.Id">{{cate.Name}}</option>
                    </select>
                  </div>
              </div>
              <div class="row" style=" display: grid;grid-template-columns: 50% 50%;">
                <div  class="is-horizontal" style="height:36px; display: grid;grid-template-columns: 36% 64%;" >
                  <div class="" style="padding-top:0.25rem; " >
                      Quantity:  
                  </div>
                  <div>
                    <input v-model="this.Items.length" class="input col-5 " type="text" disabled="disabled"> 
                  </div>
                </div>
                <div  class="is-horizontal" style="height:36px; display: grid;grid-template-columns: 20% 80%; padding-left:2rem " >
                  <div class="" style="padding-top:0.25rem;" >
                      Unit:  <span v-if="editMode" style="color:red; font-size:18px">*</span>
                  </div>
                  <input v-if="!editMode" v-model="this.EquimentByID.Unit.Name" class="input col-5 " type="text" disabled="disabled"> 
                  <div class="select" v-else>
                    <select class="" style="border: 1px #9e9e9e solid; padding-left: 1rem; width:100%"  v-model="EquimentByID.UnitID">
                              <option :key="'equipmentUnit' + unit.Id" v-for="unit in unitOptions"
                                :selected="EquimentByID.UnitID == unit.Id "                    
                                v-bind:value="unit.Id">{{unit.Name}}</option>
                    </select>
                  </div>
               </div>
              </div>
              <div  class="row" style="height:36px;" >
                  <div class="" style="margin-top:0.5rem" >
                      Schedule:  <span v-if="editMode" style="color:red; font-size:18px">*</span>
                  </div>
                  <div class="is-horizontal" v-if="!editMode" style="height:36px; display: grid;grid-template-columns: 40% 60%;">
                    <input  v-model="EquimentByID.MaintenanceDuration.Months" class="input col-7 " type="text" disabled="disabled"> 
                    <label style=" margin-top: 0.75rem;margin-left: 0.2rem;padding-left:1rem">months/time maintenance</label>
                  </div>
                  <div class="is-horizontal" v-else style="height:36px; display: grid;grid-template-columns: 40% 60%;">
                    <div class="select" >
                      <select class="" style="border: 1px #9e9e9e solid; padding-left: 1rem; width:100%"  v-model="EquimentByID.MaintenanceDurationID">
                                <option :key="'duration' + duration.Id" v-for="duration in maintenanceDurationOptions"
                                  :selected="EquimentByID.MaintenanceDurationID == duration.Id "                    
                                  v-bind:value="duration.Id">{{duration.Months}}</option>
                      </select>
                    </div>
                    <label style=" margin-top: 0.75rem;margin-left: 0.2rem;padding-left:1rem">months/time maintenance</label>
                  </div>
              </div>
             <div  class="row" style="height:36px;" >
                  <div class="" style="margin-top:0.5rem" >
                      Status:  <span v-if="editMode" style="color:red; font-size:18px">*</span>
                  </div>
                  <div class="is-horizontal" v-if="!editMode" style="height:36px; display: grid;grid-template-columns: 38% 60%;margin-top:0.5rem">
                    <label v-if="EquimentByID.Status" style="margin-right: 1rem;" class="radio"  >
                      <input type="radio" name="active" v-on:change="EquimentByID.Status = true" :checked="EquimentByID.Status" :disabled="!editMode">
                      Active
                    </label>
                    <label v-else class="radio">
                      <input type="radio"  name="active" v-on:change="EquimentByID.Status = false" :checked="!EquimentByID.Status" :disabled="!editMode">
                      InActive
                    </label>
                  </div>
                  <div class="is-horizontal" v-else style="height:36px; display: grid;grid-template-columns: 38% 60%;margin-top:0.5rem">
                    <label style="margin-right: 1rem;" class="radio"  >
                      <input type="radio" name="active" value="Active"  v-on:change="EquimentByID.Status = true"  :checked="EquimentByID.Status" >
                      Active
                    </label>
                    <label class="radio">
                      <input type="radio"  name="active" value="InActive" v-on:change="EquimentByID.Status = false" :checked="!EquimentByID.Status" >
                      InActive
                    </label>
                  </div>
              </div>
              <div  class="row" style="height:36px" >
                  <div class="" style="margin-top:0.5rem" >
                      Description:  
                  </div>
                  <input v-if="!editMode" v-model.trim="EquimentByID.Description" class="input col-7 " type="text" disabled="disabled"> 
                  <input v-else v-model.trim="EquimentByID.Description" class="input col-7 " type="text" >
              </div>
              
              <div class="row" style="height:30px" v-if="editMode">
                <div class="" style="margin-top:0.5rem">
                  Picture:
                </div>
                <div class="input_picture">                  
                  <label class="file-label"  > 
                  <span class="file-cta">
                      <input v-if="!editMode" class="file-input" type="file" accept="image/*" style="opacity:0" ref="fileInput"  disabled="disabled" />
                      <input v-else class="file-input" type="file" accept=".png, .jpg, .jpeg, .jpe, .jfif, .gif"  style="opacity: 0" ref="fileInput" v-on:change="inputFileChange" />
                      <span class="file-icon" style="margin-right=0;">
                          <i class="fa fa-upload"></i>
                      </span>
                      <span class="file-label">
                                Choose images...
                      </span>
                  </span>
                      <div class="file-upload" v-bind:key="file.name" v-for="file in files" style="width: 100% !important;">
                          {{ file.name }}
                      </div>
                  </label>              
                </div>
              </div>
              <div class=" is-horizontal" style="padding-top:0.75rem; padding-bottom: 0.5rem;" v-if="editMode" >
                <button class="btn-Cancel" v-on:click="cancelUpdateEquipment">Cancel</button>
                <button  class="btn-Update" v-on:click="updateEquipment">Save changes</button>
              </div>
            </div>       
        </div>
        <div class="equipmentItem" style="padding-top:0.5rem;">
          <div class="wrapper-table" v-if="toDisplayEquipmentItem && toDisplayEquipmentItem.length >0">
            <div class="" style="padding-left:0.4rem;font-style: italic;font-size:16px">
              Table: List item of the equipment
            </div>
            <table class="table">
                <thead>
                    <tr>
                        <th><strong>No.</strong></th>
                        <th><strong>Serial number</strong></th>
                        <th><strong>ImportDate</strong></th>
                        <th><strong>Warranty</strong></th>
                        <th><strong>Runtime Days</strong></th>
                        <th><strong>Last-MaintainDate</strong></th>
                        <th><strong>Next-MaintainDate</strong></th>
                        <th><strong>Status</strong></th>
                        <th><strong>Description</strong></th>
                    </tr>
                </thead>  
                <tbody>
                    <tr v-bind:key="item.ID" v-for="(item, index) in toDisplayEquipmentItem" v-on:click="setSelectedItem(item.ID)">
                        <td style="text-align:center">{{ 10*(currentPageEquipmentItem -1) + (index + 1) }}</td>   
                        <td>{{item.SerialNumber}}</td>
                        <td>{{item.ImportDate}}</td>
                        <td>{{item.WarrantyDuration}}</td>
                        <td>{{item.RuntimeDays}}</td>
                        <td>{{item.LastMaintainDate}}</td>
                        <td>{{item.NextMaintainDate}}</td>
                        <td>{{item.Status}}</td>
                        <td>{{item.Description ? item.Description : 'n/a' }}</td>    
                    </tr>
                </tbody>
            </table>
          </div>
          <div class="" v-else style="padding-top: 0,75rem;padding-left:0.4rem;font-style: italic;font-size:16px">
            This equipment has no item
          </div>
        </div>
           <!-- dien-start -->
        <div v-if="Eitem.length > 9" class="">
          <Page :current="currentPageEquipmentItem" :total="Eitem.length" show-elevator 
            @on-change="(newPageNumber) => {
              currentPage = newPageNumber;
              let start = 10 * (newPageNumber - 1);
              let end = start + 10;
              
              toDisplayEquipmentItem = Eitem.slice(start, end);
            }">
          </Page>
        </div>  
        <!-- dien-end -->
  </div>
    <modal v-model="addPopUp" >
      <simplert :useRadius="true" :useIcon="true" ref="simplert2"></simplert>
      <div slot="header">
        <h3 style="paddingbtn- Add-top:0.5rem; text-transform: uppercase;  font-size: 20px; color: #26a69a">Add Items</h3>
      </div>
      <div style="font-size: 0.9rem">
        <div class="" style="padding-top:0.5rem;">
          <div class="form-field-title">
            <span><strong>  Quantity (required) </strong></span>
          </div>
        <div class="field is-horizontal">
            <input type="text" class="input" placeholder="Quantity" style="margin-right: 1rem" v-model="quantity" v-on:input="() => {
                        if (quantity < 1 || quantity == '') {
                            quantity = 0;
                        } else if (quantity > this.config.numOfAddItem.maximumValue) {
                            quantity = this.config.numOfAddItem.maximumValue;
                        }
                        quantity  = getNumberFormattedThousand(quantity);
                    }" >
            <button type="submit" class="button is-primary is-focused" name="GenerateBarcode" v-on:click="getRandomNumber">Create Serial Number</button>
        </div>
        <div class="field is-horizontal">
          <span v-if="CreateItemErrors.NoQuantity != ''">. <span class="error-text">{{ CreateItemErrors.NoQuantity }}</span></span>
          <span v-if="CreateItemErrors.NoBarcode != ''">. <span class="error-text">{{ CreateItemErrors.NoBarcode }}</span></span>
        </div>
        <div v-show="showingBarcode" style="max-height: 80px; overflow-y: auto">
            <ul>
                <li v-for="(i,index) in randomNumbers" :key="i"> {{index+1}}. {{i}}</li>
            </ul>
        </div>
        <div class="field" style="display: grid; grid-template-columns: 50% 50%">
          <div class="">
              <div class="form-field-title" >
                <span><strong>  Price (required) </strong></span>
              </div>
              <div class="field is-horizontal" style="margin-right:1rem">
                <input type="text" min="50000" style="text-align: right" class="input" placeholder="Price" v-model="form.price" v-on:input="() => {
                        if (form.price < 0 || form.price == '') {
                            form.price = 0;
                        } else if (form.price.length > 14) {
                            form.price  = '99,999,999,999';
                        }
                        form.price  = getNumberFormattedThousand(form.price);
                    }">
                <label style=" margin-top: 0.75rem;margin-left: 0.2rem;">VNĐ</label>
              </div>
                <span v-if="CreateItemErrors.NoPrice != ''">. <span class="error-text">{{ CreateItemErrors.NoPrice }}</span></span>                  
          </div>
          <div >
              <div class="form-field-title">
                <span><strong> Warranty (required) </strong></span>
              </div>
              <div class="field is-horizontal" >
                <input type="text" min="1" style="text-align: right" class="input" placeholder="Warranty Months" v-model="form.warrantyDuration" v-on:input="() => {
                        if (form.warrantyDuration < 1 || form.warrantyDuration == '') {
                            form.warrantyDuration = 0;
                        } else if (form.warrantyDuration > this.config.warrantyMonth.maximumValue) {
                            form.warrantyDuration = this.config.warrantyMonth.maximumValue;
                        }
                        form.warrantyDuration  = getNumberFormattedThousand(form.warrantyDuration);
                    }">
                <label style=" margin-top: 0.75rem;margin-left: 0.2rem;">Month</label>
              </div> 
                <span v-if="CreateItemErrors.NoWarranty != ''">. <span class="error-text">{{ CreateItemErrors.NoWarranty }}</span></span>                  
          </div>
        </div>
        <div class="form-field-title">
          <span><strong>  Location - Warehouse (required) </strong></span>
          <span v-if="CreateItemErrors.NoLocation != ''">. <span class="error-text">{{ CreateItemErrors.NoLocation }}</span></span>
        </div>
        <div>
          <model-select style="width: 100% !important" :options="locationModalSelect" v-model="form.selectedLocation" placeholder="Select a location  "></model-select>  
        </div>
        <div class="form-field-title">
          <span><strong>  Block (required) </strong></span>
          <span v-if="CreateItemErrors.NoBlock != ''">. <span class="error-text">{{ CreateItemErrors.NoBlock }}</span></span>
        </div>
        <div>
          <model-select style="width: 100% !important" :options="blockModalSelect" v-model="form.selectedBlock" placeholder="Select a block  "></model-select>               
        </div>
        <div class="form-field-title">
          <span><strong>  Floor (required) </strong></span>
          <span v-if="CreateItemErrors.NoFloor != ''">. <span class="error-text">{{ CreateItemErrors.NoFloor }}</span></span>
        </div>
        <div>
          <model-select style="width: 100% !important" :options="floorModalSelect" v-model="form.selectedFloor" placeholder="Select a floor  "></model-select>             
        </div>
        <div class="form-field-title">
          <span><strong>  Tile (required) </strong></span>
          <span v-if="CreateItemErrors.NoTile != ''">. <span class="error-text">{{ CreateItemErrors.NoTile }}</span></span>
        </div>
        <div>
        <model-select style="width: 100% !important" :options="tileModalSelect" v-model="form.selectedTile" placeholder="Select a tile  "></model-select>  
        </div>
        </div>
      </div>          
      <div slot="footer">
        <div class="" style="align-items: center; display: flex; justify-content: center;">
          <button class="btn-CancelItem" v-on:click="addPopUp = false">Cancel</button>
          <button id="" class="button is-rounded is-primary" style="border-radius: 8px" v-on:click="createNewEquipentItem">Create New Items</button>  
        </div>
      </div>
    </modal>
    <modal v-model="detailPopUp" :width="580" :closable="false">
      <div v-if="selectedItem!=null" > 
        <simplert :useRadius="true" :useIcon="true" ref="simplert1"></simplert>
        <div slot="header">
            <div class="field" style=" display: grid; grid-template-columns: 85% 15%; height:3rem">
              <div style="margin-top:0.25rem"><strong style="padding-top:0.25rem; margin-top:0.25rem; text-transform: uppercase;  font-size: 18px; color: #26a69a;padding-left: 0.4rem">{{EquimentByID.Name}} - {{selectedItem.Item.SerialNumber}}</strong></div>
              <div class="" style="text-align: right; width: 100%" v-if="authUser.Role=='Equipment Staff' && (currentViewMode == 0 || currentViewMode == 1 || (currentViewMode == 2 && itemLocationID != lostLocation &&currentsttName != workingstt)) ">
                <div style="text-align: right; width: 100%" class="" v-if="!editItemMode"><button class="btn-edit" v-on:click="editItemMode = !editItemMode" style="font-size: 16px;">Edit</button></div>  
              </div>
              <!-- <div class="" v-else><button class="btn-edit" style="color: white; border-bottom: 1px solid black;background-color: #26a69a; border-radius: 5px" disabled="disabled">Edit</button></div>   -->
            </div>
        </div>
        <div style="font-size: 0.9rem; font:roboto; padding-top:0.25rem">  
            <div class="control-mode-item">
                <div class="field is-grouped view-mode" style="">
                    <button class="btn-view-mode-item" :class='{"is-active-item": currentViewMode == viewModes.Details}' v-on:click="setViewMode(viewModes.Details)">Details</button>
                    <button class="btn-view-mode-item" :class='{"is-active-item": currentViewMode == viewModes.Status}' v-on:click="setViewMode(viewModes.Status)">Status</button>
                    <button class="btn-view-mode-item" :class='{"is-active-item": currentViewMode == viewModes.Position}' v-on:click="setViewMode(viewModes.Position)">Position</button>
                    <button class="btn-view-mode-item" :class='{"is-active-item": currentViewMode == viewModes.WorkOrder}' v-on:click="setViewMode(viewModes.WorkOrder)">Working Order</button>
                    <button class="btn-view-mode-item" :class='{"is-active-item": currentViewMode == viewModes.RunTime}' v-on:click="setViewMode(viewModes.RunTime)">Runtime</button>
                </div>
            </div>
            <div class="content-infor">
              <div v-if="currentViewMode ==  viewModes.Details">
                <div  class="">
                  <span v-if="editItemMode"  style="color:red; font-size:14px"> Edit Mode: * is required, please input these fields</span>
                <div class="rowpu" style="height: 36px" >
                  <div class="titleDetail"  >
                      Serial Number:  
                  </div>
                    <input  v-model="selectedItem.Item.SerialNumber" class="input col-7 " type="text" disabled="disabled"> 
                </div>
                <div class="rowpu" style="height: 36px" >
                  <div class="titleDetail"  >
                      Price:  <span v-if="editItemMode" style="color:red; font-size:18px">*</span>
                  </div>
                  <div class="" style="margin-right:1rem; display: grid;grid-template-columns: 85% auto;" >  
                    <div class="">
                      <input v-if="!editItemMode" v-model="selectedItem.Item.Price" class="input col-7 " type="text" disabled="disabled"> 
                      <input v-else v-model="selectedItem.Item.Price" class="input col-7 " type="text" min="50000" v-on:input="() => {
                          if (selectedItem.Item.Price < 0 || selectedItem.Item.Price == '') {
                            selectedItem.Item.Price = 0;
                          } else if (selectedItem.Item.Price.length > 14) {
                              selectedItem.Item.Price  = '99,999,999,999';
                          }
                        selectedItem.Item.Price = getNumberFormattedThousand(selectedItem.Item.Price);
                      }"> 
                    </div>
                    <div class="">
                      <label style=" margin-top: 0.75rem;margin-left: 0.4rem;">VND</label>
                    </div>
                  </div>
                </div>
                <div class="rowpu" style="height: 36px" >
                  <div class="titleDetail" >
                      Warranty:  <span v-if="editItemMode" style="color:red; font-size:18px">*</span>
                  </div>
                  <div class="" style="margin-right:1rem; display: grid;grid-template-columns: 85% auto;" > 
                    <div class="">
                      <input v-if="!editItemMode" v-model="selectedItem.Item.WarrantyDuration" class="input col-7 " type="text" disabled="disabled"> 
                      <input v-else type="text"  class="input" v-model="selectedItem.Item.WarrantyDuration" v-on:input="() => {
                        if (selectedItem.Item.WarrantyDuration < 0 || selectedItem.Item.WarrantyDuration == '') {
                            selectedItem.Item.WarrantyDuration = 0;
                        } else if (selectedItem.Item.WarrantyDuration > this.config.warrantyMonth.maximumValue) {
                            selectedItem.Item.WarrantyDuration = this.config.warrantyMonth.maximumValue;
                        }
                        selectedItem.Item.WarrantyDuration  = getNumberFormattedThousand(selectedItem.Item.WarrantyDuration);
                    }">
                    </div>
                    <div class="">
                      <label style=" margin-top: 0.75rem;margin-left: 0.4rem;">Months</label>
                    </div>
                  </div>
                </div>
                <div class="rowpu" style="height: 36px" >
                  <div class="titleDetail">
                      Warehouse:  <span v-if="editItemMode" style="color:red; font-size:18px">*</span>
                  </div>
                    <input v-if="!editItemMode" v-model="selectedItem.Item.Warehouse" class="input col-7 " type="text" disabled="disabled"> 
                    <div class="select" v-else>
                      <select class="" style="border: 1px #9e9e9e solid; padding-left: 1rem; width:100%"  v-model="selectedItem.Item.WarehouseID">
                                <option :key="'equipmentUnit' + warehouse.Id" v-for="warehouse in warehouseOptions"
                                  :selected="selectedItem.Item.WarehouseID == warehouse.Id "                    
                                  v-bind:value="warehouse.Id">{{warehouse.Name}}</option>
                      </select>
                    </div>
                </div>
                <div class="rowpu" style="height: 36px" >
                  <div class="titleDetail" >
                      Import-Date:  
                  </div>
                    <input  v-model="selectedItem.Item.ImportDate" class="input col-7 " type="text" disabled="disabled"> 
                </div>
                <div class="rowpu" style="height: 36px" >
                  <div class="titleDetail" >
                      Last-MaintainDate:  
                  </div>
                    <input v-model="selectedItem.Item.LastMaintainDate" class="input col-7 " type="text" disabled="disabled">
                </div>
                <div class="rowpu" style="height: 36px" >
                  <div class="titleDetail" >
                      Next-MaintainDate:  
                  </div>
                    <input v-if="!editItemMode" v-model="selectedItem.Item.NextMaintainDate" class="input col-7 " type="text" disabled="disabled"> 
                    <input v-else v-model="selectedItem.Item.NextMaintainDate" class="input col-7 " type="date">
                </div>
                <div class="rowpu" style="margin-left: 0.5rem;margin-top: 0.75rem;margin-right: 1rem; display: grid; grid-template-columns: 40% 50%; width: 100; height:50px" >
                  <div class="titleDetail">
                      Description:  
                  </div>
                    <textarea v-if="!editItemMode" v-model="selectedItem.Item.Description" cols="7" rows="3" disabled="disabled" style="border-style:solid; border-color:#b0bec5; padding-left:0.5rem"> </textarea>
                    <textarea v-else v-model="selectedItem.Item.Description" cols="7" rows="10" style="border-style:solid; border-color:#b0bec5;padding-left:0.5rem"> </textarea>
                </div>
                  <div class="is-horizontal" style="padding-top:0.75rem; padding-bottom: 0.5rem;" v-if="editItemMode" >
                  <button class="btn-CancelItem" v-on:click="cancelUpdateItem">Cancel</button>
                  <button class="btn-UpdateItem" v-on:click="updateItem">Save changes</button>
                  </div>
                </div>
              </div>
              <div v-if="currentViewMode ==  viewModes.Status">
                <div>
                  <span v-if="editItemMode"  style="color:red; font-size:14px"> Edit Mode * is required, please input these fields</span>
                  <div class="rowpu" style="display: grid; grid-template-columns: 20% 80%;" >
                    <div class="" style="margin-top:0.2rem;margin-left:1.5rem" >
                      Status:  
                    </div>
                    <!-- <div class="" v-if="!editItemMode" ><input v-model="selectedItem.Item.Status" class="input col-7 " type="text" disabled="disabled"></div> -->
                    <div class="" v-if="!editItemMode" style="border: 1px #9e9e9e solid; padding-left: 1rem; width: 100%; height: 100%; padding-top:0.2rem">
                      <select  class=""   v-model="selectedItem.Item.StatusID" disabled="disabled">
                        <option :key="'equipmentItemStatus' + status.Id" v-for="status in statusOptions"
                          :selected="selectedItem.Item.StatusID == status.Id "                    
                          v-bind:value="status.Id">{{status.Name}}</option>
                      </select>
                    </div>
                    <div class="select" v-else>
                      <select  class="" style="border: 1px #9e9e9e solid; width: 100%"  v-model="selectedItem.Item.StatusID">
                        <option :key="'equipmentItemStatus' + status.Id" v-for="status in statusOptions"
                          :selected="selectedItem.Item.StatusID == status.Id "                    
                          v-bind:value="status.Id">{{status.Name}}</option>
                      </select>
                    </div> 
                  </div>
                  <div v-if="editItemMode" class="rowpu" style="display: grid; grid-template-columns: 20% 80%;" >
                    <div class="" style="margin-top:0.2rem;margin-left:1.5rem" >
                        Note:  <span v-if="editItemMode" style="color:red; font-size:18px">*</span>
                    </div>
                    <textarea v-model="changeItemSttDescription" cols="7" rows="3" style="border-style:solid; border-color:#b0bec5;" placeholder="Why do you change into this status?"> </textarea>
                  </div>
                  <div class="is-horizontal" style="padding-top:0.75rem; padding-bottom: 0.5rem;" v-if="editItemMode" >
                    <button class="btn-CancelItem" v-on:click="cancelUpdateItem">Cancel</button>
                    <button class="btn-UpdateItem" v-on:click="changeItemStatus">Save changes</button>
                  </div>
                  <div class="wrap-table" style=" padding-top:0,5rem" v-if="statusHistories && statusHistories.length != 0">
                    <div><h4 style="font-style: italic">Table: Equipment status history</h4></div>
                    <div style="max-height: 350px; overflow-y: auto;">
                      <table class="mytable">
                          <thead>
                            <tr>
                              <th><strong>No.</strong></th>                            
                              <th><strong>From</strong></th>
                              <th><strong>To</strong></th>
                              <th><strong>User</strong></th>
                              <th><strong>Date</strong></th>
                              <th><strong>Note</strong></th>
                            </tr>
                          </thead>  
                          <tbody >
                            <tr v-for="(history, index) in statusHistories" style="font-size=16">
                              <td width=5% style="font-size=14;text-align:center">{{index + 1}}</td>
                              <td width=20% style="font-size=14;">{{history.OldStatus.Name}}</td>    
                              <td width=20% style="font-size=14;">{{history.NewStatus.Name}}</td>  
                              <td width=16% style="font-size=14;">{{history.Fullname}}</td>  
                              <td width=16% style="font-size=14;">{{history.Date}}</td>
                              <td width=23% style="font-size=14;">{{history.Description}}</td>    
                            </tr>
                          </tbody>
                      </table>
                    </div>
                  </div>
                  <div class="" v-else style="padding-top: 0,75rem;font-style: italic">
                    This item has been not change status by someone!
                  </div>
                </div>
              </div>
              <div v-if="currentViewMode ==  viewModes.Position">
                <span v-if="editItemMode && authUser.Role=='Equipment Staff' && selectedItem.Item.StatusID"  style="color:red; font-size:14px"> Edit Mode * is required, please input these fields</span>
                <div class = "" v-if="itemLocationID == lostLocation">
                  <div class="rowpu" style="height: 36px; display: grid; grid-template-columns: 18% 82%;" >
                    <div class="" style="margin-top:0.5rem" >
                        Location: 
                    </div>
                    <div class="">
                      <div class="" ><input v-model="itemLocationID" class="input col-7 " type="text" disabled="disabled"></div>
                    </div>
                  </div>
                  <div class="rowpu" style="height: 36px; display: grid; grid-template-columns: 18% 82%;" >
                    <div class="" style="margin-top:0.5rem" >
                        Address:  
                    </div>
                    <div class="">
                      <div class="" ><input v-model="itemLocationID" class="input col-7 " type="text" disabled="disabled"></div>
                    </div>
                  </div>
                  <div class="rowpu" style="height: 36px; display: grid; grid-template-columns: 18% 82%;" >
                    <div class="" style="margin-top:0.5rem" >
                        Block: 
                    </div>
                    <div class="">
                      <div class=""><input v-model="itemBlockID" class="input col-7 " type="text" disabled="disabled"></div>
                    </div>
                  </div>
                  <div class="rowpu" style="height: 36px; display: grid; grid-template-columns: 18% 82%;" >
                    <div class="" style="margin-top:0.5rem" >
                        Floor:  
                    </div>
                    <div class="">
                      <div class="" ><input v-model="itemFloorID" class="input col-7 " type="text" disabled="disabled"></div>
                    </div>
                  </div>
                  <div class="rowpu" style="height: 36px; display: grid; grid-template-columns: 18% 82%;" >
                    <div class="" style="margin-top:0.5rem" >
                        Tile:  
                    </div>
                    <div class="">
                      <div class=""><input v-model="itemTileID" class="input col-7 " type="text" disabled="disabled"></div>
                    </div>
                  </div>
                </div>
                <div class="" v-else>
                    <div class="rowpu" style="height: 36px; display: grid; grid-template-columns: 18% 82%;" >
                      <div class="" style="margin-top:0.25rem;height: 100%" >
                          Location:  <span v-if="editItemMode" style="color:red; font-size:18px">*</span>
                      </div>
                      <div class="">
                        <div v-if="!editItemMode" style="border: 1px #9e9e9e solid; padding-left: 1rem; width: 100%; height: 100%; padding-top:0.4rem">
                          <select  class=""  v-model="selectedItem.Item.LocationID" disabled="disabled">
                            <option style="" :key="'equipmentItemLocation' + location.Id" v-for="location in locationOptions"                   
                              v-bind:value="location.Id">{{location.Name}}</option>
                          </select>
                        </div>
                      <div v-else class="select" style="width: 100%;height:100%">
                        <select  class="" style="border: 1px #9e9e9e solid; padding-left: 1rem; width: 100%;height:100%"  v-model="selectedItem.Item.LocationID">
                          <option style="" :key="'equipmentItemLocation' + location.Id" v-for="location in locationOptions"                   
                            v-bind:value="location.Id">{{location.Name}}</option>
                        </select>
                      </div> 
                      </div>
                    </div>
                  <div class="rowpu" style="height: 36px; display: grid; grid-template-columns: 18% 82%;" >
                    <div class="" style="margin-top:0.25rem" >
                        Address:  
                    </div>
                    <div class="">
                      <div  style="border: 1px #9e9e9e solid; padding-left: 1rem; width: 100%; height: 100%; padding-top:0.4rem" disable="disable">
                          <select  class=""  v-model="selectedItem.Item.LocationID" disabled="disabled">
                            <option style="" :key="'equipmentItemLocation' + location.Id" v-for="location in locationOptions"                   
                              v-bind:value="location.Id">{{location.Address| truncate(53)}}</option>
                          </select>
                        </div>
                    </div>
                  </div>
                  <div class="rowpu" style="height: 36px; display: grid; grid-template-columns: 18% 82%;" >
                    <div class="" style="margin-top:0.25rem" >
                        Block:  <span v-if="editItemMode" style="color:red; font-size:18px">*</span>
                    </div>
                    <div class="">
                      <div v-if="!editItemMode" style="border: 1px #9e9e9e solid; padding-left: 1rem; width: 100%; height: 100%; padding-top:0.4rem">
                        <select  class=""  v-model="selectedItem.Item.BlockID" disabled="disabled">
                            <option :key="'equipmentItemBlock' + block.Id" v-for="block in blockOptions"            
                              v-bind:value="block.Id">{{block.Name}}</option>
                          </select>
                      </div>
                      <div v-else class="select" style="width: 100%;height:100%">
                          <select  class="" style="border: 1px #9e9e9e solid; padding-left: 1rem; width: 100%;height:100%"  v-model="selectedItem.Item.BlockID">
                            <option :key="'equipmentItemBlock' + block.Id" v-for="block in blockOptions"            
                              v-bind:value="block.Id">{{block.Name}}</option>
                          </select>
                      </div>
                    </div>
                  </div>
                  <div class="rowpu" style="height: 36px; display: grid; grid-template-columns: 18% 82%;" >
                    <div class="" style="margin-top:0.25rem" >
                        Floor:  <span v-if="editItemMode" style="color:red; font-size:18px">*</span>
                    </div>
                    <div class="">
                      <div v-if="!editItemMode" style="border: 1px #9e9e9e solid; padding-left: 1rem; width: 100%; height: 100%; padding-top:0.4rem">
                        <select  class=""   v-model="selectedItem.Item.FloorID" disabled="disabled">
                            <option :key="'equipmentItemFloor' + floor.Id" v-for="floor in floorOptions"   
                              :value="floor.Id">{{floor.Name}}
                            </option>
                          </select>
                      </div>
                      <div v-else class="select" style="width: 100%;height:100%">
                          <select  class="" style="border: 1px #9e9e9e solid; padding-left: 1rem; width: 100%;height:100%"  v-model="selectedItem.Item.FloorID">
                            <option :key="'equipmentItemFloor' + floor.Id" v-for="floor in floorOptions"   
                              :value="floor.Id">{{floor.Name}}
                            </option>
                          </select>
                      </div>
                    </div>
                  </div>
                  <div class="rowpu" style="height: 36px; display: grid; grid-template-columns: 18% 82%;" >
                    <div class="" style="margin-top:0.25rem" >
                        Tile:  <span v-if="editItemMode" style="color:red; font-size:18px">*</span>
                    </div>
                      <div class="">
                        <div v-if="!editItemMode" style="border: 1px #9e9e9e solid; padding-left: 1rem; width: 100%; height: 100%; padding-top:0.4rem">
                            <select  class=""   v-model="selectedItem.Item.TileID" disabled="disabled">
                              <option :key="'equipmentItemTile' + tile.Id" v-for="tile in tileOptions" 
                                v-bind:value="tile.Id">{{tile.Name}}</option>
                            </select>
                        </div>
                        <div v-else class="select" style="width: 100%;height:100%">
                            <select  class="" style="border: 1px #9e9e9e solid; padding-left: 1rem; width: 100%;height:100%"  v-model="selectedItem.Item.TileID">
                              <option :key="'equipmentItemTile' + tile.Id" v-for="tile in tileOptions"                 
                                v-bind:value="tile.Id">{{tile.Name}}</option>
                            </select>
                        </div>
                      </div>
                  </div>
                  <div class="is-horizontal" style="padding-top:0.75rem; padding-bottom: 0.5rem;" v-if="editItemMode" >
                    <button class="btn-CancelItem" v-on:click="cancelUpdateItem">Cancel</button>
                    <button  class="btn-UpdateItem" v-on:click="updatePositionItem">Save changes</button>
                  </div>
                </div>
              </div>
              <div v-if="currentViewMode ==  viewModes.WorkOrder">
                <div class="wrap-table"  style="max-height: 300px; overflow-y: auto">
                  <div class="" v-if="allworkorder && allworkorder.length != 0">
                    <div><h4 style="font-style: italic">Table: Equipment working order history</h4></div>
                    <div class="" style="max-height: 350px; overflow-y: auto;">
                      <table class="mytable">
                        <thead>
                            <tr>
                              <th><strong>No.</strong></th>                            
                              <th><strong>Name</strong></th>
                              <th><strong>RequestUser</strong></th>
                              <th><strong>StartDate</strong></th>
                              <th><strong>ClosedDate</strong></th>
                              <th><strong>Status</strong></th>
                            </tr>
                          </thead>  
                          <tbody>
                            <tr v-for="(workorder, index) in allworkorder" style="font-size=16">
                              <td width=3% style="font-size=14;text-align:center">{{index + 1}}</td>    
                              <td width=33% style="font-size=14;">{{workorder.Name | truncate(30)}}</td>    
                              <td width=18% style="font-size=14;">{{workorder.RequestUser}}</td>
                              <td width=17% style="font-size=14;">{{workorder.StartDate}}</td>  
                              <td width=17% style="font-size=14;">{{workorder.Detail[0].ClosedDate ? workorder.Detail[0].ClosedDate : ''}}</td>
                              <td width=14% style="font-size=14;">{{workorder.Status}}</td>     
                            </tr>
                          </tbody>
                      </table>
                    </div>
                  </div>
                  <div class="" v-else style="font-style: italic;">
                    <h3>This item has no work order</h3>
                  </div> 
                </div>  
              </div>
              <div v-else-if="currentViewMode ==  viewModes.RunTime">
                <div class="">
                  <div class="rowpu" style="height: 36px" >
                    <div class="" style="margin-top:0.5rem;margin-left: 4.5rem" >
                        Import-Date:  
                    </div>
                    <div class="" style="margin-right:1rem; display: grid;grid-template-columns: 75% auto;">  
                      <input  v-model="selectedItem.Item.ImportDate" class="input col-7 " type="text" disabled="disabled"> 
                    </div>
                  </div>
                  <div class="rowpu" style="height: 36px" >
                    <div class="" style="margin-top:0.5rem;margin-left: 4.5rem" >
                        Run-times:  
                    </div>
                    <div class="" style="margin-right:1rem; display: grid;grid-template-columns: 75% auto;" >  
                      <input  v-model="selectedItem.Item.RuntimeDays" class="input col-7 " type="text" disabled="disabled"> 
                      <label style=" margin-top: 0.75rem;margin-left: 0.2rem;">Day(s)</label> 
                    </div>
                  </div>
                  <div class="rowpu" style="height: 36px" >
                    <div class="" style="margin-top:0.5rem;margin-left: 4.5rem" >
                        Performance:  
                    </div>
                    <div class="" style="margin-right:1rem; display: grid;grid-template-columns: 75% auto;">  
                      <input  v-model="percentRuntime" class="input col-7 " type="text" disabled="disabled">
                      <label style=" margin-top: 0.75rem;margin-left: 0.2rem;">%</label> 
                    </div>
                  </div>
                  <div class="rowpu" style="height: 36px" >
                    <div class="" style="margin-top:0.5rem;margin-left: 4.5rem" >
                        Downtime:  
                    </div>
                    <div class="" style="margin-right:1rem; display: grid;grid-template-columns: 75% auto;">  
                      <input  v-model="downtime" class="input col-7 " type="text" disabled="disabled">
                      <label style=" margin-top: 0.75rem;margin-left: 0.2rem;">Day(s)</label>  
                    </div>
                  </div>
                  <div class="" v-if="allMaintainWorkorder && allMaintainWorkorder.length != 0">
                    <div><h4 style="font-style: italic">Table: Equipment maintaining order history</h4></div>
                    <div class="" style="max-height: 350px; overflow-y: auto;">
                      <table class="mytable">
                        <thead>
                            <tr>
                              <th><strong>No.</strong></th>                            
                              <th><strong>Name</strong></th>
                              <th><strong>Maintainer</strong></th>
                              <th><strong>StartDate</strong></th>
                              <th><strong>ClosedDate</strong></th>
                              <th><strong>Cost</strong></th>
                            </tr>
                          </thead>  
                          <tbody>
                            <tr v-for="(workorder, index) in allMaintainWorkorder" style="font-size=16">
                              <td width=3% style="font-size=14;text-align:center">{{index + 1}}</td>    
                              <td width=33% style="font-size=14;">{{workorder.Name | truncate(30)}}</td>    
                              <td width=18% style="font-size=14;">{{workorder.RequestUser}}</td>
                              <td width=17% style="font-size=14;">{{workorder.StartDate}}</td>  
                              <td width=17% style="font-size=14;">{{workorder.Detail[0].ClosedDate ? workorder.Detail[0].ClosedDate : ''}}</td>
                              <td width=14% style="font-size=14;">{{workorder.Detail[0].Cost >= 0 ? getNumberFormattedThousand(workorder.Detail[0].Cost) : 'Maintaining'}}</td>     
                            </tr>
                          </tbody>
                      </table>
                    </div>
                  </div>
                  <div class="" v-else style="font-style: italic;">
                    <h3>This item has no maintaining work order</h3>
                  </div> 
                </div>
              </div>
            </div>  
        </div>
      </div>  
      <div slot="footer">
        </div>
    </modal>
    <modal v-model="changePositonLost">
      <div slot="header">
        <h2>Select position for item</h2>
      </div>
        <div style="font-size: 0.9rem">
          <div class="" style="padding-top:0.5rem;">
            <div class="form-field-title">
              <span><strong>  Location (required) </strong></span>
              <span v-if="CreateItemErrors.NoLocation != ''">. <span class="error-text">{{ CreateItemErrors.NoLocation }}</span></span>
            </div>
            <div>
              <model-select style="width: 100% !important" :options="locationModalSelect" v-model="form.selectedLocation" placeholder="Select a location  "></model-select>  
            </div>
            <div class="form-field-title">
              <span><strong>  Block (required) </strong></span>
              <span v-if="CreateItemErrors.NoBlock != ''">. <span class="error-text">{{ CreateItemErrors.NoBlock }}</span></span>
            </div>
            <div>
              <model-select style="width: 100% !important" :options="blockModalSelect" v-model="form.selectedBlock" placeholder="Select a block  "></model-select>               
            </div>
            <div class="form-field-title">
              <span><strong>  Floor (required) </strong></span>
              <span v-if="CreateItemErrors.NoFloor != ''">. <span class="error-text">{{ CreateItemErrors.NoFloor }}</span></span>
            </div>
            <div>
              <model-select style="width: 100% !important" :options="floorModalSelect" v-model="form.selectedFloor" placeholder="Select a floor  "></model-select>             
            </div>
            <div class="form-field-title">
              <span><strong>  Tile (required) </strong></span>
              <span v-if="CreateItemErrors.NoTile != ''">. <span class="error-text">{{ CreateItemErrors.NoTile }}</span></span>
            </div>
            <div>
              <model-select style="width: 100% !important" :options="tileModalSelect" v-model="form.selectedTile" placeholder="Select a tile  "></model-select>  
            </div>
          </div>
        </div> 
      <div slot="footer" style="display: relative; align-items: right; justify-content: right;">
        <simplert :useRadius="true" :useIcon="true" ref="simplert3"></simplert>
        <button class="btn-CancelItem" v-on:click="cancelPositionEQTLost">Cancel</button>
        <button  class="btn-UpdateItem" v-on:click="updatePositionEQTLost">Save changes</button>
      </div>
    </modal>
  
</div>  
</template>

<script>
import { ModelSelect } from "vue-search-select";
// import jsbarcode from "./JsBarcode.all.min.js"
import "vodal/common.css";
import "vodal/slide-up.css";
import EquipmentDetailPopup from "./EquipmentDetailPopup";
import Vodal from "vodal";
import moment from "moment";
import Utils from "@/utils.js";
import Simplert from "vue2-simplert";
import numeral from "numeral";
import { sync } from "vuex-pathify";
export default {
  // name: "ConditionalModal",

  components: {
    Simplert,
    ModelSelect,
    Vodal,
    EquipmentDetailPopup
    // jsbarcode
  },
  async created() {
    await this.getEquipmentDetail();
    this.getAllItemOfEquipment();
    this.axios
      .get("http://localhost:3000/api/vendor")
      .then(response => {
        let data = response.data;
        data.forEach(vendor => {
          if (vendor.Status) {
            this.vendorOptions.push(vendor);
          }
          if (!vendor.Status && vendor.Id == this.equipmentVendorId) {
            this.vendorOptions.push(vendor);
          }
        });
      })
      .catch(error => {
        alert(error);
      });
    this.axios
      .get("http://localhost:3000/api/location/warehouse")
      .then(response => {
        let data = response.data;
        data.forEach(warehouse => {
          if (warehouse.IsActive) {
            this.warehouseOptions.push(warehouse);
          }
          // let option = {
          //   text: vendor.BusinessName,
          //   value: vendor.Id
          // };
          // alert(this.vendorOptions.length);
        });
      })
      .catch(error => {
        alert(error);
      });

    this.axios
      .get("http://localhost:3000/api/EquipmentCategory/getAllCate")
      .then(response => {
        let data = response.data;
        data.forEach(category => {
          if (category.Status) {
            this.categoryOptions.push(category);
          }
          if (!category.Status && category.Id == this.equipmentCategoryId) {
            this.categoryOptions.push(category);
          }
        });
      })
      .catch(error => {
        alert(error);
      });
    this.axios
      .get("http://localhost:3000/api/maintenanceDuration")
      .then(response => {
        let data = response.data;
        data.forEach(maintenanceDuration => {
          this.maintenanceDurationOptions.push(maintenanceDuration);
          // alert(this.maintenanceDurationOptions.length)
        });
      })
      .catch(error => {
        alert(error);
      });
    this.axios
      .get("http://localhost:3000/api/location")
      .then(response => {
        let data = response.data;
        data.forEach(location => {
          if (location.IsActive) {
            this.locationOptions.push(location);
          }
          // let option = {
          //   text: location.Name,
          //   value: location.Id
          // };
        });
      })
      .catch(error => {
        alert(error);
      });
    this.axios
      .get("http://localhost:3000/api/unit")
      .then(response => {
        let data = response.data;
        data.forEach(unit => {
          // let option = {
          //   text: unit.Name,
          //   value: unit.Id
          // };
          this.unitOptions.push(unit);
        });
      })
      .catch(error => {
        alert(error);
      });
    this.axios
      .get("http://localhost:3000/api/EquipmentStatus")
      .then(response => {
        let data = response.data;
        data.forEach(status => {
          this.statusOptions.push(status);
        });
      })
      .catch(error => {
        alert(error);
      });
    this.axios
      .get("http://localhost:3000/api/equipmentItem/allserialnumber")
      .then(response => {
        let data = response.data;
        data.forEach(serialnumber => {
          this.serialNumbers.push(serialnumber);
        });
      })
      .catch(error => {
        alert(error);
      });
    //GET LOcation to import model-select
    this.axios
      .get("http://localhost:3000/api/location/warehouse")
      .then(response => {
        let data = response.data;
        data.forEach(location => {
          if (location.IsActive) {
            let option = {
              text: location.Name,
              value: location.Id
            };
            this.locationModalSelect.push(option);
          }
        });
      })
      .catch(error => {
        alert(error);
      });
    let URL = "http://localhost:3000/api/equipment";
    this.axios
      .get(URL)
      .then(response => {
        let data = response.data;
        // alert('in');
        data.forEach(element => {
          let equipment = element.Equipment;
          this.equipments.push(equipment);
        });
      })
      .catch(error => {
        console.log(error);
      });
  },
  // data() {
  //   return {
  //     JsBarcode("#code128", "Hi!");

  // },
  computed: {
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    },
    config: sync("config")
  },
  data() {
    return {
      newStatus: "",
      currentPageEquipmentItem: 1,
      toDisplayEquipmentItem: [],
      equipments: [],
      Eitem: [],
      CreateItemErrors: {
        NoQuantity: "",
        NoPrice: "",
        NoWarranty: "",
        NoLocation: "",
        NoBlock: "",
        NoFloor: "",
        NoTile: "",
        NoBarcode: ""
      },
      ErrorStrings: {
        NoQuantity: "Quantity must be from 1 to 50",
        NoPrice: "Price must be more than 50,000",
        NoWarranty: "Warranty duration must be bigger than 1",
        NoLocation: "Please choose location",
        NoBlock: "Please choose block",
        NoFloor: "Please choose floor",
        NoTile: "Please choose tile for item(s)",
        NoBarcode: "Please create serial number for item(s)"
      },
      lostTile: "Undefined",
      lostFloor: "Undefined",
      lostBlock: "Undefined",
      lostLocation: "Undefined",
      lostAddress: "Undefined",
      workingstt: "Working",
      maintainstt: "Maintaining",
      showingBarcode: false,
      changeItemSttDescription: "",
      show: false,
      addPopUp: false,
      changePositonLost: false,
      addItemMode: false,
      detailPopUp: false,
      selectedItem: null,
      itemId: "",
      workOrder: null,
      EquimentByID: null,
      equipmentId: "",
      quality: 0,
      updateNumber: 0,
      downtime: 0,
      totalExistDays: 0,
      percentRuntime: 0,
      lastWorkedDate: "",
      Items: [],
      files: "",
      imageUrl: "",
      quantity: 1,
      editMode: false,
      editItemMode: false,
      equipmentName: "",
      equipmentDescription: "",
      equipmentMadein: "",
      equipmentVendorId: "",
      equipmentCategoryId: "",
      equipmentUnitId: "",
      statusOptions: [],
      randomNumbers: [],
      statusHistories: [],
      allworkorder: [],
      allMaintainWorkorder: [],
      tiles: [],
      serialNumbers: [],
      oldstt: "",
      currentsttName: "",
      currentsttId: "",
      selectedStatus: {
        text: "",
        value: ""
      },
      selectedLocation: {
        text: "",
        value: ""
      },
      locationModalSelect: [],
      locationOptions: [],
      selectedBlock: {
        text: "",
        value: ""
      },
      blockModalSelect: [],
      blockOptions: [],
      selectedFloor: {
        text: "",
        value: ""
      },
      floorModalSelect: [],
      floorOptions: [],
      selectedTile: {
        text: "",
        value: ""
      },
      tileModalSelect: [],
      tileOptions: [],
      vendorOptions: [],
      selectedVendor: {
        text: "",
        value: ""
      },
      categoryOptions: [],
      selectedCategory: {
        text: "",
        value: ""
      },
      unitOptions: [],
      selectedUnit: {
        text: "",
        value: ""
      },
      warehouseOptions: [],
      maintenanceDurationOptions: [],
      form: {
        warrantyDuration: 1,
        price: 50000,
        description: "",
        selectedLocation: {
          text: "",
          value: ""
        },
        selectedBlock: {
          text: "",
          value: ""
        },
        selectedFloor: {
          text: "",
          value: ""
        },
        selectedTile: {
          text: "",
          value: ""
        }
      },
      currentViewMode: 0,
      viewModes: {
        Details: 0,
        Status: 1,
        Position: 2,
        WorkOrder: 3,
        RunTime: 4
      },
      itemPrice: "",
      itemDescription: "",
      itemWarranty: "",
      itemWarehouse: "",
      itemNextMaintainDate: "",
      itemLocationID: "",
      itemBlockID: "",
      itemFloorID: "",
      itemTileID: ""
    };
  },
  methods: {
    async getEquipmentDetail() {
      this.equipmentId = this.$route.params.id;
      return await this.axios
        .get("http://localhost:3000/api/equipment/" + this.equipmentId)
        .then(response => {
          let data = response.data;
          data.forEach(element => {
            this.EquimentByID = element.Equipment;
            this.equipmentName = this.EquimentByID.Name;
            this.equipmentDescription = this.EquimentByID.Description;
            this.equipmentMadein = this.EquimentByID.MadeIn;
            this.equipmentVendorId = this.EquimentByID.VendorId;
            this.equipmentCategoryId = this.EquimentByID.CategoryId;
            this.equipmentUnitId = this.EquimentByID.UnitID;
            this.newStatus = this.EquimentByID.Status;
          });
        });
    },
    getAllItemOfEquipment() {
      this.axios
        .get("http://localhost:3000/api/equipmentItem/" + this.equipmentId)
        .then(response => {
          this.Items = [];
          let data = response.data;
          this.Eitem = data;
          this.toDisplayEquipmentItem = this.Eitem.slice(0, 10);
          data.forEach(element => {
            this.Items.push(element);
            // this.totalRuntime = element.RuntimeDays + this.totalRuntime;
          });
        })
        .catch(error => {
          console.log(error);
        });
    },
    getNumberFormattedThousand(str) {
      let value = numeral(str).value();
      return numeral(value).format("0,0");
    },
    myParseInt(string) {
      return numeral(string).value();
    },
    cancelUpdateEquipment() {
      this.editMode = !this.editMode;
      this.EquimentByID.Name = this.equipmentName;
      this.EquimentByID.VendorId = this.equipmentVendorId;
      this.EquimentByID.MadeIn = this.equipmentMadein;
      this.EquimentByID.CategoryId = this.equipmentCategoryId;
      this.EquimentByID.UnitID = this.equipmentUnitId;
      this.EquimentByID.Description = this.equipmentDescription;
      this.EquimentByID.Status = this.newStatus;
      this.files = [];
    },
    cancelUpdateItem() {
      this.editItemMode = false;
      this.selectedItem.Item.Price = this.itemPrice;
      this.selectedItem.Item.Description = this.itemDescription;
      this.selectedItem.Item.WarehouseID = this.itemWarehouse;
      this.selectedItem.Item.WarrantyDuration = this.itemWarranty;
      this.selectedItem.Item.NextMaintainDate = this.itemNextMaintainDate;
      this.selectedItem.Item.LocationID = this.itemLocationID;
      this.selectedItem.Item.BlockID = this.itemBlockID;
      this.selectedItem.Item.FloorID = this.itemFloorID;
      this.selectedItem.Item.TileID = this.itemTileID;
      this.selectedItem.Item.StatusID = this.oldstt;
      this.changeItemSttDescription = "";
    },
    cancelUpdatePosition() {
      this.editItemMode = false;
      this.selectedItem.Item.LocationID = this.itemLocationID;
      this.selectedItem.Item.BlockID = this.itemBlockID;
      this.selectedItem.Item.FloorID = this.itemFloorID;
      this.selectedItem.Item.TileID = this.itemTileID;
      this.cancelUpdateItem();
      this.cancelChangeStatus();
      // alert(this.itemTileID);
      // alert(this.selectedItem.Item.TileID);
    },
    cancelChangeStatus() {
      this.editItemMode = false;
      this.changeItemSttDescription = "";
      this.cancelUpdatePosition();
      this.cancelUpdateItem();
    },
    cancelPositionEQTLost() {
      this.changePositonLost = false;
    },
    setViewMode(mode) {
      this.currentViewMode = mode;
    },
    async createNewEquipentItem() {
      let context = this;
      if (this.quantity === "" || this.quantity < 1 || this.quantity > 50) {
        this.CreateItemErrors.NoQuantity = this.ErrorStrings.NoQuantity;
      }
      if (this.form.price === "" || this.form.price < 50000) {
        this.CreateItemErrors.NoPrice = this.ErrorStrings.NoPrice;
      }
      if (this.form.warrantyDuration === "" || this.form.warrantyDuration < 1) {
        this.CreateItemErrors.NoWarranty = this.ErrorStrings.NoWarranty;
      }
      if (this.randomNumbers.length != this.quantity) {
        this.CreateItemErrors.NoBarcode = this.ErrorStrings.NoBarcode;
      }
      if (this.form.selectedLocation.value === "") {
        this.CreateItemErrors.NoLocation = this.ErrorStrings.NoLocation;
      }
      if (this.form.selectedBlock.value === "") {
        this.CreateItemErrors.NoBlock = this.ErrorStrings.NoBlock;
      }
      if (this.form.selectedFloor.value === "") {
        this.CreateItemErrors.NoFloor = this.ErrorStrings.NoFloor;
      }
      if (this.form.selectedTile.value === "") {
        this.CreateItemErrors.NoTile = this.ErrorStrings.NoTile;
      }
      if (
        this.CreateItemErrors.NoPrice === "" &&
        this.CreateItemErrors.NoWarranty === "" &&
        this.CreateItemErrors.NoBarcode === "" &&
        this.CreateItemErrors.NoLocation === "" &&
        this.CreateItemErrors.NoBlock === "" &&
        this.CreateItemErrors.NoFloor === "" &&
        this.CreateItemErrors.NoTile === "" &&
        this.CreateItemErrors.NoQuantity === ""
      ) {
        let result = 0;
        for (const number of this.randomNumbers) {
          let date =
            moment().valueOf() +
            this.EquimentByID.MaintenanceDuration.Months *
              30 *
              24 *
              3600 *
              1000;
              //moment(date).format("YYYY-MM-DD hh:mm:ss")
          await this.axios.post(
            "http://localhost:3000/api/equipmentItem",
            {
              equipmentID: this.EquimentByID.Id,
              serialNumber: number,
              warehoueid: this.form.selectedLocation.value,
              warrantyDuration: this.form.warrantyDuration,
              price: numeral(this.form.price).value(),
              statusId: 1,
              nextmaintaindate: moment(date).format("YYYY-MM-DD"),
              description: "No description",
              tileID: this.form.selectedTile.value
            }
          ).then(async res => {
            if (res.status == 200) {
              result = result + 1;
            }
          }).catch(error => {
            console.log(error);
            result = result - 1;
          });          
        }
        if (result == this.quantity) {
          let obj = {
            title: "Successfully!!!",
            message: "Create new " + context.quantity + " item(s) successfully",
            type: "success",
            showXclose: true,
            hideAllButton: false,
            onClose: function () {
              context.addPopUp = !context.addPopUp;
              context.getAllItemOfEquipment();
            },
          };
          context.$refs.simplert2.openSimplert(obj);          
        } else {
          alert("Add failed");
        }
      }
    },
    getRandomNumber() {
      if (this.form.Category == "") {
        alert("Please choose category");
      } else if (this.quantity === "") {
        let obj = {
          message: "You must enter quantity",
          type: "warning"
        };
        this.$refs.simplert.openSimplert(obj);
      } else if (this.quantity < 1 || this.quantity > 50) {
        let obj = {
          message: "Quantity must be from 1 to 50",
          type: "warning"
        };
        this.$refs.simplert.openSimplert(obj);
      } else {
        this.randomNumbers = [];
        for (var i = 0; i < this.quantity; i++) {
          var number = "";
          if (
            0 < this.EquimentByID.CategoryId &&
            this.EquimentByID.CategoryId < 10
          ) {
            number = "00" + this.EquimentByID.CategoryId;
          } else if (
            10 <= this.EquimentByID.CategoryId &&
            this.EquimentByID.CategoryId < 100
          ) {
            number = "0" + this.EquimentByID.CategoryId;
          } else if (
            100 <= this.EquimentByID.CategoryId &&
            this.EquimentByID.CategoryId < 1000
          ) {
            number = this.EquimentByID.CategoryId;
          } else {
            number = "000";
          }
          if (0 < this.EquimentByID.Id && this.EquimentByID.Id < 10) {
            number = number + "000" + this.EquimentByID.Id;
          } else if (10 <= this.EquimentByID.Id && this.EquimentByID.Id < 100) {
            number = number + "00" + this.EquimentByID.Id;
          } else if (
            100 <= this.EquimentByID.Id &&
            this.EquimentByID.Id < 1000
          ) {
            number = number + "0" + this.EquimentByID.Id;
          } else if (
            1000 <= this.EquimentByID.Id &&
            this.EquimentByID.Id < 10000
          ) {
            number = number + "" + this.EquimentByID.Id;
          } else {
            number = number + "0000";
          }
          var exist = 0;
          number = number + Math.floor(Math.random() * 900000 + 100000);
          for (var j = 0; j < this.serialNumbers.length; j++) {
            if (number == this.serialNumbers[i]) {
              exist = exist + 1;
            }
          }
          for (var k = 0; k < this.randomNumbers.length; k++) {
            if (number == this.randomNumbers[k]) {
              exist = exist + 1;
            }
          }
          if (exist == 0) {
            this.randomNumbers.push(number);
          } else {
            i = i - 1;
          }
        }
        this.showingBarcode = true;
      }
    },
    setSelectedItem(itemId) {
      this.axios
        .get("http://localhost:3000/api/equipmentItem/sttItem/" + itemId)
        .then(response => {
          let data = response.data;
          this.currentsttId = data.Id;
          this.currentsttName = data.Name;
          if (this.currentsttName.toUpperCase() != "LOST") {
            this.axios
              .get("http://localhost:3000/api/equipmentItem/Item/" + itemId)
              .then(response => {
                if (this.editMode == true) {
                  this.editMode = false;
                }
                this.detailPopUp = true;
                this.selectedItem = response.data;
                this.itemPrice = this.selectedItem.Item.Price;
                this.selectedItem.Item.Price = this.getNumberFormattedThousand(
                  this.selectedItem.Item.Price
                );
                this.itemDescription = this.selectedItem.Item.Description;
                this.itemWarehouse = this.selectedItem.Item.WarehouseID;
                this.itemWarranty = this.selectedItem.Item.WarrantyDuration;
                this.itemNextMaintainDate = this.selectedItem.Item.NextMaintainDate;
                this.itemLocationID = this.selectedItem.Item.LocationID;
                this.itemBlockID = this.selectedItem.Item.BlockID;
                this.itemFloorID = this.selectedItem.Item.FloorID;
                this.itemTileID = this.selectedItem.Item.TileID;
                this.oldstt = this.selectedItem.Item.StatusID;
                this.statusHistories = [];
                this.allworkorder = [];
                this.allMaintainWorkorder = [];
                this.lastWorkedDate = "";
                this.downtime = 0;
                this.percentRuntime = 0;
                this.totalExistDays = Math.abs(
                  moment().valueOf() -
                    moment(this.selectedItem.Item.ImportDate).valueOf()
                );
                this.totalExistDays = Math.floor(
                  this.totalExistDays / (1000 * 3600 * 24)
                );
                if (this.totalExistDays == 0) {
                  this.totalExistDays = 1;
                }
                this.percentRuntime = (
                  this.selectedItem.Item.RuntimeDays /
                  this.totalExistDays *
                  100
                ).toFixed(3);
                this.downtime = this.totalExistDays;
                this.axios
                  .get(
                    "http://localhost:3000/api/equipmentItemHistory/" + itemId
                  )
                  .then(response => {
                    let data = response.data;
                    data.forEach(statusHistory => {
                      this.statusHistories.push(statusHistory);
                    });
                  })
                  .catch(error => {
                    alert(error);
                  });
                this.axios
                  .get(
                    "http://localhost:3000/api/equipmentItem/allworkorder/" +
                      itemId
                  )
                  .then(response => {
                    let data = response.data;
                    data.forEach(workorder => {
                      // alert(workorder.CreateDate);
                      this.allworkorder.push(workorder);
                    });
                  })
                  .catch(error => {
                    alert(error);
                  });
                this.axios
                  .get(
                    "http://localhost:3000/api/equipmentItem/allMaintainWorkorder/" +
                      itemId
                  )
                  .then(response => {
                    let data = response.data;
                    data.forEach(workorder => {
                      // alert(workorder.CreateDate);
                      this.allMaintainWorkorder.push(workorder);
                    });
                  })
                  .catch(error => {
                    alert(error);
                  });
                this.axios
                  .get(
                    "http://localhost:3000/api/equipmentItem/closedate/" +
                      itemId
                  )
                  .then(response => {
                    let data = response.data;
                    data.forEach(closedate => {
                      this.lastWorkedDate = closedate.ClosedDate;
                      this.lastWorkedDate = moment(
                        this.lastWorkedDate
                      ).valueOf();
                      let timeDiff = Math.abs(
                        moment().valueOf() - this.lastWorkedDate
                      );
                      this.downtime = Math.floor(timeDiff / (1000 * 3600 * 24));
                    });
                  })
                  .catch(error => {
                    alert(error);
                  });
              })
              .catch(error => {
                console.log(error);
              });
          } else {
            this.axios
              .get(
                "http://localhost:3000/api/equipmentItem/Itemloststt/" + itemId
              )
              .then(response => {
                if (this.editMode == true) {
                  this.editMode = false;
                }
                this.detailPopUp = true;
                this.selectedItem = response.data;
                this.itemPrice = this.selectedItem.Item.Price;
                this.itemWarehouse = this.selectedItem.Item.WarehouseID;
                this.itemDescription = this.selectedItem.Item.Description;
                this.itemWarranty = this.selectedItem.Item.WarrantyDuration;
                this.itemNextMaintainDate = this.selectedItem.Item.NextMaintainDate;
                this.itemLocationID = this.lostLocation;
                this.itemBlockID = this.lostBlock;
                this.itemFloorID = this.lostFloor;
                this.itemTileID = this.lostTile;
                this.oldstt = this.selectedItem.Item.StatusID;
                this.statusHistories = [];
                this.allworkorder = [];
                this.allMaintainWorkorder = [];
                this.axios
                  .get(
                    "http://localhost:3000/api/equipmentItemHistory/" + itemId
                  )
                  .then(response => {
                    let data = response.data;
                    data.forEach(statusHistory => {
                      this.statusHistories.push(statusHistory);
                    });
                  })
                  .catch(error => {
                    alert(error);
                  });
                this.axios
                  .get(
                    "http://localhost:3000/api/equipmentItem/allworkorder/" +
                      itemId
                  )
                  .then(response => {
                    let data = response.data;
                    data.forEach(workorder => {
                      this.allworkorder.push(workorder);
                    });
                  })
                  .catch(error => {
                    alert(error);
                  });
                this.axios
                  .get(
                    "http://localhost:3000/api/equipmentItem/allMaintainWorkorder/" +
                      itemId
                  )
                  .then(response => {
                    let data = response.data;
                    data.forEach(workorder => {
                      this.allMaintainWorkorder.push(workorder);
                    });
                  })
                  .catch(error => {
                    alert(error);
                  });
              })
              .catch(error => {
                console.log(error);
              });
          }
        })
        .catch(error => {
          alert(error);
        });
    },
    addItem() {
      if (this.editMode == true) {
        this.editMode = false;
      }
      this.addPopUp = true;
      this.addItemMode = !this.addItemMode;
    },

    getFilePath(file) {
      return window.URL.createObjectURL(file);
    },
    inputFileChange() {
      this.files = this.$refs.fileInput.files;
    },
    async updateEquipment() {
      let madeInRegex = /^[^~`!#$%@0-9()\^=\-\[\]\\';,/{}|\\"<>\?]*?$/;
      if (this.EquimentByID.Name.trim().length < 5) {
        let obj = {
          message: "Equipment Name can be contained from 5 to 250 characters",
          type: "warning"
        };
        this.$refs.simplert.openSimplert(obj);
      } else if (this.EquimentByID.MadeIn.trim().length > 50) {
        let obj = {
          message: "MadeIn can be contained 50 characters",
          type: "warning"
        };
        this.$refs.simplert.openSimplert(obj);
      } else if (
        this.EquimentByID.MadeIn.trim().length < 50 &&
        this.EquimentByID.MadeIn.trim() != "" &&
        !madeInRegex.test(this.EquimentByID.MadeIn.trim())
      ) {
        let obj = {
          message: "MadeIn can not contain special character and number",
          type: "warning"
        };
        this.$refs.simplert.openSimplert(obj);
      } else if (
        this.EquimentByID.Description != null &&
        this.EquimentByID.Description.length > 250
      ) {
        let obj = {
          message: "Description can be contained 250 characters",
          type: "warning"
        };
        this.$refs.simplert.openSimplert(obj);
      } else {
        let numOfArchiveLost = 0;
        if (!this.EquimentByID.Status) {
          for (var i = 0; i < this.toDisplayEquipmentItem.length; i++) {
            if (
              this.toDisplayEquipmentItem[i].Status != "Archived" ||
              this.toDisplayEquipmentItem[i].Status != "Lost"
            ) {
              numOfArchiveLost = numOfArchiveLost + 1;
            }
          }
        }
        if (numOfArchiveLost > 0) {
          let obj = {
            message: "Cannot change status to InActive!!!",
            type: "warning"
          };
          this.$refs.simplert.openSimplert(obj);
        } else {
          let existed = 0;
          for (var j = 0; j < this.equipments.length; j++) {
            if (
              this.EquimentByID.Name == this.equipments[j].Name &&
              this.EquimentByID.VendorId == this.equipments[j].VendorId
            ) {
              if (
                this.EquimentByID.Name != this.equipmentName &&
                this.equipmentID.VendorId != this.equipmentVendorId
              ) {
                existed = existed + 1;
              }
            }
          }
          if (existed == 0) {
            this.imageUrl = this.EquimentByID.Image;
            if (this.files[0] && this.files[0].name) {
              let formData = new FormData();
              formData.append("api_key", "982394881563116");
              formData.append("file", this.files[0]);
              formData.append("public_id", this.files[0].name);
              formData.append("timestamp", moment().valueOf());
              formData.append("upload_preset", "ursbvd4a");
              let url =
                "https://api.cloudinary.com/v1_1/dmlopvmdy/image/upload";
              try {
                let uploadRespose = await this.axios.post(url, formData);
                if (uploadRespose.status == 200) {
                  this.imageUrl = uploadRespose.data.url;
                }
              } catch (error) {
                console.log(error);
              }
            }
            // alert(this.selectedCategory.value);
            let context = this;
            context.axios
              .put(
                "http://localhost:3000/api/equipment/" + context.equipmentId,
                {
                  id: context.equipmentId,
                  name: context.EquimentByID.Name,
                  vendorid: context.EquimentByID.VendorId,
                  image: context.imageUrl,
                  madein: context.EquimentByID.MadeIn,
                  categoryid: context.EquimentByID.CategoryId,
                  description: context.EquimentByID.Description,
                  unitid: context.EquimentByID.UnitID,
                  maintenanceDurationid:
                    context.EquimentByID.MaintenanceDurationID,
                  status: context.EquimentByID.Status
                }
              )
              .then(async function() {
                let obj = {
                  message: "Update successfully",
                  type: "success",
                  // hideAllButton: true,
                  showXclose: false
                };
                context.$refs.simplert.openSimplert(obj);
                context.getEquipmentDetail();
                context.editMode = !context.editMode;
              })
              .catch(function(error) {
                console.log(error);
              });
          } else {
            let obj = {
              title: "Existed",
              message:
                "This equipment was supplied by " +
                this.EquimentByID.Vendor.Name,
              type: "warning",
              // hideAllButton: true,
              showXclose: false
            };
            this.$refs.simplert.openSimplert(obj);
          }
        }
      }
    },
    async updatePositionItem() {
      if (this.selectedItem.Item.TileID == null) {
        let obj = {
          message: "Please choose position for this item",
          type: "warning"
        };
        this.$refs.simplert1.openSimplert(obj);
      } else {
        var result = false;
        try {
          let res = await this.axios.put(
            "http://localhost:3000/api/equipmentItem/position/tile/" +
              this.selectedItem.Item.Id,
            {
              tileId: this.selectedItem.Item.TileID
            }
          );
          if (res.status == 200) {
            result = true;
          }
        } catch (error) {
          console.log(error);
          result = false;
        }
        await Utils.sleep(200);
        if (result) {
          let obj = {
            message: "Update successfully",
            type: "success",
            showXclose: false
          };
          this.$refs.simplert1.openSimplert(obj);
          this.updateNumber = this.updateNumber + 1;
          this.editItemMode = !this.editItemMode;
          this.itemLocationID = this.selectedItem.Item.LocationID;
          this.itemBlockID = this.selectedItem.Item.BlockID;
          this.itemFloorID = this.selectedItem.Item.FloorID;
          this.itemTileID = this.selectedItem.Item.TileID;
        } else {
          alert("Update failed");
        }
      }
    },
    async updatePositionEQTLost() {
      let authUser = JSON.parse(window.localStorage.getItem("user"));
      if (this.form.selectedTile.value === "") {
        let obj = {
          message: "Please choose position for this item",
          type: "warning"
        };
        this.$refs.simplert3.openSimplert(obj);
      } else {
        var result = false;
        try {
          let res = await this.axios.put(
            "http://localhost:3000/api/equipmentItem/position/tile/" +
              this.selectedItem.Item.Id,
            {
              tileId: this.form.selectedTile.value
            }
          );
          if (res.status == 200) {
            result = true;
          }
        } catch (error) {
          console.log(error);
          result = false;
        }
        await Utils.sleep(600);
        if (result) {
          var updateSttBool = false;
          try {
            let res = await this.axios.put(
              "http://localhost:3000/api/equipmentItem/status/" +
                this.selectedItem.Item.Id,
              {
                userId: authUser.Id,
                newStatusId: this.selectedItem.Item.StatusID,
                description: this.changeItemSttDescription
              }
            );
            if (res.status == 200) {
              updateSttBool = true;
            }
          } catch (error) {
            console.log(error);
            updateSttBool = false;
          }
          await Utils.sleep(50);
          if (updateSttBool) {
            let obj = {
              message: "Update status successfully",
              type: "success",
              showXclose: false
            };
            this.$refs.simplert3.openSimplert(obj);
            await Utils.sleep(900);
            this.changePositonLost = false;
            this.updateNumber = this.updateNumber + 1;
            this.editItemMode = !this.editItemMode;
            this.setSelectedItem(this.selectedItem.Item.Id);
            this.getAllItemOfEquipment();
          } else {
            alert("Update failed");
          }
        } else {
          alert("Update failed");
        }
      }
    },
    async changeItemStatus() {
      let workingApproved = "Working Approved";
      let working = "Working";
      let maintainanceApproved = "Maintainance Approved";
      let maintaining = "Maintaining";
      let lost = "Lost";
      let statusName = "";
      for (var i = 0; i < this.statusOptions.length; i++) {
        if (this.selectedItem.Item.StatusID == this.statusOptions[i].Id) {
          statusName = this.statusOptions[i].Name; // lay stt hien tai
        }
      }
      let authUser = JSON.parse(window.localStorage.getItem("user"));
      if (this.oldstt == this.selectedItem.Item.StatusID) {
        let obj = {
          message: "Please choose new status to update !!!",
          type: "warning"
        };
        this.$refs.simplert1.openSimplert(obj);
      } else if (
        statusName.toUpperCase() == workingApproved.toUpperCase() ||
        statusName.toUpperCase() == working.toUpperCase() ||
        statusName.toUpperCase() == maintainanceApproved.toUpperCase() ||
        statusName.toUpperCase() == maintaining.toUpperCase()
      ) {
        let obj = {
          message: "Cannot change to " + statusName + " !!!",
          type: "warning"
        };
        this.$refs.simplert1.openSimplert(obj);
      } else if (
        this.currentsttName.toUpperCase() == workingApproved.toUpperCase() ||
        this.currentsttName.toUpperCase() == working.toUpperCase() ||
        this.currentsttName.toUpperCase() ==
          maintainanceApproved.toUpperCase() ||
        this.currentsttName.toUpperCase() == maintaining.toUpperCase()
      ) {
        let obj = {
          message:
            "Cannot change from " + this.currentsttName + " to other status!!!",
          type: "warning"
        };
        this.$refs.simplert1.openSimplert(obj);
      }else if(this.currentsttName == "Lost" && statusName != "Available"){
        let obj = {
          message:
            "Cannot change from " + this.currentsttName + " to " + statusName,
          type: "warning"
        };
        this.$refs.simplert1.openSimplert(obj);
      }else if(this.currentsttName == "Archived" && statusName != "Available"){
        let obj = {
          message:
            "Cannot change from " + this.currentsttName + " to " + statusName,
          type: "warning"
        };
        this.$refs.simplert1.openSimplert(obj);
      } else if (
        this.changeItemSttDescription.trim().length > 250 ||
        this.changeItemSttDescription.trim().length < 5
      ) {
        let obj = {
          message: "Please enter note from 5 to 250 characters !!!",
          type: "warning"
        };
        this.$refs.simplert1.openSimplert(obj);
      } else {
        if (this.currentsttName.toUpperCase() == "LOST") {
          this.changePositonLost = true;
        } else {
          var result = false;
          try {
            let res = await this.axios.put(
              "http://localhost:3000/api/equipmentItem/status/" +
                this.selectedItem.Item.Id,
              {
                userId: authUser.Id,
                newStatusId: this.selectedItem.Item.StatusID,
                description: this.changeItemSttDescription
              }
            );
            if (res.status == 200) {
              result = true;
            }
          } catch (error) {
            console.log(error);
            result = false;
          }
          await Utils.sleep(100);
          if (result) {
            let obj = {
              message: "Update status successfully",
              type: "success",
              showXclose: false
            };
            this.$refs.simplert1.openSimplert(obj);
            this.oldstt = this.selectedItem.Item.StatusID;
            this.changeItemSttDescription = "";
            this.updateNumber = this.updateNumber + 1;
            this.editItemMode = !this.editItemMode;
            this.setSelectedItem(this.selectedItem.Item.Id);
            this.getAllItemOfEquipment();
            // this.currentsttName = this.selectedItem.Item.Status;
            // this.currentsttId = this.this.selectedItem.Item.StatusID;
          } else {
            alert("Update failed");
          }
        }
      }
    },
    async updateItem() {
      // if (this.selectedStatus.value == "") {
      //   alert("Please choose Status for this Item");
      // } else {
      // alert(this.selectedItem.Item.Id);
      let currentdate = moment().valueOf();
      let nextmaintaindate = moment(
        this.selectedItem.Item.NextMaintainDate
      ).valueOf();
      let nextmaintainYear = moment(
        this.selectedItem.Item.NextMaintainDate
      ).format("YYYY");
      let currentyear = moment().format("YYYY");
      if (
        this.selectedItem.Item.Price === "" ||
        this.selectedItem.Item.Price < 50000
      ) {
        let obj = {
          message: "Price must be bigger than 50000!",
          type: "warning"
        };
        this.$refs.simplert1.openSimplert(obj);
      } else if (
        this.selectedItem.Item.WarrantyDuration === "" ||
        this.selectedItem.Item.WarrantyDuration < 1
      ) {
        let obj = {
          message: "Warranty must be bigger than 1",
          type: "warning"
        };
        this.$refs.simplert1.openSimplert(obj);
      } else if (nextmaintaindate < currentdate) {
        let obj = {
          message: "Next maintain date must be BIGGER than current date",
          type: "warning"
        };
        this.$refs.simplert1.openSimplert(obj);
      } else if (
        nextmaintainYear - currentyear >
        this.config.nextMaintainYear.maximumValue
      ) {
        let obj = {
          message: "Next maintain year is invalid",
          type: "warning"
        };
        this.$refs.simplert1.openSimplert(obj);
      } else {
        var result = false;
        try {
          let res = await this.axios.put(
            "http://localhost:3000/api/equipmentItem/" +
              this.selectedItem.Item.Id,
            {
              // id: this.selectedItem.Item.Id,
              warrantyDuration: this.selectedItem.Item.WarrantyDuration,
              warehouseid: this.selectedItem.Item.WarehouseID,
              runtimeDays: this.selectedItem.Item.RuntimeDays,
              price: numeral(this.selectedItem.Item.Price).value(),
              importdate: this.selectedItem.Item.ImportDate,
              lastmaintaindate: this.selectedItem.Item.LastMaintainDate,
              nextmaintaindate: this.selectedItem.Item.NextMaintainDate,
              description: this.selectedItem.Item.Description
            }
          );
          if (res.status == 200) {
            result = true;
          }
        } catch (error) {
          console.log(error);
          result = false;
        }
        await Utils.sleep(100);

        if (result) {
          // alert("Update successfully");
          let obj = {
            message: "Update successfully",
            type: "success"
          };
          this.$refs.simplert1.openSimplert(obj);
          this.updateNumber = this.updateNumber + 1;
          this.editItemMode = !this.editItemMode;
          this.itemPrice = this.selectedItem.Item.Price;
          this.itemDescription = this.selectedItem.Item.Description;
          this.itemWarehouse = this.selectedItem.Item.WarehouseID;
          this.itemWarranty = this.selectedItem.Item.WarrantyDuration;
          this.itemNextMaintainDate = this.selectedItem.Item.NextMaintainDate;
          this.setSelectedItem(this.selectedItem.Item.Id);
          this.getAllItemOfEquipment();
        } else {
          alert("UPdate failed");
        }
        // this.axios
        //   .put(
        //     "http://localhost:3000/api/equipmentItem/" +
        //       this.selectedItem.Item.Id,
        //     {
        //       // id: this.selectedItem.Item.Id,
        //       warrantyDuration: this.selectedItem.Item.WarrantyDuration,
        //       runtimeDays: this.selectedItem.Item.RuntimeDays,
        //       price: this.selectedItem.Item.Price,
        //       importdate: this.selectedItem.Item.ImportDate,
        //       lastmaintaindate: this.selectedItem.Item.LastMaintainDate,
        //       nextmaintaindate: this.selectedItem.Item.NextMaintainDate,
        //       description: this.selectedItem.Item.Description
        //     }
        //   )
        //   .then(function(respone) {
        //     alert("Update successfully");
        //     this.updateNumber = this.updateNumber + 1;
        //     this.setSelectedItem(itemId);
        //   })
        //   .catch(function(error) {
        //     console.log(error);
        //   });
      }
    }
  },
  watch: {
    changePositonLost: function() {
      if (this.changePositonLost == false) {
        this.form.selectedLocation.value = "";
        this.form.selectedLocation.text = "";
        this.locationModalSelect = [];
        this.form.selectedBlock.value = "";
        this.form.selectedBlock.text = "";
        this.blockModalSelect = [];
        this.form.selectedFloor.value = "";
        this.form.selectedFloor.text = "";
        this.floorModalSelect = [];
        this.form.selectedTile.value = "";
        this.form.selectedTile.text = "";
        this.tileModalSelect = [];
      }
      if (this.changePositonLost == true) {
        this.axios
          .get("http://localhost:3000/api/location/warehouse")
          .then(response => {
            let data = response.data;
            data.forEach(location => {
              let option = {
                text: location.Name,
                value: location.Id
              };
              this.locationModalSelect.push(option);
            });
          })
          .catch(error => {
            alert(error);
          });
      }
    },
    addPopUp: function() {
      if (this.addPopUp == false) {
        this.addItemMode = !this.addItemMode;
        this.quantity = 1;
        this.randomNumbers = [];
        this.form.price = 50000;
        this.form.warrantyDuration = 1;
        this.form.selectedLocation.value = "";
        this.form.selectedLocation.text = "";
        this.locationModalSelect = [];
        this.form.selectedBlock.value = "";
        this.form.selectedBlock.text = "";
        this.blockModalSelect = [];
        this.form.selectedFloor.value = "";
        this.form.selectedFloor.text = "";
        this.floorModalSelect = [];
        this.form.selectedTile.value = "";
        this.form.selectedTile.text = "";
        this.tileModalSelect = [];
        // this.form.selectedBlock = "";
        // this.form.selectedFloor = "";
        // this.form.selectedTile = "";
        this.CreateItemErrors.NoQuantity = "";
        this.CreateItemErrors.NoPrice = "";
        this.CreateItemErrors.NoWarranty = "";
        this.CreateItemErrors.NoLocation = "";
        this.CreateItemErrors.NoBlock = "";
        this.CreateItemErrors.NoFloor = "";
        this.CreateItemErrors.NoTile = "";
        this.CreateItemErrors.NoBarcode = "";
      }
      if (this.addPopUp == true) {
        this.locationModalSelect = [];
        this.axios
          .get("http://localhost:3000/api/location/warehouse")
          .then(response => {
            let data = response.data;
            data.forEach(location => {
              let option = {
                text: location.Name,
                value: location.Id
              };
              this.locationModalSelect.push(option);
            });
          })
          .catch(error => {
            alert(error);
          });
      }
    },
    detailPopUp: function() {
      if (this.detailPopUp == false) {
        this.selectedItem.Item.Price = this.selectedItem.Item.Price;
        this.selectedItem.Item.WarehouseID = this.selectedItem.Item.WarehouseID;
        this.selectedItem.Item.NextMaintainDate = this.selectedItem.Item.NextMaintainDate;
        this.selectedItem.Item.Description = this.selectedItem.Item.Description;
        this.selectedItem.Item.StatusID = this.oldstt;
        this.changeItemSttDescription = "";
        if (this.itemLocationID == this.lostLocation) {
        } else {
          this.selectedItem.Item.LocationID = this.itemLocationID;
          this.selectedItem.Item.BlockID = this.itemBlockID;
          this.selectedItem.Item.FloorID = this.itemFloorID;
          this.selectedItem.Item.TileID = this.itemTileID;
        }
        this.currentViewMode = this.viewModes.Details;
        if (this.editItemMode == true) {
          this.editItemMode = false;
        }

        // if (this.updateNumber > 0) {
        //   location.reload();
        // }
      }
    },
    quantity: function() {
      if (
        this.quantity != "" &&
        this.quantity < 50 &&
        this.CreateItemErrors.NoQuantity != ""
      ) {
        this.CreateItemErrors.NoQuantity = "";
      }
    },
    "form.price": function() {
      if (this.form.price >= 50000 && this.CreateItemErrors.NoPrice != "") {
        this.CreateItemErrors.NoPrice = "";
      }
    },
    "form.warrantyDuration": function() {
      if (
        this.form.warrantyDuration > 1 &&
        this.CreateItemErrors.NoWarranty != ""
      ) {
        this.CreateItemErrors.NoWarranty = "";
      }
    },
    randomNumbers: function() {
      if (
        this.randomNumbers.length == this.quantity &&
        this.CreateItemErrors.NoBarcode != ""
      ) {
        this.CreateItemErrors.NoBarcode = "";
      }
    },
    "selectedItem.Item.LocationID": function() {
      // if (this.selectedLocation.value != "") {
      this.blockOptions = [];
      this.floorOptions = [];
      this.tileOptions = [];
      if (this.editItemMode) {
        this.selectedItem.Item.BlockID = null;
      }
      if (this.itemLocationID == this.lostLocation) {
      } else {
        this.axios
          .get(
            `http://localhost:3000/api/block/location/${
              this.selectedItem.Item.LocationID
            }`
          )
          .then(res => {
            if (res.status == 200) {
              let blocks = res.data;
              blocks.forEach(block => {
                // let option = {
                //   value: block.Id,
                //   text: block.Name
                // };
                this.blockOptions.push(block);
              });
            }
          });
      }

      // }
      if (
        this.form.selectedLocation.value != "" &&
        this.CreateItemErrors.NoLocation != ""
      ) {
        this.CreateItemErrors.NoLocation = "";
      }
    },
    "selectedItem.Item.BlockID": function() {
      // if (this.selectedBlock.value != "") {

      if (this.editItemMode && this.selectedItem.Item.BlockID == null) {
        this.selectedItem.Item.FloorID = null;
        this.selectedItem.Item.TileID = null;
      }
      if (this.editItemMode && this.selectedItem.Item.BlockID != null) {
        // this.selectedItem.Item.FloorID = null;
        // this.selectedItem.Item.TileID = null;
        this.floorOptions = [];
        this.tileOptions = [];
        this.selectedItem.Item.FloorID = null;
        this.selectedItem.Item.TileID = null;
      }
      if (this.selectedItem.Item.BlockID != null) {
        this.axios
          .get(
            `http://localhost:3000/api/floor/block/${
              this.selectedItem.Item.BlockID
            }`
          )
          .then(res => {
            if (res.status == 200) {
              let floors = res.data;
              floors.forEach(floor => {
                // let option = {
                //   value: floor.Id,
                //   text: floor.Name
                // };
                this.floorOptions.push(floor);
              });
            }
          });
      }

      if (
        this.form.selectedBlock.value != "" &&
        this.CreateItemErrors.NoBlock != ""
      ) {
        this.CreateItemErrors.NoBlock = "";
      }
    },
    "selectedItem.Item.FloorID": function() {
      // alert(this.selectedFloor.value);
      // if (this.selectedFloor.value != "") {
      // alert(this.tileOptions.length);
      // this.selectedItem.Item.Tile = "";
      if (this.editItemMode && this.selectedItem.Item.FloorID == null) {
        this.selectedItem.Item.TileID = null;
        // this.tileOptions = [];
      }
      if (this.editItemMode && this.selectedItem.Item.FloorID != null) {
        this.tileOptions = [];
        this.selectedItem.Item.TileID = null;
      }
      if (this.selectedItem.Item.FloorID != null) {
        this.axios
          .get(
            `http://localhost:3000/api/tile/floor/${
              this.selectedItem.Item.FloorID
            }`
          )
          .then(res => {
            if (res.status == 200) {
              let tiles = res.data;
              tiles.forEach(tile => {
                // let option = {
                //   value: tile.Id,
                //   text: tile.Name
                // };
                this.tileOptions.push(tile);
              });
            }
          });
        // }
      }

      if (
        this.selectedFloor.value != "" &&
        this.CreateItemErrors.NoFloor != ""
      ) {
        this.CreateItemErrors.NoFloor = "";
      }
    },
    "form.selectedLocation": function() {
      if (this.form.selectedLocation.value != "") {
        this.form.selectedBlock.value = "";
        this.form.selectedBlock.text = "";
        this.form.selectedFloor.value = "";
        this.form.selectedFloor.text = "";
        this.form.selectedTile.value = "";
        this.form.selectedTile.text = "";
        this.blockModalSelect = [];
        this.floorModalSelect = [];
        this.tileModalSelect = [];
        this.axios
          .get(
            `http://localhost:3000/api/block/location/${
              this.form.selectedLocation.value
            }`
          )
          .then(res => {
            if (res.status == 200) {
              let blocks = res.data;
              blocks.forEach(block => {
                let option = {
                  value: block.Id,
                  text: block.Name
                };
                this.blockModalSelect.push(option);
              });
            }
          });
      }
      if (
        this.form.selectedLocation.value != "" &&
        this.CreateItemErrors.NoLocation != ""
      ) {
        this.CreateItemErrors.NoLocation = "";
      }
    },
    "form.selectedBlock": function() {
      if (this.form.selectedBlock.value != "") {
        this.floorModalSelect = [];
        this.tileModalSelect = [];
        this.axios
          .get(
            `http://localhost:3000/api/floor/block/${
              this.form.selectedBlock.value
            }`
          )
          .then(res => {
            if (res.status == 200) {
              let floors = res.data;
              floors.forEach(floor => {
                let option = {
                  value: floor.Id,
                  text: floor.Name
                };
                this.floorModalSelect.push(option);
              });
            }
          });
      }
      if (
        this.form.selectedBlock.value != "" &&
        this.CreateItemErrors.NoBlock != ""
      ) {
        this.CreateItemErrors.NoBlock = "";
      }
    },
    "form.selectedFloor": function() {
      if (this.form.selectedFloor.value != "") {
        this.tileModalSelect = [];
        this.axios
          .get(
            `http://localhost:3000/api/tile/floor/${
              this.form.selectedFloor.value
            }`
          )
          .then(res => {
            if (res.status == 200) {
              let tiles = res.data;
              tiles.forEach(tile => {
                let option = {
                  value: tile.Id,
                  text: tile.Name
                };
                this.tileModalSelect.push(option);
              });
            }
          });
      }
      if (
        this.form.selectedFloor.value != "" &&
        this.CreateItemErrors.NoFloor != ""
      ) {
        this.CreateItemErrors.NoFloor = "";
      }
    },
    "form.selectedTile": function() {
      if (
        this.form.selectedTile.value != "" &&
        this.CreateItemErrors.NoTile != ""
      ) {
        this.CreateItemErrors.NoTile = "";
      }
    }
  }
};
</script>

<style scoped>
/* .th{
  padding: 0.5rem !important;
} */
.btn-edit:hover {
  cursor: pointer;
  color: black;
  border-bottom: 1px solid black;
  /* background-color: #009688; */
}
.btn-edit {
  /* position: relative; */
  /* background-color: var(--primary-color); */
  color: slategray;
  font-size: 16px;
  /* border-radius: 4px; */
  /* margin-left: 0.25rem; */
  width: 100%;
  height: 36px;
}
.btn-Add:hover {
  cursor: pointer;
  color: black;
  border-bottom: 1px solid black;
  /* background-color: #009688; */
}
.is-active-option {
  cursor: pointer;
  color: black;
  border-bottom: 1px solid black;
}
.btn-Add {
  /* position: relative; */
  /* background-color: var(--primary-color); */
  color: slategray;
  font-size: 16px;
  /* border-radius: 8px; */
  /* margin-left: 0.25rem; */
  height: 36px;
  width: 100%;
  /* margin-left: 15px; */
}
.btn-Update:hover {
  cursor: pointer;
  background-color: #009688;
}
.btn-Update {
  position: relative;
  background-color: var(--primary-color);
  color: white;
  font-size: 18px;
  border-radius: 8px;
  /* margin-left: 0.25rem; */
  height: 36px;
  width: 130px;
}
.btn-changeStt {
  position: relative;
  background-color: var(--primary-color);
  color: white;
  font-size: 18px;
  border-radius: 8px;
  height: 36px;
  width: 130px;
}
.btn-changestt:hover {
  cursor: pointer;
  background-color: #009688;
}
.btn-UpdateItem {
  position: relative;
  background-color: var(--primary-color);
  color: white;
  font-size: 18px;
  border-radius: 8px;
  /* margin-left: 0.25rem; */
  height: 36px;
  width: 140px;
  /* margin-left: 10px; */
}
.btn-Cancel:hover {
  cursor: pointer;
  background-color: #9e9e9e;
  /* margin-left: 150px; */
}
.btn-Cancel:hover {
  cursor: pointer;
  background-color: #9e9e9e;
}
.btn-CancelItem {
  background-color: #9e9e9e;
  color: white;
  font-size: 18px;
  border-radius: 8px;
  /* margin-left: 0.25rem; */
  height: 36px;
  width: 140px;
  margin-right: 5%;
  margin-left: 30px;
}
.btn-Cancel {
  /* position: relative; */
  background-color: #9e9e9e;
  color: white;
  font-size: 18px;
  border-radius: 8px;
  /* margin-left: 0.25rem; */
  height: 36px;
  width: 100px;
  margin-right: 5%;
  margin-left: 2rem;
}
.row {
  /* margin-left: 0.1rem; */
  margin-top: 0.75rem;
  margin-right: 0.2rem;
  display: grid;
  grid-template-columns: 18% 82%;
}

.rowpu {
  margin-left: 0.5rem;
  margin-top: 0.5rem;
  margin-right: 1rem;
  display: grid;
  grid-template-columns: 40% 50%;
}
.rowstt {
  margin-left: 0.5rem;
  margin-top: 0.75rem;
  display: grid;
  grid-template-columns: 18% 55% 32%;
}
table {
  /* border: 1px solid black; */
  width: 100%;
  font-size: 14px;
  /* text-align: left; */
}

th {
  text-align: left;
  background-color: #cfd8dc;
  height: 30px;
  line-height: 30px;
  padding: 0rem 0rem 0.75rem 0.35rem !important;
}

td {
  text-align: left;
  vertical-align: middle !important;
  height: 25px;
  line-height: 25px;
  padding: 0rem 0rem 0.5rem 0.35rem !important;
  /* text-align: justify; */
}

tr:nth-child(odd) {
  background-color: white;
  color: #263238;
}

tr:nth-child(even) {
  background-color: #f5f5f5e8;
  color: #263238;
}

#th1:curve {
  text-align: justify;
  background-color: #b0bec5;
}
tr:hover {
  background-color: #eceff1;
}
.button-up-can {
  height: 36px;
  /* display: grid;
  grid-template-columns: 50% 50%; */
  margin-left: 0.5rem;
  margin-top: 0.75rem;
  margin-right: 1rem;
}
.btn-view-mode-item {
  /* background-color: white;
  color: #9e9e9e;
  z-index: 1;
  font-size: 15.5px;
   border-bottom: 3px white solid; 
  margin: 0.2rem;
  padding: 0.5rem;
  border-radius:4px;
  height: 2.5rem; */
  background-color: white;
  padding: 0.4rem 0.4rem;
  color: #9e9e9e;
  z-index: 1;
  font-size: 17px;
  border-bottom: 3px white solid;
}

.btn-view-mode-item:hover {
  color: #263238;
  cursor: pointer;
}
.is-active-item {
  border-bottom: 3px #26a69a solid;
  cursor: pointer;
  color: var(--primary-color);
}
.control-mode-item {
  background-color: white;
  /* border: 1px  #9e9e9e solid; */
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 8px;
  /* height: 3rem; */
}
.is-horizontal {
  display: flex;
  align-items: center;
  justify-content: center;
}
.wrap-table {
  padding-top: 0.75rem !important;
}
.titleDetail {
  margin-left: 4rem;
  font-size: 16px;
  margin-top: 0.4rem;
}
</style>