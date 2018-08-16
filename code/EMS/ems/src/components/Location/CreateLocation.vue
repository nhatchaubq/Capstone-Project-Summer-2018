<template>
    <div class="form">
        <div class="form-title">                
          <div class="form-title-start">
            Add New Location
          </div>
          <div class="form-title-end">                              
                <button id="" class="button" style="margin-right: .6rem"  v-on:click="$router.push('/location')">Cancel</button>
                <simplert :useRadius="true" :icon="true" ref="simplert"></simplert>
                <button id="" class="button is-primary"  v-on:click="createLocation()">Create New Location</button>
          </div>
           
        </div>
        <div class="form-content" >              
            <div class="form-field" style="padding-top:1.5rem; padding-bottom: 0 !important;">
                <div class="form-field-title">
                    <strong>Name (required)</strong>  <span v-if="CreateLocationErrors.NoName != ''"><span class="error-text">  {{ CreateLocationErrors.NoName }}</span></span>
                </div>
                <div class="form-field-input">
                    <input v-model="newLocation.name" type="text" class="input">
                </div>
            </div>
            <div class="form-field" style="padding-top: 0 !important;">
                <div class="form-field-title">
                    <strong>Address (required)</strong>  <span v-if="CreateLocationErrors.NoAddress != ''"></span> <span class="error-text">  {{ CreateLocationErrors.NoAddress }}</span>
                </div>
                <div class="form-field-input">                  
                    <div>                    
                      <label class="ggSearch" style="width: 100%">
                        <gmap-autocomplete  class="input" 
                          @place_changed="setPlace">
                        </gmap-autocomplete>
                        <!-- <button  id="clear-btn" v-if="currentPlace" v-on:click="() => {}">
                          <i class="material-icons">close</i>
                        </button> -->
                        <!-- <button @click="addMarker" class="btn" style="position: relative; bottom: 8px;">Check</button> -->
                      </label>                   
                    </div>
                  <br>
                  <gmap-map
                    :center="marker?  marker : center"
                    :zoom="12"
                    style="width:100%;  height: 400px;"
                  >
                    <gmap-marker
                      v-if="marker"
                      :position="marker"
                      
                    ></gmap-marker>
                  </gmap-map>                
                </div>
            </div>
            <div class="form-field" style=" display:grid ; grid-template-columns: 7% 20% auto">
                <div class="form-field-title">
                    <strong>Team</strong>
                </div>
                <div class="select form-field-input" style="width: 100% !important" >
                    <select v-model="selectedTeam" style="width:100%">
                        <option disabled=disabled value=null> -- Choose new team --</option>
                        <!-- <option :disabled="selectedTeams.length > 0" v- value="null">Not now</option> -->
                        <option v-bind:key='team.Id' v-for='team in teams' :value="team">{{team.Name}}</option>
                    </select>
                </div>
                 <div class="selected-team" style="padding-left:0.5rem">
                        <label class="lb-team" :key='team.Id' v-for="team in selectedTeams" style="margin-right:0.5rem">
                        {{team.Name}} <div class="delete" v-on:click="removeSelectedTeam(team)"></div>
                        </label> 
                    </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                   <strong>Description</strong>
                </div>
                <div class="form-field-input">
                    <!-- <input type="text" class="input" > -->
                    <textarea id="text-descrip" v-model="newLocation.description"  cols="80" rows="10"></textarea>
                </div>
            </div>
            
            
        </div>    
    </div>        
</template>

<script>
import Server from "@/config/config.js";
import { gmapApi } from "vue2-google-maps";
import Simplert from "vue2-simplert";
import Utils from "@/utils.js";

