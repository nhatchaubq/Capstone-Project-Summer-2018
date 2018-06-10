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
                    <input type="text" class="input" placeholder="Equipment Name" v-model="form.AssetName">
                </div>
            </div>
            <div class="field is-horizontal" style="margin-left: 3rem">
                <div>
                    <div class="form-field-title" >
                        Category
                    </div>
                    <div class="field is-horizontal" style="margin-right:6rem">
                        <div class="select" >
                        <select v-model="form.Category">
                            <option v-bind:key="category.id" v-for="category in categories" :value="category.Name">{{ category.Name }}</option>
                        </select>  
                        </div>
                        <button class="btn-new" style="margin: 0rem 0.3rem" v-on:click= "showingAddCategory = true"><i class="fa fa-plus"></i></button>
                    </div>
                    <div class="" v-show = "showingAddCategory" style="margin-right:2rem">
                    <div class="form-field-title">
                       Name
                    </div>
                    <div class="field is-horizontal" >
                        <input type="text" class="input-new-name" placeholder="Name">
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
                        <div class="select" >
                        <select v-model="form.Vendor">
                            <option v-bind:key="vendor.id" v-for="vendor in vendors" :value="vendor.BusinessName">{{ vendor.BusinessName }}</option>
                        </select>  
                        </div>
                        <button class="btn-new" style="margin: 0rem 0.3rem" v-on:click= "showingAddVendor = true"><i class="fa fa-plus"></i></button>
                    </div> 
                    <div class="" v-show = "showingAddVendor" >
                    <div class="">
                       Name
                    </div>
                    <div class="field is-horizontal" >
                        <input type="text" class="input-new-name" placeholder="Name">
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
                    <input type="text" class="input" placeholder="Price">
                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Made In
                </div>
                <div class="form-field-input">
                    <input type="text" class="input" placeholder="Made In">
                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Quantity
                </div>
                <div class="field is-horizontal">
                    <input type="text" class="input" placeholder="Quantity" width="30rem">
                    <button type="submit" class="btn-generateCode" name="GenerateBarcode">GenerateBarcode</button>
                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Description
                </div>
                <div class="form-field-input">
                    <input type="text" class="input" placeholder="Description">
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import AddEquipment from "./AddEquipment";
export default {
  components: {
    AddEquipment
  },
  created() {
    this.axios
      .get("http://localhost:3000/api/EquipmentCategory")
      .then(response => {
        let data = response.data;
        data.forEach(category => {
          this.categories.push(category);
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
          this.vendors.push(vendor);
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
        Category: ""
      },
      showingAddCategory: false,
      showingAddVendor: false,
      categories: [],
      vendors: [],
      files: []
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
      alert(this.form.AssetName + " " + this.form.ModelName);
      this.axios
        .post("http://localhost:3000/api/equipment", {
          name: this.form.AssetName
        })
        .then(function(respone) {
          // console.log(respone);
        })
        .catch(function(error) {
          console.log(error);
        });
    }
  }
};
</script>

<style scoped>
.form {
  background-color: white;
  margin: 0 1.5rem;
  padding: 0 !important;
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
