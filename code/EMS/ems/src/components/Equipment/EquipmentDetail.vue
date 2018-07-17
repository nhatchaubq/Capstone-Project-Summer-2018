<template>
<div>
  <div style="padding: 0rem 2rem 0rem 1rem">
    <router-link to='/equipment'>
        <a><span class="fa fa-chevron-left"></span> Back </a>
    </router-link>
  </div>
    <div>
        <!-- <h1>{{this.EquimentByID.Name}}</h1> -->
        <div class="field" style=" display: grid; grid-template-columns: 45% 55%; width: 100;">
            <div class="left" style="padding-top:0.5rem; padding-left:1rem ">
                <img :src= "this.EquimentByID.Image" style="width: 400px; height: 350px; ">
            </div>
            <div class="">
              <div class="field" style=" display: grid; grid-template-columns: 70% 20% 10%">
                  <strong style="text-transform: uppercase;  font-size: 20px; color: #26a69a">{{equipmentName}}</strong>
                  <button v-if="!addItemMode" class="btn-Add"   v-on:click="addItem">Add Item</button>
                  <div class="" v-else ><button  class="btn-Add" style="color: white;border-bottom: 1px solid black;background-color: #26a69a;border-radius: 5px" >Add Item</button></div>
                  <button v-if="!editMode" class="btn-edit"  v-on:click="editMode = !editMode">Edit</button> 
                  <div class="" v-else><button class="btn-edit" style="color: white;border-bottom: 1px solid black;background-color: #26a69a;border-radius: 5px" :class="{'is-active-option': editMode}">Edit</button> </div>
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
                <div  class="is-horizontal" style="height:36px; display: grid;grid-template-columns: 40% 60%;" >
                  <div class="" style="padding-top:0.25rem; " >
                      Quantity:  
                  </div>
                  <input v-model="this.Items.length" class="input col-5 " type="text" disabled="disabled"> 
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
              <div  class="row" style="height:36px" >
                  <div class="" style="margin-top:0.5rem" >
                      Description:  
                  </div>
                  <input v-if="!editMode" v-model="this.EquimentByID.Description" class="input col-7 " type="text" disabled="disabled"> 
                  <input v-else v-model="EquimentByID.Description" class="input col-7 " type="text" >
              </div>
              
              <div class="row" style="height:30px" v-if="editMode">
                <div class="" style="margin-top:0.5rem">
                  Picture:
                </div>
                <div class="input_picture">                  
                  <label class="file-label"  > 
                  <span class="file-cta">
                      <input v-if="!editMode" class="file-input" type="file" accept="image/*" style="opacity:0" ref="fileInput"  disabled="disabled" />
                      <input v-else class="file-input" type="file" accept="image/*"  style="opacity: 0" ref="fileInput" v-on:change="inputFileChange" />
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
                <button  class="btn-Update" v-on:click="updateEquipment">Update</button>
              </div>
            </div>       
        </div>
        <div class="equipmentItem" style="padding-top:1rem;">
          <table class="table">
              <thead>
                  <tr>
                      <th><strong>Order #</strong></th>
                      <th><strong>Serial number</strong></th>
                      <th><strong>ImportDate</strong></th>
                      <th><strong>Warranty</strong></th>
                      <th><strong>Runtime</strong></th>
                      <th><strong>Last-MaintainDate</strong></th>
                      <th><strong>Next-MaintainDate</strong></th>
                      <th><strong>Status</strong></th>
                      <th><strong>Description</strong></th>
                  </tr>
              </thead>  
              <tbody>
                  <tr v-bind:key="item.ID" v-for="(item, index) in Items" v-on:click="setSelectedItem(item.ID)">
                      <td>{{ index + 1 }}</td>   
                      <td>{{item.SerialNumber}}</td>
                      <td>{{item.ImportDate}}</td>
                      <td>{{item.WarrantyDuration}}</td>
                      <td>{{item.RuntimeDays}}</td>
                      <td>{{item.LastMaintainDate}}</td>
                      <td>{{item.NextMaintainDate}}</td>
                      <td>{{item.Status}}</td>
                      <td>{{item.Description ? item.Description : 'N/A' }}</td>    
                  </tr>
              </tbody>
          </table>
        </div>
        <modal v-model="addPopUp" >
          <div slot="header">
            <h3 style="paddingbtn- Add-top:0.5rem; text-transform: uppercase;  font-size: 20px; color: #26a69a">Add Items</h3>
          </div>
          <div style="font-size: 0.9rem">
            <div class="" style="padding-top:0.5rem;">
            <div class="form-field-title">
              <span><strong>  Quantity (required) </strong></span>
              
            </div>
            <div class="field is-horizontal">
                <input type="number" min="1" class="input" placeholder="Quantity" style="margin-right: 1rem" v-model="quantity" >
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
                    <input type="number" min="50000" style="text-align: right" class="input" placeholder="Price" v-model="form.price" step="10000">
                    <label style=" margin-top: 0.75rem;margin-left: 0.2rem;">VNĐ</label>
                  </div>
                    <span v-if="CreateItemErrors.NoPrice != ''">. <span class="error-text">{{ CreateItemErrors.NoPrice }}</span></span>                  
              </div>
              <div >
                  <div class="form-field-title">
                   <span><strong> Warranty (required) </strong></span>
                  </div>
                  <div class="field is-horizontal" >
                    <input type="number" min="1" style="text-align: right" class="input" placeholder="Warranty Months" v-model="form.warrantyDuration">
                    <label style=" margin-top: 0.75rem;margin-left: 0.2rem;">Month</label>
                  </div> 
                    <span v-if="CreateItemErrors.NoWarranty != ''">. <span class="error-text">{{ CreateItemErrors.NoWarranty }}</span></span>                  
              </div>
            </div>
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
          <div slot="footer">
            <div class="" style="align-items: center; display: flex; justify-content: center;">
              <button class="btn-CancelItem" v-on:click="addPopUp = false">Cancel</button>
              <button id="" class="button is-rounded is-primary" style="border-radius: 8px" v-on:click="createNewEquipentItem">Create New Items</button>  
            </div>
          </div>
        </modal>
       
        <!-- <vodal class="no-padding" height="600" width="540" :show="selectedItem != null" :closeButton='false' @hide="() => {
                                                                                      selectedItem = null;
                                                                                      editItemMode = false;
                                                                                    }" animation="slideUp"> -->
          <!-- <equipment-detail-popup :equipment="selectedItem" class="" v-show="selectedItem != null"></equipment-detail-popup> -->
      <modal v-model="detailPopUp" >
         <div v-if="selectedItem!=null" > 
          <div slot="header">
              <div class="field" style=" display: grid; grid-template-columns: 10% 75% 10%">
                <i class="material-icons" style="font-size: 2rem;">clear_all</i>
                <strong style="padding-top:0.25rem; text-transform: uppercase;  font-size: 18px; color: #26a69a">{{EquimentByID.Name}} - {{selectedItem.Item.SerialNumber}}</strong>
                <div class="" v-if="!editItemMode"><button class="btn-edit" v-on:click="editItemMode = !editItemMode">Edit</button></div>  
                <div class="" v-else><button class="btn-edit" style="color: white; border-bottom: 1px solid black;background-color: #26a69a; border-radius: 5px" disabled="disabled">Edit</button></div>  
              </div>
          </div>
          <div style="font-size: 0.9rem; font:roboto">  
              <div class="control-mode-item">
                  <div class="field is-grouped view-mode" style="">
                      <button class="btn-view-mode-item" :class='{"is-active-item": currentViewMode == viewModes.Details}' v-on:click="setViewMode(viewModes.Details)">Details</button>
                      <button class="btn-view-mode-item" :class='{"is-active-item": currentViewMode == viewModes.Status}' v-on:click="setViewMode(viewModes.Status)">Status</button>
                      <button class="btn-view-mode-item" :class='{"is-active-item": currentViewMode == viewModes.Position}' v-on:click="setViewMode(viewModes.Position)">Position</button>
                      <button class="btn-view-mode-item" :class='{"is-active-item": currentViewMode == viewModes.WorkOrder}' v-on:click="setViewMode(viewModes.WorkOrder)">Work Order</button>
                      <button class="btn-view-mode-item" :class='{"is-active-item": currentViewMode == viewModes.RunTime}' v-on:click="setViewMode(viewModes.RunTime)">Runtime</button>
                  </div>
              </div>
              <div class="content-infor">
                <div v-if="currentViewMode ==  viewModes.Details">
                  <div  class="">
                    <span v-if="editItemMode"  style="color:red; font-size:14px">* is required, please input these fields</span>
                  <div class="rowpu" style="height: 36px" >
                    <div class="" style="margin-top:0.5rem" >
                        Serial Number:  
                    </div>
                      <input  v-model="selectedItem.Item.SerialNumber" class="input col-7 " type="text" disabled="disabled"> 
                  </div>
                  <div class="rowpu" style="height: 36px" >
                    <div class="" style="margin-top:0.5rem" >
                        Price:  <span v-if="editItemMode" style="color:red; font-size:18px">*</span>
                    </div>
                      <input v-if="!editItemMode" v-model="selectedItem.Item.Price" class="input col-7 " type="text" disabled="disabled"> 
                      <input v-else v-model="selectedItem.Item.Price" class="input col-7 " type="number" min="50000" step="10000"> 
                  </div>
                  <div class="rowpu" style="height: 36px" >
                    <div class="" style="margin-top:0.5rem" >
                        Warranty:  <span v-if="editItemMode" style="color:red; font-size:18px">*</span>
                    </div>
                      <input v-if="!editItemMode" v-model="selectedItem.Item.WarrantyDuration" class="input col-7 " type="text" disabled="disabled"> 
                      <input v-else v-model="selectedItem.Item.WarrantyDuration" class="input col-7 " type="number" min="1"> 
                  </div>
                  <div class="rowpu" style="height: 36px" >
                    <div class="" style="margin-top:0.5rem" >
                        Run-times:  
                    </div>
                      <input  v-model="selectedItem.Item.RuntimeDays" class="input col-7 " type="text" disabled="disabled"> 
                  </div>
                  <div class="rowpu" style="height: 36px" >
                    <div class="" style="margin-top:0.5rem" >
                        Import-Date:  
                    </div>
                      <input  v-model="selectedItem.Item.ImportDate" class="input col-7 " type="text" disabled="disabled"> 
                  </div>
                  <div class="rowpu" style="height: 36px" >
                    <div class="" style="margin-top:0.5rem" >
                        Last-MaintainDate:  
                    </div>
                      <input v-model="selectedItem.Item.LastMaintainDate" class="input col-7 " type="text" disabled="disabled">
                  </div>
                  <div class="rowpu" style="height: 36px" >
                    <div class="" style="margin-top:0.5rem" >
                        Next-MaintainDate:  
                    </div>
                      <input v-if="!editItemMode" v-model="selectedItem.Item.NextMaintainDate" class="input col-7 " type="text" disabled="disabled"> 
                      <input v-else v-model="selectedItem.Item.NextMaintainDate" class="input col-7 " type="date">
                  </div>
                  <div class="rowpu" style="margin-left: 0.5rem;margin-top: 0.75rem;margin-right: 1rem; display: grid; grid-template-columns: 42% 58%; width: 100; height:50px" >
                    <div class="" style="margin-top:0.5rem" >
                        Description:  
                    </div>
                      <textarea v-if="!editItemMode" v-model="selectedItem.Item.Description" cols="7" rows="3" disabled="disabled"> </textarea>
                      <textarea v-else v-model="selectedItem.Item.Description" cols="7" rows="10" style="border-style:solid; border-color:#b0bec5;"> </textarea>
                  </div>
                    <div class="is-horizontal" style="padding-top:0.75rem; padding-bottom: 0.5rem;" v-if="editItemMode" >
                    <button class="btn-CancelItem" v-on:click="cancelUpdateItem">Cancel</button>
                    <button class="btn-UpdateItem" v-on:click="updateItem">Update Item</button>
                    </div>
                  </div>
                </div>
                <div v-if="currentViewMode ==  viewModes.Status">
                  <div>
                    <div class="rowstt" style="height: 36px; padding-bottom = 0.5rem" >
                      <div class="" style="margin-top:0.5rem;" >
                        Status:  
                      </div>
                      <div class="select">
                        <select  class="" style="border: 1px #9e9e9e solid; padding-left: 1rem"  v-model="selectedItem.Item.StatusID">
                          <option :key="'equipmentItemStatus' + status.Id" v-for="status in statusOptions"
                            :selected="selectedItem.Item.StatusID == status.Id "                    
                            v-bind:value="status.Id">{{status.Name}}</option>
                        </select>
                      </div> 
                      <div>
                      <div class="" v-if="!editItemMode"> <button class="" style="background-color: #bdbdbd8f; color: white;font-size: 18px;border-radius: 8px;height: 36px;width: 130px;" disabled="disabled">Change Status</button></div>
                      <div class="" v-else> <button class="btn-changeStt" v-on:click="changeItemStatus">Change Status</button></div>
                      </div>
                    </div>
                    <div class="rowpu" style="display: grid; grid-template-columns: 18% 82%;" >
                    <div class="" style="margin-top:0.5rem" >
                        Description:  
                    </div>
                      <textarea v-model="changeItemSttDescription" cols="7" rows="4" style="border-style:solid; border-color:#b0bec5;"> </textarea>
                  </div>
                    <div class="wrap-table" style="max-height: 300px; overflow-y: auto">
                    <table class="mytable">
                        <thead>
                          <tr>                            
                            <th><strong>From</strong></th>
                            <th><strong>To</strong></th>
                            <th><strong>User</strong></th>
                            <th><strong>Date</strong></th>
                            <th><strong>Description</strong></th>
                          </tr>
                        </thead>  
                          <tbody>
                            <tr v-for="history in statusHistories" style="font-size=16">
                              <td style="font-size=14;">{{history.OldStatus.Name}}</td>    
                              <td style="font-size=14;">{{history.NewStatus.Name}}</td>  
                              <td style="font-size=14;">{{history.Fullname}}</td>  
                              <td style="font-size=14;">{{history.Date}}</td>
                              <td style="font-size=14;">{{history.Description}}</td>    
                            </tr>
                          </tbody>
                      </table>
                    </div>
                  </div>
                </div>
                <div v-if="currentViewMode ==  viewModes.Position">
                  <div class="rowpu" style="height: 36px" >
                    <div class="" style="margin-top:0.5rem" >
                        Location:  <span v-if="editItemMode" style="color:red; font-size:18px">*</span>
                    </div>
                    <div class="">
                      <div class="" v-if="itemLocationID == lostLocation"><input v-if="!editItemMode" v-model="itemLocationID" class="input col-7 " type="text" disabled="disabled"></div>
                      <div class="" v-else>
                        <input v-if="!editItemMode" v-model="selectedItem.Item.Location" class="input col-7 " type="text" disabled="disabled">
                        <div v-else class="select" style="width: 100%">
                        <select  class="" style="border: 1px #9e9e9e solid; padding-left: 1rem; width: 100%"  v-model="selectedItem.Item.LocationID">
                          <option style="" :key="'equipmentItemLocation' + location.Id" v-for="location in locationOptions"                   
                            v-bind:value="location.Id">{{location.Name}}</option>
                        </select>
                        </div> 
                      </div>
                    </div>
                  </div>
                  <div class="rowpu" style="height: 36px" >
                    <div class="" style="margin-top:0.5rem" >
                        Address:  
                    </div>
                    <div class="">
                      <div class="" v-if="itemLocationID == lostLocation"><input v-model="itemLocationID" class="input col-7 " type="text" disabled="disabled"></div>
                      <div class="" v-else>
                        <input  v-model="selectedItem.Item.Address" class="input col-7 " type="text" disabled="disabled">
                      </div>
                    </div>
                  </div>
                  <div class="rowpu" style="height: 36px" >
                    <div class="" style="margin-top:0.5rem" >
                        Block:  <span v-if="editItemMode" style="color:red; font-size:18px">*</span>
                    </div>
                    <div class="">
                      <div class="" v-if="itemBlockID == lostBlock"><input v-if="!editItemMode" v-model="itemBlockID" class="input col-7 " type="text" disabled="disabled"></div>
                      <div class="" v-else>
                        <input v-if="!editItemMode" v-model="selectedItem.Item.Block" class="input col-7 " type="text" disabled="disabled">
                        <div v-else class="select" style="width: 100%">
                            <select  class="" style="border: 1px #9e9e9e solid; padding-left: 1rem; width: 100%"  v-model="selectedItem.Item.BlockID">
                              <option :key="'equipmentItemBlock' + block.Id" v-for="block in blockOptions"
                                                  
                                v-bind:value="block.Id">{{block.Name}}</option>
                            </select>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="rowpu" style="height: 36px" >
                    <div class="" style="margin-top:0.5rem" >
                        Floor:  <span v-if="editItemMode" style="color:red; font-size:18px">*</span>
                    </div>
                    <div class="">
                      <div class="" v-if="itemFloorID == lostFloor"><input v-if="!editItemMode" v-model="itemFloorID" class="input col-7 " type="text" disabled="disabled"></div>
                      <div class="" v-else>
                        <input v-if="!editItemMode" v-model="selectedItem.Item.FLoor" class="input col-7 " type="text" disabled="disabled">
                        <div v-else class="select" style="width: 100%">
                            <select  class="" style="border: 1px #9e9e9e solid; padding-left: 1rem; width: 100%"  v-model="selectedItem.Item.FloorID">
                              <option :key="'equipmentItemFloor' + floor.Id" v-for="floor in floorOptions"   
                                  
                                :value="floor.Id">{{floor.Name}}
                              </option>
                            </select>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="rowpu" style="height: 36px" >
                    <div class="" style="margin-top:0.5rem" >
                        Tile:  <span v-if="editItemMode" style="color:red; font-size:18px">*</span>
                    </div>
                    <div class="">
                      <div class="" v-if="itemTileID == lostTile"><input v-if="!editItemMode" v-model="itemTileID" class="input col-7 " type="text" disabled="disabled"></div>
                      <div class="" v-else>
                        <input v-if="!editItemMode" v-model="selectedItem.Item.Tile" value="selectedItem.Item.Tile ? selectedItem.Item.Tile : 'undefined'" class="input col-7 " type="text" disabled="disabled">
                        <div v-else class="select" style="width: 100%">
                            <select  class="" style="border: 1px #9e9e9e solid; padding-left: 1rem; width: 100%"  v-model="selectedItem.Item.TileID">
                              <option :key="'equipmentItemTile' + tile.Id" v-for="tile in tileOptions"
                                                  
                                v-bind:value="tile.Id">{{tile.Name}}</option>
                            </select>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="is-horizontal" style="padding-top:0.75rem; padding-bottom: 0.5rem;" v-if="editItemMode" >
                    <button class="btn-CancelItem" v-on:click="cancelUpdatePosition">Cancel</button>
                    <button  class="btn-UpdateItem" v-on:click="updatePositionItem">Update Item</button>
                  </div>
                </div>
                <div v-if="currentViewMode ==  viewModes.WorkOrder">
                  <div class="wrap-table" style="max-height: 300px; overflow-y: auto">
                    <table class="mytable">
                        <thead>
                          <tr>                            
                            <th><strong>Name</strong></th>
                            <th><strong>RequestUser</strong></th>
                            <th><strong>Status</strong></th>
                          </tr>
                        </thead>  
                          <tbody>
                            <tr v-for="workorder in allworkorder" style="font-size=16">
                              <td style="font-size=14;">{{workorder.Name}}</td>    
                              <td style="font-size=14;">{{workorder.RequestUser}}</td>  
                              <td style="font-size=14;">{{workorder.Status}}</td>     
                            </tr>
                          </tbody>
                      </table>
                    </div>  
                </div>
                <div v-else-if="currentViewMode ==  viewModes.RunTime">
                  <p>This is Runtime tab - Coming soon</p>
                </div>
              </div>  
          </div>
        </div>  
        <div slot="footer">
          </div>
      </modal>
      </div>
  </div>
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
export default {
  // name: "ConditionalModal",

  components: {
    ModelSelect,
    Vodal,
    EquipmentDetailPopup
    // jsbarcode
  },
  created() {
    this.equipmentId = this.$route.params.id;
    this.axios
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
        });
      });

    // this.axios
    //   .get("http://localhost:3000/api/equipmentItem/" + equipmentId)
    //   .then(response => {
    //     this.quality = response.data.Quality;
    //   });
    this.axios
      .get("http://localhost:3000/api/equipmentItem/" + this.equipmentId)
      .then(response => {
        let data = response.data;
        data.forEach(element => {
          this.Items.push(element);
        });
      })
      .catch(error => {
        console.log(error);
      });
    this.axios
      .get("http://localhost:3000/api/vendor")
      .then(response => {
        let data = response.data;
        data.forEach(vendor => {
          // let option = {
          //   text: vendor.BusinessName,
          //   value: vendor.Id
          // };
          this.vendorOptions.push(vendor);
          // alert(this.vendorOptions.length);
        });
      })
      .catch(error => {
        alert(error);
      });
    this.axios
      .get("http://localhost:3000/api/EquipmentCategory")
      .then(response => {
        let data = response.data;
        data.forEach(category => {
          // let option = {
          //   text: category.Name,
          //   value: category.Id
          // };
          this.categoryOptions.push(category);
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
          // let option = {
          //   text: location.Name,
          //   value: location.Id
          // };
          this.locationOptions.push(location);
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
          // alert(this.statusOptions.length);
        });
      })
      .catch(error => {
        alert(error);
      });
    //GET LOcation to import model-select
    this.axios
      .get("http://localhost:3000/api/location")
      .then(response => {
        let data = response.data;
        data.forEach(location => {
          let option = {
            text: location.Name,
            value: location.Id
          };
          this.locationModalSelect.push(option);
          // alert(this.locationModalSelect[0].value);
        });
      })
      .catch(error => {
        alert(error);
      });
  },
  // data() {
  //   return {
  //     JsBarcode("#code128", "Hi!");

  // },
  data() {
    return {
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
      lostTile: "undefined",
      lostFloor: "undefined",
      lostBlock: "undefined",
      lostLocation: "undefined",
      lostAddress: "undefined",
      showingBarcode: false,
      changeItemSttDescription: "",
      show: false,
      addPopUp: false,
      addItemMode: false,
      detailPopUp: false,
      selectedItem: null,
      itemId: "",
      workOrder: null,
      EquimentByID: null,
      equipmentId: "",
      quality: 0,
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
      tiles: [],
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
      itemNextMaintainDate: "",
      itemLocationID: "",
      itemBlockID: "",
      itemFloorID: "",
      itemTileID: ""
    };
  },
  methods: {
    cancelUpdateEquipment() {
      this.editMode = !this.editMode;
      this.EquimentByID.Name = this.equipmentName;
      this.EquimentByID.VendorId = this.equipmentVendorId;
      this.EquimentByID.MadeIn = this.equipmentMadein;
      this.EquimentByID.CategoryId = this.equipmentCategoryId;
      this.EquimentByID.UnitID = this.equipmentUnitId;
      this.EquimentByID.Description = this.equipmentDescription;
      this.files = [];
    },
    cancelUpdateItem() {
      this.editItemMode = !this.editItemMode;
      this.selectedItem.Item.Price = this.itemPrice;
      this.selectedItem.Item.Description = this.itemDescription;
      this.selectedItem.Item.WarrantyDuration = this.itemWarranty;
      this.selectedItem.Item.NextMaintainDate = this.itemNextMaintainDate;
    },
    cancelUpdatePosition() {
      this.editItemMode = !this.editItemMode;
      this.selectedItem.Item.LocationID = this.itemLocationID;
      this.selectedItem.Item.BlockID = this.itemBlockID;
      this.selectedItem.Item.FloorID = this.itemFloorID;
      this.selectedItem.Item.TileID = this.itemTileID;
      // alert(this.itemTileID);
      // alert(this.selectedItem.Item.TileID);
    },
    setViewMode(mode) {
      this.currentViewMode = mode;
    },
    async createNewEquipentItem() {
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
        var result = false;
        this.randomNumbers.forEach(async number => {
          try {
            let res = await this.axios.post(
              "http://localhost:3000/api/equipmentItem",
              {
                equipmentID: this.EquimentByID.Id,
                serialNumber: number,
                warrantyDuration: this.form.warrantyDuration,
                price: this.form.price,
                statusId: 1,
                description: "No description",
                tileID: this.form.selectedTile.value
              }
            );
            if (res.status == 200) {
              result = true;
            }
          } catch (error) {
            console.log(error);
            result = false;
          }
        });
        await Utils.sleep(500);

        if (result) {
          alert("Add " + this.quantity + " item(s) successfully!");
          location.reload();
        } else {
          alert("Add failed");
        }
      }
    },
    getRandomNumber() {
      if (this.form.Category == "") {
        alert("Please choose category");
      } else if (this.quantity === "" || this.quantity < 1) {
        alert("Quantity must be bigger than 0");
      } else {
        this.randomNumbers = [];
        for (var i = 0; i < this.quantity; i++) {
          var number = "";
          if (
            0 < this.EquimentByID.CategoryId &&
            this.EquimentByID.CategoryId < 10
          ) {
            number = "000" + this.EquimentByID.CategoryId;
          } else if (
            10 <= this.EquimentByID.CategoryId &&
            this.EquimentByID.CategoryId < 100
          ) {
            number = "00" + this.EquimentByID.CategoryId;
          } else if (
            100 <= this.EquimentByID.CategoryId &&
            this.EquimentByID.CategoryId < 1000
          ) {
            number = "0" + this.EquimentByID.CategoryId;
          } else {
            number = this.EquimentByID.CategoryId;
          }
          number = number + Math.floor(Math.random() * 900000000 + 100000000);
          this.randomNumbers.push(number);
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
          if(this.currentsttName.toUpperCase() != "LOST"){
            this.axios
              .get("http://localhost:3000/api/equipmentItem/Item/" + itemId)
              .then(response => {
                if (this.editMode == true) {
                  this.editMode = false;
                }
                this.detailPopUp = true;
                this.selectedItem = response.data;
                this.itemPrice = this.selectedItem.Item.Price;
                this.itemDescription = this.selectedItem.Item.Description;
                this.itemWarranty = this.selectedItem.Item.WarrantyDuration;
                this.itemNextMaintainDate = this.selectedItem.Item.NextMaintainDate;
                this.itemLocationID = this.selectedItem.Item.LocationID;
                this.itemBlockID = this.selectedItem.Item.BlockID;
                this.itemFloorID = this.selectedItem.Item.FloorID;
                this.itemTileID = this.selectedItem.Item.TileID;
                this.oldstt = this.selectedItem.Item.StatusID;
                this.statusHistories = [];
                this.allworkorder = [];
                this.axios
                  .get("http://localhost:3000/api/equipmentItemHistory/" + itemId)
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
                    "http://localhost:3000/api/equipmentItem/allworkorder/" + itemId
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
              })
              .catch(error => {
                console.log(error);
              });
          }else{
           this.axios
              .get("http://localhost:3000/api/equipmentItem/Itemloststt/" + itemId)
              .then(response => {
                if (this.editMode == true) {
                  this.editMode = false;
                }
                this.detailPopUp = true;
                this.selectedItem = response.data;
                this.itemPrice = this.selectedItem.Item.Price;
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
                this.axios
                  .get("http://localhost:3000/api/equipmentItemHistory/" + itemId)
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
                    "http://localhost:3000/api/equipmentItem/allworkorder/" + itemId
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
      // this.editMode = !this.addPopUp;
    },

    getFilePath(file) {
      return window.URL.createObjectURL(file);
    },
    inputFileChange() {
      this.files = this.$refs.fileInput.files;
    },
    async updateEquipment() {
      if (this.EquimentByID.Name.trim().length < 5) {
        alert("Equipment name must contain more than 5 characters");
      } else {
        this.imageUrl = this.EquimentByID.Image;
        if (this.files[0] && this.files[0].name) {
          let formData = new FormData();
          formData.append("api_key", "982394881563116");
          formData.append("file", this.files[0]);
          formData.append("public_id", this.files[0].name);
          formData.append("timestamp", moment().valueOf());
          formData.append("upload_preset", "ursbvd4a");
          let url = "https://api.cloudinary.com/v1_1/dmlopvmdy/image/upload";
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

        this.axios
          .put("http://localhost:3000/api/equipment/" + this.equipmentId, {
            id: this.equipmentId,
            name: this.EquimentByID.Name,
            vendorid: this.EquimentByID.VendorId,
            image: this.imageUrl,
            madein: this.EquimentByID.MadeIn,
            categoryid: this.EquimentByID.CategoryId,
            description: this.EquimentByID.Description,
            unitid: this.EquimentByID.UnitID
          })
          .then(function(respone) {
            alert("Update successfully");
            location.reload();
            this.editMode = !this.editMode;
          })
          .catch(function(error) {
            console.log(error);
          });
      }
    },
    updatePositionItem() {
      if(this.selectedItem.Item.TileID == null){
        alert('Please choose position for this item')
      }else{
        this.axios
        .put(
          "http://localhost:3000/api/equipmentItem/position/tile/" +
            this.selectedItem.Item.Id,
          {
            tileId: this.selectedItem.Item.TileID
          }
        )
        .then(function(respone) {
          alert("Update successfully");
          location.reload();
        })
        .catch(function(error) {
          console.log(error);
        });
      }
    },
    changeItemStatus() {
      let authUser = JSON.parse(window.localStorage.getItem("user"));
      // alert(this.changeItemSttDescription);
      // alert(this.selectedItem.Item.StatusID);
      if (this.oldstt == this.selectedItem.Item.StatusID) {
        alert("Cannot updatde, please choose new status");
      } else {
        this.axios
          .put(
            "http://localhost:3000/api/equipmentItem/status/" +
              this.selectedItem.Item.Id,
            {
              userId: authUser.Id,
              newStatusId: this.selectedItem.Item.StatusID,
              description: this.changeItemSttDescription
            }
          )
          .then(function(respone) {
            alert("Update successfully");
            location.reload();
          })
          .catch(function(error) {
            console.log(error);
          });
      }
      if (this.selectedItem.Item.StatusID == 7) {
        alert(this.selectedItem.Item.Id);
        this.axios
          .put(
            "http://localhost:3000/api/equipmentItem/tileId/" +
              this.selectedItem.Item.Id
          )
          .then(function(respone) {
            location.reload();
          })
          .catch(function(error) {
            consonle.log(error);
          });
      }
    },
    updateItem() {
      // if (this.selectedStatus.value == "") {
      //   alert("Please choose Status for this Item");
      // } else {
      // alert(this.selectedItem.Item.Id);

      let importdate = moment(this.selectedItem.Item.ImportDate).format("L");
      let currentdate = moment(Date.now()).format("L");
      let lastmaitaindate = moment(
        this.selectedItem.Item.LastMaintainDate
      ).format("L");
      let nextmaintaindate = moment(
        this.selectedItem.Item.NextMaintainDate
      ).format("L");
      if (
        this.selectedItem.Item.Price === "" ||
        this.selectedItem.Item.Price < 50000
      ) {
        alert("Price must be bigger than 50000");
      } else if (
        this.selectedItem.Item.WarrantyDuration === "" ||
        this.selectedItem.Item.WarrantyDuration < 1
      ) {
        alert("Warranty durration must be bigger than 0");
      } else if (currentdate > nextmaintaindate) {
        alert("Next maintain date must be BIGGER than current date");
      } else {
        this.axios
          .put(
            "http://localhost:3000/api/equipmentItem/" +
              this.selectedItem.Item.Id,
            {
              // id: this.selectedItem.Item.Id,
              warrantyDuration: this.selectedItem.Item.WarrantyDuration,
              runtimeDays: this.selectedItem.Item.RuntimeDays,
              price: this.selectedItem.Item.Price,
              importdate: this.selectedItem.Item.ImportDate,
              lastmaintaindate: this.selectedItem.Item.LastMaintainDate,
              nextmaintaindate: this.selectedItem.Item.NextMaintainDate,
              description: this.selectedItem.Item.Description
            }
          )
          .then(function(respone) {
            alert("Update successfully");
            location.reload();
            this.editItemMode = !this.editItemMode;
          })
          .catch(function(error) {
            console.log(error);
          });
      }
    }
  },
  watch: {
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
      if(this.addPopUp == true){
        this.axios
      .get("http://localhost:3000/api/location")
      .then(response => {
        let data = response.data;
        data.forEach(location => {
          let option = {
            text: location.Name,
            value: location.Id
          };
          this.locationModalSelect.push(option);
          // alert(this.locationModalSelect[0].value);
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
        this.selectedItem.Item.NextMaintainDate = this.selectedItem.Item.NextMaintainDate;
        this.selectedItem.Item.Description = this.selectedItem.Item.Description;
        if(this.itemLocationID === this.lostLocation){

        }else{
          this.selectedItem.Item.LocationID = this.itemLocationID;
          this.selectedItem.Item.BlockID = this.itemBlockID;
          this.selectedItem.Item.FloorID = this.itemFloorID;
          this.selectedItem.Item.TileID = this.itemTileID;
        }
        this.currentViewMode = this.viewModes.Details;
        if (this.editItemMode == true) {
          this.editItemMode = false;
        }
      }
    },
    quantity: function() {
      if (this.quantity != "" && this.quantity <50 && this.CreateItemErrors.NoQuantity != "") {
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
      if(this.selectedItem.Item.LocationID === this.lostLocation){
        alert(this.selectedItem.Item.LocationID)
        alert(this.lostLocation)
      }else{
        alert(this.selectedItem.Item.LocationID);
        alert(this.lostLocation);
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
     
      if (this.editItemMode && this.selectedItem.Item.BlockID == null ) {
        this.selectedItem.Item.FloorID = null;
        this.selectedItem.Item.TileID = null;
        
      }
      if (this.editItemMode && this.selectedItem.Item.BlockID != null ) {
          // this.selectedItem.Item.FloorID = null;
        // this.selectedItem.Item.TileID = null;
          this.floorOptions = [];
          this.tileOptions = [];
          this.selectedItem.Item.FloorID = null;
          this.selectedItem.Item.TileID = null;
      }
      if(this.selectedItem.Item.BlockID != null){
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
      if(this.selectedItem.Item.FloorID != null){
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
  width: 100px;
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
  background-color:  #9e9e9e;
  /* margin-left: 150px; */
}
.btn-Cancel:hover {
  cursor: pointer;
  background-color:  #9e9e9e;
}
.btn-CancelItem {
  background-color: #9e9e9e ;
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
  grid-template-columns: 20% 80%;
}

.rowpu {
  margin-left: 0.5rem;
  margin-top: 0.75rem;
  margin-right: 1rem;
  display: grid;
  grid-template-columns: 42% 58%;
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
  padding: 0rem 0rem 0.75rem 0.3rem !important;
}

td {
  text-align: left;
  vertical-align: middle !important;
  height: 25px;
  line-height: 25px;
  padding: 0rem 0rem 0.5rem 0.3rem !important;
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
</style>