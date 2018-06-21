<template>
    
    <div class="location-page">
      <!-- <div class="type-page">
        <div><button id="btn-list">Location List</button></div>
        <div><button id="btn-map-view">Map View</button></div>
      </div> -->
      <div class="location-list">
        <!-- <div class="location-sort">
          <b>Sort By</b>
        </div> -->
        <div class="location-blocks">
          <div class="material-box material-shadow-animate" :key='location.Id' v-for="location in locations" v-on:click="setSelectedLocation(location)">
            <div class="location-name">
              {{location.Name}}
            </div>
            <div class="location-address">
              <i class="material-icons">place</i>
              {{location.Address}}
              
            </div>
          </div>         
        </div>
        <router-link to="/location/create-location" class="btn-add-location material-shadow-animate" >Add Location</router-link> 
      </div>
   
      <div v-if="selectedLocation != null" class="location-detail material-box material-shadow">  
          <div class="info-location" >
            <div class="header-detail">
              <div style="font-size: 1.8rem;" >{{selectedLocation.Name}}</div>      
              <div class="btn-edit">
              <router-link :to="'/location/edit-location/'+selectedLocation.Id" class="rtl-edit"> Edit <i class="material-icons" style="position: relative;top: 0.43rem;right: 0.3rem;font-size: 25px;">chevron_right</i></router-link> 
            </div>
            </div>    
            <div class="location-address">
              {{selectedLocation.Address}}
            </div>
            <div>
              Description: {{selectedLocation.Description}}            
            </div>
            
          </div>         
          <div class="type-bar">
              <div v-on:click="currentMode = modes.MAP">Map</div>
              <div v-on:click="currentMode = modes.EQUIPMENT">Equipment</div>
              <div v-on:click="currentMode = modes.WORKORDER">Work Order</div>
              <div v-on:click="currentMode = modes.TEAM">Team</div>
              <div v-on:click="currentMode = modes.POSITION">Position</div>
          </div>
          <div class="infor-detail-type">
            <div v-if="currentMode == modes.MAP">
              <div class="ggmap">
                <GmapMap
                :center="{lat:selectedLocation.Latitude, lng:selectedLocation.Longitude}"
                :zoom="16"
                map-type-id="terrain"
                style="width: 100%; height:31rem"
              >
              <GmapMarker
                :position="google && new google.maps.LatLng(selectedLocation.Latitude, selectedLocation.Longitude)"
                :clickable="true"
                :draggable="true"
                @click="center=google && new google.maps.LatLng(selectedLocation.Latitude, selectedLocation.Longitude)"
              />
              </GmapMap>
              </div>
            </div>
            <div v-if="currentMode == modes.EQUIPMENT" > 
              
              <div >
                
                <!-- {{equipment.Id}},{{equipment.Name}} , 
                <img v-show="equipment.Image" :src="equipment.Image"  style="width: 3rem; height: 3rem;"> -->
                <v-flex >
                        <v-expansion-panel popout>
                            <v-expansion-panel-content v-bind:key='equipment.Id' v-for="equipment in equipments">
                                <div slot="header" style="display: grid; grid-template-columns: 25% auto;">
                                    <div style="display: flex">
                                        <img v-show="equipment.Image" :src="equipment.Image" style="width: 3rem; height: 3rem;">
                                    </div>
                                    <div style="display: grid; grid-template-rows: auto auto;">
                                        <div>
                                            {{ equipment.Name }}
                                        </div>                                            
                                        <div style="font-size: .9rem">
                                            <!-- Quantity: {{ equipment.EquipmentItems.length }} -->
                                            Quantity: {{ equipment.EquipmentItems.length }}
                                        </div>
                                    </div>
                                </div>
                                <v-card v-for="eqtItem in equipment.EquipmentItems" :key="eqtItem.Id">
                                    <v-card-text style="font-size: .9rem">
                                        Serial #: <a>{{ eqtItem.SerialNumber }}</a> | 
                                        <a href="">View position</a>
                                    </v-card-text>
                                </v-card>
                            </v-expansion-panel-content>
                        </v-expansion-panel>
                    </v-flex>
              </div>
            </div>
            <div v-else-if="currentMode == modes.WORKORDER" style="padding-top:5px">              
              <div v-bind:key='workorder.Id' v-for="workorder in workorders">           
                <div style="display: grid; grid-template-columns: 40% 40% auto;" class="order-box">
                    <div style="display: flex">
                        {{workorder.Name}}
                    </div>
                    <div style="display: grid; grid-template-rows: auto auto;">                                                                                  
                        <div style="font-size: .9rem">
                            <!-- Quantity: {{ equipment.EquipmentItems.length }} -->
                            Created Date: {{ workorder.CreateDate }}
                        </div>
                        <div>
                          Quantity of Item: {{workorder.Quantity}}
                        </div>
                    </div>
                    <div>
                       <a href="" id="show-detail">Show Detail</a>
                    </div>
                </div>
              </div>
            </div>
            <div v-else-if="currentMode == modes.TEAM">
              <v-flex >
                        <v-expansion-panel popout>
                            <v-expansion-panel-content :key='account.Id' v-for="account in team">
                                <div slot="header" style="padding-top:0.2rem; width: 100% " >
                                  <div class="name-team">
                                    <div><i class="material-icons" >group</i></div>
                                    <div style="padding-left:10px">{{account.NameOfTeam}}</div> 
                                    
                                  </div>                 
                                </div>
                                <v-card>
                                    <v-card-text style="font-size: .9rem">
                                      <div style="display: grid; grid-template-columns: 40% auto; background-color:#F5F5F5; padding: 1rem;">
                                        <div class="acc-img">
                                          <img v-show="account.AvatarImage" :src="account.AvatarImage" >
                                        </div>
                                      <div >
                                        <div>
                                          <h2 id="info-title">Information</h2>
                                        </div>
                                        <div class="acc-info">
                                          <div><i class="material-icons">credit_card</i> Name: {{account.Fullname}}  </div>
                                          <div><i class="material-icons">settings_phone  </i> Phone: {{account.Phone}} </div>
                                          <div><i class="material-icons">email</i> Email: {{account.Email}} </div>
                                          <div><i class="material-icons">date_range</i> StartDate: {{account.StartDate}}</div>
                                          <div id="team-detail">
                                            <router-link :to="'/team/' + account.IdOfTeam" >Show Team Detail </router-link>
                                          </div>
                                        </div>                        
                                      </div>
                                      </div>
                                    </v-card-text>
                                </v-card>
                            </v-expansion-panel-content>
                      </v-expansion-panel>
                    </v-flex>                 
                   
                   
                   
                 </div>
                 <!-- <div v-else>
                   <i class="material-icons">perm_identity</i>
                 </div> -->  
                 <div v-else>position </div>          
            </div>            
          </div>                                
  </div>
          
     
