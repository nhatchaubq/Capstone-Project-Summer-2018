<template>
    <div v-if="equipments">
        <table class="table">
            <thead>
                <tr>
                    <th><strong>Order #</strong></th>
                    <th><strong>Equipment name</strong></th>
                    <th><strong>Vendor name</strong></th>
                    <th><strong>Made In</strong></th>
                    <th><strong>Description</strong></th>
                    <th><strong>Category</strong></th>
                </tr>
            </thead>  
            <tbody>
                <tr v-bind:key="equipment.id" v-for="(equipment, index) in equipments" v-on:click="setSelectedEquipment(equipment)">
                    <td>{{ index + 1 }}</td>   
                    <td>{{equipment.Name}}</td>
                    <td>{{equipment.Vendor.Name}}</td>
                    <td>{{equipment.MadeIn}}</td>
                    <!-- <td>{{equipment.Price ? equipment.Price : 'n/a'}}</td> -->
                    <td>{{equipment.Description ? equipment.Description : 'n/a' }}</td>
                    <td>{{equipment.Category.Name}}</td>
                </tr>
            </tbody>
        </table>
        <vodal class="no-padding" height="500" :show="selectedEquipment != null" @hide="selectedEquipment = null" animation="slideUp">
          <!-- <div>alo</div> -->
          <equipment-detail-popup :equipment="selectedEquipment" class="" v-show="selectedEquipment != null"></equipment-detail-popup>
        </vodal>
    </div>
</template>

<script>
import "vodal/common.css";
import "vodal/slide-up.css";
import EquipmentDetailPopup from './EquipmentDetailPopup';
import Vodal from 'vodal';

export default {
  name: "equipment-table",
  components: {
    EquipmentDetailPopup, Vodal
  },
  props: {
    equipments: null
  }, 
  data() {
    return {
      selectedEquipment: null,
    }
  },
  methods: {
    setSelectedEquipment(equipment) {
      this.selectedEquipment = equipment;
    }
  }
};
</script>

<style scoped>
table {
  /* border: 1px solid black; */
  width: 100%;
  /* text-align: right; */
}

th {
  text-align: left;
  background-color: #cfd8dc;
}

td {
  vertical-align: middle;
  /* text-align: justify; */
}

tr:nth-child(odd) {
  background-color: white;
  color: #263238;
}

tr:nth-child(even) {
  background-color: #eceff1;
  color: #263238;
}

#th1:curve {
  text-align: justify;
  background-color: #b0bec5;
}

.no-padding {
  padding: 0 !important;
}
</style>
