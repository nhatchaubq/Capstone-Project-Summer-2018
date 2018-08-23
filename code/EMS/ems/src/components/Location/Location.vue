<template>  
<div>
  
  <div>
    <div class="emtpy-text" v-if="locations && locations.length == 0">
      There is no location to display.
    </div>
    <div class="location-page" v-if="locations && locations.length > 0">
      <div class="field is-grouped view-mode" v-if="authUser.Role == 'Manager'">
        <button class="btn-view-mode-left" :class='{"is-active": isListViewMode}' v-on:click="isListViewMode = true">List view</button>
        <button class="btn-view-mode-right" :class='{"is-active": !isListViewMode}' v-on:click="isListViewMode = false">Map view</button>
      </div>
      <div v-if="isListViewMode">
         <div class="location-list">
          <!-- <div class="location-sort">
            <b>Sort By</b>
          </div> -->
          <div class="location-blocks" :style="authUser.Role == 'Manager' ? 'max-height: 83%; min-height: 83%' : 'max-height: 90.15%; min-height: 90.15%'">
            <div class="material-box material-shadow-animate" :class="isActive(location.Id)"  :key='"location" + location.Id' v-for="location in locations" v-on:click="setSelectedLocation(location)" >
              <div class="location-name">                
                <div>{{location.Name}}</div>
                <!-- <div style="text-align: right; line-height: 1.6rem;">
                  <div v-if="!location.IsActive" class="tag" style="width: 100%; background-color:var(--danger-color);color:white">Inactive</div>
                  <div v-else class="tag" style="width: 100%; background-color:var(--success-color);color:white">Active</div>
                </div> -->
              </div>
              <div class="location-address">
                <i class="material-icons">place</i>
                {{location.Address}}                
              </div>
            </div>         
          </div>
          <router-link to="/location/create-location" v-if="authUser.Role == 'Manager'">
            <button class="btn-add-location button btn-primary material-shadow-animate">
              Add Location
            </button>
          </router-link> 
        </div>

        <div v-if="selectedLocation != null" class="location-detail material-box material-shadow"  :style="authUser.Role == 'Manager' ? 'max-height: 81%' : 'max-height: 88%'">  
          <div class="info-location" >
            <div class="header-detail">
              <div style="font-size: 1.8rem;" >{{selectedLocation.Name}}</div>      
              <div style="display: flex; justify-content: flex-end; align-items: center; font-weight: 500;">
                <a v-if="authUser.Role == 'Manager'" @click="$router.push(`/location/edit-location/${selectedLocation.Id}`)">Edit</a>
              </div>
            </div>
            
            <div class="location-address">
              <i style="position: relative; top: .1rem" class="material-icons">location_on</i> {{selectedLocation.Address}}
            </div>
            <div v-if="selectedLocation.Description">
              Description: {{selectedLocation.Description}}            
            </div>

            <br/> 
            <div style="">
              <div class="type-bar">
                <div :class="{'is-active': currentMode == modes.MAP}" v-on:click="currentMode = modes.MAP">Map</div>
                <div :class="{'is-active': currentMode == modes.EQUIPMENT}" v-on:click="currentMode = modes.EQUIPMENT">Equipment</div>
                <div :class="{'is-active': currentMode == modes.WORKORDER}" v-on:click="currentMode = modes.WORKORDER">Work Order</div>
                <div :class="{'is-active': currentMode == modes.TEAM}" v-on:click="currentMode = modes.TEAM">Team</div>
              </div>
            </div>
          

            <div v-if="currentMode == modes.MAP" style="padding-top: 1rem">
              <div class="ggmap">
                <GmapMap
                :center="{lat:selectedLocation.Latitude, lng:selectedLocation.Longitude}"
                :zoom="16"
                map-type-id="terrain"
                style="width: 100%; height:27rem"
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
            <div v-if="currentMode == modes.EQUIPMENT && equipments" style="padding-top:5px">               
              <div v-if="equipments.length > 0">                
                <!-- {{equipment.Id}},{{equipment.Name}} , 
                <img v-show="equipment.Image" :src="equipment.Image"  style="width: 3rem; height: 3rem;"> -->
                <v-flex >
                        <v-expansion-panel popout>
                            <v-expansion-panel-content v-bind:key="'equipment' + equipment.Id" v-for="equipment in equipments">
                                <div slot="header" style="display: grid; grid-template-columns: 25% auto;">
                                    <div style="display: flex">
                                        <img v-show="equipment.Image" :src="equipment.Image" style="width: 3rem; height: 3rem;">
                                    </div>
                                    <div style="display: grid; grid-template-rows: auto auto;">
                                        <div>
                                            {{ equipment.Name }}
                                        </div>                                            
                                        <div style="font-size: .9rem">                                            
                                            Quantity: {{ equipment.EquipmentItems.length }}
                                        </div>
                                    </div>
                                </div>
                                <v-card v-for="eqtItem in equipment.EquipmentItems" :key="'eqtItem' + eqtItem.Id">
                                    <v-card-text style="font-size: .9rem">
                                        Serial #: <a>{{ eqtItem.SerialNumber }}</a> | Current in: Block {{eqtItem.Block}} - Floor {{eqtItem.Floor}} - Tile {{eqtItem.Tile}}
                                    </v-card-text>
                                </v-card>
                            </v-expansion-panel-content>
                        </v-expansion-panel>
                    </v-flex>
              </div>
              <div v-else>
                This location has no equipment.
              </div>
            </div>
            
            <div v-else-if="currentMode == modes.WORKORDER" style="padding-top:5px">
              <div  v-if="workorders.length > 0">
                <div v-bind:key='"workorder" + workorder.Id' v-for="workorder in workorders">                           
                <div style="display: grid; grid-template-columns: 80% auto;border-bottom:0.15px solid;padding-top:1rem; font-size: 0.95rem" >
                    <div style=" border-right: 0.25px solid">
                      <div style="display: grid; grid-template-columns: 80% auto; font-weight: 500; padding: .5rem 0">
                        <div style="font-size: 1.3rem; margin-top: -.6rem;">{{workorder.Name}}</div>                        
                        <div style="color: white; margin-top: -.3rem; margin-right:0.5rem" :style="{'background-color':  makeStatusBackground(workorder.Status)}" class="tag"> {{workorder.Status}}</div>
                      </div>
                      <div style="display: grid; grid-template-columns:auto 35% 20%;">                        
                        <div><i class="material-icons" style="color: gray;position: relative;top: 0.3rem;">group</i> {{workorder.Team}} </div> 
                        <div style="position: relative;top: 0.5rem;"><i class="fa fa-calendar" style="color:gray;"></i> {{getFormatDate(workorder.CreateDate)}}</div>                                             
                      </div>                      
                    </div>                    
                    <div style="text-align:center">
                       <a  id="show-detail" v-on:click="showWorkorderDetail(workorder)">Show Detail</a>
                    </div>
                </div>
              </div>
              </div>                            
              <div v-else>
                This location has no work order.
              </div>
            </div>
            <div v-else-if="currentMode == modes.TEAM" style="padding-top:5px">
              <div v-if="teams.length > 0">
                <v-flex>
                        <v-expansion-panel popout>
                            <v-expansion-panel-content :key='"account" + account.Id' v-for="account in teams">
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
                                            <h2 id="info-title">Team Leader</h2>
                                          </div>
                                          <div class="acc-info">
                                            <div><i class="material-icons">credit_card</i> Name: {{account.Fullname}}  </div>
                                            <div><i class="material-icons">settings_phone  </i> Phone: {{account.Phone}} </div>
                                            <div><i class="material-icons">email</i> Email: {{account.Email}} </div>
                                            <div><i class="material-icons">date_range</i> StartDate: {{getFormatDate(account.StartDate)}}</div>
                                            <!-- <div id="team-detail">
                                              <router-link :to="'/team/' + account.IdOfTeam" >Show Team Detail </router-link>
                                            </div> -->
                                          </div>                                         
                                        </div>
                                      </div>
                                      <div style="display:grid; grid-template-columns:20% auto;padding-left:3rem; background-color:#F5F5F5">
                                        <div style="font-weight:bold; font-size:18px">
                                          Members:
                                        </div>
                                        <div style="font-size:15px;">
                                          <div style="margin-bottom:0.2rem" :key="'member' + member.Id" v-for="member in account.Members">
                                            -  {{member.Fullname}}<br>
                                          </div>                                          
                                        </div>
                                      </div>
                                    </v-card-text>
                                </v-card>
                            </v-expansion-panel-content>
                      </v-expansion-panel>
                    </v-flex>                
              </div>
              <div v-else>
                This location has no team.
              </div>                             
            </div>
                 <!-- <div v-else>
                   <i class="material-icons">perm_identity</i>
                 </div> -->                  
               </div>
            </div>
            <div v-else>  </div>
      </div>
      <div v-else style="height: 100% !important">
        <map-view :locations="locations"></map-view>     
      </div>   
      <modal v-model="addPopUp" v-if="selectedWorkorder && status.length>0">        
        <div slot="header" class="title-wd"> 
          Work Order: {{selectedWorkorder.Name}}
        </div>
        <div class="info-wd">
          <div class="" style="display:grid; grid-template-columns: 16% auto; font-size:20px">
            <div class="info-title">
              Team:
            </div>
            <div class="info-content">
              {{selectedWorkorder.Team}}
            </div>
          </div>
          <div class="" style="display:grid;grid-template-columns:auto auto auto auto;font-size:15px">
            <div class="info-title">
              <i class="fa fa-calendar" style="color:gray;"></i> Start Date: 
            </div>
            <div class="info-content">
              {{getFormatDate(selectedWorkorder.StartDate)}}
            </div>
            <div class="info-title">
               <i class="fa fa-calendar" style="color:gray;"></i> Due Date: 
            </div>
            <div class="info-content">
               {{getFormatDate(selectedWorkorder.ExpectingStartDate)}} - 
               {{getFormatDate(selectedWorkorder.ExpectingCloseDate)}}
            </div>
          </div>
          
          <div class="info-field">
            
            <div class="info-title">
             <i class="fa fa-calendar" style="color:gray;"></i>  Closed Date:
            </div>
            <div class="info-content" v-if="selectedWorkorder.ClosedDate">
               {{getFormatDate(selectedWorkorder.ClosedDate)}}
            </div>
            <div class="info-content"  v-else>
              N/A
            </div>
          </div>                                        
        </div>
        <!-- <div style="text-align:center; padding-bottom: 1.5rem">          
          <step-progress :workOrderStatus="{id: selectedWorkorder.StatusID, name: selectedWorkorder.Status}" 
                    :statusList="status.filter(s => s.name != 'Cancelled')"></step-progress>          
        </div>    -->
        <div >          
            <table style="width:100%"> 
              <thead >
                <tr style="width:100%">
                  <th><strong>Equipment</strong></th>
                  <th><strong>Serial #</strong></th>
                  <th><strong>Status</strong></th>
                </tr>                
              </thead>
              <tbody style="font-size:14px" :class="{'row-even': index % 2 != 0}" :key='"workorderDetail" + workorderDetail.Id' v-for="(workorderDetail, index) in selectedWorkorder.WorkorderDetail">
                <tr >
                  <td :rowspan="`${workorderDetail.EquipmentItems.length + 1}`">{{workorderDetail.Name}}</td>
                </tr>
                <tr :key="'EquipmentItems' + item.Id" v-for="item in workorderDetail.EquipmentItems">                  
                  <td >{{item.SerialNumber}}</td>
                  <td v-if="selectedWorkorder.Status == 'In Progress' || selectedWorkorder.Status == 'Closed'" :style="{color: item.ClosedDate? 'var(--blue)' : 'var(--success-color)'}">{{item.ClosedDate? "Returned" : "Working" }}</td>
                  <td v-if="selectedWorkorder.Status == 'Requested'" style="color: var(--status-requested)" >Requested</td>
                  <td v-if="selectedWorkorder.Status == 'Checked'" style="color: var(--status-checked)" >Checked</td>
                  <td v-if="selectedWorkorder.Status == 'Approved'" style="color: var(--status-approved)" >Approved</td>              
                </tr>
              </tbody>
            </table>            
            <!-- <div style="display: flex">
              {{workorderDetail.Id}}
              {{workorderDetail.StartDate}}   
              {{workorderDetail.FinishedDate}}           
            </div>
            <div style="display: grid; grid-template-rows: auto auto;">
                <div>
                    {{ workorderDetail.Name }}
                </div>                                            
                <div style="font-size: .9rem">                  
                    Quantity: {{ workorderDetail.EquipmentItems.length }}
                </div>
            </div> -->
          </div>                     
        <div slot="footer"><button class="button" v-on:click="addPopUp = false" style="background-color:var(--primary-color);color:white">OK</button></div>
      </modal>
    </div>
  </div>
