<template>
    <div style="display: grid; grid-template-columns: 20% 80%">
        <div class="columnleft">
            <div class="filter">
                <div>
                    <div class="txtText"> 
                        Equipment Category
                    </div>                    
                    <div class="select">
                    <select style="width:100%" v-model="tmpCategory">                                                                              
                        <option :value='null'>All</option>
                        <option :key="category.Id" v-for="category in categories" :value="category" >{{category.Name}} </option>  
                    </select>
                    </div>
                </div>
                <div>
                    <div class="txtText">
                        Vendor
                    </div>                    
                    <div class="select">
                    <select style="width:100%" v-model="tmpVendor">
                        <option :value='null'>All</option>                                
                        <option :key="vendor.Id" v-for="vendor in vendors" :value="vendor" >{{vendor.BusinessName}} </option>                                
                    </select>
                    </div>
                </div>

                <div>
                    <div class="txtText">
                        Export 
                    </div>                    
                    <div class="export">
                        <button class="exportbtn"> Export to Excel</button>
                        <button class="exportbtn"> Export to CSV</button>
                    </div>
                </div>                                      
            </div>
        </div>
            
        <div class="columnright">
            <div class="btncotrol">
                <div class="field is-grouped view-mode">
                    <button class="btn-view-mode">All Equipment</button>
                    <!-- <button class="btn-view-mode" :class='{"is-active": currentViewMode == viewModes.STOCK}' v-on:click="setViewMode(viewModes.STOCK)">Stock</button>
                    <button class="btn-view-mode" :class='{"is-active": currentViewMode == viewModes.DOWNTIME}' v-on:click="setViewMode(viewModes.DOWNTIME)">Downtime History</button> -->
                </div>
            </div>
            <div class="content">
                <div>
                    <table class="mytable">
                        <thead>
                            <tr>                            
                                <th><strong>Name</strong></th>
                                <th><strong>Quantity </strong></th>
                                <th><strong>Vendor</strong></th>
                                <th><strong>Made In</strong></th>
                                <th><strong>Category</strong></th>                                
                            </tr>                            
                        </thead>  
                        <tbody>
                            <tr :key="equipment.Id" v-for="equipment in tmpEquipments" v-on:click="selectedEquipment(equipment.Detail)">                            
                                <td>{{equipment.Name}}</td>    
                                <td>{{equipment.Quantity}}</td>  
                                <td>{{equipment.Vendor}}</td> 
                                <td>{{equipment.MadeIn}}</td>                                  
                                <td>{{equipment.Category}}</td>                                 
                            </tr>                                                        
                        </tbody>
                    </table>
                </div>                                
            </div>
        </div>
        <vodal :show="showEquipmentItemPopup" @hide="showEquipmentItemPopup = false" animation="slideUp" :height='600' :width='700'>
            <div  v-if="equipmentItems.length > 0" style="max-height:355px;overflow-y:auto;margin-top: 20px">
                <div style="display: grid; grid-template-columns: 15% auto; border-bottom:1px solid">
                                    <div style="display: flex">
                                        <img v-show="equipmentItems[0].Image" :src="equipmentItems[0].Image" style="width: 5rem; height: 5rem;">
                                    </div>
                                    <div style="display: grid; grid-template-rows: auto auto;">
                                        <div>
                                            Name: {{ equipmentItems[0].Name }}
                                        </div>                                            
                                        <div style="font-size: .9rem">
                                            Made In: {{equipmentItems[0].Category}}
                                        </div>
                                    </div>
                </div>
                <div style="display: grid; grid-template-columns: 8% auto auto auto;">
                    <div>
                        
                    </div>
                    <div >
                           <div>Serial Number</div> 
                    </div>
                    <div >
                           <div>Status</div> 
                    </div>
                    <div >
                           <div>Added Date</div> 
                    </div>
                </div>
                
                <div style="display: grid; grid-template-columns: 8% auto auto auto;">
                    <div>
                        Item:
                    </div>
                    <div >
                           <div :key="eqti.Id" v-for="eqti in equipmentItems">{{eqti.SerialNumber}}</div> 
                    </div>
                    <div >
                           <div :key="eqti.Id" v-for="eqti in equipmentItems">{{eqti.Status}}</div> 
                    </div>
                    <div >
                           <!-- <div :key="eqti.Id" v-for="eqti in equipmentItems">{{getFormatDate(eqti.ImportDate)}}</div>  -->
                           <div :key="eqti.Id" v-for="eqti in equipmentItems">{{(getWeek(eqti.ImportDate))}}</div>
                    </div>
                </div>                    
                                       
            </div>
        </vodal>
    </div>
</template>

