<template>
    <div class="form">
        <div class="form-title">
                Add New Location    
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
                    <input v-model="newLocation.address" type="text" class="input">
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
            <div class="form-field" style=" display:grid ; grid-template-columns: 10% 10% 80%">
                <div class="form-field-title">
                    Team
                </div>
                <div class="select" >
                    <select>
                        <option>Not now</option>
                        <option v-bind:key='team.Id' v-for='team in teams'>{{team.Name}}</option>
                    </select>
                </div>
            </div>
            
        </div>
        <div class="form-button">
            <div style="text-align: right; padding-right: 2rem">
                <button id="btn-create" class="button" v-on:click="createLocation()" >
                    Create
                </button>
            </div>
            <div>
                <button id="btn-cancel" class="button">
                    Cancel
                </button>
            </div>
        </div>
    </div>        
</template>

<script>
import Server from "@/config/config.js";

export default {
  data() {
    return {
      teams: [],
      selectedTeam: null,
      newLocation: {
          name: '',
          address:'',
          description:'',
          longtitude: 40.244228,
          latitude: 109.998079
      }
    };
  },
  methods: {
    setSelectedTeamLeader(team) {
      this.selectedTeam = team;
    }
  },
  created() {
    this.axios
      .get(Server.TEAM_API_PATH)
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
      createLocation(){
      this.axios.post(Server.LOCATION_CREATE_API_PATH,{
          newLocation: this.newLocation
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
.form-title {
  border-bottom: 0.02px solid;

  height: 50px;
  line-height: 50px;
  padding-left: 30px;
  top: 10px;
  font-weight: bold;
  font-size: 20px;
  color: #616161;
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
.form-button {
  display: grid;
  grid-template-columns: 50% 50%;
  padding-top: 8rem;
}
.form-button div button {
  height: 60px;
  width: 200px;
  border-radius: 5px;
}
#btn-create {
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
}
#text-descrip {
  border: 0.5px solid lightgray;
  border-radius: 5px;
  padding: 0.3rem;
  
}
#text-descrip:hover {
  border: 1px solid grey;
}
</style>
