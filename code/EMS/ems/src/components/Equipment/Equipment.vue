<template>
  <div>
    <div v-if="authUser.Role == 'Equipment Staff' || authUser.Role == 'Manager' " >
        <div class="filter" style="width: 100%; display: grid; grid-template-columns: 5% auto">
          <div style="font-weight: bold">
              Filter:
          </div>
          <div>
              <div style="width: 100%; height:1.5rem;display: grid; grid-template-columns:4rem 6rem auto;">
                <div>Status: </div> 
                  <div style="user-select: none; display: grid; grid-template-columns: 3.5rem auto;">
                      <div>Active:</div>
                      <div style="padding-top:0.1rem">
                        <input type="checkbox" v-model="activeChecked">                            
                      </div>                        
                  </div>
                  <div style="user-select: none; display: grid; grid-template-columns: 4.5rem auto;">
                      <div>In Active:</div>
                      <div style="padding-top:0.1rem">
                        <input type="checkbox"  v-model="inActiveChecked">
                      </div>
                  </div>
              </div>
          </div>
      </div>
    </div>
    <div v-if="toDisplayData && toDisplayData.length!=0">   
        <div v-if="authUser.Role == 'Staff' || authUser.Role == 'Maintainer' " >
          <div class="field is-grouped view-mode" style="margin-bottom: 0.2rem !important; padding: 0rem!important">
            <router-link to='/Equipment/'>  
              <button class="btn-view-mode-left" style="margin-right:0rem" disabled="disabled"> All Equipment</button>
            </router-link>
            <router-link to='/myEquipment/'>  
              <button class="btn-view-mode-right" >My Equipment</button>
            </router-link>
          </div>
        </div>
        <div style="padding-top:0.5rem">
          <table class="table">
              <thead>
                  <tr>
                      <th style="text-align:center" ><strong>No.</strong></th>
                      <th ><strong>Equipment name</strong></th>
                      <th ><strong>Available</strong></th>
                      <th ><strong>Vendor name</strong></th>      
                      <th ><strong>Description</strong></th>
                      <th ><strong>Category</strong></th>
                      <th ><strong>Status</strong></th>
                  </tr>
              </thead>  
              <tbody>
                  <tr v-bind:key=" 'toDisplayData'+ index +''+ equipment.Id " v-for="(equipment, index) in toDisplayData" v-on:click="gotoDetail(equipment.Id)">
                      <td width=5% style="text-align:center" >{{ 10*(currentPage -1) + (index + 1) }}</td>   
                      <td width=30% >{{equipment.Name | truncate(50)}}</td>
                      <td width=5% >{{equipment.AvailableQuantity}}/{{equipment.Quantity}}</td>
                      <td width=20% >{{equipment.Vendor.Name | truncate(30)}}</td>
                      <td width=15% >{{equipment.Description ? equipment.Description: 'N/A' }}</td>
                      <td width=10% >{{equipment.Category.Name }}</td>
                      <td width=10% :style="{color: equipment.Status? 'var(--primary-color)' : '#607D8B'}">{{equipment.Status? "Active" : "InActive"}}</td>
                  </tr>
              </tbody>
          </table>
        </div>
      <div v-if="equipments.length >9" class="">
        <Page :current="currentPage" :total="equipments.length" show-elevator 
          @on-change="(newPageNumber) => {
            currentPage = newPageNumber
            let start = 10 * (newPageNumber - 1);
            let end = start + 10;
            toDisplayData = equipments.slice(start, end);
          }">
        </Page>
      </div>  
    </div>
    <div v-else>
      There is no equipment to display.
    </div>
    <router-link to='/equipment/create/'>
      <button v-if="authUser.Role == 'Equipment Staff'" id="btn-add-equipment"  class="button btn-primary material-shadow-animate">Add Equipment</button>
    </router-link>
  </div>
</template>

<script>
import { sync } from "vuex-pathify";
import Server from "@/config/config.js";
import EquipmentTable from "./EquipmentTable";
// import EquipmentCard from "./EquipmentCard";