<script>
import Vue from "vue";
import Server from "@/config/config.js";
import "vodal/common.css";
import "vodal/slide-up.css";
import Vodal from "vodal";
import moment from "moment";
export default {
  components: {
    Vodal
  },
  data() {
    return {
      equipments: [],
      equipmentItems: [],
      categories: [],
      vendors: [],
      tmpEquipments: [],
      tmpCategory: null,
      tmpVendor: null,

      showEquipmentItemPopup: false
    };
  },
  methods: {
    selectedEquipment(Items) {
      if (Items) {
        this.equipmentItems = Items;
        this.showEquipmentItemPopup = true;
      }
    },
    getFormatDate(date) {
      return moment(date).format("L");
    },
    getDate(date) {
      return moment(date).date();
    },
    getMonth(date) {
      return moment(date).month() + 1;
    },
    getYear(date) {
      return moment(date).year();
    },
    getWeek(date) {
      return moment(date).week();
    }
  },
  watch: {
    tmpCategory: function() {
      Vue.nextTick(() => {
        if (this.tmpCategory == null) {
          this.tmpEquipments = this.equipments;
        } else {
          this.tmpEquipments = this.equipments.filter(
            equipment => equipment.CategoryID == this.tmpCategory.Id
          );
        }
        if (this.tmpVendor) {
          this.tmpEquipments = this.tmpEquipments.filter(
            equipment => equipment.VendorID == this.tmpVendor.Id
          );
        }
      });
    },
    tmpVendor: function() {
      Vue.nextTick(() => {
        if (this.tmpCategory == null) {
          this.tmpEquipments = this.equipments;
        } else {
          this.tmpEquipments = this.equipments.filter(
            equipment => equipment.CategoryID == this.tmpCategory.Id
          );
        }
        if (this.tmpVendor) {
          this.tmpEquipments = this.tmpEquipments.filter(
            equipment => equipment.VendorID == this.tmpVendor.Id
          );
        }
      });
    }
  },
  created() {
    this.axios
      .get(Server.REPORT_EQUIPMENT_API_PATH)
      .then(res => {
        let data = res.data;
        data.forEach(equipment => {
          this.equipments.push(equipment);
        });
        this.tmpEquipments = this.equipments;
      })
      .catch(error => {
        console.log(error);
      });
    this.axios
      .get("http://localhost:3000/api/report/getCategory")
      .then(res => {
        let data = res.data;
        data.forEach(category => {
          this.categories.push(category);
        });
      })
      .catch(error => {
        console.log(error);
      });
    this.axios
      .get("http://localhost:3000/api/report/getVendor")
      .then(res => {
        let data = res.data;
        data.forEach(vendor => {
          this.vendors.push(vendor);
        });
      })
      .catch(error => {
        console.log(error);
      });
  }
};
</script>
    
<style scoped>
.columnleft {
  width: 100%;
  background-color: #eceff1;
  padding: 0.3rem;
}

.txtText {
  text-align: center;
  /*margin: 0.3rem;*/
  padding: 0.5rem;
  background-color: #cfd8dc;
}

.select {
  width: 100%;
  margin-bottom: 0.5rem;
}

.filter {
}

.radio {
  width: 100%;
  padding: 0.3rem;
}
.radio:hover {
  background-color: #eceff1;
}
.control {
  width: 100%;
  background-color: white;
  padding: 0.5rem;
  padding-left: 0.5rem;
  margin-bottom: 0.5rem;
}
.export {
  width: 100%;
}
.exportbtn {
  border: 1px #cfd8dc solid;
  padding: 0.3rem;
  background-color: white;
  margin-top: 0.2rem;
  width: 100%;
}
.exportbtn:hover {
  background-color: #eceff1;
}
.columnright {
  width: 100%;
  padding: 0.3rem;
}
.btn-view-mode {
  background-color: white;
  padding: 0.4rem 0.4rem;
  color: black;
  z-index: 1;
  font-size: 17px;
  border-bottom: 3px white solid;
}

.btn-view-mode:hover {
  color: #263238;
  cursor: pointer;
}

.is-active {
  border-bottom: 3px #26a69a solid;
  cursor: pointer;
  color: var(--primary-color);
}
.content {
  margin-top: 0.3rem;
  width: 100%;
}
.content div {
  width: 100%;
}
table {
  /* border: 1px solid black; */
  width: 100%;
  font-size: 15px;
  /* text-align: right; */
}

th {
  text-align: left;
  background-color: #cfd8dc;
  height: 30px;
  line-height: 30px;
  padding: 0.5rem !important;
}

td {
  /* text-align: center; */
  vertical-align: middle;
  height: 25px;
  line-height: 25px;
  padding: 0.5rem;

  /* text-align: justify; */
}

tr:nth-child(odd) {
  background-color: white;
  color: #263238;
}

tr:nth-child(even) {
  background-color: #f5f5f5;
  color: #263238;
}

#th1:curve {
  text-align: justify;
  background-color: #b0bec5;
}
tr:hover {
  background-color: #eceff1;
}
</style>
