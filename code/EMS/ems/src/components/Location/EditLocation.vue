<template>

    <div v-if="location" class="form">
        <div class="form-title">          
            <div class="form-title-start">
               Edit Location 
            </div>
            <div class="form-title-end">              
              <button  class="button" style="margin-right: .6rem" v-on:click="$router.push('/location')">Cancel</button>
              <simplert :useRadius="true" :useIcon="true" ref="simplert"></simplert>
              <button  class="button is-primary"  v-on:click="updateLocation()">Save Changes</button>              
            </div>
        </div>       
        <div class="form-content">
            <div class="form-field">
                <div class="form-field-title">
                  <strong>Location ame (required)</strong>
                  <span class="error-text" v-if="NoName != ''"> {{ NoName }}</span>
                </div>
                <div class="form-field-input">
                  <input class="input" style="width: 40%;" type="text" v-model.trim="location.Name" >   
                </div>
            </div> 
            <div class="form-field">
                <div class="form-field-title">
                  <strong>Location address</strong>
                </div>
                <div class="form-field-input">
                    <input class="input" style="width: 50%;" type="text" v-model="location.Address" disabled="disabled" >
                    <!-- <label v-if="location.WorkOrderQuantity >0" style="color: red">This location have working Work Oders.So you can't edit address!!! </label> -->
                </div>
            </div>  
            <div class="form-field" >
              <div>
                <div class="form-field-title">
                  <strong>Status</strong>
                  <span v-if="location.Items || selectedTeams.length" class="error-text"> (There are the equipment in this location. Can't change the activity status)</span>
                </div>
                <div class="form-field-input" style="margin-top:10px;">
                  <label class="radio" v-on:click="location.IsActive = true" style="margin-right:0.5rem">
                    <input type="radio" name="status" style="margin-right:0.5rem"  :checked="location.IsActive || selectedTeams.length" > Active
                  </label>
                  <label class="radio" v-on:click="() => {                    
                      if (!location.Items && selectedTeams.length==0) {
                        location.IsActive = false
                      }
                    }">
                    <input type="radio" name="status" :disabled="location.Items" :checked="!location.IsActive && !selectedTeams.length" :disabled="location.Items || selectedTeams.length > 0">Inactive
                  </label>                                                  
                </div>
              </div>
            </div>             
            <div class="form-field">
              <div>

              </div>
                <div class="form-field-title">
                  <strong>Team</strong>
                  <span class="select" style="margin-left: .5rem; position: relative; top: -.3rem"> 
                    <select v-model="tmpTeam">  
                      <option disabled=disabled :value="null">-- Choose new team --</option>                                               
                      <option v-bind:key='team.Id' v-for='team in unselectedTeams' :value="team">{{team.Name}}</option>
                    </select>
                  </span>
                </div>
                <div class="selected-team" v-if="selectedTeams != null" style="padding-top:0.5rem">
                    <label :key='team.Id' v-for="team in selectedTeams" style="margin: 0! important; margin-right :0.5rem" class="lb-team">
                      {{team.Name}} <span style="font-size: 1rem; margin-left: .5rem;" class="delete" v-on:click="removeTeam(team)"></span>
                    </label>
                    <!-- <label v-if="tmpTeam != null">{{tmpTeam.Name}}</label> -->
                </div>             
            </div><div class="form-field" >
              <div>
                <div class="form-field-title">
                  <strong>Description</strong>
                </div>
                <div class="form-field-input">
                  <textarea class="input" v-model.trim="location.Description" cols="80" rows="7" style="min-height: 4rem; max-height: 7rem; width: 50%;" >  </textarea>                              
                </div>
              </div>
            </div>
        </div>
        <!-- <div class="end">
            <button id="btn-add" class="button" v-on:click="updateLocation()">Save Changes</button>           
            <button id="btn-cancel" class="button" v-on:click="$router.push('/location')">Cancel</button>
        </div> -->

    </div>

</template>