export default {
  components: {
    Simplert
  },
  computed: {
    google: gmapApi
  },
  data() {
    return {
      teams: [],
      selectedTeam: null,
      tempTeams: [],
      allLocations: [],
      selectedTeams: [],
      newLocation: {
        name: "",
        address: "",
        description: "",
        longtitude: "",
        latitude: "",
        idActive: null
      },

      center: { lat: 45.508, lng: -73.587 },
      marker: null,
      place: null,
      currentPlace: null,
      CreateLocationErrors: {
        NoName: "",
        NoAddress: ""
      },
      ErrorStrings: {
        NoName: "Please enter name!",
        ShortName: "Use 6 characters or more for location's name",
        LongName: "Use 100 characters or fewer for location's name",
        NoAddress: "Please enter and choose address",
        DuplicateAddress: "Both name and address already exists.",
        DuplicateName: "Both name and address already exists."
      },
      form: {
        Name: "",
        Address: ""
      },
      duplicate: false
    };
  },
  mounted() {
    this.geolocate();
  },

  created() {
    this.axios
      .get(Server.TEAM_API_PATH + "/getAllTeam")
      .then(response => {
        let data = response.data;
        data.forEach(team => {
          this.teams.push(team);
        });
      })
      .catch(error => {
        console.log(error);
      });
    this.getAllLocations();
  },

  methods: {
    createLocation() {
      this.duplicate = false;
      if (this.newLocation.name.trim() == "") {
        this.CreateLocationErrors.NoName = this.ErrorStrings.NoName;
      } else if (this.newLocation.name.trim().length < 6) {
        this.CreateLocationErrors.NoName = this.ErrorStrings.ShortName;
      } else if (this.newLocation.name.trim().length > 100) {
        this.CreateLocationErrors.NoName = this.ErrorStrings.LongName;
      }
      if (!this.currentPlace) {
        this.CreateLocationErrors.NoAddress = this.ErrorStrings.NoAddress;
      }
      // this.allLocations.forEach(location => {
      //   if (
      //     this.newLocation.name.trim() == location.Name &&
      //     this.currentPlace.geometry.location.lng() == location.Longitude &&
      //     this.currentPlace.geometry.location.lat() == location.Latitude
      //   ) {
      //     alert(this.newLocation.name.trim());
      //     alert(location.Name, location.Longitude, location.Latitude);
      //     this.duplicate = true;
      //   }
      // });
      // if (this.duplicate) {
      //   this.CreateLocationErrors.NoName = this.ErrorStrings.DuplicateName;
      //   this.CreateLocationErrors.NoAddress = this.ErrorStrings.DuplicateAddress;
      // }
      if (this.currentPlace) {
        for (const location of this.allLocations) {
          // alert(
          //   parseFloat(this.currentPlace.geometry.location.lng()).toFixed(6) +
          //     " ? " +
          //     parseFloat(location.Longitude).toFixed(6) +
          //     "\n" +
          //     parseFloat(this.currentPlace.geometry.location.lat()).toFixed(6) +
          //     " ? " +
          //     parseFloat(location.Latitude).toFixed(6)
          // );

          if (
            this.newLocation.name.trim().toUpperCase() == location.Name.toUpperCase() &&
            parseFloat(this.currentPlace.geometry.location.lng()).toFixed(6) ==
              parseFloat(location.Longitude).toFixed(6) &&
            parseFloat(this.currentPlace.geometry.location.lat()).toFixed(6) ==
              parseFloat(location.Latitude).toFixed(6)
          ) {
            this.duplicate = true;
            break;
          }
        }
      }

      if (this.duplicate) {
        this.CreateLocationErrors.NoName = this.ErrorStrings.DuplicateName;
        this.CreateLocationErrors.NoAddress = this.ErrorStrings.DuplicateAddress;
      }
      if (
        this.CreateLocationErrors.NoName == "" &&
        this.CreateLocationErrors.NoAddress == ""
      ) {
        this.axios
          .post(Server.LOCATION_CREATE_API_PATH, {
            newLocation: {
              name: this.newLocation.name.trim(),
              address: this.currentPlace.formatted_address,
              description: this.newLocation.description.trim(),
              longtitude: this.currentPlace.geometry.location.lng(),
              latitude: this.currentPlace.geometry.location.lat(),
              isActive: 1
            }
          })
          .then(async res => {
            // alert(this.selectedTeams.length);
            if (this.selectedTeams.length > 0) {
              if (res.data.NewLocationId) {
                this.selectedTeams.forEach(async team => {
                  await this.axios.post(Server.TEAM_LOCATION_CREATE_API_PATH, {
                    locationId: res.data.NewLocationId,
                    teamId: team.Id
                  });
                });
              }
            }
            let obj = {
              title: "Create Location",
              message: "Successfully!!!",
              type: "success"
            };
            this.$refs.simplert.openSimplert(obj);
            await Utils.sleep(1500);
            this.$router.push("/location");
          })
          .catch(error => {
            console.log(error);
          });
      }
    },
    getAllLocations() {
      let url = "";
      url = "http://localhost:3000/api/location/";
      this.axios
        .get(url)
        .then(response => {
          let data = response.data;
          data.forEach(location => {
            this.allLocations.push(location);
          });
        })
        .catch(error => {
          console.log(error);
        });
    },
    removeSelectedTeam(tmpTeam) {
      this.selectedTeams = this.selectedTeams.filter(
        team => team.Id != tmpTeam.Id
      );
      // this.teams = this.tempTeams;
      this.teams = this.tempTeams.filter(
        team => !this.selectedTeams.includes(team)
      );

      if (this.selectedTeams.length == 0) {
        this.teams = this.tempTeams;
      }
    },
    setPlace(place) {
      this.currentPlace = place;
      // alert(JSON.stringify(this.currentPlace));
    },    
    geolocate() {
      navigator.geolocation.getCurrentPosition(position => {
        this.center = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
      });
    }
  },
  watch: {
    "newLocation.name": function() {
      if (this.newLocation.name.trim() != "") {
        if (this.duplicate) {
          this.CreateLocationErrors.NoName = "";
          this.CreateLocationErrors.NoAddress = "";
        } else {
          this.CreateLocationErrors.NoName = "";
        }
      }
    },
    selectedTeam: function() {
      if (this.selectedTeam) {
        if (this.selectedTeams.length == 0) {
          this.tempTeams = this.teams;
        }
        this.teams = this.teams.filter(team => team.Id != this.selectedTeam.Id);
        this.selectedTeams.push(this.selectedTeam);
        this.selectedTeam = null;
      }
    },
    currentPlace: function() {
      if (this.currentPlace) {
        if (this.duplicate) {
          this.CreateLocationErrors.NoAddress = "";
          this.CreateLocationErrors.NoName = "";
        } else {
          this.CreateLocationErrors.NoAddress = "";
        }
      }
      if (this.currentPlace) {
        const tmpMarker = {
          lat: this.currentPlace.geometry.location.lat(),
          lng: this.currentPlace.geometry.location.lng()
        };
        this.marker = tmpMarker;
        this.place = this.currentPlace;
        this.center = this.marker;
      }
    }
  }
};
</script>

