<template>
     <div class="form">
         
         <form @submit.prevent="createAccount1()">
            <div class="form-title">
                <div class="form-title-start">
                    Add New Account
                </div>
                <div></div>

            </div>
            <div>
                <div class="form-field">
                    <div class="form-field-title">
                    <strong>  Username (required)</strong> <span v-if="CreateAccountErrors.UsernameMin != ''"> <span></span> <span class="error-text">{{ CreateAccountErrors.UsernameMin }}</span></span>  <span v-if="CreateAccountErrors.UsernameMax != ''"> <span></span> <span class="error-text">{{ CreateAccountErrors.UsernameMax }}</span></span><span v-if="CreateAccountErrors.UserNameTrim != ''"> <span></span> <span class="error-text">{{ CreateAccountErrors.UserNameTrim }}</span></span>
                    <!-- <span v-if="CreateWorkOrderErrors.NoTitle != ''">. <span class="error-text">{{ CreateWorkOrderErrors.NoTitle }}</span></span> -->
                    </div>
                    <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model.trim="account.username" class="input " type="text" placeholder="Text input" >

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
                    <strong>   Password (required)</strong> <span v-show="CreateAccountErrors.WeakAccount != ''"> <span class="error-text">{{ CreateAccountErrors.WeakAccount }}</span></span><span v-show="CreateAccountErrors.MaxPassword != ''"> <span class="error-text">{{ CreateAccountErrors.MaxPassword }}</span></span>
                <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model.trim="account.password" class="input " type="password" placeholder="Text input" name="password" id="password">
                            <span class="icon is-small is-left">
                            <i class="fa fa-expeditedssl"></i>
                            </span>
                            <!-- <span class="icon is-small is-right">
                            <i class="fa fa-check"></i>
                            </span> -->
                            <!-- {{account.password}} -->
                        </div>
                    </div>

                </div>
                
            </div>
            <div>
                <div class="form-field">
                    <div class="form-field-title">
                        <strong>
                            Fullname (required)
                        </strong>     <span v-if="CreateAccountErrors.FullNameMax != ''"> <span class="error-text">{{ CreateAccountErrors.FullNameMax }}</span></span> <span v-if="CreateAccountErrors.FullNameMin != ''"> <span class="error-text">{{ CreateAccountErrors.FullNameMin }}</span></span>
                    </div>
                    <div class="form-field-input">
                    <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model.trim="account.fullname" class="input " type="text" placeholder="Text input" name="fullname" id="fullname">
                            <span class="icon is-small is-left">
                            <i class="fa fa-user"></i>
                            </span>
                            <!-- <span class="icon is-small is-right">
                            <i class="fa fa-check"></i>
                            </span> -->
                            <!-- {{account.fullname}} -->
                        </div>
                    </div>

                </div>
                
            </div>
            <div>
                <div class="form-field">
                    <div class="form-field-title">
                        <strong>
                            Phone (required)

                        </strong>  <span v-if="CreateAccountErrors.PhoneMax != ''"> <span class="error-text">{{ CreateAccountErrors.PhoneMax }}</span></span> <span v-if="CreateAccountErrors.PhoneMin != ''"> <span class="error-text">{{ CreateAccountErrors.PhoneMin }}</span></span>
                    </div>
                    <div class="form-field-input">
                    <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model.trim="account.phone" class="input " type="text" placeholder="Text input" name="phone" id="phone">
                            <span class="icon is-small is-left">
                            <i class="fa fa-mobile"></i>
                            </span>
                            <!-- <span class="icon is-small is-right">
                            <i class="fa fa-check"></i>
                            </span> -->
                            <!-- {{account.phone}} -->
                        </div>
                    </div>

                </div>
                
            </div>
                    <div>
                <div class="form-field">
                    <div class="form-field-title">
                        <strong>
                            Email (required) 
                        </strong> <span v-if="CreateAccountErrors.NoEmail != ''"> <span class="error-text">{{ CreateAccountErrors.NoEmail }}</span></span>
                    </div>
                    <div class="form-field-input">
                    <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model.trim="account.email" class="input" type="email" placeholder="Text input" >
                            <span class="icon is-small is-left">
                            <i class="fa fa-envelope"></i>
                            </span>

                        </div>
                    </div>

                </div>
                
            </div>
