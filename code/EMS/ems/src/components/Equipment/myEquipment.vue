<template>
  <div>
    <div v-if="authUser.Role == 'Staff' || authUser.Role == 'Maintainer' " >
        <div class="field is-grouped view-mode" style="margin-bottom: 0.2rem !important; padding: 0rem!important">
          <router-link to='/Equipment/'>  
            <button class="btn-view-mode-left" style="margin-right:0rem"> All Equipment</button>
          </router-link>
          <router-link to='/myEquipment/'>  
            <button class="btn-view-mode-right" disabled="disabled">My Equipment</button>
          </router-link>
        </div>
    </div>
    <div v-if="displayOrders && displayOrders.length != 0"> 
      <div class = "" v-if="authUser.Role == 'Staff'">
        <table class="table" >
            <thead>
                  <tr>
                      <th rowspan="2"><strong>Location</strong></th>
                      <th rowspan="2"><strong>Work Order</strong></th>
                      <th rowspan="2"><strong>Start Date</strong></th>
                      <th rowspan="2"><strong>Expect Close</strong></th>
                      <th rowspan="2"><strong>Equipment</strong></th>
                      <th rowspan="2"><strong>Serial number</strong></th>
                      <th colspan="3"><strong>Position</strong></th>
                      <th rowspan="2"><strong>Update Position</strong></th>
                  </tr>
                  <tr>
                      <th ><strong>Block</strong></th>
                      <th ><strong>Floor</strong></th>
                      <th ><strong>Tile</strong></th>
                  </tr>
            </thead>  
            <tbody style="font-size:14px"   v-bind:key="index" v-for="(order, index) in displayOrders">
                  <tr>
                      <td style="margin-top:0.5rem" width=10% :rowspan="`${order.WorkorderDetail.length + 1}`">{{order.Location}}</td> 
                      <td :style=" {color: period[index]<3? 'red' : 'black'}" width=20% :rowspan="`${order.WorkorderDetail.length + 1}`">{{order.Name}}</td>
                      <td style="margin-top:0.5rem" width=4% :rowspan="`${order.WorkorderDetail.length + 1}`">{{getDate(order.StartDate)}}</td>
                      <td style="margin-top:0.5rem" width=4% :rowspan="`${order.WorkorderDetail.length + 1}`">{{getDate(order.ExpectingCloseDate)}}</td>
                  </tr>
                  <tr :key="detail.EquipmentItemID" v-for="detail in order.WorkorderDetail">                  
                      <td class="detail" width=20%>{{detail.Name}}</td>
                      <td class="detail" width=10%>{{detail.SerialNumber}}</td>
                      <td class="detail" width=8%>{{detail.Block}}</td>
                      <td class="detail" width=6%>{{detail.Floor}}</td>
                      <td class="detail" width=6%>{{detail.Tile}}</td>
                      <td class="detail"><a v-on:click="showChangePosition(detail.EquipmentItemID)">Update positon</a></td>
                  </tr>
            </tbody>
        </table>
      </div>
      <div class="" v-else>
        <table class="table" >
            <thead >
                  <tr style="height: 3rem !important;">
                      <th ><strong>No. </strong></th>
                      <th ><strong>Work Order</strong></th>
                      <th ><strong>Start Date</strong></th>
                      <th ><strong>Expect Close</strong></th>
                      <th ><strong>Equipment</strong></th>
                      <th ><strong>Serial number</strong></th>
                  </tr>
            </thead>  
            <tbody style="font-size:14px"   v-bind:key="index" v-for="(order, index) in displayOrders">
                  <tr>
                      <td style="margin-top:0.5rem" width=4% :rowspan="`${order.WorkorderDetail.length + 1}`">{{index+1}}</td>
                      <td :style=" {color: period[index]<3? 'red' : 'black'}" width=20% :rowspan="`${order.WorkorderDetail.length + 1}`">{{order.Name}}</td>
                      <td style="margin-top:0.5rem" width=4% :rowspan="`${order.WorkorderDetail.length + 1}`">{{getDate(order.StartDate)}}</td>
                      <td style="margin-top:0.5rem" width=4% :rowspan="`${order.WorkorderDetail.length + 1}`">{{getDate(order.ExpectingCloseDate)}}</td>
                  </tr>
                  <tr :key="detail.EquipmentItemID" v-for="detail in order.WorkorderDetail">                  
                      <td class="detail" width=20%>{{detail.Name}}</td>
                      <td class="detail" width=10%>{{detail.SerialNumber}}</td>
                  </tr>
            </tbody>
        </table>
      </div>
      <modal v-model="changePosition" style="font-family: Roboto">
        <simplert :useRadius="true" :useIcon="true" ref="simplert"></simplert>
        <div slot="header" style="font-weight: bold">
            <span>Update Position </span>
        </div>
        <div :style="{
            'max-height': '50vh',
            'overflow-y': 'auto',
            'font-size': '.95rem',
        }">
            <div v-if="selectedItem">
              <strong style="font-size:15px"> {{selectedItem.Item.EquipmentName}} - {{selectedItem.Item.SerialNumber}}</strong>
            </div>
            <div v-if="locationToUpdate">
                {{locationToUpdate.Name}} - {{locationToUpdate.Address}}
            </div>
            <div style="display: grid; grid-template-columns: 30% 30% 30%; grid-column-gap: 5%; margin: 2rem 0;" v-if="locationToUpdate">
                <div style="width: 100%">
                  <div class="" style="margin-left:0.6rem">
                    Block
                  </div>  
                  <div style="width: 100%" class="select">
                      <select style="width: 100%" v-model="updateBlock">
                          <option disabled :value="''">Select a block</option>
                          <option :value="block" :key="'updateBlock' + block.Id" v-for="block in blockOptions">
                                {{ block.Name }}
                          </option>
                      </select>
                  </div>
                </div>
                <div style="width: 100%">
                  <div class="" style="margin-left:0.6rem" v-if="updateBlock && floorOptions.length>0">
                    Floor
                  </div>
                  <div style="width: 100%" class="select" v-if="updateBlock && floorOptions.length>0">
                      <select style="width: 100%" v-model="updateFloor">
                          <option disabled :value="''">Select a floor</option>
                          <option :value="floor" :key="'updateFloor' + floor.Id" v-for="floor in floorOptions">
                                {{ floor.Name }}
                          </option>
                      </select>
                  </div>                   
                </div>
                <div style="width: 100%">
                  <div class="" style="margin-left:0.6rem" v-if="updateFloor && tileOptions.length>0">
                    Tile
                  </div>
                  <div style="width: 100%" class="select" v-if="updateFloor && tileOptions.length>0">
                      <select style="width: 100%" v-model="updateTile">
                          <option disabled :value="''">Select a tile</option>
                          <option :value="tile" :key="'updateTileFloor' + tile.Id" v-for="tile in tileOptions">
                              {{ tile.Name }}
                          </option>
                      </select>
                  </div>
                </div>
            </div>
            <div v-if="errorUpdatePosition != ''" style="margin-top: 0.5rem;">
                <span class="error-text" style="font-weight: 500 !important">{{ errorUpdatePosition }}</span>
            </div>
        </div>
        <div slot="footer" style="display: relative; align-items: right; justify-content: right;">
          <button class="btn-CancelItem" 
                        v-on:click="cancelUpdatePosition()">Cancel</button>
                    <button class="btn-UpdateItem" 
                        v-on:click="() => {
                            if (!updateBlock || !updateFloor || !updateTile) {
                                errorUpdatePosition = 'You must select block, floor and tile to update position.';
                            }
                            if (errorUpdatePosition == '' && updateTile) {
                                updateItemPosition();
                            }
                    }">Save changes</button>
        </div>
      </modal>
    </div>
    <div v-else>
      There is no equipment yet.
    </div>
  </div>
