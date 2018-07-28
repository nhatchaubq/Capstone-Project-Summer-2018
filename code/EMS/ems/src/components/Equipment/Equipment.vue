<template>
  <div>
    <!-- <div class="">
      <div class="field is-grouped view-mode">
        <button class="btn-view-mode" :class='{"is-active": isTableMode}' v-on:click="setTableMode(true)">Table view</button>
        <button class="btn-view-mode" :class='{"is-active": !isTableMode}' v-on:click="setTableMode(false)">Card view</button>
      </div>
    </div> -->
    <div v-if="!equipments">
      There is no equipment yet.
    </div>
    <div v-else>
      <!-- <equipment-table :equipments="toDisplayData" v-if="isTableMode"></equipment-table> -->
      <!-- <equipment-card :equipments="equipments" v-else></equipment-card> -->
 <div v-if="equipments">
        <table class="table">
            <thead>
                <tr>
                    <th ><strong>Order #</strong></th>
                    <th ><strong>Equipment name</strong></th>
                    <th ><strong>Available</strong></th>
                    <th ><strong>Vendor name</strong></th>
                    <th ><strong>Made In</strong></th>
                    <th ><strong>Description</strong></th>
                    <th ><strong>Category</strong></th>
                </tr>
            </thead>  
            <tbody>
                <tr v-bind:key=" 'toDisplayData'+ index +''+ equipment.Id " v-for="(equipment, index) in toDisplayData" v-on:click="gotoDetail(equipment.Id)">
                    <td width=5% >{{ 10*(currentPage -1) + (index + 1) }}</td>   
                    <td width=30% >{{equipment.Name | truncate(50)}}</td>
                    <td width=5% >{{equipment.AvailableQuantity}}/{{equipment.Quantity}}</td>
                    <td width=20% >{{equipment.Vendor.Name | truncate(35)}}</td>
                    <td width=10%>{{equipment.MadeIn| truncate(10)  }}</td>
                    <!-- <td>{{equipment.Price ? equipment.Price : 'n/a'}}</td> -->
                    <td width=15% >{{equipment.Description ? equipment.Description: 'N/A' }}</td>
                    <td width=10% >{{equipment.Category.Name }}</td>
                </tr>
            </tbody>
        </table>
        <!-- <vodal class="no-padding" height="500" :show="selectedEquipment != null" @hide="selectedEquipment = null" animation="slideUp">
          <equipment-detail-popup :equipment="selectedEquipment" class="" v-show="selectedEquipment != null"></equipment-detail-popup>
        </vodal> -->
    </div>




      <!-- test1 -->
  <div v-if="equipments.length >9" class="pageNa">
    <Page :current="currentPage" :total="equipments.length" show-elevator 
      @on-change="(newPageNumber) => {
        currentPage = newPageNumber
        let start = 10 * (newPageNumber - 1);
        let end = start + 10;
        showarlet(`${start } ${end} ${this.total}`)
        //alert(start)
      //  alert(end)
        toDisplayData = equipments.slice(start, end);
      }">
    </Page>
  </div>  
<!-- test1-end -->

    </div>

    <router-link to='/equipment/create/'>
      <button id="btn-add-equipment"  class="button btn-primary material-shadow-animate">Add Equipment</button>
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
    let URL = Server.EQUIPMENT_API_PATH;
    this.axios
      .get(URL)
      .then(response => {
        let data = response.data;
        // alert('in');
        data.forEach(element => {
          let equipment = element.Equipment;
          this.equipments.push(equipment);
          this.toDisplayData = this.equipments.slice(0, 10);
        });
      })
      .catch(error => {
        console.log(error);
      });
  },
  computed: {
    isTableMode: sync("equipmentPage.isTableMode")
  },
  data() {
    return {
      currentPage: 1,
      equipments: [],
      toDisplayData: [],
      selectedEquipment: null
    };
  },
  methods: {
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
</style>