<!-- test -->
    <!-- <div >
                <div class="form-field">
                    <div class="form-field-title">
                        IsActive 
                    </div>
                    <div class="form-field-input">
                    <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model="account.isActive" class="input" type="text" placeholder="Text input" value="TRUE">
                            <span class="icon is-small is-left">
                            <i class="fa fa-envelope"></i>
                            </span>

                        </div>
                    </div>

                </div>
                
    </div> -->
         <!-- /test    -->
            <div >

            </div>
            <!-- <div>
                <div class="form-field">
                    <div class="form-field-title">
                        <strong>
                            Start date 
                        </strong>
                    </div>
                    <div class="form-field-input">
                        <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model="account.startdate" class="input" type="date" placeholder="Text input" >
                            <span class="icon is-small is-left">
                            <i class="fa fa-calendar"></i>
                            </span>

                        </div>
                    </div>

                </div>
                
            </div> -->
    
            <div>
                <div class="form-field">
                    <!-- <div class="form-field-title">
                        Role <strong><span style="color:red;">*</span></strong>
                    </div>
                    <div class="form-field-input">
                    <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model="account.rolename" class="input" type="text" placeholder="Text input" >
                            <span class="icon is-small is-left">
                            <i class="fa fa-user-md"></i>
                            </span>

                        </div>
                    </div> -->
<!-- tien -->
                    <div class="form-field-title" >
                        <strong>
                            Role (required)
                        </strong><span v-if="CreateAccountErrors.NoRole != ''"> <span class="error-text">{{ CreateAccountErrors.NoRole }}</span></span>
                    </div> 
                    <div class="field is-horizontal" >
                        <model-select style="width: 100% !important" :options="roleOptions" v-model="account.roleid" placeholder="Select a role"></model-select>  
                        
                    </div>
<!-- /tien -->      
                </div>            
            </div>

            
    
    <div class="form-title-end" style="margin-bottom:2rem">
                    <router-link to='/account'>
                        <button id="btn-cancel" class="button" >Cancel</button>
                    </router-link>

                    <!-- <button id="btn-add" class="button" v-on:click="createAccount()">Create Account</button>
                    <button id="btn-add" class="button" v-on:click="createAccountTrueEnd()">Create Account true end</button> -->
                    <!-- <router-link to='/account/'>
                    <button id="btn-add" class="button">Create Account</button>
                    </router-link> -->
                    <button id="btn-add" class="button">Create Account</button>
                </div>
            <!-- <div>&nbsp</div> -->
         <!-- </form> -->
         </form>
    </div>
</template>

