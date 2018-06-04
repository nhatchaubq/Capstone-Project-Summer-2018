<template>
     <div>
         <div class="equipment-block">
       <div class="field is-grouped" >
            <router-link to='/equipment'>
            <button id="btn-table-view" >Table view  
            </button>
          </router-link>

          <router-link to='/equipment/card'>
            <button id="btn-table-view" disabled="disabled">Card view  
            </button>
          </router-link>
        </div>
        
        </div>

       <div class="columns" >
            <div class="column is-one-quarter" v-bind:key="equipment.id" v-for="equipment in equipmentpool">
                <v-card class="dashboard-tile" style="border: none !important;" >
                    <!-- <div class="dashboard-tile-title">
                        <div v-bind:key="equipment.id" v-for="equipment in equipmentpools">
                        <img src="{{equipment.thumbnail}}" alt="Crane">
                        </div>
                    </div> -->
                    <div class="dashboard-tile-content" >

                        <!-- <img src="{{equipment.thumbnail}}" alt="Crane"> -->
                        <h2><strong>{{equipment.equipmentName}}</strong></h2>
                        <div><span>ID: </span>{{equipment.id}}</div>
                        <div><span>Vendor's name: </span>{{equipment.vendorName}}</div>
                        <div><span>Import's date: </span>{{equipment.importDate}}</div>
                        <div><span>Price: </span>{{equipment.price}}</div>
                        <div><span>Description: </span>{{equipment.description}}</div>
                        <div><span>Category: </span>{{equipment.category}}</div>
                        <div><span>In department: </span>{{equipment.department}}</div>

                    </div>
                </v-card>
            </div>
        </div>
          <router-link to='/equipment/add/'>
    <button id="btn-add-equipment">Add Equipment</button>
  </router-link>
    </div>
</template>

<script>
import data from "@/models/equipment_tb.js";

export default {
  name: "equipmentCard",
  data() {
    return {
      equipmentpool: data
    };
  }
};
</script>

<style>
.dashboard-tile {
  /* border: 1px solid #bdbdbd; */
  height: 200px;
  width: 100%;
  margin-bottom: 20px;
}

.dashboard-tile-title {
  border-bottom: 1px solid #e0e0e0;
  padding: 10px 15px 10px 15px;
}

.dashboard-tile-content {
  padding: 10px 15px 10px 15px;
}

.circle-progress {
  border: 10px solid #bdbdbd;
  border-top: 10px solid green;
  border-right: 10px solid green;
  border-radius: 50%;
  width: 200px;
  height: 200px;
}

.circle-progress p {
  text-align: center;
  position: relative;
  top: 65px;
}
img {
  height: 287px;
  width: 175px;
}
</style>
