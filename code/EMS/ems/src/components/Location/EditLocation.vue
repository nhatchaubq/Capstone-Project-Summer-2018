<template>

    <div v-if="location">
        <div class="title">          
            Edit Location 
        </div>
        <div class="form-old">


        </div>
        <div class="form-new">
            <div class="field">
                <div>
                <strong>  New Name <span style="color:red;">*</span></strong>
                </div>
            <div>
                    <input  class="input " type="text"  :value="location.Name" >                              
            </div>
            </div> 
            <div class="field">
                <div>
                <strong>  New Address <span style="color:red;">*</span></strong>
                </div>
                <div>
                    <input  class="input " type="text"  :value="location.Address">                                
                </div>
            </div>  
            <div class="field">
                <div>
                <strong> New Description <span style="color:red;">*</span></strong>
                </div>
                <div>
                    <textarea :value="location.Description" cols="100" rows="10" >  </textarea>                              
                </div>
            </div> 
            <div class="field">
                <div>
                <strong> New Team <span style="color:red;">*</span></strong>
                </div>
                <div class="team-place">
                    <div class="select"> 
                        <select>                            
                            <option v-bind:key='tmpTeam.Id' v-for='tmpTeam in unselectedTeams'>{{tmpTeam.Name}}</option>
                        </select>
                    </div>
                    <div class="selected-team" v-if="location.Team != null" >
                        <label class="lb-team"   :key='team.Id' v-for="team in location.Team">
                        {{team.Name}} <div class="delete" style=""></div>
                        </label> 
                    </div>
                    
                </div>
                
            </div>
        </div>
        <div class="end">
            <button id="btn-add" class="button">Create Account</button>
            <router-link to='/location'>
                        <button id="btn-cancel" class="button" >Cancel</button>
            </router-link>
        </div>

    </div>
</template>

<script>
import Server from "@/config/config.js";
export default {
  data() {
    return {
      location: null,
      unselectedTeams: []
    };
  },
  created() {
    let url = `${Server.LOCATION_UPDATE_API_PATH}/${this.$route.params.id}`;
    this.axios
      .get(url)
      .then(response => {
        let data = response.data[0];
        this.location = data;
      })
      .catch(error => {
        console.log(error);
      });
    this.getSelectTeam();
  },
  methods: {
    getSelectTeam() {
      this.axios
        .get(Server.TEAM_API_PATH + "/getAllTeam")
        .then(response => {
          let data = response.data;
          data.forEach(selectTeam => {
            this.unselectedTeams.push(selectTeam);
          });
        })
        .catch(error => {
          console.log(error);
        });
    }
  }
};
</script>

<style scoped>
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
.team-place {
  display: grid;
  grid-template-columns: auto auto;
}
</style>
