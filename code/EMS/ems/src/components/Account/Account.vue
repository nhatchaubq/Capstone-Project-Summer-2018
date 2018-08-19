<template>
   <div>
    <!-- <div v-if="authUser.Role == 'Admin' || authUser.Role == 'Manager' " >
        <div class="filter" style="width: 100%; display: grid; grid-template-columns: 5% auto">
          <div style="font-weight: bold">
              Filter:
          </div>
          <div>
              <div style="width: 100%; height:1.5rem;display: grid; grid-template-columns:4rem 6rem auto;">
                <div>Status: </div> 
                  <div style="user-select: none; display: grid; grid-template-columns: 3.5rem auto;">
                      <div>Active:</div>
                      <div style="padding-top:0.1rem">
                        <input type="checkbox" v-model="activeChecked">                            
                      </div>                        
                  </div>
                  <div style="user-select: none; display: grid; grid-template-columns: 4.5rem auto;">
                      <div>In Active:</div>
                      <div style="padding-top:0.1rem">
                        <input type="checkbox"  v-model="inActiveChecked">
                      </div>
                  </div>
              </div>
          </div>
      </div>
    </div> -->
    
    <div >
      <div class="field is-grouped view-mode" style="margin-bottom: 0.2rem !important; padding: 0rem!important">
        <!-- <button class="btn-view-mode-left" :class='{"is-active": isTableMode}' v-on:click="setTableMode(true)">Table view</button>
        <button class="btn-view-mode-right" :class='{"is-active": !isTableMode}' v-on:click="setTableMode(false)">Card view</button> -->
        <router-link to='/account/'>  
          <button v-if="authUser.Role !='Admin'" class="btn-view-mode-left" style="margin-right:0rem" disabled="disabled">Account view</button>
        </router-link>
        <!-- <router-link to='/account/'>  
          <button v-if="authUser.Role !='Manager'" class="btn-view-mode" style="margin-right:0rem" disabled="disabled">Account view</button>
        </router-link> -->
        <router-link to='/team/'>  
          <button  class="btn-view-mode-right" v-if="authUser.Role =='Manager'" >Team view</button>
        </router-link>
      </div>
    </div>

        <div v-if="!accounts">
      There is no account yet.
    </div>
    <div v-else>

      <!-- <account-table :accounts="accounts" v-if="isTableMode"></account-table>
      <account-card :accounts="accounts" v-else></account-card> -->
    <table class="mytable" style="margin-bottom:0.5rem !important">
      <thead>
        <tr style="height:28px !important">
          <!-- <th><strong>ID</strong></th> -->
  
          <th style="width:3% !important"><strong >#</strong></th>
          <th style="width:15% !important"><strong>User name</strong></th>
  
          <th style="width:25% !important"><strong>Full name </strong></th>
  
          <th style="width:20% !important"><strong>Email </strong></th>
  
          <th style="width:15% !important"><strong>Phone</strong></th>
  
          <th style="width:15% !important"><strong>Role</strong></th>
  
          <th style="width:7% !important"><strong>Status</strong></th>
        </tr>
      </thead>  
      <tbody>
          <tr  :key="account.Id" v-for="(account, index) in toDisplayData"  style="height:28px !important" v-on:click="gotoDetail(account.Id)"  >
          <td>{{ 10*(currentPage -1) + (index + 1) }}</td>   
          <td>{{account.Username | truncate(13)}}</td>
          <td>{{account.Fullname ? account.Fullname: "N/A" }}</td>
          <td>{{account.Email ? account.Email : "N/A" }}</td>
          <td>{{account.Phone ? account.Phone : "N/A"}}</td>
          <td>{{account.Role.Name}}</td>
          <strong>
            <td :style="{color: account.IsActive? 'var(--primary-color)' : '#607D8B'}">{{account.IsActive? "Active" : "Inactive"}}</td>
          </strong> 
          </tr>
      </tbody>  
    </table>

  <div v-if="totalAccount > 9" >
    <Page :current="currentPage" :total="totalAccount" show-elevator 
      @on-change="(newPageNumber) => {
        currentPage = newPageNumber
        let start = 10 * (newPageNumber - 1);
        let end = start + 10;
        
        toDisplayData = accounts.slice(start, end);
      }">
    </Page>
  </div>  

    </div>

    <router-link to='/account/add/'>
      <button id="btn-add-account" class="button btn-primary material-shadow-animate" v-if="authUser.Role =='Admin'">Add Account</button>
    </router-link>

    </div>
</template>

<script>
// import data from "@/models/accounts.js";
import Server from "@/config/config.js";
import { sync } from "vuex-pathify";
import AccountCard from "./AccountCard";
import AccountTable from "./AccountTable";
import moment from "moment";

