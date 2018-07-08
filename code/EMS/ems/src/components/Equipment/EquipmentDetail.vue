<template>
    <div>
        <!-- <h1>{{this.EquimentByID.Name}}</h1> -->
        <div class="field" style=" display: grid; grid-template-columns: 50% 50%; width: 100;">
            <div class="left" style="padding-top:0.5rem; padding-left:1rem ">
                <img :src= "this.EquimentByID.Image" style="width: 400px; height: 350px; ">
            </div>
        <div class="">
        <!-- <div class="field is-horizontal"> -->
        <div class="field" style=" display: grid; grid-template-columns: 85% 15%">
            <strong style="padding-top:0.25rem; text-transform: uppercase;  font-size: 18px; color: #26a69a">{{EquimentByID.Name}}</strong>
            <button class="btn-edit" v-on:click="editMode = !editMode">Edit</button>
        </div>
        <div class="row" style="height: 36px" >
            <div class="" style="margin-top:0.5rem" >
                Name:  
            </div>
            <input v-if="!editMode" v-model="EquimentByID.Name" class="input col-7 " type="text" disabled="disabled"> 
            <input v-else v-model="EquimentByID.Name" class="input col-7 " type="text"  >
        </div>
        
        <div class="row" style="height: 36px" >
            <div class="" style="margin-top:0.5rem" >
                Vendor:  
            </div>
            <input v-if="!editMode" v-model="EquimentByID.Vendor.Name" class="input col-7 " type="text" disabled="disabled"> 
            <!-- <input v-else v-model="EquimentByID.Vendor.Name" class="input col-7 " type="text" > -->
            <model-select v-else style="width: 100% !important" :options="vendorOptions" v-model="selectedVendor" placeholder="Select a vendor"></model-select>  
        </div> 
        <div  class="row" style="height: 36px" >
            <div class="" style="margin-top:0.5rem" >
                Made In:  
            </div>
            <input v-if="!editMode" v-model="EquimentByID.MadeIn" class="input col-7 " type="text" disabled="disabled"> 
            <input v-else v-model="EquimentByID.MadeIn" class="input col-7 " type="text" >
        </div>
        <div  class="row" style="height: 36px" >
            <div class="" style="margin-top:0.5rem" >
                Category:  
            </div>
            <input v-if="!editMode" v-model="this.EquimentByID.Category.Name" class="input col-7 " type="text" disabled="disabled"> 
            <model-select v-else style="width: 100% !important" :options="categoryOptions" v-model="selectedCategory" placeholder="Select a category"></model-select>  
        </div>
        <div  class="row" style="height: 36px" >
            <div class="" style="margin-top:0.5rem" >
                Description:  
            </div>
            <input v-if="!editMode" v-model="this.EquimentByID.Description" class="input col-7 " type="text" disabled="disabled"> 
            <input v-else v-model="EquimentByID.Description" class="input col-7 " type="text" >
        </div>
        <div  class="row" style="height: 36px" >
            <div class="" style="margin-top:0.5rem" >
                Quantity:  
            </div>
            <input v-model="this.Items.length" class="input col-7 " type="text" disabled="disabled"> 
        </div>
        <div class="row" style="height: 30px">
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
                    <th><strong>Price</strong></th>
                    <th><strong>ImportDate</strong></th>
                    <th><strong>Warranty</strong></th>
                    <th><strong>Runtime</strong></th>
                    <th><strong>Status</strong></th>
                    <th><strong>Description</strong></th>
                </tr>
            </thead>  
            <tbody>
                <tr v-bind:key="item.ID" v-for="(item, index) in Items" v-on:click="setSelectedItem(item.ID)">
                    <td>{{ index + 1 }}</td>   
                    <td>{{item.SerialNumber}}</td>
                    <td>{{item.Price}}</td>
                    <td>{{item.ImportDate}}</td>
                    <td>{{item.WarrantyDuration}}</td>
                    <td>{{item.RuntimeDays}}</td>
                    <td>{{item.Status}}</td>
                    <td>{{item.Description ? item.Description : 'N/A' }}</td>    
                </tr>
            </tbody>
        </table>
        <vodal class="no-padding" height="500" :show="selectedItem != null" @hide="selectedItem = null" animation="slideUp">
          <!-- <equipment-detail-popup :equipment="selectedItem" class="" v-show="selectedItem != null"></equipment-detail-popup> -->
            <div v-if="selectedItem!=null" >
            <div class="field" style=" display: grid; grid-template-columns: 85% 15%">
              <strong style="padding-top:0.25rem; text-transform: uppercase;  font-size: 18px; color: #26a69a">{{EquimentByID.Name}}</strong>
              <button class="btn-edit" v-on:click="editMode = !editMode">Edit</button>
            </div>
            <div class="row" style="height: 36px" >
              <div class="" style="margin-top:0.5rem" >
                  Serial Number:  
              </div>
                <input v-model="selectedItem.SerialNumber" class="input col-7 " type="text" disabled="disabled"> 
                <!-- <input v-model="EquimentByID.Name" class="input col-7 " type="text"  > -->
            </div>
            <div class="row" style="height: 36px" >
              <div class="" style="margin-top:0.5rem" >
                  Price:  
              </div>
                <input v-model="selectedItem.Price" class="input col-7 " type="text" disabled="disabled"> 
            </div>
            <div class="row" style="height: 36px" >
              <div class="" style="margin-top:0.5rem" >
                  Warranty:  
              </div>
                <input v-model="selectedItem.WarrantyDuration" class="input col-7 " type="text" disabled="disabled"> 
            </div>
            <div class="row" style="height: 36px" >
              <div class="" style="margin-top:0.5rem" >
                  Run-times:  
              </div>
                <input v-model="selectedItem.RuntimeDays" class="input col-7 " type="text" disabled="disabled"> 
            </div>
            <div class="row" style="height: 36px" >
              <div class="" style="margin-top:0.5rem" >
                  Import-Date:  
              </div>
                <input v-model="selectedItem.ImportDate" class="input col-7 " type="text" disabled="disabled"> 
            </div>
            <div class="row" style="height: 36px" >
              <div class="" style="margin-top:0.5rem" >
                  Status:  
              </div>
                <input v-model="selectedItem.Status" class="input col-7 " type="text" disabled="disabled"> 
            </div>
            </div>
        </vodal>
    </div>
    </div>
    
