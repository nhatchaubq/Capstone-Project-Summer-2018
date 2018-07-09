<template>
    <div>
        <!-- <h1>{{this.EquimentByID.Name}}</h1> -->
        <div class="field" style=" display: grid; grid-template-columns: 50% 50%; width: 100;">
            <div class="left" style="padding-top:0.5rem; padding-left:1rem ">
                <img :src= "this.EquimentByID.Image" style="width: 400px; height: 350px; ">
            </div>
        <div class="">
        <!-- <div class="field is-horizontal"> -->
        <div class="field" style=" display: grid; grid-template-columns: 70% 20% 10%">
            <strong style="text-transform: uppercase;  font-size: 20px; color: #26a69a">{{EquimentByID.Name}}</strong>
            <button  class="btn-Add" :class="{'is-active-option': addPopUp}"  v-on:click="addItem">Add Item</button>
            <button class="btn-edit" :class="{'is-active-option': editMode}" v-on:click="editMode = !editMode">Edit</button> 
        </div>
        <div class="row" style="height:36px" >
            <div class="" style="margin-top:0.5rem" >
                Name:  
            </div>
            <input v-if="!editMode" v-model="EquimentByID.Name" class="input col-7 " type="text" disabled="disabled"> 
            <input v-else v-model="EquimentByID.Name" class="input col-7 " type="text"  >
        </div>
        <div class="row" style="height:36px" >
            <div class="" style="margin-top:0.5rem" >
                Vendor:  
            </div>
            <input v-if="!editMode" v-model="EquimentByID.Vendor.Name" class="input col-7 " type="text" disabled="disabled"> 
            <!-- <input v-else v-model="EquimentByID.Vendor.Name" class="input col-7 " type="text" > -->
            <model-select v-else style="width: 100% !important" :options="vendorOptions" v-model="selectedVendor" placeholder="Select a vendor"></model-select>  
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
                Category:  
            </div>
            <input v-if="!editMode" v-model="this.EquimentByID.Category.Name" class="input col-7 " type="text" disabled="disabled"> 
            <model-select v-else style="width:100% !important" :options="categoryOptions" v-model="selectedCategory" placeholder="Select a category"></model-select>  
        </div>
        <div  class="row" style="height:36px" >
            <div class="" style="margin-top:0.5rem" >
                Description:  
            </div>
            <input v-if="!editMode" v-model="this.EquimentByID.Description" class="input col-7 " type="text" disabled="disabled"> 
            <input v-else v-model="EquimentByID.Description" class="input col-7 " type="text" >
        </div>
        <div  class="row" style="height:36px" >
            <div class="" style="margin-top:0.5rem" >
                Quantity:  
            </div>
            <input v-model="this.Items.length" class="input col-7 " type="text" disabled="disabled"> 
        </div>
        <div class="row" style="height:30px">
          <div class="" style="margin-top:0.5rem">
            Picture:
          </div>
              <div class="input_picture">                  
              <label class="file-label"  > 
              <span class="file-cta">
                  <input v-if="!editMode" class="file-input" type="file" ref="fileInput"  disabled="disabled" />
                  <input v-else class="file-input" type="file" ref="fileInput" v-on:change="inputFileChange" />
                  <!-- <span class="file-icon" style="margin-right=0;"> -->
                      <i class="fa fa-upload"></i>
                  <!-- </span> -->
              </span>
                  <div class="file-upload" v-bind:key="file.name" v-for="file in files" style="width: 100% !important;">
                      {{ file.name }}
                  </div>
              </label>
              </div>
        </div>
        <div class=" is-horizontal" style="padding-top:0.75rem; padding-bottom: 0.5rem;" v-if="editMode" >
          <button  class="btn-Update" v-on:click="updateEquipment">Update</button>
          <button class="btn-Cancel" v-on:click="editMode = !editMode">Cancel</button>
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
        <vodal class="no-padding"  height="600" :show="addPopUp" @hide="() => {
                                                                                      
                                                                                      addPopUp = false;
                                                                                    }" animation="slideUp">
          <h3 style="paddingbtn-Add-top:0.5rem; text-transform: uppercase;  font-size: 20px; color: #26a69a">Add Items</h3>
          <div class="" style="padding-top:0.5rem;">
          <div class="form-field-title">
              Quantity
          </div>
          <div class="field is-horizontal">
              <input type="number" min="1" class="input" placeholder="Quantity" style="margin-right: 1rem" v-model="quantity" >
              <button type="submit" class="button is-primary is-focused" name="GenerateBarcode" v-on:click="getRandomNumber">Barcode</button>
          </div>
          <div v-show="showingBarcode" style="max-height: 80px; overflow-y: auto">
              <ul>
                  <li v-for="(i,index) in randomNumbers" :key="i"> {{index+1}}. {{i}}</li>
              </ul>
          </div>
          <div class="field" style="display: grid; grid-template-columns: 50% 50%">
            <div>
                <div class="form-field-title" >
                  Price
                </div>
                <div class="field is-horizontal" style="margin-right:1rem">
                  <input type="number" class="input" placeholder="Price" v-model="form.price">
                </div>
            </div>
            <div >
                <div class="form-field-title">
                  Warranty
                </div>
                <div class="field is-horizontal" >
                  <input type="number" min="1" class="input" placeholder="Warranty Months" v-model="form.warrantyDuration">
                </div> 
            </div>
          </div>
          <div class="form-field-title">
              Location
          </div>
          <div>
          <model-select style="width: 100% !important" :options="locationOptions" v-model="selectedLocation" v-on:click="changeLocation" placeholder="Select a location"></model-select>  
          </div>
          <div class="form-field-title">
              Block
          </div>
           <div>
          <model-select style="width: 100% !important" :options="blockOptions" v-model="selectedBlock" placeholder="Select a block  "></model-select>  
          </div>
           <div class="form-field-title">
              Floor
          </div>
           <div>
          <model-select style="width: 100% !important" :options="floorOptions" v-model="selectedFloor" placeholder="Select a floor  "></model-select>  
          </div>

           <div class="form-field-title">
              Tile
          </div>
           <div>
          <model-select style="width: 100% !important" :options="tileOptions" v-model="selectedTile" placeholder="Select a tile  "></model-select>  
          </div>
          </div>
          <div class="" style="align-items: center; display: flex; justify-content: center;">
          <button id="" class="button is-rounded is-primary" style="margin-top: 10px" v-on:click="createNewEquipentItem">Create New Items</button>  
          </div>
        </vodal>
       
        <vodal class="no-padding" height="600" width="540" :show="selectedItem != null" :closeButton='false' @hide="() => {
                                                                                      selectedItem = null;
                                                                                      editItemMode = false;
                                                                                    }" animation="slideUp">
          <!-- <equipment-detail-popup :equipment="selectedItem" class="" v-show="selectedItem != null"></equipment-detail-popup> -->
            <div v-if="selectedItem!=null" >              
            <div class="field" style=" display: grid; grid-template-columns: 10% 75% 15%">
              <i class="material-icons" style="font-size: 2rem;">clear_all</i>
              <strong style="padding-top:0.25rem; text-transform: uppercase;  font-size: 18px; color: #26a69a">{{EquimentByID.Name}} - {{selectedItem.Item.SerialNumber}}</strong>
              <button class="btn-edit" v-on:click="editItemMode = !editItemMode">Edit</button>  
            </div>
            
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
                <div>
                <div class="rowpu" style="height: 36px" >
                  <div class="" style="margin-top:0.5rem" >
                      Serial Number:  
                  </div>
                    <input  v-model="selectedItem.Item.SerialNumber" class="input col-7 " type="text" disabled="disabled"> 
                    <!-- <input v-else v-model="selectedItem.Item.SerialNumber" class="input col-7 " type="text">  -->
                </div>
                <div class="rowpu" style="height: 36px" >
                  <div class="" style="margin-top:0.5rem" >
                      Price:  
                  </div>
                    <input v-if="!editItemMode" v-model="selectedItem.Item.Price" class="input col-7 " type="text" disabled="disabled"> 
                    <input v-else v-model="selectedItem.Item.Price" class="input col-7 " type="text"> 
                </div>
                <div class="rowpu" style="height: 36px" >
                  <div class="" style="margin-top:0.5rem" >
                      Warranty:  
                  </div>
                    <input v-if="!editItemMode" v-model="selectedItem.Item.WarrantyDuration" class="input col-7 " type="text" disabled="disabled"> 
                    <input v-else v-model="selectedItem.Item.WarrantyDuration" class="input col-7 " type="text"> 
                </div>
                <div class="rowpu" style="height: 36px" >
                  <div class="" style="margin-top:0.5rem" >
                      Run-times:  
                  </div>
                    <input v-if="!editItemMode" v-model="selectedItem.Item.RuntimeDays" class="input col-7 " type="text" disabled="disabled"> 
                    <input v-else v-model="selectedItem.Item.RuntimeDays" class="input col-7 " type="text">  
                </div>
                <div class="rowpu" style="height: 36px" >
                  <div class="" style="margin-top:0.5rem" >
                      Import-Date:  
                  </div>
                    <input v-if="!editItemMode" v-model="selectedItem.Item.ImportDate" class="input col-7 " type="text" disabled="disabled"> 
                    <input v-else v-model="selectedItem.Item.ImportDate" class="input col-7 " type="date"> 
                </div>
                <div class="rowpu" style="height: 36px" >
                  <div class="" style="margin-top:0.5rem" >
                      Last-MaintainDate:  
                  </div>
                    <input v-if="!editItemMode" v-model="selectedItem.Item.LastMaintainDate" class="input col-7 " type="text" disabled="disabled">
                    <input v-else v-model="selectedItem.Item.LastMaintainDate" class="input col-7 " type="date"> 
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
                    <button  class="btn-UpdateItem" v-on:click="updateItem">Update Item</button>
                    <button class="btn-CancelItem" v-on:click="editItemMode = !editItemMode">Cancel</button>
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
                      <button class="btn-changeStt" v-on:click="changeItemStatus">Change Status</button>
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
                <p>This is position tab - Coming soon</p>
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
        </vodal>
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
          let option = {
            text: vendor.BusinessName,
            value: vendor.Id
          };
          this.vendorOptions.push(option);
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
          let option = {
            text: category.Name,
            value: category.Id
          };
          this.categoryOptions.push(option);
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
          let option = {
            text: location.Name,
            value: location.Id
          };
          this.locationOptions.push(option);
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
  },
  // data() {
  //   return {
  //     JsBarcode("#code128", "Hi!");

  // },
  data() {
    return {
      showingBarcode: false,
      changeItemSttDescription: "",
      show: false,
      addPopUp: false,
      selectedItem: null,
      itemId: "",
      workOrder: null,
      EquimentByID: null,
      equipmentId: "",
      quality: 0,
      Items: [],
      files: "",
      quantity: 1,
      editMode: false,
      editItemMode: false,
      statusOptions: [],
      randomNumbers: [],
      statusHistories: [],
      allworkorder: [],
      selectedStatus: {
        text: "",
        value: ""
      },
      selectedLocation: {
        text: "",
        value: ""
      },
      locationOptions: [],
      selectedBlock: {
        text: "",
        value: ""
      },
      blockOptions: [],
      selectedFloor: {
        text: "",
        value: ""
      },
      floorOptions: [],
      selectedTile: {
        text: "",
        value: ""
      },
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
      form: {
        warrantyDuration: 1,
        price: 50000,
        description: ""
      },
      currentViewMode: 0,
      viewModes: {
        Details: 0,
        Status: 1,
        Position: 2,
        WorkOrder: 3,
        RunTime: 4
      }
    };
  },
  methods: {
    changeLocation() {
      alert(this.selectedLocation.value);
      this.axios
        .get(
          "http://localhost:3000/api/block/location/" +
            this.selectedLocation.value
        )
        .then(response => {
          let data = response.data;
          data.forEach(block => {
            let option = {
              text: block.Name,
              value: block.Id
            };
            this.blockOptions.push(option);
          });
        })
        .catch(error => {
          alert(error);
        });
    },
    setViewMode(mode) {
      this.currentViewMode = mode;
    },
    createNewEquipentItem() {
      var result = false;
      if (this.form.price == "") {
        alert("Please enter price");
      } else {
        if (this.form.warrantyDuration == "") {
          alert("Please enter warranty duration");
        } else {
          if (this.randomNumbers.length == 0) {
            alert("Please create barcode to add");
          } else {
            for (var i = 0; i < this.quantity; i++) {
              this.axios
                .post("http://localhost:3000/api/equipmentItem", {
                  equipmentID: this.EquimentByID.Id,
                  serialNumber: this.randomNumbers[i],
                  warrantyDuration: this.form.warrantyDuration,
                  price: this.form.price,
                  statusId: 1,
                  description: "No description",
                  tileID: this.selectedTile.value
                })
                .then(function(respone) {
                  result = true;
                  location.reload();
                })
                .catch(function(error) {
                  console.log(error);
                });
            }
            if ((result = true)) {
              alert("Add " + this.quantity + " items successfully!");
            }
          }
        }
      }
      this.created();
    },
    getRandomNumber() {
      if (this.form.Category == "") {
        alert("Please choose category");
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
        .get("http://localhost:3000/api/equipmentItem/Item/" + itemId)
        .then(response => {
          this.selectedItem = response.data;
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
          //  alert(this.selectedItem.SerialNumber);
        })
        .catch(error => {
          console.log(error);
        });
    },

    addItem() {
      this.addPopUp = true;
      this.editMode = !this.addPopUp;
      // alert(this.addPopUp);
    },

    getFilePath(file) {
      return window.URL.createObjectURL(file);
    },
    inputFileChange() {
      this.files = this.$refs.fileInput.files;
    },
    updateEquipment() {
      if (
        this.selectedCategory.value == "" ||
        this.selectedCategory.value == ""
      ) {
        alert("Please choose category and vendor");
      } else if (this.EquimentByID.Name == "") {
        alert("Please enter equipment name");
      } else {
        // alert(this.selectedCategory.value);
        this.editMode = !this.editMode;
        this.axios
          .put("http://localhost:3000/api/equipment/" + this.equipmentId, {
            id: this.equipmentId,
            name: this.EquimentByID.Name,
            vendorid: this.selectedVendor.value,
            image:
              "http://dailymayxaydung.com/wp-content/uploads/2016/05/bua_duc_hoi_g10.jpg",
            madein: this.EquimentByID.MadeIn,
            categoryid: this.selectedCategory.value,
            description: this.EquimentByID.Description
          })
          .then(function(respone) {
            alert("Update successfully");
          })
          .catch(function(error) {
            console.log(error);
          });
      }
    },
    changeItemStatus() {
      let authUser = JSON.parse(window.localStorage.getItem("user"));
      // alert(this.changeItemSttDescription);
      this.axios
        .put(
          "http://localhost:3000/api/equipmentItem/status/" +
            this.selectedItem.Item.Id,
          {
            newStatus: this.selectedItem.Item.StatusID,
            userId: authUser.Id,
            description: this.changeItemSttDescription
          }
        )
        .then(function(respone) {
          alert("Update successfully");
          this.created();
        })
        .catch(function(error) {
          console.log(error);
        });
    },
    updateItem() {
      // if (this.selectedStatus.value == "") {
      //   alert("Please choose Status for this Item");
      // } else {
      // alert(this.selectedItem.Item.Id);
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
          this.created();
        })
        .catch(function(error) {
          console.log(error);
        });
      // }
    }
  },
  watch: {
    selectedLocation: function() {
      if (this.selectedLocation.value != "") {
        this.blockOptions = [];
        this.axios
          .get(
            `http://localhost:3000/api/block/location/${
              this.selectedLocation.value
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
                this.blockOptions.push(option);
              });
            }
          });
      }
    },
    selectedBlock: function() {
      if (this.selectedBlock.value != "") {
        this.floorOptions = [];
        this.axios
          .get(
            `http://localhost:3000/api/floor/block/${this.selectedBlock.value}`
          )
          .then(res => {
            if (res.status == 200) {
              let floors = res.data;
              floors.forEach(floor => {
                let option = {
                  value: floor.Id,
                  text: floor.Name
                };
                this.floorOptions.push(option);
              });
            }
          });
      }
    },
    selectedFloor: function() {
      // alert(this.selectedFloor.value);
      if (this.selectedFloor.value != "") {
        this.tileOptions = [];
        this.axios
          .get(
            `http://localhost:3000/api/tile/floor/${this.selectedFloor.value}`
          )
          .then(res => {
            if (res.status == 200) {
              let tiles = res.data;
              tiles.forEach(tile => {
                let option = {
                  value: tile.Id,
                  text: tile.Name
                };
                this.tileOptions.push(option);
              });
            }
          });
      }
    }
  }
};
</script>