export default {
  components: {
    AccountCard,
    AccountTable,
    moment
  },
  computed: {
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    },
    isTableMode: sync("accountPage.isTableMode"),
    searchValues: sync("accountPage.searchValues")
  },
  created() {
    // let url = Server.ACCOUNT_API_PATH;
    // this.axios
    //   .get(url)
    //   .then(response => {
    //     let data = response.data;
    //     data.forEach(element => {
    //       let account = element.Account;
    //       this.accounts.push(account);
    //       this.toDisplayData = this.accounts.slice(0, 10);
    //     });
    //   })
    //   .catch(error => {
    //     alert(error);
    //   });
    this.getAccountDetail();
  },
  // computed: {
  //   isTableMode: sync("accountPage.isTableMode")
  // },
  data() {
    return {
      currentPage: 1,
      totalAccount: 0,
      toDisplayData: [],
      accounts: [],
      selectedAccount: null,
      currentViewMode: true,
      viewModes: {},
      inActiveChecked: false,
      activeChecked: true
    };
  },
  methods: {
    setSelectedAccount(account) {
      this.selectedAccount = account;
    },
    setTableMode(value) {
      this.$store.state.accountPage.isTableMode = value;
    },
    getDate(date) {
      return moment(date).format("L");
    },
    gotoDetail(accountId) {
      this.$router.push(`/account/${accountId}`);
    },
    getAccountDetail() {
      let url = Server.ACCOUNT_API_PATH;
      this.axios.get(url).then(response => {
        this.accounts = [];
        response.data.forEach(value => this.accounts.push(value.Account));
        this.totalAccount = this.accounts.length;
        this.toDisplayData = this.accounts.slice(0, 10);
      });
    },
    getAllAccountStatusTrueFalse() {
      let URL = Server.ACCOUNT_API_PATH;
      this.axios
        .get(URL)
        .then(response => {
          let data = response.data;
          // alert('in');
          data.forEach(value => {
            this.accounts.push(value.Account);
            if (this.$store.state.accountPage.searchText != "") {
              let tempAccounts = [];
              if (this.searchValues.length > 0) {
                for (const account of this.searchValues) {
                  tempAccounts = tempAccounts.concat(
                    this.accounts.filter(a => a.Id == account.Id)
                  );
                }
              }
              this.accounts = tempAccounts;
              this.searchMode = true;
            } else {
              // this.$store.state.workOrderPage.searchValues = [];
              this.searchMode = false;
            }
            this.toDisplayData = this.accounts.slice(0, 10);
          });
        })
        .catch(error => {
          console.log(error);
        });
    },
    getAccountInActive() {
      let URL = Server.ACCOUNT_API_PATH;
      this.axios
        .get(URL)
        .then(response => {
          let data = response.data;
          // alert('in');
          data.forEach(value => {
            let account = value.Account;
            if (account.Status == false) {
              this.accounts.push(account);
            }
            if (this.$store.state.accountPage.searchText != "") {
              let tempAccounts = [];
              if (this.searchValues.length > 0) {
                for (const account of this.searchValues) {
                  tempAccounts = tempAccounts.concat(
                    this.accounts.filter(e => e.Id == account.Id)
                  );
                }
              }
              this.accounts = tempAccounts;
              this.searchMode = true;
            } else {
              // this.$store.state.workOrderPage.searchValues = [];
              this.searchMode = false;
            }
            this.toDisplayData = this.accounts.slice(0, 10);
          });
        })
        .catch(error => {
          console.log(error);
        });
    }
  },
  watch: {
    activeChecked: function() {
      this.accounts = [];
      this.toDisplayData = [];
      if (this.activeChecked) {
        if (this.inActiveChecked) {
          this.getAllAccountStatusTrueFalse();
          this.currentPage = 1;
        } else {
          this.getAccountDetail();
          this.currentPage = 1;
        }
      } else {
        if (this.inActiveChecked) {
          this.getAccountInActive();
          this.currentPage = 1;
        } else {
          this.accounts = [];
          this.toDisplayData = [];
        }
      }
    },
    inActiveChecked: function() {
      this.accounts = [];
      this.toDisplayData = [];
      if (this.inActiveChecked) {
        if (this.activeChecked) {
          this.getAllAccountStatusTrueFalse();
          this.currentPage = 1;
        } else {
          this.getAccountInActive();
          this.currentPage = 1;
        }
      } else {
        if (this.activeChecked) {
          this.getAccountDetail();
          this.currentPage = 1;
        } else {
          this.accounts = [];
          this.toDisplayData = [];
        }
      }
    },
    searchValues: function() {
      if (this.searchValues && this.searchValues.length > 0) {
        let tmpAccounts = [];
        for (const account of this.searchValues) {
          tmpAccounts = tmpAccounts.concat(
            this.accounts.filter(a => a.Id == account.Id)
          );
        }
        this.toDisplayData = tmpAccounts.slice(0, 10);
        this.totalAccount = this.toDisplayData.length;
        this.currentPage = 1;
        if (this.toDisplayData == "") {
          this.getAccountDetail();
          for (const account of this.searchValues) {
            tmpAccounts = tmpAccounts.concat(
              this.accounts.filter(a => a.Id == account.Id)
            );
          }
        }
      } else {
        this.accounts = [];
        this.toDisplayData = [];
        this.totalAccount = 0;
      }
    },
    "$store.state.accountPage.searchText": function() {
      if (this.$store.state.accountPage.searchText == "") {
        this.getAccountDetail();
      }
    }
  }
};
</script>

