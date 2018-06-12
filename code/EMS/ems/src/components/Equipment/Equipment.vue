<template>
  <div>
    <div class="">
      <div class="field is-grouped view-mode">
        <button class="btn-view-mode" :class='{"is-active": isTableMode}' v-on:click="setTableMode(true)">Table view</button>
        <button class="btn-view-mode" :class='{"is-active": !isTableMode}' v-on:click="setTableMode(false)">Card view</button>
      </div>

    </div>
    <div v-if="!equipments">
      There is no equipment yet.
    </div>
    <div v-else>
      <equipment-table :equipments="equipments" v-if="isTableMode"></equipment-table>
      <equipment-card :equipments="equipments" v-else></equipment-card>
    </div>

    <router-link to='/equipment/create/'>
      <button id="btn-add-equipment" class="material-shadow-animate">Add Equipment</button>
    </router-link>

  </div>
</template>

<script>
import { sync } from "vuex-pathify";
import Server from "@/config/config.js";
import EquipmentTable from "./EquipmentTable";
import EquipmentCard from "./EquipmentCard";

export default {
  components: {
    EquipmentTable,
    EquipmentCard
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
      equipments: [],
      selectedEquipment: null
    };
  },
  methods: {
    setSelectedEquipment(equipment) {
      this.selectedEquipment = equipment;
    },
    setTableMode(value) {
      this.$store.state.equipmentPage.isTableMode = value;
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
  bottom: 2rem;
  background-color: var(--primary-color);
  padding: 13px;
  color: white;
  border-radius: 5px;
  z-index: 1;
}

#btn-add-equipment:hover {
  cursor: pointer;
  background-color: #009688;
  color: white;
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
</style>
