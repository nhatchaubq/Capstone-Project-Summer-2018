<template>
    <div class="form">
        <div class="form-title">
            <div class="form-title-start">
                Add New Equipment
            </div>            
            <div class="form-title-end">
                <router-link to='/equipment'> <button id="" class="button is-rounded" style="margin-right: .6rem">Cancel</button></router-link>
                <button id="" class="button is-rounded is-primary" v-on:click="createNewEquipment">Create New Equipment</button>
                
            </div>
        </div>
        <div class="form-content">
          <simplert :useRadius="true" :useIcon="true" ref="simplert"></simplert>          
            <div class="form-field-picture">
                <div class="form-field-title">
                  <span><strong>  Picture (required) </strong></span><span v-if="CreateEquipmentErrors.NoImage != ''">. <span class="error-text">{{ CreateEquipmentErrors.NoImage }}</span></span>
                </div>
                <div class="input_picture">                    
                    <label class="file-label" style="width: 100% !important"> 
                    <span class="file-cta">
                        <input class="file-input" type="file" accept="image/*" ref="fileInput" style="opacity:0" v-on:change="inputFileChange"  />
                        <span class="file-icon">

                            <i class="fa fa-upload"></i>
                        </span>
                        <span class="file-label">
                            Choose images...
                        </span>
                    </span>
                        <div class="file-upload" v-bind:key="file.name" v-for="file in files" style="width: 100% !important;">
                            {{ file.name }}
                        <div>
                            <img class="file-upload" v-bind:src="getFilePath(file)" width="300px" height="450px"/>
                        </div>
                        </div>
                    </label>
                </div> 
            </div>
            <div class="form-field">
                <div class="form-field-title">
                   <span><strong> Equipment Name (required) </strong></span>
                   <span v-if="CreateEquipmentErrors.NoName != ''">. <span class="error-text">{{ CreateEquipmentErrors.NoName }}</span></span>
                    <span v-if="CreateEquipmentErrors.NameLength != ''">. <span class="error-text">{{ CreateEquipmentErrors.NameLength }}</span></span>
                </div>
                <div class="form-field-input" >
                  <!-- <Autocomplete :items="equipmentOptions"
                    filterby="equipmentOptions.Name"
                    @change="onChange"
                    title="Look for a customer"
                    @selected="customerSelected"/> -->
                  <!-- <model-select style="width: 100% !important" :options="equipmentOptions" v-model="selectedEquipment" placeholder="Equipment Name"></model-select>   -->
                  <input type="text" class="input" placeholder="EquipmentName" v-model="form.EquipmentName" >
                </div>
            </div>
            <div class="field" style="margin-left: 3rem; margin-top: 0.9rem; margin-right: 2rem; display: grid; grid-template-columns: 50% 50%">
                <div class="">
                    <div class="form-field-title" >
                      <span><strong> Category (required) </strong></span>
                      <span v-if="CreateEquipmentErrors.NoCategory != ''">. <span class="error-text">{{ CreateEquipmentErrors.NoCategory }}</span></span>
                    </div>
                    <div class="field is-horizontal" style="">
                        <model-select style="width: 100% !important" :options="categoryOptions" v-model="form.Category" placeholder="Select a category"></model-select>  
                        <button class="btn-new" style="margin: 0rem 0.3rem" v-on:click= "showingAddCategory = true"><i class="fa fa-plus"></i></button>
                    </div>
                    <div class="" v-show = "showingAddCategory" style="margin-right:2rem">
                        <div class="form-field-title">
                          <span><strong> Name (required) </strong></span> 
                        </div>
                        <div class="field is-horizontal" >
                            <input type="text" class="input" placeholder="Name" v-model="newCategory">
                            <button class="button is-rounded is-primary" style="margin-left: .6rem" v-on:click="createNewCategory">Add</button>
                            <button class="button is-rounded" style="margin-left: .6rem" v-on:click="() =>{
                              showingAddCategory = false;
                              newCategory = '';
                              }">Cancel</button>
                        </div>
                    </div>
                </div>
                <div class="" style="">
                    <div class="form-field-title">
                      <span><strong>  Vendor (required) </strong></span>
                      <span v-if="CreateEquipmentErrors.NoVendor != ''">. <span class="error-text">{{ CreateEquipmentErrors.NoVendor }}</span></span>
                    </div>
                    <div class="field is-horizontal" >
                        <model-select style="width: 100% !important" :options="vendorOptions" v-model="selectedVendor" placeholder="Select a vendor"></model-select>  
                        <button class="btn-new" style="margin: 0rem 0.3rem" v-on:click= "showingAddVendor = true"><i class="fa fa-plus"></i></button>
                    </div> 
                    <div class="" v-show = "showingAddVendor" >
                      <div class="">
                        <span><strong> Name (required) </strong></span>
                      </div>
                      <div class="field is-horizontal" >
                          <input type="text" class="input" placeholder="Name" v-model="newVendor">
                          <button class="button is-rounded is-primary" style="margin-left: .6rem" v-on:click ="createNewVendor">Add</button>
                          <button class="button is-rounded" style="margin-left: .6rem" v-on:click="() =>{
                              showingAddVendor = false;
                              newVendor = '';
                              }">Cancel</button>
                      </div>
                    </div>
                </div>                 
            </div>   
            <div class="field" style="margin-left: 3rem; margin-top: 0.9rem; margin-right: 2rem; display: grid; grid-template-columns: 50% 50%">
                <div class="">
                    <div class="form-field-title" >
                       <span><strong> Maintenance Duration(Months) (required) </strong></span>
                      <span v-if="CreateEquipmentErrors.NoMaintenanceDuration != ''">. <span class="error-text">{{ CreateEquipmentErrors.NoMaintenanceDuration }}</span></span>
                    </div>
                    <div class="field is-horizontal" style="">
                        <model-select style="width: 100% !important" :options="maintenanceDurationOptions" v-model="form.MaintenanceDuration" placeholder="Select maintenance duration (months)"></model-select>  
                        <button class="btn-new" style="margin: 0rem 0.3rem" v-on:click= "showingAddMaintenanceDuration = true"><i class="fa fa-plus"></i></button>
                    </div>
                    <div class="" v-show = "showingAddMaintenanceDuration" style="margin-right:2rem">
                        <div class="form-field-title">
                        <span><strong> Duration (required) </strong></span> 
                        </div>
                        <div class="field is-horizontal" >
                            <input type="text" class="input" placeholder="Duration (month)" v-model="newDuration" v-on:input="() => {
                            if (newDuration < 1 || newDuration == '') {
                                newDuration = 0;
                            } else if (newDuration > 60) {
                                newDuration = 60;
                            }
                            newDuration = getNumberFormattedThousand(newDuration);
                        }">
                            <button class="button is-rounded is-primary" style="margin-left: .6rem" v-on:click="createNewMaintenanceDuration">Add</button>
                            <button class="button is-rounded" style="margin-left: .6rem" v-on:click="() =>{
                              showingAddMaintenanceDuration = false;
                              newDuration = 3;
                              }">Cancel</button>
                        </div>
                    </div>
                </div>
                 <div class="" style="">
                    <div class="form-field-title" >
                       <span><strong> Unit (required) </strong></span>
                       <span v-if="CreateEquipmentErrors.NoUnit != ''">. <span class="error-text">{{ CreateEquipmentErrors.NoUnit }}</span></span>
                    </div>
                    <div class="field is-horizontal" style="">
                        <model-select style="width: 100% !important" :options="unitOptions" v-model="form.Unit" placeholder="Select a unit"></model-select>  
                        <button class="btn-new" style="margin: 0rem 0.3rem" v-on:click= "showingAddUnit = true"><i class="fa fa-plus"></i></button>
                    </div>
                    <div class="" v-show = "showingAddUnit" style="margin-right:2rem">
                        <div class="form-field-title">
                        <span><strong> Name (required) </strong></span> 
                        </div>
                        <div class="field is-horizontal" >
                            <input type="text" class="input" placeholder="Name" v-model="newUnit">
                            <button class="button is-rounded is-primary" style="margin-left: .6rem" v-on:click="createNewUnit">Add</button>
                            <button class="button is-rounded" style="margin-left: .6rem" v-on:click="() =>{
                              showingAddUnit = false;
                              newUnit = '';
                              }">Cancel</button>
                        </div>
                    </div>
                </div>                  
            </div>  
            <div class="form-field">
                <div class="form-field-title">
                  <span><strong>  Made In </strong></span>
                  <span v-if="CreateEquipmentErrors.MadeInTooLong != ''">. <span class="error-text">{{ CreateEquipmentErrors.MadeInTooLong }}</span></span>
                </div>
                <div class="form-field-input">
                    <input type="text" class="input" placeholder="Made In" v-model="form.MadeIn">
                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                  <span><strong>  Description </strong></span>
                  <span v-if="CreateEquipmentErrors.DescriptionTooLong != ''">. <span class="error-text">{{ CreateEquipmentErrors.DescriptionTooLong }}</span></span>
                </div>
                <div class="form-field-input">
                    <input type="text" class="input" placeholder="Description" v-model="form.Description">
                </div>
            </div>
        </div>               
    </div>