<style scoped>
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

  margin-left: 100px;
}
.btn-changeStt {
  position: relative;
  background-color: var(--primary-color);
  color: white;
  font-size: 18px;
  border-radius: 8px;
  /* margin-left: 0.25rem; */
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
  margin-left: 30px;
}
.btn-Cancel:hover {
  cursor: pointer;
  background-color: #bdbdbda1;
  /* margin-left: 150px; */
}
.btn-Cancel:hover {
  cursor: pointer;
  background-color: #bdbdbda1;
}
.btn-CancelItem {
  background-color: #bdbdbd8f;
  color: white;
  font-size: 18px;
  border-radius: 8px;
  /* margin-left: 0.25rem; */
  height: 36px;
  width: 140px;
  /* margin-right: 25%; */
  margin-left: 30px;
}
.btn-Cancel {
  /* position: relative; */
  background-color: #bdbdbd8f;
  color: white;
  font-size: 18px;
  border-radius: 8px;
  /* margin-left: 0.25rem; */
  height: 36px;
  width: 100px;
  margin-right: 25%;
  margin-left: 2rem;
}
.row {
  margin-left: 0.5rem;
  margin-top: 0.75rem;
  margin-right: 1rem;
  display: grid;
  grid-template-columns: 35% 65%;
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
  padding: 0rem 0rem 0.75rem 0rem !important;
}

td {
  text-align: left;
  vertical-align: middle !important;
  height: 25px;
  line-height: 25px;
  padding: 0rem 0rem 0.5rem 0rem !important;
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