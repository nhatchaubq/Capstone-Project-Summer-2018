<template>

  <div v-if="account">
    <router-link to="/account">
      <a><span class="material-icons" style="position: relative; top: .4rem">keyboard_arrow_left</span> Back to Accounts</a>
    </router-link>

<div class="grid-wrapper1">

  <!-- <button class="button " style="background-color:green;   position: fixed;
  top: 6rem;
  right: 2rem;" v-on:click="editMode = !editMode">edit</button> -->
  <div>

<img :src="account.AvatarImage? account.AvatarImage: 'https://i.stack.imgur.com/l60Hf.png' " :alt="account.Name" style="width: 100%; ">
 <div style="font-size: 20px;margin-top:0.5rem; margin-bot:0.5rem"><strong>Team</strong></div>
<div v-bind:key="team.id" v-for="team in account.Teams" >
  <div style="margin-left:1.5rem; color:#26a69a" v-if="team.TeamRole.TeamRole == 'Leader'"> 
                        <router-link :to="`/team/${team.Id}`">
                        {{team.Name}}
                    </router-link>
      ({{team.TeamRole.TeamRole}} ) </div>
  <div style="margin-left:1.5rem" v-else>                        
                      <router-link :to="`/team/${team.Id}`">
                        {{team.Name}}
                    </router-link> ( {{team.TeamRole.TeamRole}} ) </div>
</div>
  </div>

<div class="material-box">
<div class="row" style="margin: 0 !important">
  <h2 class="col-9" style="padding: 0 !important"><strong style="text-transform: uppercase;  font-size: 20px; color: #26a69a;" >{{account.Username}}</strong> </h2>
  <div class="col-3" v-if ="!editMode">
    <button class="button btn-edit btn-primary material-shadow-animate pull-right" v-on:click="editMode = !editMode">Edit</button>
  </div>
</div>
<!-- <form @submit.prevent="editAccount()"> -->
  <div  class="row " style="height: 36px" >
      <div class="col-12" style="margin-top:0.5rem" >
      <strong>Full name</strong> <span v-if="editMode"><strong style="color:red"> *</strong></span>    <span v-if="CreateAccountErrors.FullNameMax != ''"> <span class="error-text">{{ CreateAccountErrors.FullNameMax }}</span></span> <span v-if="CreateAccountErrors.FullNameMin != ''"> <span class="error-text">{{ CreateAccountErrors.FullNameMin }}</span></span>
      </div>  
  </div>
  <input v-if="!editMode" v-model="account.Fullname" class="input col-7 " type="text"  placeholder="Text input" disabled="disabled">
  <input v-else v-model.trim="account.Fullname" class="input col-7 " type="text"  placeholder="Text input" >
  <div v-if="editMode" class="row" style="margin-top:0.5rem;  height: 36px">
      <div class="col-12" style="margin-top:0.5rem"> <strong>Password</strong>  <span v-if="editMode"><strong style="color:red"> *</strong></span> <span v-show="CreateAccountErrors.WeakAccount != ''"> <span class="error-text">{{ CreateAccountErrors.WeakAccount }}</span></span><span v-show="CreateAccountErrors.MaxPassword != ''"> <span class="error-text">{{ CreateAccountErrors.MaxPassword }}</span></span> </div> 
  </div>
    <input v-if="editMode" v-model.trim ="account.Password"  class="input col-7 " type="password"  placeholder="Text input">
  <!-- <div class="row" style="margin-top:0.5rem;  height: 36px">
    <div class="col-12" style="margin-top:0.5rem">Password: </div>

    <input v-if="!editMode" v-model="account.Password" class="input col-7 " type="text"  placeholder="Text input" disabled="disabled">
    <input v-else v-model="account.Password" class="input col-7 " type="text"  placeholder="Text input">

  </div> -->

  <div class="row" style="margin-top:0.5rem; height: 36px">
    <div class=" col-12" style="margin-top:0.5rem">
      <strong>
        Status 
      </strong>
    </div>
  </div >
  <div class="col-7" style="padding-left: 0 !important">
      <div style="margin-top:0.5rem" >
        <label style="margin-right: 1rem;" class="radio"  >
          <input type="radio" name="active" v-on:change="account.IsActive = true" :checked="account.IsActive" :disabled="!editMode">
          Active
        </label>
        <label class="radio">
          <input type="radio" style="margin-top: 0.5rem" name="active" v-on:change="account.IsActive = false" :checked="!account.IsActive" :disabled="!editMode">
          Inactive
        </label>
      </div>
  </div>
  <div class="row" style="margin-top:0.5rem; height: 36px">
    <div class="col-12" > <strong>Role</strong> </div>
  </div>
  <div class="col-7" style="padding-left: 0 !important;"> {{account.SystemRole.Name}}</div>
  <div class="row" style="margin-top:0.5rem; height: 36px">
    <div class="col-12"> <strong>Start date</strong>  </div>
  </div>
  <div class="col-7" style="padding-left: 0 !important;"> {{account.StartDate ? getDate(account.StartDate): 'N/A' }}</div>
  <!-- <h2 style="padding-top:0.9rem;padding-bottom: 0.9rem">Start date: {{account.StartDate ? account.StartDate: 'N/A' }}</h2> -->
  <div class="row" style="margin-top:0.5rem; height: 36px">
  <div class="col-12" style="margin-top:0.5rem"> <strong>Email</strong> <span v-if="editMode"><strong style="color:red"> *</strong></span> <span v-if="CreateAccountErrors.NoEmail != ''"> <span class="error-text">{{ CreateAccountErrors.NoEmail }}</span></span> </div> 
  <!-- <div class="col-7">{{account.Email ?account.Email: 'N/A' }} </div> -->
