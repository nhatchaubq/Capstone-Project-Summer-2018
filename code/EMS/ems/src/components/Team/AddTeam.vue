<template>
       <div class="form">
         
         <form @submit.prevent="createTeam()">
            <div class="form-title">
                <div class="form-title-start">
                    Add New Team
                </div>
            <div class="form-title-end">
              <router-link to='/team'>
                    <button id="btn-cancel" class="button" >Cancel</button>
              </router-link>
              <button id="btn-add" class="button">Create Team</button>
            </div>
            </div>
            <div>
                <div class="form-field">
                    <div class="form-field-title">
                    <strong>  Team's name (required) </strong> <span v-if="CreateTeamErrors.TeamNameMax != ''"> <span class="error-text">{{ CreateTeamErrors.TeamNameMax }}</span></span> <span v-else-if="CreateTeamErrors.TeamNameMin != ''"> <span class="error-text">{{ CreateTeamErrors.TeamNameMin }}</span></span> <span v-else-if="CreateTeamErrors.ValidName != ''"> <span class="error-text">{{ CreateTeamErrors.ValidName }}</span></span> <span v-else-if="CreateTeamErrors.DuplicateName != ''"> <span class="error-text">{{ CreateTeamErrors.DuplicateName }}</span></span>
                    </div>
                    <div class="control has-icons-right col-6" style="padding:8px">
                        <input v-model.trim="team.name" class="input " type="text" placeholder="Dream team" >

                            <!-- <span class="icon is-small is-left">
                            <i class="fa fa-user"></i>
                            </span> -->
                            <!-- <span class="icon is-small is-right">
                            <i class="fa fa-check"></i>
                            </span> -->

                        </div>
                    </div>
                
            </div>
            <!-- <div v-bind:key="team.Id" v-for="team in teams" >
              <div>{{team.Name}}</div>
            </div> -->
            
            <!-- <div>
                <div class="form-field">
                    <div class="form-field-title">
                      <strong>Create date (required)</strong><span v-if="CreateTeamErrors.NoCreateDate != ''">. <span class="error-text">{{ CreateTeamErrors.NoCreateDate }}</span></span>  
                    </div>
                    <div class="form-field-input">
                        <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model="team.createdDate" class="input" type="date" placeholder="Text input" >
                            <span class="icon is-small is-left">
                            <i class="fa fa-calendar"></i>
                            </span>

                        </div>
                    </div>

                </div>
                
            </div> -->
            <!-- teset -->
            <div class="form-field">
              <div class="form-field-title">
                <strong>Member</strong>
                 
              </div>
              <div class="select" style="margin-left:0.5rem; margin-bottom:1rem">
                <select v-model="selectedAccount" style="width: 35rem">
                  <option :disabled="selectedAccounts.length > 0"  value="null"></option>
                  <option v-bind:key='account.Id' v-for='account in accounts' :value="account">{{account.Username}}</option>
                </select>
              </div>
              <div class="selected-account" >
                <label class="lb-account" :key='account.Id' v-for="account in selectedAccounts">
                  {{account.Username}} <div class="delete" v-on:click="removeSelectedAccount(account)"></div>
                </label> 
              </div>
            </div>
            <!-- test-end -->

    
    

            
    
    <!-- <div class="form-title-end" style="margin-bottom:1rem">
                    <router-link to='/team'>
                        <button id="btn-cancel" class="button" >Cancel</button>
                    </router-link>


                    <button id="btn-add" class="button">Create Team</button>

                </div> -->

         </form>
        
    </div>
</template>