<style scoped>
.view-mode {
  margin-bottom: 2rem;
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
  background-color: #26a69a;
  color: white;
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
  border: 1px solid #26a69a;
  z-index: 1;
  /* padding-right: 20px;
      padding-left: 20px; */
  margin-right: 5px;
}

.btn-view-mode-right:hover {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}
.btn-view-mode {
  background-color: white;
  padding: 0.4rem 0.6rem;
  /* height: 2rem; */
  font-size: 15px;
  /* line-height: 2rem; */
  color: var(--primary-color);
  border-radius: 5px 5px 5px 5px;
  border: 1px solid #26a69a;
  z-index: 1;
  /* padding-right: 20px;
      padding-left: 20px; */
  margin-right: 5px;
}

.btn-view-mode:hover {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}
.btn-view-mode:disabled {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}
.is-active {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}

#btn-add-account {
  position: fixed;
  right: 3rem;
  bottom: 0.5rem;
  /* background-color: var(--primary-color); */
  /* padding: 13px;
  color: white;
  border-radius: 5px; */
  z-index: 1;
}
.pageNa {
  position: fixed;
  left: 17rem;
  bottom: 0.5rem;
}

#btn-add-account:hover {
  cursor: pointer;
  background-color: #009688;
  color: white;
}
#btn-add-account1 {
  background-color: white;
  padding: 0.4rem 0.6rem;
  /* height: 2rem; */
  font-size: 15px;
  /* line-height: 2rem; */
  color: var(--primary-color);
  border-radius: 5px 5px 5px 5px;
  border: 1px solid #26a69a;
  z-index: 1;
  /* padding-right: 20px;
      padding-left: 20px; */
  margin-right: 5px;
}

#btn-add-account1:hover {
  cursor: pointer;
  background-color: var(--primary-color);
  color: white;
}
#btn-add-account1:disabled {
  cursor: pointer;
  background-color: var(--primary-color);
  color: white;
}

/* test */

/* .btn-view-mode1:hover {
  color: #263238;
  cursor: pointer;
} */
.btn-view-mode1 {
  background-color: white;
  padding: 0.4rem 0.4rem;
  color: #9e9e9e;
  z-index: 1;
  font-size: 17px;
  /* border-bottom: 3px solid; */
}

.btn-view-mode1:hover {
  color: #263238;
  cursor: pointer;
  border-bottom: 3px var(--primary-color) solid;
}
.is-active {
  border-bottom: 3px #26a69a solid;
  cursor: pointer;
  color: var(--primary-color);
}

.btn-view-mode-left:disabled {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}
.btn-view-mode-right:hover {
  background-color: #26a69a;
  color: white;
  cursor: context-menu;
}
.btn-view-mode-left {
  background-color: white;
  padding: 0.4rem 0.6rem;
  /* height: 2rem; */
  font-size: 15px;
  /* line-height: 2rem; */
  color: var(--primary-color);
  border-radius: 5px 0px 0px 5px;
  border: 1px solid #26a69a;
  z-index: 1;
  /* padding-right: 20px;
      padding-left: 20px; */
  margin-right: 5px;
}
.btn-view-mode-right {
  background-color: white;
  padding: 0.4rem 0.6rem;
  /* height: 2rem; */
  font-size: 15px;
  /* line-height: 2rem; */
  color: var(--primary-color);
  border-radius: 0px 5px 5px 0px;
  border: 1px solid #26a69a;
  z-index: 1;
  /* padding-right: 20px;
      padding-left: 20px; */
  margin-right: 5px;
}
/* /test */

th {
  text-align: left;
  background-color: #cfd8dc;
  height: 30px;
  line-height: 30px;
  padding: 0.5rem !important;
}

td {
  vertical-align: middle;
  height: 40px;
  line-height: 25px;
  padding: 0.5rem;
}

tr:nth-child(odd) {
  background-color: white;
  color: #263238;
}

tr:nth-child(even) {
  background-color: #f5f5f5;
  color: #263238;
}

#th1:curve {
  text-align: justify;

  background-color: #b0bec5;
}

tr:hover {
  background-color: #eceff1;
}
td:hover {
  cursor: pointer;
}

.txtText {
  text-align: left;

  /*margin: 0.3rem;*/

  padding: 0.5rem;

  background-color: #cfd8dc;
}

table {
  /* border: 1px solid black; */

  width: 100%;

  font-size: 15px;

  /* text-align: right; */
}
</style>
