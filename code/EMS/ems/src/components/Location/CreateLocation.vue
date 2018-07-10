<template>
    <div class="form">
        <div class="form-title">                
          <div class="form-title-start">
            Add New Location
          </div>
          <div class="form-title-end">              
                <button id="" class="button is-rounded is-primary" style="margin-right: .6rem" v-on:click="createLocation()">Create New Location</button>
                <button id="" class="button is-rounded"  v-on:click="$router.push('/location')">Cancel</button>
          </div>  
        </div>
        <div class="form-input" >   
            <div class="form-field" style="padding-top:1.5rem">
                <div class="form-field-title">
                    Name of location (required)
                </div>
                <div>
                    <input v-model="newLocation.name" type="text" class="input">
                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                    Address (required)
                </div>
                <div>
                  
                    <div>
                    
                    <label class="ggSearch" style="width: 100%">
                      <gmap-autocomplete  class="input" 
                        @place_changed="setPlace">
                      </gmap-autocomplete>
                      <!-- <button @click="addMarker" class="btn" style="position: relative; bottom: 8px;">Check</button> -->
                    </label>
                    <br/>

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
            <div class="form-field">
                <div class="form-field-title">
                    Description
                </div>
                <div >
                    <!-- <input type="text" class="input" > -->
                    <textarea id="text-descrip" v-model="newLocation.description"  cols="80" rows="10"></textarea>
                </div>
            </div>
            <div class="form-field" style=" display:grid ; grid-template-columns: 10% 20% auto">
                <div class="form-field-title">
                    Choose Team
                </div>
                <div class="select" style="width: 100% !important" >
                    <select v-model="selectedTeam" >
                        <option :disabled="selectedTeams.length > 0" v- value="null">Not now</option>
                        <option v-bind:key='team.Id' v-for='team in teams' :value="team">{{team.Name}}</option>
                    </select>
                </div>
                 <div class="selected-team" style="padding-left:0.5rem">
                        <label class="lb-team" :key='team.Id' v-for="team in selectedTeams" style="margin-right:0.5rem">
                        {{team.Name}} <div class="delete" v-on:click="removeSelectedTeam(team)"></div>
                        </label> 
                    </div>
            </div>
            
        </div>
        <!-- <div class="form-button">
            <div style="text-align: right; padding-right: 2rem">
                <button id="btn-create" class="button" v-on:click="createLocation()" >
                    Create
                </button>
            </div>
            <div>
                <button id="btn-cancel" class="button" >
                    Cancel
                </button>
            </div>
        </div> -->
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
      teams: [],
      selectedTeam: null,
      tempTeams: [],
      selectedTeams: [],
      newLocation: {
        name: "",
        address: "",
        description: "",
        longtitude: "",
        latitude: ""
      },

      center: { lat: 45.508, lng: -73.587 },
      marker: null,
      place: null,
      currentPlace: null
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
  },
  methods: {
    createLocation() {
      this.axios
        .post(Server.LOCATION_CREATE_API_PATH, {
          newLocation: {
            name: this.newLocation.name,
            address: this.currentPlace.formatted_address,
            description: this.newLocation.description,
            longtitude: this.currentPlace.geometry.location.lng(),
            latitude: this.currentPlace.geometry.location.lat()
          }
        })
        .then(res => {
          // alert(this.selectedTeams.length);
          if (this.selectedTeams.length > 0) {
            if (res.data.NewLocationId) {
              this.selectedTeams.forEach(async team => {
                await this.axios.post(Server.TEAM_LOCATION_CREATE_API_PATH, {
                  locationId: res.data.NewLocationId,
                  teamId: team.Id
                });
              });
              this.$router.push('/location');
            }
          }
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
    // addMarker() {
    //   if (this.currentPlace) {
    //     // const marker = {
    //     //   lat: this.currentPlace.geometry.location.lat(),
    //     //   lng: this.currentPlace.geometry.location.lng()
    //     // };
    //     const tmpMarker = {
    //       lat: this.currentPlace.geometry.location.lat(),
    //       lng: this.currentPlace.geometry.location.lng()
    //     };
    //     // this.markers.push({ position: marker });
    //     this.marker = tmpMarker;
    //     // this.places.push(this.currentPlace);
    //     this.place = this.currentPlace;
    //     this.center = this.marker;
    //     // this.currentPlace = null;
    //   }
    // },
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
        const tmpMarker = {
          lat: this.currentPlace.geometry.location.lat(),
          lng: this.currentPlace.geometry.location.lng()
        };
        this.marker = tmpMarker;
        this.place = this.currentPlace;
        this.center = marker;
      }
    }
  }
};
</script>

<style scoped>
.form {
  background-color: white;
  padding: 0 !important;
  grid-template-columns: 20% 20% 60%;
}
.form-title {
  display: grid;
  grid-template-columns: 73% auto;
  border-bottom: 0.02px solid;

  height: 50px;
  line-height: 50px;
  padding-left: 30px;
  top: 10px;
  /* font-weight: bold; */
  font-size: 20px;
  color: #616161;
}
/* .form-title-start {
  position: relative;
  top: 10px;
  font-weight: bold;
  font-size: 20px;
  color: #616161;
} */
.form-title-end {
  /* width: 100%; */
  /* display: flex;
  justify-content: flex-end; */

  /* bottom: 20px; */
  /* align-content: center; */
  position: relative;
  top: 0.5rem;
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
