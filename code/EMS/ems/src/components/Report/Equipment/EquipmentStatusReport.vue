<template>
    <div style="display: grid; grid-template-columns: 20% 80%">
        <div class="columnleft">
            <div class="filter">
                <div>
                    <div class="txtText">
                        Equipment Category
                    </div>                    
                    <div class="select">
                    <select style="width:100%">
                        <option disabled :value=null>Showing</option>                                
                        <option>All</option>
                        <option>Construction Equipment</option>
                        <option>Electricity Equipment</option>
                        <option>Office Equipment</option>                           
                                
                    </select>
                    </div>
                </div>
                <div>
                    <div class="txtText">
                        Period
                    </div>                    
                    <div class="select">
                    <select style="width:100%">
                        <option disabled :value=null>Showing</option>                                
                        <option>All time</option>
                        <option>This year</option>
                        <option>This month</option>
                        <option>This week</option>
                        <option>Today</option>
                        <option>Yesterday</option>
                        <option>Last week</option>
                        <option>Last month</option>
                        <option>Last year</option>                               
                                
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
                    <button class="btn-view-mode">Inactive Equipments</button>
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
                                <th><strong>Made In </strong></th>                                                                
                                <th><strong>Damaged</strong></th>                                
                                <th><strong>Lost</strong></th> 
                                <th><strong>Archive</strong></th> 

                            </tr>                            
                        </thead>  
                        <tbody>
                            <tr :key="equipment.Id" v-for="equipment in equipments">                            
                                <td>{{equipment.Name}}</td>    
                                <td>{{equipment.MadeIn}}</td>                                  
                                <td v-on:click="selectedStatus(equipment.DAMAGED.Detail)">{{equipment.DAMAGED.Quantity}}</td>   
                                <td v-on:click="selectedStatus(equipment.LOST.Detail)">{{equipment.LOST.Quantity}}</td>                                  
                                <td v-on:click="selectedStatus(equipment.ARCHIVE.Detail)">{{equipment.ARCHIVE.Quantity}}</td>                                  
                            </tr>                                                        
                        </tbody>
                    </table>
                </div>
                
                <!-- <div v-else>
                    <table class="mytable">
                        <thead>
                            <tr>                            
                                <th><strong>Stock Item</strong></th>
                                <th><strong>Equipment</strong></th>
                                <th><strong>Import Date</strong></th>
                                <th><strong>Used</strong></th>
                                <th><strong>Downtime Duration</strong></th>
                                <th><strong>Description</strong></th>                                
                            </tr>
                        </thead>  
                        <tbody>
                            <tr>
                                <td>CM9562</td>                            
                                <td>Concrete mixer</td>    
                                <td>20/02/2018</td>  
                                <td>10</td>  
                                <td>56 days</td>  
                                <td>n/a</td>                                 
                            </tr>
                            <tr>
                                <td>CM9856</td>                            
                                <td>Concrete mixer</td>    
                                <td>20/02/2018</td>  
                                <td>10</td>  
                                <td>12 days</td>  
                                <td>n/a</td>                                 
                            </tr>
                            <tr>
                                <td>CM1124</td>                            
                                <td>Concrete mixer</td>    
                                <td>20/02/2018</td>  
                                <td>60</td>  
                                <td>996 days</td>  
                                <td>n/a</td>                                 
                            </tr>

                            <tr>
                                <td>BH1140</td>                            
                                <td>Builder's hoist</td>    
                                <td>20/02/2018</td>  
                                <td>14</td>  
                                <td>52 days</td>  
                                <td>n/a</td>                                 
                            </tr>
                            <tr>
                                <td>EV1652</td>                            
                                <td>Excavator</td>    
                                <td>20/02/2018</td>  
                                <td>52</td>  
                                <td>562 days</td>  
                                <td>n/a</td>                                 
                            </tr>
                            
                        </tbody>
                    </table>
                </div> -->
            </div>
        </div>
        <vodal :show="showEquipmentItemPopup" @hide="showEquipmentItemPopup = false" animation="slideUp" :height='400'>
            <div  v-if="equipmentItems.length > 0" style="max-height:355px;overflow-y:auto;margin-top: 20px">
                <div style="display: grid; grid-template-columns: 25% auto;">
                                    <div style="display: flex">
                                        <img v-show="equipmentItems[0].Image" :src="equipmentItems[0].Image" style="width: 3rem; height: 3rem;">
                                    </div>
                                    <div style="display: grid; grid-template-rows: auto auto;">
                                        <div>
                                            Name: {{ equipmentItems[0].Name }}
                                        </div>                                            
                                        <div style="font-size: .9rem">
                                            Made In: {{equipmentItems[0].MadeIn}}
                                        </div>
                                    </div>
                </div>
                <div style="display: grid; grid-template-columns: 30% auto;">
                    <div>
                        SerialNumber:
                    </div>
                    <div >
                           <div :key="eqti.Id" v-for="eqti in equipmentItems">{{eqti.SerialNumber}}</div> 
                    </div>
                    
                </div>                    
                                       
            </div>
        </vodal>
    </div>
</template>

<script>
import "vodal/common.css";
import "vodal/slide-up.css";
import Vodal from "vodal";
import Server from "@/config/config.js";
export default {
  components: {
    Vodal
  },
  data() {
    return {
      equipments: [],
      showEquipmentItemPopup: false,
      equipmentItems: []
    };
  },
  methods: {
    selectedStatus(Items) {
      if (Items) {
        this.equipmentItems = Items;
        this.showEquipmentItemPopup = true;
      }
    }
  },
  created() {
    this.axios
      .get(Server.REPORT_STATUS_EQUIPMENT_API_PATH)
      .then(res => {
        let data = res.data;
        data.forEach(equipment => {
          this.equipments.push(equipment);
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