<script>
// import VueBase64FileUpload from "vue-base64-file-upload";
import { ModelSelect } from "vue-search-select";
export default {
  components: {
    // VueBase64FileUpload,
    ModelSelect
  },
  created() {
    this.axios
      .get("http://localhost:3000/api/role")
      .then(response => {
        let data = response.data;
        data.forEach(role => {
          let option = {
            text: role.Name,
            value: role.Id
          };
          this.roleOptions.push(option);
        });
      })
      .catch(error => {
        alert(error);
      });
  },

  data() {
    return {
      sending: false,
      ErrorStrings: {
        // NoUsername: "You must provide username for this account",
        // NoPassword: "You must provide password for this account",
        // fullname-start
        FullNameMax: "Use from 6 to 50 characters for your full name",
        FullNameMin: "Use from 6 to 50 characters for your full name",
        // NoFullname: "You must provide full name for this account",
        // fullname-end
        // NoPhone: "You must provide phone number for this account",
        // username-start
        UsernameMax: "Use from 6 to 50 characters for your  username",
        UsernameMin: "Use from 6 to 50 characters for your username",
        // UserNameTrim: " No Space Allowed",
        // username-end
        //password
        MaxPassword: "Use from 6 to 50 characters for your password",
        WeakAccount: "Use from 6 to 50 characters for your password",
        //password-end

        // phone-start
        PhoneMin: "Use from 9 to 13 characters for your phonenumber",
        PhoneMax: "Use from 9 to 13 characters for your phonenumber",
        // phone-end
        NoEmail: "Enter email",
        NoRole: "Select role"
      },
      CreateAccountErrors: {
        // NoUsername: "",
        // NoPassword: "",
        // NoFullname: "",
        UsernameMax: "",
        UsernameMin: "",
        UserNameTrim: "",
        WeakAccount: "",
        MaxPassword: "",
        FullNameMax: "",
        FullNameMin: "",
        PhoneMin: "",
        PhoneMax: "",
        // NoPhone: "",
        NoEmail: "",
        NoRole: ""
      },
      account: {
        username: "",
        password: "",
        fullname: "",
        phone: "",
        email: "",
        startdate: "",
        roleid: null
      },
      roleOptions: []
    };
  },
  methods: {
    createAccount1() {
      //   if (this.account.username === "") {
      //     this.CreateAccountErrors.NoUsername = this.ErrorStrings.NoUsername;
      //   }
      if (this.account.username.length < 6) {
        this.CreateAccountErrors.UsernameMin = this.ErrorStrings.UsernameMin;
      }
      if (this.account.username.length > 50) {
        this.CreateAccountErrors.UsernameMax = this.ErrorStrings.UsernameMax;
      }
      // if (this.account.username.trim() === "") {
      //   this.CreateAccountErrors.UserNameTrim = this.ErrorStrings.UserNameTrim;
      // }
      //   if (this.account.password === "") {
      //     this.CreateAccountErrors.NoPassword = this.ErrorStrings.NoPassword;
      //   }
      if (this.account.password.length < 6) {
        this.CreateAccountErrors.WeakAccount = this.ErrorStrings.WeakAccount;
      }
      if (this.account.password.length > 50) {
        this.CreateAccountErrors.MaxPassword = this.ErrorStrings.MaxPassword;
      }
      // if (this.account.fullname === "") {
      //   this.CreateAccountErrors.NoFullname = this.ErrorStrings.NoFullname;
      // }
      if (this.account.fullname.length < 6) {
        this.CreateAccountErrors.FullNameMin = this.ErrorStrings.FullNameMin;
      }
      if (this.account.fullname.length > 50) {
        this.CreateAccountErrors.FullNameMax = this.ErrorStrings.FullNameMax;
      }
      //   if (this.account.phone === "") {
      //     this.CreateAccountErrors.NoPhone = this.ErrorStrings.NoPhone;
      //   }
      if (this.account.phone.length < 9) {
        this.CreateAccountErrors.PhoneMin = this.ErrorStrings.PhoneMin;
      }
      if (this.account.phone.length > 13) {
        this.CreateAccountErrors.PhoneMax = this.ErrorStrings.PhoneMax;
      }
      if (this.account.email === "") {
        this.CreateAccountErrors.NoEmail = this.ErrorStrings.NoEmail;
      }

      if (!this.account.roleid || this.account.roleid == "") {
        this.CreateAccountErrors.NoRole = this.ErrorStrings.NoRole;
      }
      if (this.validateAccount()) {
        this.axios
          .post("http://localhost:3000/api/account", {
            account: this.account
          })
          .then(res => {
            this.$router.push("/account");
          });
      }
    },
    validateAccount() {
      return (
        // this.CreateAccountErrors.NoUsername === "" &&
        // this.CreateAccountErrors.NoPassword === "" &&
        // this.CreateAccountErrors.NoFullname === "" &&
        // this.CreateAccountErrors.NoPhone === "" &&
        this.CreateAccountErrors.UsernameMax === "" &&
        this.CreateAccountErrors.UsernameMin === "" &&
        // this.CreateAccountErrors.UserNameTrim === "" &&
        this.CreateAccountErrors.MaxPassword === "" &&
        this.CreateAccountErrors.WeakAccount === "" &&
        this.CreateAccountErrors.FullNameMax === "" &&
        this.CreateAccountErrors.FullNameMin === "" &&
        this.CreateAccountErrors.PhoneMax === "" &&
        this.CreateAccountErrors.PhoneMin === "" &&
        this.CreateAccountErrors.NoEmail === "" &&
        this.CreateAccountErrors.NoRole === ""
      );
    }
  },
  watch: {
    "account.username": function() {
      // if (this.account.username.trim() != "") {
      //   this.CreateAccountErrors.UserNameTrim = "";
      // }
      if (this.account.username.length > 5) {
        this.CreateAccountErrors.UsernameMin = "";
      }
      if (this.account.username.length < 51) {
        this.CreateAccountErrors.UsernameMax = "";
      }
    },
    "account.password": function() {
      //   if (this.account.password != "") {
      //     this.CreateAccountErrors.NoPassword = "";
      //   }
      if (this.account.password.length > 5) {
        this.CreateAccountErrors.WeakAccount = "";
      }
      if (this.account.password.length < 51) {
        this.CreateAccountErrors.MaxPassword = "";
      }
    },
    "account.fullname": function() {
      // if (this.account.fullname != "") {
      //   this.CreateAccountErrors.NoFullname = "";
      // }
      if (this.account.fullname.length < 51) {
        this.CreateAccountErrors.FullNameMax = "";
      }
      if (this.account.fullname.length > 5) {
        this.CreateAccountErrors.FullNameMin = "";
      }
    },
    "account.phone": function() {
      // if (this.account.phone != "") {
      //   this.CreateAccountErrors.NoPhone = "";
      // }
      if (this.account.phone.length > 8) {
        this.CreateAccountErrors.PhoneMin = "";
      }
      if (this.account.phone.length < 14) {
        this.CreateAccountErrors.PhoneMax = "";
      }
    },
    "account.email": function() {
      if (this.account.email != "") {
        this.CreateAccountErrors.NoEmail = "";
      }
    },
    "account.roleid": function() {
      if (this.account.roleid && this.account.roleid != "") {
        this.CreateAccountErrors.NoRole = "";
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
