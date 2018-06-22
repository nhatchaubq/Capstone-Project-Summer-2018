<template>
   <div>
      <!-- <div class="field is-grouped ">
        <router-link to='/account/'>
          <button id="btn-add-account1" class="button" >Account</button>
        </router-link>
        <router-link to='/department'>
          <button id="btn-add-account1" class="button ">Department</button>
        </router-link>
        <router-link to='/team'>
          <button id="btn-add-account1" class="button ">Team</button>
        </router-link>
      </div> -->
    
    <div >
      <div class="field is-grouped view-mode" >
        <!-- <button class="btn-view-mode-left" :class='{"is-active": isTableMode}' v-on:click="setTableMode(true)">Table view</button>
        <button class="btn-view-mode-right" :class='{"is-active": !isTableMode}' v-on:click="setTableMode(false)">Card view</button> -->
        <router-link to='/account/'>  
          <button class="btn-view-mode" disabled="disabled">Account view</button>
        </router-link>
        <router-link to='/team/'>  
          <button class="btn-view-mode" >Team view</button>
        </router-link>
      </div>
    </div>
    <div class="btncotrol" >
      <div class="field is-grouped view-mode1">
        <button class="btn-view-mode1" :class='{"is-active": isTableMode}' v-on:click="setTableMode(true)">Table view</button>
        <button class="btn-view-mode1" :class='{"is-active": !isTableMode}' v-on:click="setTableMode(false)">Card view</button>
      </div>
    </div>
        <div v-if="!accounts">
      There is no account yet.
    </div>
    <div v-else>

      <account-table :accounts="accounts" v-if="isTableMode"></account-table>
      <account-card :accounts="accounts" v-else></account-card>

    </div>

    <router-link to='/account/add/'>
      <button id="btn-add-account" class=" material-shadow-animate">Add Account</button>
    </router-link>

    </div>
</template>

<script>
// import data from "@/models/accounts.js";
import Server from "@/config/config.js";
import { sync } from "vuex-pathify";
import AccountCard from "./AccountCard";
import AccountTable from "./AccountTable";

export default {
  components: {
    AccountCard,
    AccountTable
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
  computed: {
    isTableMode: sync("accountPage.isTableMode")
  },
  data() {
    return {
      accounts: [],
      selectedAccount: null,
      currentViewMode: true,
      viewModes: {}
    };
  },
  methods: {
    setSelectedAccount(account) {
      this.selectedAccount = account;
    },
    setTableMode(value) {
      this.$store.state.accountPage.isTableMode = value;
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
  bottom: 2rem;
  background-color: var(--primary-color);
  padding: 13px;
  color: white;
  border-radius: 5px;
  z-index: 1;
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

.btn-view-mode1:hover {
  color: #263238;
  cursor: pointer;
}
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
/* /test */
</style>