</template>

<script>
import { ModelSelect } from "vue-search-select";
import "vodal/common.css";
import "vodal/slide-up.css";
import EquipmentDetailPopup from "./EquipmentDetailPopup";
import Vodal from "vodal";
export default {
  components: {
    ModelSelect,
    Vodal,
    EquipmentDetailPopup
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
  },
  data() {
    return {
      selectedItem: null,
      EquimentByID: null,
      equipmentId: "",
      quality: 0,
      Items: [],
      files: "",
      editMode: false,
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
      new: {
        EquipmentName: null,
        Category: "",
        Vendor: "",
        MadeIn: "",
        Description: ""
      }
    };
  },
  methods: {
    setSelectedItem(itemId) {
      this.axios
        .get("http://localhost:3000/api/equipmentItem/Item/" + itemId)
        .then(response => {
          this.selectedItem = response.data;
          alert(this.selectedItem.SerialNumber);
          n;
        })
        .catch(error => {
          console.log(error);
        });
    },
    getFilePath(file) {
      return window.URL.createObjectURL(file);
    },
    inputFileChange() {
      this.files = this.$refs.fileInput.files;
    },
    updateEquipment() {
      alert(this.equipmentId);
      if (
        this.selectedCategory.value == "" ||
        this.selectedCategory.value == ""
      ) {
        alert("Please choose category and vendor");
      } else {
        alert(this.selectedCategory.value);
        this.axios
          .put("http://localhost:3000/api/equipment/" + this.equipmentId, {
            id: this.equipmentId,
            name: this.EquimentByID.Name,
            vendorid: this.selectedVendor.value,
            image:
              "http://dailymayxaydung.com/wp-content/uploads/2016/05/may_bom_SEV50X.jpg",
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
    }
  }
};
</script>

<style scoped>
.btn-edit:hover {
  cursor: pointer;
  background-color: #009688;
}
.btn-edit {
  /* position: relative; */
  background-color: var(--primary-color);
  color: white;
  font-size: 18px;
  border-radius: 4px;
  /* margin-left: 0.25rem; */
  width: 100%;
  height: 36px;
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
  margin-left: 150px;
}
.btn-Cancel:hover {
  cursor: pointer;
  background-color: #bdbdbda1;
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
table {
  /* border: 1px solid black; */
  width: 100%;
  font-size: 30px;
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
</style>