</div>
  <input v-if="!editMode" v-model="account.Email" class="input col-7 " type="email"  placeholder="Text input" disabled="disabled">
  <input v-else v-model.trim="account.Email" class="input col-7 " type="email"  placeholder="Text input">
<div class="row" style="margin-top:0.5rem; height: 36px">
  <div class="col-12" style="margin-top:0.5rem"> <strong>Phone</strong> <span v-if="editMode"><strong style="color:red"> *</strong></span> <span v-if="CreateAccountErrors.PhoneMin != ''"> <span class="error-text">{{ CreateAccountErrors.PhoneMin }}</span></span>  <span v-if="CreateAccountErrors.PhoneMax != ''"> <span class="error-text">{{ CreateAccountErrors.PhoneMax }}</span></span>  </div> 
  <!-- <div class="col-7">{{account.Phone ? account.Phone: 'N/A' }} </div> -->
</div>
  <input v-if="!editMode" v-model="account.Phone" class="input col-7 " type="text"  placeholder="Text input" disabled="disabled">
  <input v-else v-model.trim="account.Phone" class="input col-7 " type="text"  placeholder="Text input">
<div class="row" v-if="editMode">
  <!-- <button class="button btn-confirm-edit btn-primary material-shadow-animate" v-on:click="editAccount()">Save change</button> -->
  <button class="button btn-confirm-edit btn-primary material-shadow-animate" v-on:click="editAccount()" >Save change</button>
    <button v-if="editMode" class="button btn-cancel btn-primary material-shadow-animate" v-on:click="() => {
         getAccountDetail($route.params.id);
         editMode = false;
      }">Cancel</button>
</div>

<!-- </form> -->


<!-- <div style="font-size: 20px;margin-top:0.5rem; margin-bot:0.5rem"><strong>Team</strong></div>
<div v-bind:key="team.id" v-for="team in account.Teams" >
  <div style="margin-left:1.5rem; color:#26a69a" v-if="team.TeamRole.TeamRole == 'Leader'"> 
                        <router-link :to="`/team/${team.Id}`">
                        {{team.Name}}
                    </router-link>
      ({{team.TeamRole.TeamRole}} ) </div>
  <div style="margin-left:1.5rem" v-else>                        
                      <router-link :to="`/team/${team.Id}`">
                        {{team.Name}}
                    </router-link> ( {{team.TeamRole.TeamRole}} ) </div>