</template>

<script>
import Server from "@/config/config.js";
import { gmapApi } from "vue2-google-maps";

export default {
  computed: {
    google: gmapApi
  },
  data() {
    return {
      locations: [],
      equipments: [],
      workorders: [],
      team: [],
      selectedLocation: null,
      currentMode: 4,
      modes: {
        EQUIPMENT: 0,
        WORKORDER: 1,
        TEAM: 2,
        POSITION: 3,
        MAP: 4
      }
    };
  },
  methods: {
    setSelectedLocation(location) {
      // let url = `${Server.EQUIPMENTITEM_BY_ID_LOCATION_API_PATH}/${location.Id}/getByLocationId`;
      // this.axios.get(url)
      //   .then((response) => {
      //     let data = response.data;
      //     data.forEach(equipment => {
      //       this.equipments.push(equipment);
      //     })
      //   })
      //   .catch((error) => {
      //     console.log(error);
      //   })
      // alert(this.selectedLocation);
      this.selectedLocation = location;
      this.getEquipmentFromLocation(location);
      this.getWororderFromLocation(location);
      this.getTeamFromLocation(location);
    },
    getEquipmentFromLocation(location) {
      this.equipments = [];
      let url = `${
        Server.EQUIPMENTITEM_BY_ID_LOCATION_API_PATH
      }/getByEquipmentId/${location.Id}`;
      this.axios
        .get(url)
        .then(response => {
          let data = response.data;
          data.forEach(eqtItem => {
            this.equipments.push(eqtItem);
          });
        })
        .catch(error => {
          console.log(error);
        });
    },
    getWororderFromLocation(location) {
      this.workorders = [];
      let url = `${Server.WORKODER_BY_ID_LOCATION_API_PATH}/${location.Id}`;
      this.axios
        .get(url)
        .then(response => {
          let data = response.data;
          data.forEach(workorder => {
            this.workorders.push(workorder);
          });
        })
        .catch(error => {
          console.log(error);
        });
    },
    getTeamFromLocation(location) {
      this.team = [];
      let url = `${Server.TEAM_BY_LOCATION_ID_API_PATH}/${location.Id}`;
      this.axios
        .get(url)
        .then(response => {
          let data = response.data;
          data.forEach(account => {
            this.team.push(account);
          });
        })
        .catch(error => {
          console.log(error);
        });
    }
  },

  created() {
    this.axios
      .get(Server.LOCATION_API_PATH)
      .then(response => {
        let data = response.data;
        data.forEach(location => {
          this.locations.push(location);
        });
        // this.selectedLocation(this.locations[0]);
      })
      .catch(error => {
        console.log(error);
      });
  }
};
</script>

