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
       
        <div class="form-new">
            <div class="field">
                <div>
                <strong>  New Name(required) </strong>
                </div>
            <div>
                    <input  class="input " type="text"  v-model="location.Name" >   
            </div>
            </div> 
            <div class="field">
                <div>
                <strong>  New Address(required) </strong>
                </div>
                <div>
                    <input  class="input " type="text"  v-model="location.Address" disabled="disabled" >
                    <!-- <label v-if="location.WorkOrderQuantity >0" style="color: red">This location have working Work Oders.So you can't edit address!!! </label> -->
                </div>
            </div>  
            <div class="field">
                <div>
                <strong> New Description </strong>
                </div>
                <div>
                    <textarea v-model="location.Description" cols="100" rows="6" >  </textarea>                              
                </div>
            </div> 
            <div class="field">
                <div>
                <strong> New Team <span style="color:red;">*</span></strong>
                </div>
                <div class="team-place">
                    <div class="select"> 
                        <select v-model="tmpTeam">  
                          <option :value="null">Select a new team</option>                                               
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
      newTeams: []
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
        alert("Please fill out the required fields");
      } else {
        this.axios
          .put(Server.LOCATION_EDIT_API_PATH, {
            newLocation: {
              id: this.location.Id,
              name: this.location.Name,
              address: this.location.Address,
              description: this.location.Description
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
        alert(
          "This team have working Work Order. So you can't delete this team!!!"
        );
      }
    }
  },
  watch: {
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
.form-title {
  display: grid;
  grid-template-columns: 78% auto;
  border-bottom: 0.02px solid;

  height: 50px;
  line-height: 50px;

  top: 10px;
  /* font-weight: bold; */
  font-size: 20px;
  color: #616161;
}

.form-new {
  padding-top: 2rem;
}
.field {
  padding-bottom: 0.5rem;
}
.end {
  padding-top: 3rem;
  text-align: center;
}

#btn-cancel {
  background-color: #bdbdbd;
  color: white;
  margin-right: 0.6rem;
}

#btn-add {
  background-color: var(--primary-color);
  color: white;
}
#btn-add:hover {
  cursor: pointer;
  background-color: #009688;
  color: white;
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