</template>

<script>
import AddEquipment from "./AddEquipment";
import VueBase64FileUpload from "vue-base64-file-upload";
import { ModelSelect } from "vue-search-select";
import Autocomplete from "./Autocomplete";
import Utils from "@/utils.js";
import fileBase64 from "vue-file-base64";
import moment from "moment";
import Simplert from "vue2-simplert";
import numeral from "numeral";
export default {
  props: ["filterby"],
  components: {
    Simplert,
    AddEquipment,
    VueBase64FileUpload,
    ModelSelect,
    Autocomplete
  },
  created() {
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
      .get("http://localhost:3000/api/EquipmentCategory/getAllCate")
      .then(response => {
        let data = response.data;
        data.forEach(category => {
          if (category.Status) {
            let option = {
              text: category.Name,
              value: category.Id
            };
            this.categoryOptions.push(option);
          }
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
          let option = {
            text: unit.Name,
            value: unit.Id
          };
          this.unitOptions.push(option);
        });
      })
      .catch(error => {
        alert(error);
      });
    this.axios
      .get("http://localhost:3000/api/vendor")
      .then(response => {
        let data = response.data;
        data.forEach(vendor => {
          if (vendor.Status) {
            let option = {
              text: vendor.BusinessName,
              value: vendor.Id
            };
            this.vendorOptions.push(option);
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
          let option = {
            text: maintenanceDuration.Months,
            value: maintenanceDuration.Id
          };
          this.maintenanceDurationOptions.push(option);
        });
      })
      .catch(error => {
        alert(error);
      });
  },
  data() {
    return {
      CreateEquipmentErrors: {
        NoImage: "",
        NoName: "",
        NameLength: "",
        NoCategory: "",
        NoVendor: "",
        NoUnit: "",
        NoMaintenanceDuration: "",
        MadeInTooLong: "",
        DescriptionTooLong: ""
      },
      ErrorStrings: {
        NoImage: "You must choose an image",
        NoName: "You must enter equipment name",
        NameLength:
          "The length of name must be more than 5 characters and less than 250 characters",
        NoCategory: "Please choose a category",
        NoVendor: "Please choose a vendor",
        NoUnit: "Please choose a unit",
        NoMaintenanceDuration: "Please choose duration",
        DescriptionTooLong: "Description can be contained 250 characters",
        MadeInTooLong: "MadeIn can be contained 50 characters"
      },
      form: {
        EquipmentName: "",
        Category: "",
        Vendor: "",
        Unit: "",
        MaintenanceDuration: "",
        MadeIn: "",
        Description: "",
        Price: 500000,
        Warranty: 1
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
      selectedEquipment: {
        text: "",
        value: ""
      },
      selectedVendor: {
        text: "",
        value: ""
      },
      selectedUnit: {
        text: "",
        value: ""
      },
      selectedDuration: {
        text: "",
        value: ""
      },
      byName: "",
      imageUrl: "",
      newCategory: "",
      newVendor: "",
      newUnit: "",
      newDuration: 3,
      showingAddCategory: false,
      showingAddVendor: false,
      showingAddUnit: false,
      showingAddMaintenanceDuration: false,
      showingBarcode: false,
      unitOptions: [],
      categoryOptions: [],
      vendorOptions: [],
      maintenanceDurationOptions: [],
      equipmentOptions: [],
      files: [],
      randomNumbers: [],
      existEquipment: [],
      equipments: [],
      quantity: 1,
      validateExistEquipment: false,
      file: "",
      visible: false,
      checked: false
    };
  },

  methods: {
    getNumberFormattedThousand(str) {
      let value = numeral(str).value();
      return numeral(value).format("0,0");
    },
    EquipSelected(equipment) {
      console.log(
        `Customer Selected:\nid: ${equipment.Dd}\nname: ${equipment.Name}`
      );
    },
    onChange(value) {
      // do something with the current value
    },
    onFileChanged() {
      this.selectedFile = this.$refs.file.files[0];
    },
    onUpload() {
      let formData = new FormData();
      formData.append("file", this.file);
      alert("in");
      this.axios.post(
        "https://api.cloudinary.com/v1_1/deanwflps/image/upload",
        formData
      );
      alert(this.selectedFile.name);
    },
    inputFileChange() {
      this.files = this.$refs.fileInput.files;
    },
    getFilePath(file) {
      return window.URL.createObjectURL(file);
    },
    checkExistEquipment() {
      this.validateExistEquipment = false;
      this.axios
        .get(
          "http://localhost:3000/api/equipment/" +
            this.selectedEquipment.value +
            "/" +
            this.selectedVendor.value
        )
        .then(response => {
          let data = response.data;
          if (data.Quantity == 1) {
            this.validateExistEquipment = true;
          }
        })
        .catch(error => {
          alert(error);
        });
    },
    async createNewCategory() {
      if (this.newCategory.trim() == "") {
        let obj = {
          message: "Please enter new category!!!",
          type: "warning",
          showXclose: false
        };
        this.$refs.simplert.openSimplert(obj);
      } else {
        var duplicate = 0;
        for (var i = 0; i < this.categoryOptions.length; i++) {
          if (
            this.categoryOptions[i].text.toUpperCase() ==
            this.newCategory.trim().toUpperCase()
          ) {
            duplicate = duplicate + 1;
          }
        }
        if (duplicate == 0) {
          let res = await this.axios
            .post("http://localhost:3000/api/EquipmentCategory/categoryName", {
              name: this.newCategory
            })
            .catch(function(error) {
              console.log(error);
              alert("Add failed: " + error);
            });
          if (res.status == 200) {
            let obj = {
              message: "Create new category successfully",
              type: "success",
              hideAllButton: true,
              showXclose: false
            };
            this.$refs.simplert.openSimplert(obj);
            await Utils.sleep(1100);
            location.reload();
          }
        } else {
          let obj = {
            message: "This category is existed!!!",
            type: "warning",
            showXclose: false
          };
          this.$refs.simplert.openSimplert(obj);
        }
      }
    },
    async createNewVendor() {
      if (this.newVendor.trim() == "") {
        let obj = {
          message: "Please enter new vendor name!!!",
          type: "warning",
          showXclose: false
        };
        this.$refs.simplert.openSimplert(obj);
      } else {
        var duplicate = 0;
        for (var i = 0; i < this.vendorOptions.length; i++) {
          if (
            this.vendorOptions[i].text.toUpperCase() ==
            this.newVendor.trim().toUpperCase()
          ) {
            duplicate = duplicate + 1;
          }
        }
        if (duplicate == 0) {
          let res = await this.axios
            .post("http://localhost:3000/api/Vendor/vendorName", {
              businessName: this.newVendor
            })
            .catch(function(error) {
              console.log(error);
            });
          if (res.status == 200) {
            let obj = {
              message: "Create new vendor successfully",
              type: "success",
              hideAllButton: true,
              showXclose: false
            };
            this.$refs.simplert.openSimplert(obj);
            await Utils.sleep(1100);
            location.reload();
          }
        } else {
          let obj = {
            message: "This vendor is existed!!!",
            type: "warning",
            showXclose: false
          };
          this.$refs.simplert.openSimplert(obj);
        }
      }
    },
    async createNewUnit() {
      if (this.newUnit.trim() == "") {
        let obj = {
          message: "Please enter new unit!!!",
          type: "warning",
          showXclose: false
        };
        this.$refs.simplert.openSimplert(obj);
      } else {
        var duplicate = 0;
        for (var i = 0; i < this.unitOptions.length; i++) {
          if (
            this.unitOptions[i].text.toUpperCase() ==
            this.newUnit.trim().toUpperCase()
          ) {
            duplicate = duplicate + 1;
          }
        }
        if (duplicate == 0) {
          let res = await this.axios
            .post("http://localhost:3000/api/unit", {
              name: this.newUnit
            })
            .catch(function(error) {
              console.log(error);
            });
          if (res.status == 200) {
            let obj = {
              message: "Create new unit successfully",
              type: "success",
              hideAllButton: true,
              showXclose: false
            };
            this.$refs.simplert.openSimplert(obj);
            await Utils.sleep(1100);
            location.reload();
          }
        } else {
          let obj = {
            message: "This unit is existed!!!",
            type: "warning",
            showXclose: false
          };
          this.$refs.simplert.openSimplert(obj);
        }
      }
    },
    async createNewMaintenanceDuration() {
      if (this.newDuration == "" || this.newDuration < 3) {
        let obj = {
          message: "Maintaince duration must be from 3 to 60 months",
          type: "warning",
          showXclose: false
        };
        this.$refs.simplert.openSimplert(obj);
      } else {
        var duplicate = 0;
        for (var i = 0; i < this.maintenanceDurationOptions.length; i++) {
          if (this.maintenanceDurationOptions[i].text == this.newDuration) {
            duplicate = duplicate + 1;
          }
        }
        if (duplicate == 0) {
          let res = await this.axios
            .post("http://localhost:3000/api/maintenanceDuration", {
              month: this.newDuration
            })
            .catch(function(error) {
              console.log(error);
            });
          if (res.status == 200) {
            let obj = {
              message: "Create new maintaince duration successfully",
              type: "success",
              hideAllButton: true,
              showXclose: false
            };
            this.$refs.simplert.openSimplert(obj);
            await Utils.sleep(1100);
            location.reload();
          }
        } else {
          let obj = {
            message: "This maintaince duration is existed!!!",
            type: "warning",
            showXclose: false
          };
          this.$refs.simplert.openSimplert(obj);
        }
      }
    },
    async createNewEquipment() {
      // this.checkExistEquipment();
      // if (this.validateExistEquipment) {
      //   alert("This equipment is exist with this vendor");
      // }
      // else {
      // this.files[0].name = "";
      // alert(this.files[0].name);
      let context = this;
      var exist = 0;

      if (
        this.form.EquipmentName.trim().length < 5 ||
        this.form.EquipmentName.trim().length > 250
      ) {
        if (this.form.EquipmentName.trim() === "") {
          this.CreateEquipmentErrors.NoName = this.ErrorStrings.NoName;
          this.CreateEquipmentErrors.NameLength = "";
        } else {
          this.CreateEquipmentErrors.NameLength = this.ErrorStrings.NameLength;
        }
      }
      if (this.selectedVendor.value === "") {
        this.CreateEquipmentErrors.NoVendor = this.ErrorStrings.NoVendor;
      }
      if (this.form.Category === "") {
        this.CreateEquipmentErrors.NoCategory = this.ErrorStrings.NoCategory;
      }
      if (this.form.Unit === "") {
        this.CreateEquipmentErrors.NoUnit = this.ErrorStrings.NoUnit;
      }
      if (this.form.Unit === "") {
        this.CreateEquipmentErrors.NoMaintenanceDuration = this.ErrorStrings.NoMaintenanceDuration;
      }
      if (this.form.MadeIn.trim().length > 50) {
        this.CreateEquipmentErrors.MadeInTooLong = this.ErrorStrings.MadeInTooLong;
      }
      if (this.form.Description.trim().length > 250) {
        this.CreateEquipmentErrors.DescriptionTooLong = this.ErrorStrings.DescriptionTooLong;
      }
      if (this.files[0] && this.files[0].name) {
        this.CreateEquipmentErrors.NoImage = "";
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
      } else {
        //  alert(this.files[0])
        //alert(this.files[0].name)
        this.CreateEquipmentErrors.NoImage = this.ErrorStrings.NoImage;
      }
      if (
        this.CreateEquipmentErrors.NoImage === "" &&
        this.CreateEquipmentErrors.NoName === "" &&
        this.CreateEquipmentErrors.NoCategory === "" &&
        this.CreateEquipmentErrors.NoVendor === "" &&
        this.CreateEquipmentErrors.NoUnit === "" &&
        this.CreateEquipmentErrors.NameLength === "" &&
        this.CreateEquipmentErrors.NoMaintenanceDuration === ""
      ) {
        for (var i = 0; i < context.equipments.length; i++) {
          if (
            context.form.EquipmentName.toUpperCase() ===
              context.equipments[i].Name.toUpperCase() &&
            context.selectedVendor.value == context.equipments[i].VendorId
          ) {
            exist = exist + 1;
          }
        }
        if (exist == 0) {
          context.axios
            .post("http://localhost:3000/api/equipment", {
              name: context.form.EquipmentName,
              vendorID: context.selectedVendor.value,
              image: context.imageUrl,
              madein: context.form.MadeIn,
              description: context.form.Description,
              categoryID: context.form.Category,
              unitID: context.form.Unit,
              maintenanceDurationID: context.form.MaintenanceDuration
            })
            .then(async function(respone) {
              // console.log(respone);
              if (respone.status == 200) {
                let obj = {
                  message: "A new equipment is created successfully",
                  type: "success",
                  hideAllButton: true,
                  showXclose: false
                };
                context.$refs.simplert.openSimplert(obj);
                await Utils.sleep(1500);
                context.$router.push("/equipment");
              }
            })
            .catch(function(error) {
              console.log(error);
            });
        } else {
          let obj = {
            title: "Existed",
            message:
              "This equipment was supplied by " + context.selectedVendor.text,
            type: "warning",
            // hideAllButton: true,
            showXclose: false
          };
          context.$refs.simplert.openSimplert(obj);
        }
      }
    },
    getRandomNumber() {
      if (this.form.Category == "") {
        alert("Please choose category");
      } else {
        this.randomNumbers = [];
        for (var i = 0; i < this.quantity; i++) {
          var number = "";
          if (0 < this.form.Category && this.form.Category < 10) {
            number = "00" + this.form.Category;
          } else if (10 <= this.form.Category && this.form.Category < 100) {
            number = "0" + this.form.Category;
          } else if (100 <= this.form.Category && this.form.Category < 1000) {
            number = this.form.Category;
          } else {
            number = "000";
          }
          number = number + Math.floor(Math.random() * 900000000 + 100000000);
          this.randomNumbers.push(number);
        }
        this.showingBarcode = true;
      }
    },
    createNewEquipentItem() {
      let result = false;
      if (this.form.Price === "" || this.form.Price < 50000) {
        alert("Please enter price more than 50000");
      } else if (this.form.Warranty === "" || this.form.Warranty < 1) {
        alert("Please enter warranty duration more than 1");
      } else if (this.randomNumbers.length == 0) {
        alert("Please create serial number for item(s) to add");
      } else if (this.selectedTile.value === "") {
        alert("Please choose tile for item(s)");
      } else {
        let name = this.form.EquipmentName.trim();
        this.axios
          .get("http://localhost:3000/api/equipment/byName/" + name)
          .then(function(respone) {
            this.byName = response.data;
          })
          .catch(function(error) {
            console.log(error);
          });
        alert(byName.Id);
        // for (var i = 0; i < this.quantity; i++) {
        //   this.axios
        //     .post("http://localhost:3000/api/equipmentItem", {
        //       equipmentID: EQTNameID.Id,
        //       serialNumber: this.randomNumbers[i],
        //       warrantyDuration: this.form.Warranty,
        //       price: this.form.Price,
        //       statusId: 1,
        //       description: "No description",
        //       tileID: this.selectedTile.value
        //     })
        //     .then(function(respone) {
        //       result = true;
        //     })
        //     .catch(function(error) {
        //       console.log(error);
        //     });
        // }
        if ((result = true)) {
          alert("Add " + this.quantity + " item(s) successfully!");
          location.reload();
        }
      }
    }
  },
  // watch: {
  //   selectedEquipment: function() {
  //     this.axios
  //       .get(
  //         "http://localhost:3000/api/equipment/" + this.selectedEquipment.text
  //       )
  //       .then(response => {
  //         let data = response.data;
  //         //alert("IN");
  //         //let equipment = element.Equipment;
  //         this.existEquipment.push(data);
  //         if (this.existEquipment.length > 0) {
  //           //alert("exist");
  //         }
  //       })
  //       .catch(error => {
  //         alert(error);
  //       });
  //   }
  // }
  watch: {
    "form.EquipmentName": function() {
      if (
        this.form.EquipmentName.trim() != "" &&
        this.CreateEquipmentErrors.NoName != ""
      ) {
        this.CreateEquipmentErrors.NoName = "";
      }
      if (
        this.form.EquipmentName.trim().length >= 5 &&
        this.CreateEquipmentErrors.NameLength != "" &&
        this.form.EquipmentName.trim().length < 250
      ) {
        this.CreateEquipmentErrors.NameLength = "";
      }
    },
    selectedVendor: function() {
      if (
        this.selectedVendor.value != "" &&
        this.CreateEquipmentErrors.NoVendor != ""
      ) {
        this.CreateEquipmentErrors.NoVendor = "";
      }
    },
    "form.Category": function() {
      if (
        this.form.Category != "" &&
        this.CreateEquipmentErrors.NoCategory != ""
      ) {
        this.CreateEquipmentErrors.NoCategory = "";
      }
    },
    "form.Unit": function() {
      if (this.form.Unit != "" && this.CreateEquipmentErrors.NoUnit != "") {
        this.CreateEquipmentErrors.NoUnit = "";
      }
    },
    "form.MaintenanceDuration": function() {
      if (
        this.form.MaintenanceDuration != "" &&
        this.CreateEquipmentErrors.NoMaintenanceDuration != ""
      ) {
        this.CreateEquipmentErrors.NoMaintenanceDuration = "";
      }
    },
    "form.MadeIn": function() {
      if (
        this.form.MadeIn.trim().length < 250 &&
        this.CreateEquipmentErrors.MadeInTooLong != ""
      ) {
        this.CreateEquipmentErrors.MadeInTooLong = "";
      }
    },
    "form.Description": function() {
      if (
        this.form.Description.trim().length < 250 &&
        this.CreateEquipmentErrors.DescriptionTooLong != ""
      ) {
        this.CreateEquipmentErrors.DescriptionTooLong = "";
      }
    },
    files: function() {
      if (
        this.files[0] &&
        this.files[0].name &&
        this.CreateEquipmentErrors.NoImage != ""
      ) {
        this.CreateEquipmentErrors.NoImage = "";
      }
    },
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
.form {
  background-color: white;
  /* margin: 0 1.5rem; */
  padding: 0 !important;
  z-index: 99;
}
.form-title {
  display: grid;
  grid-template-columns: 50% 50%;
  border-bottom: 1px solid #e0e0e0;
  padding: 1rem 2rem;
}
.form-title-start {
  position: relative;
  /* top: 10px; */
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

#btn-cancel {
  background-color: #bdbdbd;
}

#btn-add {
  background-color: var(--primary-color);
  padding: 13px;
  color: white;
  border-radius: 10px;
  box-shadow: 4px 4px 5px #bdbdbd;
}

.form-field {
  /* margin-bottom: 5px; */
  padding: 1rem 3rem;
}
.form-field-picture {
  padding: 1rem 3rem;
  border: none;
}

.form-field-title {
  font-size: 15px;
}

.input_picture {
  padding: 1rem 3rem 1rem 3rem;
  outline: 1px dashed #a8a8a8fb;
  background-color: #f0efeffb;
  display: flex;
}
.file-cta {
  border: none;
  background-color: #a8a8a8fb;
  margin: auto;
}
.file-upload {
  padding-left: 2rem;
}
.box {
  height: 5rem;
  outline: none;
  border-style: none;
  background-color: aliceblue;
  align-items: center;

  font-size: 13px;
}
.btn-new {
  background-color: #26a69a;
  border: none;
  color: white;
  align-content: center;
  position: relative;
  top: 0.3rem;
  font-size: 10px;
  cursor: pointer;
  border-radius: 50%;
  width: 1.5rem;
  height: 1.5rem;
}
.btn-new:hover {
  color: #fafafa;
  background-color: #80deea;
}
.input-new-name {
  border: 1px solid black;
}
.form-content {
  /* position: fixed;
  max-height: 100%;
  width: 85%;
  overflow-y: scroll;*/
  max-height: 82.5%;
  width: 85%;
  position: fixed;
  overflow-y: auto;
}
.hr {
  border-top: 0.5px solid #616161;
  margin: 1rem 3rem;
}
</style>