</div>  
    
</template>

<script>
import Server from "@/config/config.js";
import { gmapApi } from "vue2-google-maps";
import Vodal from "vodal";
import "vodal/common.css";
import "vodal/slide-up.css";
import MapView from "./MapView";

import { sync } from "vuex-pathify";
// import StepProgress from "@/components/StepProgress/StepProgress.vue";
import moment from "moment";

export default {
  components: {
    MapView,
    Vodal
    // StepProgress
  },
  computed: {
    google: gmapApi,
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    },
    searchValues: sync("locationPage.searchValues")
  },
  async created() {
    // alert(JSON.parse(window.localStorage.getItem("user")).Id);
    // alert(JSON.parse(window.localStorage.getItem("user")).Role);
    let url = "";
    if (
      JSON.parse(window.localStorage.getItem("user")).Role == "Manager" ||
      JSON.parse(window.localStorage.getItem("user")).Role ==
        "Equipment Staff" ||
      JSON.parse(window.localStorage.getItem("user")).Role == "Admin"
    ) {
      url = "http://localhost:3000/api/location/";
    } else {
      url = `http://localhost:3000/api/location/getLocation/${
        JSON.parse(window.localStorage.getItem("user")).Id
      }`;
    }
    // alert(url);
    await this.axios
      .get(url)
      .then(async response => {
        let data = response.data;
        this.locations = data;
        this.allLocations = data;
        if (this.locations.length > 0) {
          this.setSelectedLocation(data[0]);
        }
      })
      .catch(error => {
        console.log(error);
      });
  },
  data() {
    return {
      addPopUp: false,
      locations: [],
      equipments: [],
      workorders: [],
      workorderDetails: [],
      selectedWorkorder: null,
      teams: [],
      selectedLocation: null,
      currentMode: 4,
      modes: {
        EQUIPMENT: 0,
        WORKORDER: 1,
        TEAM: 2,
        POSITION: 3,
        MAP: 4
      },
      allLocations: [],
      // chaubqn - start chaubqn - start
      isListViewMode: true,
      status: []
      // chaubqn - end
    };
  },

  methods: {
    makeStatusBackground(status) {
      switch (status) {
        case "Requested": {
          return "var(--status-requested)";
        }
        case "Checked": {
          return "var(--status-checked)";
        }
        case "Approved": {
          return "var(--status-approved)";
        }
        case "In Progress": {
          return "var(--status-in-progress)";
        }
        case "Closed": {
          return "var(--status-closed)";
        }
      }
    },
    showWorkorderDetail(tmpWorkorder) {
      this.addPopUp = true;
      this.selectedWorkorder = tmpWorkorder;
    },
    isActive(locationId) {
      if (this.selectedLocation && locationId != this.selectedLocation.Id) {
        return "is-active-block";
      } else {
        return "";
      }
    },
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
      if (
        JSON.parse(window.localStorage.getItem("user")).Role ==
        ("Staff" || "Maintainer")
      ) {
        url = `http://localhost:3000/api/equipmentItem/getItemByMem/${
          location.Id
        }`;
      }

      this.axios
        .get(url)
        .then(response => {
          let data = response.data;
          data.forEach(eqtItem => {
            if (
              JSON.parse(window.localStorage.getItem("user")).Role ==
              ("Staff" || "Maintainer")
            ) {
              eqtItem.OfTeam.forEach(mem => {
                if (
                  JSON.parse(window.localStorage.getItem("user")).Id == mem.Id
                ) {
                  this.equipments.push(eqtItem);
                }
              });
            } else {
              this.equipments.push(eqtItem);
            }
          });
        })
        .catch(error => {
          console.log(error);
        });
    },
    getAllLocation() {
      this.locations = [];
      this.allLocations = [];
      let url = "";
      if (
        JSON.parse(window.localStorage.getItem("user")).Role == "Manager" ||
        JSON.parse(window.localStorage.getItem("user")).Role ==
          "Equipment Staff"
      ) {
        url = "http://localhost:3000/api/location/";
      } else {
        url = `http://localhost:3000/api/location/getLocation/${
          JSON.parse(window.localStorage.getItem("user")).Id
        }`;
      }
      // alert(url);
      this.axios
        .get(url)
        .then(response => {
          let data = response.data;
          data.forEach(location => {
            this.locations.push(location);
            this.allLocations.push(location);
          });
          if (this.locations.length > 0) {
            this.setSelectedLocation(data[0]);
          }
        })
        .catch(error => {
          console.log(error);
        });
    },
    getWororderFromLocation(location) {
      this.workorders = [];
      let url = `${Server.WORKODER_BY_ID_LOCATION_API_PATH}/${location.Id}`;
      this.axios.get(url).then(response => {
        let data = response.data;
        if (
          JSON.parse(window.localStorage.getItem("user")).Role ==
          ("Staff" || "Maintainer")
        ) {
          data.forEach(workorder => {
            workorder.OfTeam.forEach(mem => {
              if (
                JSON.parse(window.localStorage.getItem("user")).Id == mem.Id
              ) {
                this.workorders.push(workorder);
              }
            });
          });
        } else {
          data.forEach(workorder => {
            this.workorders.push(workorder);
          });
        }
      });
    },
    getFormatDate(date) {
      return moment(date).format("L");
    },
    getTeamFromLocation(location) {
      this.teams = [];
      let url = `${Server.TEAM_BY_LOCATION_ID_API_PATH}/${location.Id}`;
      this.axios
        .get(url)
        .then(response => {
          let data = response.data;
          data.forEach(team => {
            this.teams.push(team);
          });
        })
        .catch(error => {
          console.log(error);
        });
      this.axios
        .get(Server.WORKORDER_STATUS_API_PATH)
        .then(response => {
          let data = response.data;
          data.forEach(element => {
            let status = {
              id: element.Id,
              name: element.Name
            };
            this.status.push(status);
          });
        })
        .catch(error => {
          if (error == "Request failed with status code 500") {
            this.$router.push("/500");
          }
        });
    }
    // chaubqn - start
    // getLocationBlockFloorTile(locationId) {
    //   let url = `${Server.LOCATION_BLOCK_FLOOR_TILE_API_PATH}/${locationId}`;
    //   this.axios.get(url)
    //     .then((res) => {
    //       this.mapViewSelectedLocation = res.data;
    //     })
    //     .catch((error) => {
    //       console.log(error);
    //     })
    // }
    // chaubqn - end
  },
  watch: {
    searchValues: function() {
      if (this.searchValues && this.searchValues.length > 0) {
        let tmpLocations = [];
        for (const location of this.searchValues) {
          tmpLocations = tmpLocations.concat(
            this.allLocations.filter(l => l.Id == location.Id)
          );
        }
        this.locations = tmpLocations;
      } else {
        this.locations = [];
      }
    },
    "$store.state.locationPage.searchText": function() {
      if (this.$store.state.locationPage.searchText.length > 0) {
        // this.setSelectedLocation(null);
        this.selectedLocation = null;
      }
      if (this.$store.state.locationPage.searchText == "") {
        this.getAllLocation();
      }
    }
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
  /* height: 88%; */
  padding-right: 1rem;
  width: 35%;
  overflow-y: auto;
  padding-bottom: 1rem;
  /* max-height: 83%; */
}
/* .location-blocks-choose {
  position: fixed;
  height: 88%;
  padding-right: 1rem;
  width: 35%;
  overflow-y: auto;
  background-color: #263238;
} */

