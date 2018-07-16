<template>

    <div v-if="location" class="form">
        <div class="form-title">          
            <div class="form-title-start">
               Edit Location 
            </div>
            <div class="form-title-end">              
              <button  class="button" style="margin-right: .6rem"  v-on:click="$router.push('/location')">Cancel</button>
              <button  class="button is-primary"  v-on:click="updateLocation()">Save Changes</button>              
            </div>
        </div>
       
        <div class="form-content">
            <div class="form-field">
                <div class="form-field-title">
                <strong>  New Name<span style="color:red;">*</span> </strong>  <span v-if="NoName != ''"><span class="error-text">  {{ NoName }}</span></span>
                </div>
                <div class="form-field-input">
                        <input  class="input " type="text"  v-model="location.Name" >   
                </div>
            </div> 
            <div class="form-field">
                <div class="form-field-title">
                <strong>  New Address<span style="color:red;">*</span> </strong>
                </div>
                <div class="form-field-input">
                    <input  class="input " type="text"  v-model="location.Address" disabled="disabled" >
                    <!-- <label v-if="location.WorkOrderQuantity >0" style="color: red">This location have working Work Oders.So you can't edit address!!! </label> -->
                </div>
            </div>  
            <div class="form-field" style="display:grid; grid-template-columns: 25% auto">
              <div>
                <div class="form-field-title">
                <strong> Status </strong>
                </div>
                <div class="form-field-input" style="padding-left:30px;padding-top:10px;">
                  <label class="radio" v-on:click="location.IsActive = true" style="margin-right:25px;">
                    <input type="radio" name="status"  :checked="location.IsActive"> Active
                  </label>
                  <label class="radio" v-on:click="() => {
                      if (!location.Items) {
                        location.IsActive = false
                      }
                    }">
                    <input type="radio" name="status" :disabled="location.Items" :checked="!location.IsActive"> Inactive
                  </label>                                                  
                </div>
              </div>
              <div v-if="location.Items" style="color:red;font-size:20px">
                <br>
                NOTE: <label style="font-size:18px; color: black"> There are the equipments in this location. Can't change the activity status!!!</label>
              </div>
                
                
              </div>
            <div class="form-field" >
              <div>
                <div class="form-field-title">
                <strong> New Description </strong>
                </div>
                <div class="form-field-input">
                    <textarea v-model="location.Description" cols="80" rows="7" >  </textarea>                              
                </div>
              </div>
              
                
            </div> 
            <div class="form-field">
                <div class="form-field-title">
                <strong> New Team </strong>
                </div>
                <div class="team-place">
                    <div class="select"> 
                        <select v-model="tmpTeam">  
                          <option disabled=disabled :value="null">-- Choose new team --</option>                                               
                            <option v-bind:key='team.Id' v-for='team in unselectedTeams' :value="team">{{team.Name}}</option>
                        </select>
                    </div>
                    <div class="selected-team" v-if="selectedTeams != null" style="padding-top:0.5rem">
                        <label class="lb-team"   :key='team.Id' v-for="team in selectedTeams" style="margin-right :0.5rem">
                        {{team.Name}} <div class="delete" v-on:click="removeTeam(team)"></div>
                        </label> 
                        <!-- <label v-if="tmpTeam != null">{{tmpTeam.Name}}</label> -->
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
export default {
  data() {
    return {
      location: null,
      tmpTeam: null,
      unselectedTeams: [],
      selectedTeams: [],
      teams: [],
      woTeams: [],
      newTeams: [],
      NoName: ""
    };
  },
  created() {
    let url = `${Server.LOCATION_UPDATE_API_PATH}/${this.$route.params.id}`;
    this.axios
      .get(url)
      .then(response => {
        let data = response.data[0];
        this.location = data;
        this.woTeams = this.location.TeamWithWorkOrdering;
        this.unselectedTeams = this.teams;
        if (this.location.Team) {
          this.selectedTeams = this.location.Team;

          this.selectedTeams.forEach(team => {
            this.unselectedTeams = this.unselectedTeams.filter(
              unteam => unteam.Id != team.Id
            );
          });
        }
      })
      .catch(error => {
        console.log(error);
      });
    this.getAllTeam();

    // this.unselectedTeams = this.unselectedTeams.filter(
    //   team => !this.location.Team.includes(team)
    // );
  },
  methods: {
    getAllTeam() {
      this.axios
        .get(Server.TEAM_API_PATH + "/getAllTeam")
        .then(response => {
          let data = response.data;
          data.forEach(selectTeam => {
            this.teams.push(selectTeam);
          });
        })
        .catch(error => {
          console.log(error);
        });
    },
    updateLocation() {
      if (this.location.Name.trim() == "") {
        this.NoName = "Please enter new name!";
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
                .then(res => {
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
                  alert("Successfully!!!");
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
        alert("This team have working Order. So you can't delete this team!!!");
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
textarea {
  border: 0.5px solid lightgray;
  border-radius: 5px;
  padding: 0.3rem;
  background-color: white;
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