export default {
  components: {
    EquipmentTable
    // EquipmentCard
  },
  created() {
    this.getEquipment();
  },
  computed: {
    isTableMode: sync("equipmentPage.isTableMode"),
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    },
    searchValues: sync("equipmentPage.searchValues")
  },
  data() {
    return {
      currentPage: 1,
      equipments: [],
      toDisplayData: [],
      selectedEquipment: null,
      searchMode: false,
      inActiveChecked: false,
      activeChecked: true
    };
  },
  methods: {
    getEquipment() {
      let URL = Server.EQUIPMENT_API_PATH;
      this.axios
        .get(URL)
        .then(response => {
          let data = response.data;
          // alert('in');
          data.forEach(element => {
            let equipment = element.Equipment;
            if (equipment.Status) {
              this.equipments.push(equipment);
            }
            if (this.$store.state.equipmentPage.searchText != "") {
              let tempEQTs = [];
              if (this.searchValues.length > 0) {
                for (const equipment of this.searchValues) {
                  tempEQTs = tempEQTs.concat(
                    this.equipments.filter(e => e.Id == equipment.Id)
                  );
                }
              }
              this.equipments = tempEQTs;
              this.searchMode = true;
            } else {
              // this.$store.state.workOrderPage.searchValues = [];
              this.searchMode = false;
            }
            this.toDisplayData = this.equipments.slice(0, 10);
          });
        })
        .catch(error => {
          console.log(error);
        });
    },
    getAllEquipmentStatusTrueFalse() {
      let URL = Server.EQUIPMENT_API_PATH;
      this.axios
        .get(URL)
        .then(response => {
          let data = response.data;
          // alert('in');
          data.forEach(element => {
            let equipment = element.Equipment;
            this.equipments.push(equipment);
            if (this.$store.state.equipmentPage.searchText != "") {
              let tempEQTs = [];
              if (this.searchValues.length > 0) {
                for (const equipment of this.searchValues) {
                  tempEQTs = tempEQTs.concat(
                    this.equipments.filter(e => e.Id == equipment.Id)
                  );
                }
              }
              this.equipments = tempEQTs;
              this.searchMode = true;
            } else {
              // this.$store.state.workOrderPage.searchValues = [];
              this.searchMode = false;
            }
            this.toDisplayData = this.equipments.slice(0, 10);
          });
        })
        .catch(error => {
          console.log(error);
        });
    },
    getEquipmentInActive() {
      let URL = Server.EQUIPMENT_API_PATH;
      this.axios
        .get(URL)
        .then(response => {
          let data = response.data;
          // alert('in');
          data.forEach(element => {
            let equipment = element.Equipment;
            if (equipment.Status == false) {
              this.equipments.push(equipment);
            }
            if (this.$store.state.equipmentPage.searchText != "") {
              let tempEQTs = [];
              if (this.searchValues.length > 0) {
                for (const equipment of this.searchValues) {
                  tempEQTs = tempEQTs.concat(
                    this.equipments.filter(e => e.Id == equipment.Id)
                  );
                }
              }
              this.equipments = tempEQTs;
              this.searchMode = true;
            } else {
              // this.$store.state.workOrderPage.searchValues = [];
              this.searchMode = false;
            }
            this.toDisplayData = this.equipments.slice(0, 10);
          });
        })
        .catch(error => {
          console.log(error);
        });
    },
    setSelectedEquipment(equipment) {
      this.selectedEquipment = equipment;
    },
    setTableMode(value) {
      this.$store.state.equipmentPage.isTableMode = value;
    },
    showarlet(msg) {
      console.log(msg);
    },
    gotoDetail(equipmentId) {
      this.$router.push(`/equipment/${equipmentId}`);
    }
  },
  watch: {
    searchValues: function() {
      this.equipments = [];
      this.toDisplayData = [];
      this.getEquipment();
    },
    activeChecked: function() {
      this.equipments = [];
      this.toDisplayData = [];
      if (this.activeChecked) {
        if (this.inActiveChecked) {
          this.getAllEquipmentStatusTrueFalse();
          this.currentPage = 1;
        } else {
          this.getEquipment();
          this.currentPage = 1;
        }
      } else {
        if (this.inActiveChecked) {
          this.getEquipmentInActive();
          this.currentPage = 1;
        } else {
          this.equipments = [];
          this.toDisplayData = [];
        }
      }
    },
    inActiveChecked: function() {
      this.equipments = [];
      this.toDisplayData = [];
      if (this.inActiveChecked) {
        if (this.activeChecked) {
          this.getAllEquipmentStatusTrueFalse();
          this.currentPage = 1;
        } else {
          this.getEquipmentInActive();
          this.currentPage = 1;
        }
      } else {
        if (this.activeChecked) {
          this.getEquipment();
          this.currentPage = 1;
        } else {
          this.equipments = [];
          this.toDisplayData = [];
        }
      }
    }
  }
};
</script>

<style scoped>
.cards-wrapper {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
}

.view-mode {
  margin-bottom: 2rem;
}

#btn-add-equipment {
  position: fixed;
  right: 3rem;
  bottom: 0.5rem;
  /* background-color: var(--primary-color); */
  /* padding: 13px; */
  color: white;
  /* border-radius: 5px; */
  z-index: 1;
}

#btn-add-equipment:hover {
  cursor: pointer;
  /* background-color: #009688;
  color: white; */
}
th {
  text-align: left;
  background-color: #cfd8dc;
  height: 30px;
  line-height: 30px;
  padding: 0.5rem !important;
}

td {
  vertical-align: middle;
  height: 40px;
  line-height: 25px;
  padding: 0.5rem;
}

tr:nth-child(odd) {
  background-color: white;
  color: #263238;
}

tr:nth-child(even) {
  background-color: #f5f5f5;
  color: #263238;
}
tr {
  cursor: pointer;
}
/* tr:hover {
  background-color: #fff !important;
} */
.btn-view-mode {
  background-color: white;
  padding: 0.4rem 0.6rem;
  /* height: 2rem; */
  font-size: 15px;
  /* line-height: 2rem; */
  color: var(--primary-color);
  border-radius: 5px 5px 5px 5px;
  border: 1px solid #26a69a;
  z-index: 1;
  /* padding-right: 20px;
      padding-left: 20px; */
  margin-right: 5px;
}

.btn-view-mode:hover {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}

.is-active {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}

.equipment-block {
  display: grid;
  grid-template-columns: 80% 20%;
  grid-template-rows: 1 1 1;
  background-color: #fafafa;
  border-radius: 3px;
  padding: 0.3rem 1rem;
  /* box-shadow: 3px 3px 5px #bdbdbd;
      margin: 2rem 5rem; */
}
.pageNa {
  position: fixed;
  left: 17rem;
  bottom: 0.5rem;
}
.btn-view-mode-left {
  background-color: white;
  padding: 0.4rem 0.6rem;
  font-size: 15px;
  color: var(--primary-color);
  border-radius: 5px 0 0 5px;
  border: 1px solid #26a69a;
  z-index: 1;
}
.btn-view-mode-left:disabled {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}
.btn-view-mode-left:hover {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}
.btn-view-mode-right {
  background-color: white;
  padding: 0.4rem 0.6rem;
  font-size: 15px;
  color: var(--primary-color);
  border-radius: 0 5px 5px 0;
  border: 1px solid #26a69a;
  z-index: 1;
  margin-right: 5px;
}

.btn-view-mode-right:hover {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}
</style>
