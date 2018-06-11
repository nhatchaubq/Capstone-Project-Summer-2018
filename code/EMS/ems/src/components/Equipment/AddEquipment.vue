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

        <div>           
            
            <div class="form-field-picture">
                <div class="form-field-title">
                    Picture
                </div>

                <div class="input_picture">                    
                    <label class="file-label" style="width: 100% !important"> 

                    <span class="file-cta">
                        <input class="file-input" type="file" ref="fileInput" v-on:change="inputFileChange" multiple />
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
                            <img class="file-upload" v-bind:src="getFilePath(file)"/>
                        </div>

                        </div>
                    </label>
                </div> 
            </div>

            <div class="form-field">
                <div class="form-field-title">
                    Equipment Name
                </div>
                <div class="form-field-input" >
                    <model-select style="width: 100% !important" :options="equipmentOptions" v-model="form.EquipmentName" placeholder="Equipment Name"></model-select>  
                </div>
            </div>
            <div class="field" style="margin-left: 3rem; display: grid; grid-template-columns: 50% 50%">
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
                            <input type="text" class="input" placeholder="Name">
                            <button class="button is-rounded is-primary" style="margin-left: .6rem">Add</button>
                            <button class="button is-rounded" style="margin-left: .6rem" v-on:click= "showingAddCategory = false">Cancel</button>
                        </div>
                    </div>
                </div>
                <div class="" style="margin-right: 1.1rem">
                    <div class="form-field-title">
                        Vendor
                    </div>
                    <div class="field is-horizontal" >
                        <model-select style="width: 100% !important" :options="vendorOptions" v-model="form.Vendor" placeholder="Select a vendor"></model-select>  
                        <button class="btn-new" style="margin: 0rem 0.3rem" v-on:click= "showingAddVendor = true"><i class="fa fa-plus"></i></button>
                    </div> 
                    <div class="" v-show = "showingAddVendor" >
                    <div class="">
                       Name
                    </div>
                    <div class="field is-horizontal" >
                        <input type="text" class="input" placeholder="Name">
                        <button class="button is-rounded is-primary" style="margin-left: .6rem">Add</button>
                        <button class="button is-rounded" style="margin-left: .6rem" v-on:click= "showingAddVendor = false">Cancel</button>
                    </div>
                    </div>
                </div>                  
            </div>    
            <div class="form-field">
                <div class="form-field-title">
                    Price
                </div>
                <div class="form-field-input">
                    <input type="text" class="input" placeholder="Price" v-model="form.Price">
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
            <div class="form-field">
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
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Warranty
                </div>
                <div class="field is-horizontal">
                    <input type="number" class="input" placeholder="Warranty Months" v-model="form.Warranty">
                </div>
            </div>
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

  data() {
    return {
      form: {
        EquipmentName: "",
        Category: "",
        Vendor: "",
        Price: "",
        MadeIn: "",
        Description: ""
      },
      showingAddCategory: false,
      showingAddVendor: false,
      showingBarcode: false,
      categoryOptions: [],
      vendorOptions: [],
      equipmentOptions: [],
      files: [],
      randomNumbers: [],
      quantity: 1,
      customImageMaxSize: 3
    };
  },

  methods: {
    handleFileChange(e) {
      this.$emit("input", e.target.files[0]);
    },
    inputFileChange() {
      this.files = this.$refs.fileInput.files;
    },
    getFilePath(file) {
      return window.URL.createObjectURL(file);
    },
    createNewEquipment() {
      this.axios
        .post("http://localhost:3000/api/equipment", {
          name: this.form.EquipmentName,
          vendorID: this.form.Vendor,
          price: this.form.Price,
          madein: this.form.MadeIn,
          description: this.form.description,
          categoryID: this.form.Category
        })
        .then(function(respone) {
          // console.log(respone);
        })
        .catch(function(error) {
          console.log(error);
        });
    },
    getRandomNumber() {
      this.randomNumbers = [];
      for (var i = 0; i < this.quantity; i++) {
        var number = Math.floor(Math.random() * 9000000000000 + 1000000000000);
        this.randomNumbers.push(number);
      }
      this.showingBarcode = true;
    },
    onFile(file) {
      console.log(file); // file object
    },

    onLoad(dataUri) {
      console.log(dataUri); // data-uri string
    },

    onSizeExceeded(size) {
      alert(
        `Image ${size}Mb size exceeds limits of ${this.customImageMaxSize}Mb!`
      );
    }
    // createBarcode(){
    //     var barcode ="";
    //     for (var i=0; i<13; i++){
    //         var x = this.getRandomNumber();
    //         barcode = barcode + x;
    //     }
    //     return barcode;
    // }
  }
};
</script>

<style scoped>
.form {
  background-color: white;
  margin: 0 1.5rem;
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
</style>