<script>
import Server from "@/config/config.js";
export default {
  data() {
    return {
      NameRegex: /^[^~`!#$%@()\^&*+=\-\[\]\\';,/{}|\\":<>\?]*?$/,
      sending: false,
      ErrorStrings: {
        // NoTeamName: "You must provide name for this team",
        TeamNameMax: "Use from 6 to 50 characters for your team name.",
        TeamNameMin: "Use from 6 to 50 characters for your team name.",
        ValidName: " Team's name cannot contain special character. ",
        DuplicateName: " This team's name already belongs to another team. "
        // NoCreateDate: "You must provide create date for this team"
      },
      CreateTeamErrors: {
        // NoTeamName: "",
        TeamNameMax: "",
        TeamNameMin: "",
        ValidName: "",
        DuplicateName: ""
        // NoCreateDate: ""
      },
      team: {
        name: "",
        createdDate: ""
      },
      accounts: [],
      selectedAccount: null,
      tempAccounts: [],
      selectedAccounts: []
    };
  },
  created() {
    let url1 = Server.TEAM_API_PATH;
    this.axios.get(url1).then(response => {
      this.teams = [];
      response.data.forEach(value => this.teams.push(value.Team));
    });
    let url = "http://localhost:3000/api/allaccwithout";
    this.axios
      .get(url)
      .then(response => {
        let data = response.data;
        data.forEach(element => {
          let account = element;
          // let account = element.Account;
          this.accounts.push(account);
        });
      })
      .catch(error => {
        alert(error);
      });
  },
  methods: {
    createTeam() {
      // if (this.team.name === "") {
      //   this.CreateTeamErrors.NoTeamName = this.ErrorStrings.NoTeamName;
      // }
      if (this.team.name.length > 50) {
        this.CreateTeamErrors.TeamNameMax = this.ErrorStrings.TeamNameMax;
      }
      if (this.team.name.length < 6) {
        this.CreateTeamErrors.TeamNameMin = this.ErrorStrings.TeamNameMin;
      }
      if (!this.NameRegex.test(this.team.name)) {
        this.CreateTeamErrors.ValidName = this.ErrorStrings.ValidName;
      } else {
        this.CreateTeamErrors.ValidName = "";
      }
      for (const team of this.teams) {
        if (team.Name == this.team.name) {
          this.CreateTeamErrors.DuplicateName = this.ErrorStrings.DuplicateName;
          break;
        }
      }
      // if (this.team.createdDate === "") {
      //   this.CreateTeamErrors.NoCreateDate = this.ErrorStrings.NoCreateDate;
      // }
      if (this.validateTeam())
        this.axios
          .post("http://localhost:3000/api/team", {
            team: this.team
          })
          .then(res => {
            if (this.selectedAccounts.length > 0) {
              if (res.data.NewTeamId) {
                // alert(res.data.NewTeamId);
                this.selectedAccounts.forEach(account => {
                  this.axios.post(Server.TEAM_ACCOUNT_CREATE_API_PATH, {
                    teamId: res.data.NewTeamId,
                    accountId: account.Id
                  });
                  // alert("Success!");
                });
              }
            }
            this.$router.push("/team");
          });
    },
    validateTeam() {
      return (
        // this.CreateTeamErrors.NoTeamName === "" &&
        this.CreateTeamErrors.TeamNameMax === "" &&
        this.CreateTeamErrors.TeamNameMin === "" &&
        this.CreateTeamErrors.ValidName == "" &&
        this.CreateTeamErrors.DuplicateName == ""
        // this.CreateTeamErrors.NoCreateDate === ""
      );
    },
    removeSelectedAccount(tmpAccount) {
      this.selectedAccounts = this.selectedAccounts.filter(
        account => account.Id != tmpAccount.Id
      );
      // this.teams = this.tempTeams;
      this.accounts = this.tempAccounts.filter(
        account => !this.selectedAccounts.includes(account)
      );

      if (this.selectedAccounts.length == 0) {
        this.accounts = this.tempAccounts;
      }
    }
  },
  watch: {
    selectedAccount: function() {
      if (this.selectedAccount) {
        if (this.selectedAccounts.length == 0) {
          this.tempAccounts = this.accounts;
        }
        this.accounts = this.accounts.filter(
          account => account.Id != this.selectedAccount.Id
        );
        this.selectedAccounts.push(this.selectedAccount);
        this.selectedAccount = null;
      }
    },
    "team.name": function() {
      // if (this.team.name != "") {
      //   this.CreateTeamErrors.NoTeamName = "";
      // }
      if (this.team.name.length > 5) {
        this.CreateTeamErrors.TeamNameMin = "";
      }
      if (this.team.name.length < 51) {
        this.CreateTeamErrors.TeamNameMax = "";
      }
      if (this.NameRegex.test(this.team.name)) {
        this.CreateTeamErrors.ValidName = "";
      }
      let isDupName = false;
      for (const team in this.teams) {
        if (team.Name == this.team.name) {
          isDupName = true;
          break;
        }
      }
      if (!isDupName) {
        this.CreateTeamErrors.DuplicateName = "";
      }
    }
    // "team.createdDate": function() {
    //   if (this.team.createdDate != "") {
    //     this.CreateTeamErrors.NoCreateDate = "";
    //   }
    // }
  }
};
</script>

<style scoped>
.form {
  background-color: white;
  padding: 0 !important;
}
.form-title {
  display: grid;
  grid-template-columns: 65% 35%;
  border-bottom: 1px solid #e0e0e0;
  padding: 0.5rem 2rem;
}

.form-title-start {
  /* position: relative; */
  padding-top: 0.3rem;
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

#btn-cancel {
  background-color: White;
  color: black;
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

.form-field {
  /* margin-bottom: 5px; */
  padding: 1rem 3rem;
}

.form-field-title {
  font-size: 13px;
}

#btn-change-pass {
  background-color: var(--primary-color);
  padding: 13px;
  color: white;
  border-radius: 5px;
  z-index: 1;
}

#btn-change-pass:hover {
  cursor: pointer;
  background-color: #009688;
  color: white;
}
</style>