</div> -->



         



  </div>
  




  </div>  



  </div>
</template>

<script>
import moment from "moment";
export default {
  components: {
    moment
  },
  created() {
    //   let URL = "http://localhost:3000/api/account/id/:id";
    //   this.axios.get(URL).then(response => {
    //     let data = response.data;
    //     // alert('in');
    //     data.forEach(element => {
    //       let account = element.Account;
    //       this.accounts.push(account);
    //     });
    //   });
    // },
    this.getAccountDetail(this.$route.params.id);
  },

  data() {
    return {
      sending: false,
      ErrorStrings: {
        // NoUsername: 'You must provide username for this account',
        // NoFullname: "You must provide full name for this account",
        FullNameMax: " Use from 6 to 50 characters for your full name",
        FullNameMin: " Use from 6 to 50 characters for your full name",

        // NoPassword: "You must provide password for this account",
        MaxPassword: " Use from 6 to 50 characters for your password",
        WeakAccount: " Use from 6 to 50 characters for your password",

        // NoPhone: "You must provide phone number for this account",
        PhoneMin: " Use from 9 to 13 characters for your phone number",
        PhoneMax: " Use from 9 to 13 characters for your phone number",

        NoEmail: " Enter email"
        // NoRole: "You must provide role for this account"
      },
      CreateAccountErrors: {
        // NoUsername: '',
        // NoFullname: "",
        FullNameMax: "",
        FullNameMin: "",

        // NoPassword: "",
        WeakAccount: "",
        MaxPassword: "",

        // NoPhone: "",
        PhoneMin: "",
        PhoneMax: "",

        NoEmail: ""
        // NoRole: ""
      },
      account: null,
      checkedActive: [],
      editMode: false
    };
  },
  methods: {
    editAccount() {
      // if(this.account.username === ''){
      //     this.CreateAccountErrors.NoUsername = this.ErrorStrings.NoUsername;
      // }
      // if (this.account.Fullname === "") {
      //   this.CreateAccountErrors.NoFullname = this.ErrorStrings.NoFullname;
      // }
      if (this.account.Fullname.length < 6) {
        this.CreateAccountErrors.FullNameMin = this.ErrorStrings.FullNameMin;
      }
      if (this.account.Fullname.length > 50) {
        this.CreateAccountErrors.FullNameMax = this.ErrorStrings.FullNameMax;
      }
      // if (this.account.Password === "") {
      //   this.CreateAccountErrors.NoPassword = this.ErrorStrings.NoPassword;
      // }
      if (this.account.Password.length < 6) {
        this.CreateAccountErrors.WeakAccount = this.ErrorStrings.WeakAccount;
      }
      if (this.account.Password.length > 50) {
        this.CreateAccountErrors.MaxPassword = this.ErrorStrings.MaxPassword;
      }
      // if (this.account.Phone === "") {
      //   this.CreateAccountErrors.NoPhone = this.ErrorStrings.NoPhone;
      // }
      if (this.account.Phone.length < 9) {
        this.CreateAccountErrors.PhoneMin = this.ErrorStrings.PhoneMin;
      }
      if (this.account.Phone.length > 13) {
        this.CreateAccountErrors.PhoneMax = this.ErrorStrings.PhoneMax;
      }
      if (this.account.Email === "") {
        this.CreateAccountErrors.NoEmail = this.ErrorStrings.NoEmail;
      }
      // if (!this.account.roleid || this.account.roleid == "") {
      //   this.CreateAccountErrors.NoRole = this.ErrorStrings.NoRole;
      // }
      if (this.validateAccount())
        this.axios
          .put(`http://localhost:3000/api/account/${this.$route.params.id}`, {
            account: this.account
          })
          .then(res => {
            // this.$router.push("/account");
            if (res.status == 200) {
              alert("Change successful");
              this.editMode = false;
              this.getAccountDetail(this.$route.params.id);
            }
          });
    },
    validateAccount() {
      return (
        // this.CreateAccountErrors.NoPassword === "" &&
        // this.CreateAccountErrors.NoFullname === "" &&
        this.CreateAccountErrors.FullNameMin === "" &&
        this.CreateAccountErrors.FullNameMax === "" &&
        this.CreateAccountErrors.PhoneMin === "" &&
        this.CreateAccountErrors.PhoneMax === "" &&
        // this.CreateAccountErrors.NoPhone === "" &&
        this.CreateAccountErrors.NoEmail === "" &&
        //&& this.CreateAccountErrors.NoRole === ""
        this.CreateAccountErrors.WeakAccount === "" &&
        this.CreateAccountErrors.MaxPassword === ""
        //  && this.CreateAccountErrors.NoUsername === ''
      );
    },
    getAccountDetail(accountId) {
      let URL = `http://localhost:3000/api/account/id/${accountId}`;
      this.axios.get(URL).then(response => {
        let data = response.data;
        this.account = data;
      });
    },
    getDate(date) {
      return moment(date).format("L");
    }
  },
  watch: {
    // "account.username": function(){
    //     if(this.account.username != ''){
    //         this.CreateAccountErrors.NoUsername = ''
    //     }
    // },
    "account.Password": function() {
      if (this.account.Password != "") {
        this.CreateAccountErrors.NoPassword = "";
      }
      if (this.account.Password.length > 5) {
        this.CreateAccountErrors.WeakAccount = "";
      }
      if (this.account.Password.length < 51) {
        this.CreateAccountErrors.MaxPassword = "";
      }
    },
    "account.Fullname": function() {
      if (this.account.Fullname != "") {
        this.CreateAccountErrors.NoFullname = "";
      }
      if (this.account.Fullname.length > 5) {
        this.CreateAccountErrors.FullNameMin = "";
      }
      if (this.account.Fullname.length < 51) {
        this.CreateAccountErrors.FullNameMax = "";
      }
    },
    "account.Phone": function() {
      // if (this.account.Phone != "") {
      //   this.CreateAccountErrors.NoPhone = "";
      // }
      if (this.account.Phone.length > 8) {
        this.CreateAccountErrors.PhoneMin = "";
      }
      if (this.account.Phone.length < 14) {
        this.CreateAccountErrors.PhoneMax = "";
      }
    },
    "account.Email": function() {
      if (this.account.Email != "") {
        this.CreateAccountErrors.NoEmail = "";
      }
    }
    // "account.roleid": function() {
    //   if (this.account.roleid && this.account.roleid != "") {
    //     this.CreateAccountErrors.NoRole = "";
    //   }
    // }
  }
};
</script>