<style scoped>
/* #clear-btn {
  border-left: 0.5px solid lightgray;
  border-radius: 3px;
  position: relative;
  left: 70.05rem;
  bottom: 2.25rem;
  height: 2.4rem;
  padding-top: 0.25rem;

  color: red;
} */

.form {
  background-color: white;
  padding: 0 !important;
  grid-template-columns: 20% 20% 60%;
}
.form-content {
  font-size: 0.9rem;
  position: fixed;
  max-height: 82.5%;
  width: 82%;
  overflow-y: auto;

  /* display: flex;
        flex-direction: column;  */
}

.form-field {
  /* margin-bottom: 5px; */
  width: 100%;
  padding: 1rem 2rem;
}

.form-title {
  display: grid;
  grid-template-columns: 65% 35%;
  border-bottom: 1px solid #e0e0e0;
  padding: 1rem 2rem;
}
.form-title-start {
  position: relative;
  top: 10px;
  font-weight: bold;
  font-size: 20px;
  color: #616161;
}
.form-title-end {
  width: 100%;
  display: flex;
  justify-content: flex-end;
  /* align-content: center; */
}
.form-input {
  padding-left: 50px;
  padding-right: 50px;
}
.form-field {
  margin-bottom: 1.5rem;
}

.form-field-title {
  font-size: 15px;
}
/* .form-button {
  display: grid;
  grid-template-columns: 50% 50%;
  padding-top: 8rem;
} */
/* .form-button div button {
  height: 60px;
  width: 200px;
  border-radius: 5px;
} */
/* #btn-create {
  background-color: var(--primary-color);
  color: white;
  font-size: 22px;
  font-weight: bold;
}
#btn-cancel {
  background-color: chocolate;
  color: white;
  font-size: 22px;
  font-weight: bold;
} */
#text-descrip {
  border: 0.5px solid lightgray;
  border-radius: 5px;
  padding: 0.3rem;
}
#text-descrip:hover {
  border: 1px solid grey;
}
.lb-team {
  border: 0.5px solid;
  border-radius: 5px;
  padding: 3px;
}

.delete {
  position: relative;
  top: 0.2rem;
  font-size: 20px;
}
</style>
