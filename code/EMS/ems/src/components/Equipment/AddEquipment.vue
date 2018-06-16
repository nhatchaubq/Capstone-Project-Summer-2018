<template>
    <div class="form">
        <div class="form-title">
            <div class="form-title-start">
                Add New Equipment
            </div>            
            <div class="form-title-end">
                <button id="" class="button is-rounded" style="margin-right: .6rem">Cancel</button>
                <button id="" class="button is-rounded is-primary" v-on:click="createNewEquipment">Create New Equipment</button>
            </div>
        </div>
        <div class="form-content">            
            <div class="form-field-picture">
                <div class="form-field-title">
                    Picture
                </div>

                <div class="input_picture">                    
                    <label class="file-label" style="width: 100% !important"> 
                    <span class="file-cta">
                        <input class="file-input" type="file" ref="fileInput" v-on:change="inputFileChange"  />
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
                            <img class="file-upload" v-bind:src="getFilePath(file)" style="width: 75px height:75px"/>
                        </div>

                        </div>
                    </label>
                    <input type="file" id="file"  v-on:change="onFileChanged">
                    <button v-on:click="onUpload">Upload!!!</button>
                </div> 
            </div>

            <div class="form-field">
                <div class="form-field-title">
                    Equipment Name
                </div>
                <div class="form-field-input" >
                  <!-- <model-select style="width: 100% !important" :options="equipmentOptions" v-model="selectedEquipment" placeholder="Equipment Name"></model-select>   -->
                  <input type="text" class="input" placeholder="EquipmentName" v-model="form.EquipmentName">
                </div>
            </div>
            <div class="field" style="margin-left: 3rem; margin-right: 1.5rem; display: grid; grid-template-columns: 50% 50%">
                <div>
                    <div class="form-field-title" >
                        Category
                    </div>
                    <div class="field is-horizontal" style="margin-right:6rem">
                        <model-select style="width: 100% !important" :options="categoryOptions" v-model="form.Category" placeholder="Select a category"></model-select>  
                        <button class="btn-new" style="margin: 0rem 0.3rem" v-on:click= "showingAddCategory = true"><i class="fa fa-plus"></i></button>
                    </div>
                    <div class="" v-show = "showingAddCategory" style="margin-right:2rem">
                        <div class="form-field-title">
                        Name
                        </div>
                        <div class="field is-horizontal" >
                            <input type="text" class="input" placeholder="Name" v-model="newCategory">
                            <button class="button is-rounded is-primary" style="margin-left: .6rem" v-on:click="createNewCategory">Add</button>
                            <button class="button is-rounded" style="margin-left: .6rem" v-on:click= "showingAddCategory = false">Cancel</button>
                        </div>
                    </div>
                </div>
                <div class="" style="margin-right: 1.1rem">
                    <div class="form-field-title">
                        Vendor
                    </div>
                    <div class="field is-horizontal" >
                        <model-select style="width: 100% !important" :options="vendorOptions" v-model="selectedVendor" placeholder="Select a vendor"></model-select>  
                        <button class="btn-new" style="margin: 0rem 0.3rem" v-on:click= "showingAddVendor = true"><i class="fa fa-plus"></i></button>
                    </div> 
                    <div class="" v-show = "showingAddVendor" >
                    <div class="">
                       Name
                    </div>
                    <div class="field is-horizontal" >
                        <input type="text" class="input" placeholder="Name" v-model="newVendor">
                        <button class="button is-rounded is-primary" style="margin-left: .6rem" v-on:click ="createNewVendor">Add</button>
                        <button class="button is-rounded" style="margin-left: .6rem" v-on:click= "showingAddVendor = false">Cancel</button>
                    </div>
                    </div>
                </div>                  
            </div>    
            <div class="form-field">
                <div class="form-field-title">
                    Made In
                </div>
                <div class="form-field-input">
                    <input type="text" class="input" placeholder="Made In" v-model="form.MadeIn">
                </div>
            </div>
            <!-- <div class="form-field">
                <div class="form-field-title">
                    Quantity
                </div>
                <div class="field is-horizontal">
                    <input type="number" min="1" class="input" placeholder="Quantity" style="margin-right: 1rem" v-model="quantity" >
                    <button type="submit" class="button is-primary is-focused" name="GenerateBarcode" v-on:click="getRandomNumber">Barcode</button>
                </div>
                <div v-show="showingBarcode">
                    <ul>
                        
                        <li v-for="i in randomNumbers" :key="i">{{i}}</li>
                    </ul>
                </div>
            </div> -->
            <!-- <div class="form-field">
                <div class="form-field-title">
                    Warranty
                </div>
                <div class="field is-horizontal">
                    <input type="number" class="input" placeholder="Warranty Months" v-model="form.Warranty">
                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Price
                </div>
                <div class="form-field-input">
                    <input type="text" class="input" placeholder="Price" v-model="form.Price">
                </div>
            </div> -->
            <div class="form-field">
                <div class="form-field-title">
                    Description
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
export default {
  components: {
    AddEquipment,
    VueBase64FileUpload,
    ModelSelect
  },
  created() {
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
      .get("http://localhost:3000/api/equipment")
      .then(response => {
        let data = response.data;
        data.forEach(element => {
          let option = {
            text: element.Equipment.Name,
            value: element.Equipment.Id
          };
          this.equipmentOptions.push(option);
        });
      })
      .catch(error => {
        alert(error);
      });
  },
  createdCategory() {
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
  },
  data() {
    return {
      form: {
        EquipmentName: "",
        Category: "",
        Vendor: "",
        MadeIn: "",
        Description: ""
      },
      selectedEquipment: {
        text: "",
        value: ""
      },
      selectedVendor: {
        text: "",
        value: ""
      },
      newCategory: "",
      newVendor: "",
      showingAddCategory: false,
      showingAddVendor: false,
      showingBarcode: false,
      categoryOptions: [],
      vendorOptions: [],
      equipmentOptions: [],
      files: [],
      randomNumbers: [],
      existEquipment: [],
      quantity: 1,
      validateExistEquipment: false,
      file: ""
    };
  },

  methods: {
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
    createNewCategory() {
      this.axios
        .post("http://localhost:3000/api/EquipmentCategory", {
          name: this.newCategory
        })
        .then(function(respone) {
          // console.log(respone);
        })
        .catch(function(error) {
          console.log(error);
        });
    },
    createNewVendor() {
      this.axios
        .post("http://localhost:3000/api/Vendor", {
          businessName: this.newVendor
        })
        .then(function(respone) {
          // console.log(respone);
          alert("Add successfully");
          this.created();
        })
        .catch(function(error) {
          console.log(error);
        });
    },
    createNewEquipment() {
      // this.checkExistEquipment();
      // if (this.validateExistEquipment) {
      //   alert("This equipment is exist with this vendor");
      // }
      // else {
      this.axios
        .post("http://localhost:3000/api/equipment", {
          name: this.form.EquipmentName,
          vendorID: this.selectedVendor.value,
          madein: this.form.MadeIn,
          description: this.form.Description,
          categoryID: this.form.Category
        })
        .then(function(respone) {
          // console.log(respone);
        })
        .catch(function(error) {
          console.log(error);
        });
      //   }
    }
    // getRandomNumber() {
    //   this.randomNumbers = [];
    //   for (var i = 0; i < this.quantity; i++) {
    //     var number = Math.floor(Math.random() * 9000000000000 + 1000000000000);
    //     this.randomNumbers.push(number);
    //   }
    //   this.showingBarcode = true;
    // }
    // createBarcode(){
    //     var barcode ="";
    //     for (var i=0; i<13; i++){
    //         var x = this.getRandomNumber();
    //         barcode = barcode + x;
    //     }
    //     return barcode;
    // }
  },
  watch: {
    selectedEquipment: function() {
      this.axios
        .get(
          "http://localhost:3000/api/equipment/" + this.selectedEquipment.text
        )
        .then(response => {
          let data = response.data;
          //alert("IN");
          //let equipment = element.Equipment;
          this.existEquipment.push(data);
          if (this.existEquipment.length > 0) {
            //alert("exist");
          }
        })
        .catch(error => {
          alert(error);
        });
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
  grid-template-columns: 25% 40% 35%;
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
  outline: 2px dashed #a8a8a8fb;
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
  position: fixed;
  max-height: 100%;
  width: 85%;
  overflow-y: scroll;
}
</style>