<style scoped>
/* .type-page{
  display: grid;
  grid-template-columns: 10% 10% auto;
  padding-top: 0 ;
  width: 100%;
  height: 2.5rem;
  line-height: 2.5rem;
 
}
#btn-list{
  background-color: white;
  padding: 0.4rem 0.6rem;
  
  font-size: 15px;
 
  color: var(--primary-color);
  border-radius: 5px 0 0 5px;
  border: 1px solid #26a69a;
  z-index: 1;
}
#btn-map-view{
  background-color: #26a69a;
  color: white;
  cursor: pointer;
} */

#edit-text {
  font-size: 1.3rem;
  cursor: pointer;
  text-indent: 1px;
  color: teal;
}
.location-page {
  width: 100%;
  /* padding: 0 !important; */
}
.location-list {
  width: 40%;
}

.location-sort {
  height: 2.6rem;
  line-height: 2.6rem;
  /* text-justify:  */
  width: 100%;
  background-color: lightgrey;
  text-align: center;
  font-size: 1.4rem;
}
.location-blocks {
  /* display: grid;
  grid-gap: 10px; */
  position: fixed;
  height: 88%;
  padding-right: 1rem;
  width: 40%;
  overflow-y: auto;
}

.location-blocks div {
  margin-bottom: 0.6rem;
  cursor: pointer;
}

.location-name {
  font-size: 1.5rem;
}
.location-address {
  font-size: 1rem;
  color: grey;
}
.location-address i {
  font-size: 1rem;
}

.location-detail {
  display: grid;
  grid-template-rows: auto auto auto;
  grid-gap: 0.3rem;
  position: fixed;
  left: 56%;
  max-height: 88%;
  overflow-y: auto;
  overflow-x: hidden;
  width: 43%;
  z-index: 2;
}
.info-location {
  border-bottom: 1px solid lightgray;
}
.header-detail {
  display: grid;
  grid-template-columns: 80% auto;
}
.rtl-edit {
  color: var(--lighten-primary-color);
}
.rtl-edit:hover {
  cursor: pointer;
  color: #009688;
}
.btn-edit {
  position: relative;
  left: 1.2rem;
  bottom: 1.2rem;
  text-align: right;
  padding-right: 0% !important;

  color: var(--lighten-primary-color);
  padding: 7px;

  border-radius: 5px;
  z-index: 10;
  font-size: 1rem;
  font-weight: bold;
}

.btn-add-location {
  position: fixed;
  right: 43.5rem;
  bottom: 1.5rem;
  background-color: var(--primary-color);
  padding: 13px;
  color: white;
  border-radius: 5px;
  z-index: 10;
  font-size: 1.3rem;
}
.btn-add-location:hover {
  cursor: pointer;
  background-color: #009688;
}
.type-bar {
  border: 0.5px solid;
  border-radius: 5px;
  display: grid;
  grid-template-columns: auto auto auto auto auto;
  color: var(--primary-color);
  border-color: var(--primary-color);
}
.type-bar div {
  border-right: 1px solid;
  border-color: var(--primary-color);
  text-align: center;
}
.type-bar div:last-child {
  border-right: 0px;
}
.type-bar div:hover {
  cursor: pointer;
  color: white;
  background-color: var(--primary-color);
}
.btn-add-location {
  position: fixed;
  right: 43.5rem;
  bottom: 1.5rem;
  background-color: var(--primary-color);
  padding: 13px;
  color: white;
  border-radius: 5px;
  z-index: 10;
  font-size: 1.3rem;
}
.btn-add-location:hover {
  cursor: pointer;
  background-color: #009688;
}
.order-box {
  padding-top: 0.5rem;
  border-bottom: 1.5px solid lightgray;
  padding-left: 10px;
}

.name-team {
  display: grid;
  grid-template-columns: 5% auto;
  height: 3rem;
  line-height: 3rem;

  font-size: 20px;
  font-weight: bold;
  color: var(--primary-color);
  border-bottom: 0.5px solid lightgrey;
}
.name-team i {
  color: gray;
  position: relative;
  top: 0.3rem;
  font-size: 25px;
}
#show-detail {
  text-align: center;
  height: 100%;
  line-height: 70px;
}
.acc-info {
  padding-left: 1rem;
  margin: 0.3rem;
}
#info-title {
  padding-left: 0 !important;
  padding-bottom: 0.5rem;
  width: 100%;
  text-align: center;
  border-bottom: var(--shadow) 1px solid;
  font: 24px bold;
}
.acc-info i {
  position: relative;
  top: 0.3rem;
}
.acc-info div {
  width: 100%;
}
#team-detail {
  margin-top: 0.5rem;
  color: #26a69a !important;
  font-size: 17px;
  text-align: center;
}
/* #team-detail router-link{
  color: #26a69a;
}
#team-detail:hover{
  color: var(--darken-primary-color);
} */
</style>