<script>
import Vue from "vue";
import Server from "@/config/config.js";
import Simplert from "vue2-simplert";
import Utils from "@/utils.js";
export default {
  components: {
    Simplert
  },
  data() {
    return {
      location: null,
      tmpTeam: null,
      unselectedTeams: [],
      selectedTeams: [],
      teams: [],
      woTeams: [],
      newTeams: [],
      NoName: "",
      sameAddressLocations: [],
      duplicate: false
    };
  },
  async created() {
    await this.getAllTeam();
    let url = `${Server.LOCATION_UPDATE_API_PATH}/${this.$route.params.id}`;
    await this.axios
      .get(url)
      .then(async response => {
        let data = response.data[0];
        this.location = data;
        this.woTeams = this.location.TeamWithWorkOrdering;
        this.unselectedTeams = this.teams;
        if (this.location.Team) {
          this.selectedTeams = this.location.Team;
          for (const team of this.selectedTeams) {
            this.unselectedTeams = this.unselectedTeams.filter(
              unteam => unteam.Id != team.Id
            );
          }
        }
      })
      .catch(error => {
        console.log(error);
      });
    await this.getSameAddressLocations();

    // alert(this.sameAddressLocations.length);
    // this.unselectedTeams = this.unselectedTeams.filter(
    //   team => !this.location.Team.includes(team)
    // );
  },
  methods: {
    async getSameAddressLocations() {
      let url = "";
      url = "http://localhost:3000/api/location/";
      await this.axios
        .get(url)
        .then(async response => {
          let data = response.data;
          for (const tmpLocation of data) {
            // alert(
            //   parseFloat(tmpLocation.Longitude).toFixed(6) +
            //     " " +
            //     parseFloat(this.location.Longitude).toFixed(6) +
            //     "\n" +
            //     parseFloat(tmpLocation.Latitude).toFixed(6) +
            //   " " +
            //   parseFloat(this.location.Latitude).toFixed(6)
            // );
            if (
              parseFloat(tmpLocation.Longitude).toFixed(6) ==
                parseFloat(this.location.Longitude).toFixed(6) &&
              parseFloat(tmpLocation.Latitude).toFixed(6) ==
                parseFloat(this.location.Latitude).toFixed(6) &&
              tmpLocation.Id != this.location.Id
            ) {
              // alert("add zo");
              this.sameAddressLocations.push(tmpLocation);
            }
          }
        })
        .catch(error => {
          console.log(error);
        });
    },
    async getAllTeam() {
      return await this.axios
        .get(Server.TEAM_API_PATH + "/getAllTeam")
        .then(async response => {
          let data = response.data;
          data.forEach(selectTeam => {
            this.teams.push(selectTeam);
          });
        })
        .catch(error => {
          console.log(error);
        });
    },
    async updateLocation() {
      for (const tmpLocation of this.sameAddressLocations) {
        if (
          this.location.Name.trim().toUpperCase() ==
            tmpLocation.Name.toUpperCase() &&
          tmpLocation.Id != this.location.Id
        ) {
          this.duplicate = true;
          break;
        }
      }

      if (this.location.Name.trim() == "") {
        this.NoName = "Please enter new name!";
      } else if (this.duplicate) {
        this.NoName = "Both name and address already exists.";
        this.duplicate = false;
      } else if (this.location.Name.trim().length < 6) {
        this.NoName = "Use 6 characters or more for location's name";
      } else if (this.location.Name.trim().length > 100) {
        this.NoName = "Use 100 characters or fewer for location's name";
      } else {
        this.axios
          .put(Server.LOCATION_EDIT_API_PATH, {
            newLocation: {
              id: this.location.Id,
              name: this.location.Name.trim(),
              address: this.location.Address,
              description: this.location.Description.trim(),
              isActive: this.location.IsActive
            }
          })
          .then(res => {
            if (this.selectedTeams.length >= 0) {
              this.axios
                .delete(
                  Server.LOCATION_DELETE_TEAM_WITHOUT_WORDODER +
                    "/" +
                    this.location.Id
                )
                .then(async res => {
                  if (
                    this.location.TeamWithWorkOrdering != null &&
                    this.location.TeamWithWorkOrdering.length > 0
                  ) {
                    this.newTeams = this.selectedTeams;
                    this.location.TeamWithWorkOrdering.forEach(team => {
                      this.newTeams = this.newTeams.filter(
                        newTeam => newTeam.Id != team.TeamID
                      );
                    });
                    this.newTeams.forEach(team => {
                      this.axios.post(Server.TEAM_LOCATION_CREATE_API_PATH, {
                        locationId: this.location.Id,
                        teamId: team.Id
                      });
                    });
                  } else {
                    this.newTeams = this.selectedTeams;
                    this.newTeams.forEach(team => {
                      this.axios.post(Server.TEAM_LOCATION_CREATE_API_PATH, {
                        locationId: this.location.Id,
                        teamId: team.Id
                      });
                    });
                  }
                  let obj = {
                    title: "Update Location",
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
          })
          .catch(error => {
            console.log(error);
          });
      }
    },
    removeTeam(tmpTeam) {
      var check = true;
      if (this.woTeams && this.woTeams.length > 0) {
        this.woTeams.forEach(team => {
          if (tmpTeam.Id == team.TeamID) {
            check = false;
          }
        });
      }

      // for (var i = 0; i < this.woTeams.length; i++) {
      //   if (this.woTeams[i].Id == tmpTeam.Id) {
      //     check = false;
      //     break;
      //   }
      // }

      if (check) {
        this.selectedTeams = this.selectedTeams.filter(
          team => team.Id != tmpTeam.Id
        );

        this.unselectedTeams = this.teams;
        this.selectedTeams.forEach(selectedTeam => {
          this.unselectedTeams = this.unselectedTeams.filter(
            team => team.Id != selectedTeam.Id
          );
        });

        // this.unselectedTeams = this.teams.filter(
        //   team => (!this.selectedTeams.includes(team))
        // );
      } else {
        let obj = {
          title: "Unable To Remove",
          message: "This team has working order(s).",
          type: "warning"
        };
        this.$refs.simplert.openSimplert(obj);
      }
    }
  },
  watch: {
    "location.Name": function() {
      if (this.location.Name.trim() != "") {
        this.NoName = "";
      }
    },
    tmpTeam: function() {
      Vue.nextTick(() => {
        if (this.tmpTeam) {
          this.unselectedTeams = this.unselectedTeams.filter(
            team => team.Id != this.tmpTeam.Id
          );
          this.selectedTeams.push(this.tmpTeam);
          this.location.IsActive = true;
          this.tmpTeam = null;
        }
      });
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
  padding: .5rem 2rem;
}
.form-title-start {
  padding-top: .2rem;
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

.form-field-title {
  font-size: 15px;
}

.lb-team {
  border: 1px solid #616161;
  border-radius: 5px;
  padding: .3rem;
}
.delete {
  /* position: relative;
  top: 0.2rem; */
  font-size: 20px;
}
</style>