.location-blocks div {
  margin-bottom: 0.6rem;
  cursor: pointer;
}

.location-blocks div:last-child {
  margin-bottom: 0;
}

.location-name {
  display: grid;
  grid-template-columns: 85% 15%;
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
  max-height: 83.5%;
  overflow-y: auto;
  overflow-x: hidden;
  width: 43%;
  /* padding-bottom: 5rem; */
  z-index: 2;
}
.info-location {
  border-bottom: 1px solid lightgray;
}
.header-detail {
  display: grid;
  grid-template-columns: 95% 5%;
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

/* .btn-add-location {
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
} */
.type-bar {
  border: 0.5px solid;
  border-radius: 5px;
  display: grid;
  grid-template-columns: auto auto auto auto;
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
  color: #263238;
  /*background-color: var(--secondary-color);*/
  background-color: #80cbc4;
}

.is-active {
  cursor: pointer;
  color: white;
  background-color: var(--primary-color);
}

.btn-add-location {
  position: fixed;
  right: 47%;
  bottom: 1.5rem;
  /* background-color: var(--primary-color); */
  /* padding: 13px; */
  /* color: white; */
  /* border-radius: 5px; */
  z-index: 10;
  /* font-size: 1.3rem; */
}
.btn-add-location:hover {
  cursor: pointer;
  /* background-color: #009688; */
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

.btn-view-mode-left {
  background-color: white;
  padding: 0.4rem 0.6rem;
  /* height: 2rem; */
  font-size: 15px;
  /* line-height: 2rem; */
  color: var(--primary-color);
  border-radius: 5px 0 0 5px;
  border: 1px solid #26a69a;
  z-index: 1;
  /* padding-right: 20px;
      padding-left: 20px; */
}

.btn-view-mode-left:hover {
  background-color: #80cbc4;
  color: #263238;
  cursor: pointer;
}
.btn-view-mode-right {
  background-color: white;
  padding: 0.4rem 0.6rem;
  /* height: 2rem; */
  font-size: 15px;
  /* line-height: 2rem; */
  color: var(--primary-color);
  border-radius: 0 5px 5px 0;
  border-top: 1px solid #26a69a;
  border-right: 1px solid #26a69a;
  border-bottom: 1px solid #26a69a;
  z-index: 1;
  /* padding-right: 20px;
      padding-left: 20px; */
  margin-right: 5px;
}

.btn-view-mode-right:hover {
  background-color: #80cbc4;
  color: #263238;
  cursor: pointer;
}

.is-active {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
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
.title-wd {
  font-size: 24px;
  font-weight: bold;
}
.info-wd {
  padding-bottom: 0.8rem;
}
.info-field {
  display: grid;
  grid-template-columns: 25% 25.6% auto auto;
  font-size: 15px;
}
.info-title {
  font-weight: bold;
}

/* dien */

/* dienend */
</style>
