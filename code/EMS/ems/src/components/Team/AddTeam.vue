<template>
       <div class="form">
         
         <form @submit.prevent="createTeam()">
            <div class="form-title">
                <div class="form-title-start">
                    Add New Team
                </div>
                <div></div>

            </div>
            <div>
                <div class="form-field">
                    <div class="form-field-title">
                    <strong>  Team's name <span style="color:red;">*</span></strong>
                    </div>
                    <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model="team.name" class="input " type="text" placeholder="Text input" >

                            <span class="icon is-small is-left">
                            <i class="fa fa-user"></i>
                            </span>
                            <!-- <span class="icon is-small is-right">
                            <i class="fa fa-check"></i>
                            </span> -->

                        </div>
                    </div>
                
            </div>
            
            <div>
                <div class="form-field">
                    <div class="form-field-title">
                        Create date <strong><span style="color:red;">*</span></strong>
                    </div>
                    <div class="form-field-input">
                        <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model="team.createdDate" class="input" type="date" placeholder="Text input" >
                            <span class="icon is-small is-left">
                            <i class="fa fa-calendar"></i>
                            </span>
                            <!-- <span class="icon is-small is-right">
                            <i class="fa fa-check"></i>
                            </span> -->
                            <!-- {{account.startdate}} -->
                        </div>
                    </div>
                    <!-- <h3>{{account.startdate}}</h3> -->
                </div>
                
            </div>
            <!-- teset -->
            <div class="form-field">
              <div class="form-field-title">
                Member 
              </div>
              <div class="select" style="margin-left:0.5rem; margin-bottom:1rem">
                <select v-model="selectedAccount" style="width:62rem">
                  <option :disabled="selectedAccounts.length > 0"  value="null">No account is selected</option>
                  <option v-bind:key='account.Id' v-for='account in accounts' :value="account">{{account.Fullname}}</option>
                </select>
              </div>
              <div class="selected-account" >
                <label class="lb-account" :key='account.Id' v-for="account in selectedAccounts">
                  {{account.Fullname}} <div class="delete" v-on:click="removeSelectedAccount(account)"></div>
                </label> 
              </div>
            </div>
            <!-- test-end -->

    
    

            
    
    <div class="form-title-end" style="margin-bottom:1rem">
                    <router-link to='/team'>
                        <button id="btn-cancel" class="button" >Cancel</button>
                    </router-link>

                    <!-- <button id="btn-add" class="button" v-on:click="createAccount()">Create Account</button>
                    <button id="btn-add" class="button" v-on:click="createAccountTrueEnd()">Create Account true end</button> -->
                    <!-- <router-link to='/team/'>
                    <button id="btn-add" class="button">Create Team</button>
                    </router-link> -->
                    <button id="btn-add" class="button">Create Team</button>

                    <!-- <button id="btn-add" class="button">Create Account</button> -->
                </div>

         </form>
        
    </div>
</template>

<script>
import Server from "@/config/config.js";
export default {
  data() {
    return {
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
    let url = Server.ACCOUNT_API_PATH;
    this.axios
      .get(url)
      .then(response => {
        let data = response.data;
        data.forEach(element => {
          let account = element.Account;
          this.accounts.push(account);
        });
      })
      .catch(error => {
        alert(error);
      });
  },
  methods: {
    createTeam() {
      this.axios
        .post("http://localhost:3000/api/team", {
          team: this.team
        })
        .then(res => {
          if (this.selectedAccounts.length > 0) {
            if (res.data.NewTeamId) {
              alert(res.data.NewTeamId);
              this.selectedAccounts.forEach(account => {
                this.axios.post(Server.TEAM_ACCOUNT_CREATE_API_PATH, {
                  teamId: res.data.NewTeamId,
                  accountId: account.Id
                });
                alert("Success!");
              });
            }
          }
          this.$router.push("/team");
        });
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
    }
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
  grid-template-columns: 25% 40% 35%;
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
  /* float: left; */
  /* align-content: center; */
  margin-left: 25rem;
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

