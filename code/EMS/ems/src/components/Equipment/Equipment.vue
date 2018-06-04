<template>
    <div>
      <div class="equipment-block">
       <div class="field is-grouped" >


          <router-link to='/equipment'>
            <button id="btn-table-view" disabled="disabled">Table view  
            </button>
          </router-link>

          <router-link to='/equipment/card'>
            <button id="btn-table-view" >Card view  
            </button>
          </router-link>

            <!-- <a href="/equipment/card"><button id="btn-card-view" >Card view</button></a> -->
        </div>
      </div>


<!-- table -->
<table class="table">
  <thead>
    <tr >
      <th><strong>ID</strong> </th>
      <th><strong>Equipment name</strong></th>
      <th><strong>Vendor name</strong></th>
      <th><strong>Import date</strong></th>
      <th><strong>Price</strong></th>
      <th><strong>Description</strong></th>
      <th><strong>Category</strong></th>

    </tr>


  </thead>
  
  <tbody>
      <tr v-bind:key="equipment.id" v-for="equipment in equipmentlist">
        <td>{{equipment.id}}</td>    
        <td>{{equipment.equipmentName}}</td>
        <td>{{equipment.vendorName}}</td>
        <td>{{equipment.importDate}}</td>
        <td>{{equipment.price}}</td>
        <td>{{equipment.description}}</td>
        <td>{{equipment.category}}</td>
      </tr>
  </tbody>
</table>

    <a href="/equipment/add"><button id="btn-add-equipment">Add Equipment</button></a>
      
    </table>


<!-- /table -->
        
  <router-link to='/equipment/add/'>
    <button id="btn-add-equipment">Add Equipment</button>
  </router-link>


    </div>
</template>

<script>
import EquipmentCard from "./EquipmentCard";
import data from "@/models/equipment_tb.js";
// import equipmentstb from "./EquipmentTableBlock/EquipmentBlock";

export default {
  components: {
    EquipmentCard
  },
      data() {
        return {
            equipmentlist: data,
            selectedequipment: null,
        }
    },
    methods: {
        setSelectedEquipment(equipment) {
            this.selectedequipment = equipment;
        },
        
    }
};
</script>

<style>
.cards-wrapper {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
}
#field1 {
  background-color: white;
}
#btn-add-equipment {
  position: fixed;
  right: 3rem;
  bottom: 2rem;
  background-color: var(--primary-color);
  padding: 13px;
  color: white;
  border-radius: 10px;
  box-shadow: 4px 4px 5px #bdbdbd;
  z-index: 1;
}

#btn-add-equipment:hover {
  cursor: pointer;
  background-color: #009688;
  color: white;
}
#btn-table-view {
  background-color: white;
  padding: 4px;
  height: 30px;
  font-size: 15px;
  line-height: 15px;
  color: var(--primary-color);
  border-radius: 5px 5px 5px 5px;

  border: 1px solid #26a69a;
  z-index: 1;
  /* padding-right: 20px;
  padding-left: 20px; */
  margin-right: 5px;
}
#btn-table-view:hover {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}
#btn-table-view:disabled {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}

#btn-card-view {
  background-color: white;
  padding: 4px;
  height: 30px;
  font-size: 15px;
  line-height: 15px;
  color: var(--primary-color);
  border-radius: 5px 5px 5px 5px;
  border: 1px solid #26a69a;
  z-index: 1;
}
#btn-card-view:hover {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}
#btn-card-view:disabled {
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
table {
    /* border: 1px solid black; */
    width: 100%;
    text-align: right;
}
th{
  text-align: left;
  background-color: #CFD8DC;

}
td {
    text-align: justify;
    padding-top: 15px;
  
}
tr:nth-child(odd){background-color: white; color: #263238}
tr:nth-child(even){background-color: #ECEFF1; color: #263238}
#th1:curve{
  text-align: justify;
  background-color: #B0BEC5;
}

</style>