<style scoped>
.grid-wrapper1 {
  display: grid;
  grid-template-columns: 50% 50%;
  grid-column-gap: 1rem;
  grid-row-gap: 2rem;
}
/* #btn-add-account {
  position: fixed;
  right: 3rem;
  bottom: 2rem;
  background-color: #ff1d1d;
  padding: 13px;
  color: white;
  border-radius: 5px;
  z-index: 1;
}

#btn-add-account:hover {
  cursor: pointer;
  background-color: var(--danger-color);
  color: white;
} */

.btn-edit {
  /* margin-left: 15rem; */
  background-color: var(--primary-color);
  /* padding: 13px; */
  color: white;
  /* border-radius: 5px;
  z-index: 10;
  font-size: 1.3rem; */
}

/* .btn-edit:hover {
  cursor: pointer;
  background-color: #009688;
} */
.btn-confirm-edit {
  background-color: var(--primary-color);
  margin-left: 7rem;
  margin-top: 1rem;
  /* padding: 13px; */
  color: white;
  /* border-radius: 5px;
  z-index: 10;
  font-size: 1.3rem; */
}

.btn-confirm-edit:hover {
  cursor: pointer;
  background-color: #009688;
}

.btn-cancel {
  background-color: var(--shadow);
  margin-left: 1rem;
  margin-top: 1rem;
  /* padding: 13px; */
  color: white;
  /* border-radius: 5px;
  z-index: 10;
  font-size: 1.3rem; */
}

.btn-cancel:hover {
  cursor: pointer;
  background-color: #aca4a4;
}
</style>