</template>

<script>
import { sync } from "vuex-pathify";
import Vue from "vue";
import Server from "@/config/config.js";
import EquipmentTable from "./EquipmentTable";
import moment from "moment";
import Vodal from "vodal";
import Utils from "@/utils.js";
import Simplert from "vue2-simplert";
import { ModelSelect } from "vue-search-select";
// import EquipmentCard from "./EquipmentCard";

export default {
  components: {
    EquipmentTable,
    Simplert,
    Vodal,
    ModelSelect
    // EquipmentCard
  },
  created() {
    if (this.authUser.Role == "Staff") {
      this.getAllInProgressWorkOrderOfTeamlead();
    } else if (this.authUser.Role == "Maintainer") {
      this.getAllInProgressWorkOrderOfMaintainer();
    }
    this.axios
      .get("http://localhost:3000/api/location")
      .then(response => {
        let data = response.data;
        data.forEach(location => {
          this.locationOptions.push(location);
        });
      })
      .catch(error => {
        alert(error);
      });
  },
  computed: {
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    }
  },
  data() {
    return {
      orders: [],
      currentPage: 1,
      equipments: [],
      toDisplayData: [],
      displayOrders: [],
      displayLocation: [],
      displayOrderDetail: [],
      displayItemDetail: [],
      period: [],
      selectedEquipment: null,
      changePosition: false,
      form: {
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
      locationOptions: [],
      blockOptions: [],
      floorOptions: [],
      tileOptions: [],
      selectedItem: "",
      WOlocationID: 0,
      locationToUpdate: "",
      updateBlock: "",
      updateFloor: "",
      updateTile: "",
      errorUpdatePosition: "",
      updateNumber: 0,
      lastTileId: ""
    };
  },
  methods: {
    getAllInProgressWorkOrderOfTeamlead() {
      this.axios
        .get(
          "http://localhost:3000/api/work_order/workorderbyUserId/" +
            this.authUser.Id
        )
        .then(response => {
          let data = response.data;
          this.displayOrders = data;
          for (var i = 0; i < this.displayOrders.length; i++) {
            this.period[i] = Math.abs(
              moment(this.displayOrders[i].ExpectingCloseDate).valueOf() -
                moment().valueOf()
            );

            this.period[i] = Math.floor(this.period[i] / (1000 * 3600 * 24));
            if (
              moment().valueOf() >
              moment(this.displayOrders[i].ExpectingCloseDate).valueOf()
            ) {
              this.period[i] = -this.period[i];
            }
            for (
              var j = 0;
              j < this.displayOrders[i].WorkorderDetail.length;
              j++
            ) {
              this.displayOrderDetail.push(
                this.displayOrders[i].WorkorderDetail[j]
              );
            }
          }
        })
        .catch(error => {
          console.log(error);
        });
    },
    getAllInProgressWorkOrderOfMaintainer() {
      this.axios
        .get(
          "http://localhost:3000/api/work_order/workorderbyMaintainerId/" +
            this.authUser.Id
        )
        .then(response => {
          let data = response.data;
          this.displayOrders = data;
          for (var i = 0; i < this.displayOrders.length; i++) {
            this.period[i] = Math.abs(
              moment(this.displayOrders[i].ExpectingCloseDate).valueOf() -
                moment().valueOf()
            );

            this.period[i] = Math.floor(this.period[i] / (1000 * 3600 * 24));
            if (
              moment().valueOf() >
              moment(this.displayOrders[i].ExpectingCloseDate).valueOf()
            ) {
              this.period[i] = -this.period[i];
            }
            for (
              var j = 0;
              j < this.displayOrders[i].WorkorderDetail.length;
              j++
            ) {
              this.displayOrderDetail.push(
                this.displayOrders[i].WorkorderDetail[j]
              );
            }
          }
        })
        .catch(error => {
          console.log(error);
        });
    },
    async showChangePosition(itemId) {
      for (var i = 0; i < this.displayOrders.length; i++) {
        for (var j = 0; j < this.displayOrders[i].WorkorderDetail.length; j++) {
          if (
            this.displayOrders[i].WorkorderDetail[j].EquipmentItemID == itemId
          ) {
            this.WOlocationID = this.displayOrders[i].LocationID;
          }
        }
      }
      await this.axios
        .get("http://localhost:3000/api/equipmentItem/Item/" + itemId)
        .then(response => {
          this.selectedItem = response.data;
        })
        .catch(error => {
          console.log(error);
        });
      try {
        this.axios
          .get(
            `http://localhost:3000/api/location/editlocation/${
              this.WOlocationID
            }`
          )
          .then(res => {
            if (res.status == 200) {
              this.locationToUpdate = res.data[0];
              if (this.WOlocationID != "") {
                this.changePosition = true;
              }
            }
          });
      } catch (error) {
        console.log(error);
      }
    },
    async updateItemPosition() {
      var result = false;
      if (this.updateTile.Id == this.lastTileId) {
        let obj = {
          message: "This item has been at this position",
          type: "warning"
        };
        this.$refs.simplert.openSimplert(obj);
      } else {
        try {
          let res = await this.axios.put(
            "http://localhost:3000/api/equipmentItem/position/tile/" +
              this.selectedItem.Item.Id,
            {
              tileId: this.updateTile.Id
            }
          );
          if (res.status == 200) {
            result = true;
            this.lastTileId = this.updateTile.Id;
            await this.axios
              .get(
                "http://localhost:3000/api/equipmentItem/Item/" +
                  this.selectedItem.Item.Id
              )
              .then(response => {
                this.selectedItem = response.data;
              })
              .catch(error => {
                console.log(error);
              });
          }
        } catch (error) {
          console.log(error);
          alert(this.selectedItem.Item.Id);
          result = false;
        }
        await Utils.sleep(200);
        if (result) {
          let obj = {
            message: "Update successfully",
            type: "success",
            showXclose: false
          };
          this.$refs.simplert.openSimplert(obj);
          this.updateNumber = this.updateNumber + 1;
        } else {
          alert("Update failed");
        }
      }
    },
    cancelUpdatePosition() {
      this.changePosition = false;
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
    },
    getDate(date) {
      return moment(date).format("L");
    }
  },
  watch: {
    changePosition: function() {
      if (this.changePosition && this.WOlocationID != "") {
        this.axios
          .get(
            `http://localhost:3000/api/block/location/${
              this.locationToUpdate.Id
            }`
          )
          .then(res => {
            if (res.status == 200) {
              let blocks = res.data;
              blocks.forEach(block => {
                this.blockOptions.push(block);
              });
            }
          });
      } else {
        this.updateBlock = "";
        this.updateFloor = "";
        this.updateTile = "";
        this.locationToUpdate = "";
        this.blockOptions = [];
        this.floorOptions = [];
        this.tileOptions = [];
        if (this.updateNumber > 0) {
          location.reload();
        }
      }
    },
    updateBlock: function() {
      this.floorOptions = [];
      this.tileOptions = [];
      this.updateFloor = "";
      this.updateTile = "";
      if (this.updateBlock != "") {
        this.axios
          .get(`http://localhost:3000/api/floor/block/${this.updateBlock.Id}`)
          .then(res => {
            if (res.status == 200) {
              let floors = res.data;
              floors.forEach(floor => {
                this.floorOptions.push(floor);
              });
            }
          });
      }
    },
    updateFloor: function() {
      this.tileOptions = [];
      this.updateTile = "";
      if (this.updateFloor != "") {
        this.axios
          .get(`http://localhost:3000/api/tile/floor/${this.updateFloor.Id}`)
          .then(res => {
            if (res.status == 200) {
              let tiles = res.data;
              tiles.forEach(tile => {
                this.tileOptions.push(tile);
              });
            }
          });
      }
    },
    updateTile: function() {
      Vue.nextTick(() => {
        if (
          this.updateTile &&
          this.updateTile.Id == this.selectedItem.Item.TileID
        ) {
          this.errorUpdatePosition = "This item is already in this position";
        } else if (this.updateTile) {
          this.errorUpdatePosition = "";
        } else if (this.updateTile == "") {
          this.errorUpdatePosition = "";
        }
      });
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
th {
  text-align: center;
  background-color: #cfd8dc;
  height: 25px;
  line-height: 25px;
  padding: 0rem 0rem 0.25rem 0.35rem !important;
}
tr:nth-child(odd) {
  height: 8px;
}
tr:nth-child(even) {
  height: 8px;
}
table {
  border: none !important;
}
tr {
  cursor: context-menu !important;
}
tr:hover {
  background-color: #fff !important;
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
.detail {
  padding-top: 0.25rem !important;
}
#btn-add-equipment:hover {
  cursor: pointer;
  /* background-color: #009688;
  color: white; */
}

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
.btn-view-mode-right:hover {
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
.btn-view-mode-right:disabled {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}
</style>
