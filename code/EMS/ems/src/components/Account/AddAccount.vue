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
                    <strong>  Username (required)</strong> <span v-if="CreateAccountErrors.NoUsername != ''">. <span class="error-text">{{ CreateAccountErrors.NoUsername }}</span></span>
                    <!-- <span v-if="CreateWorkOrderErrors.NoTitle != ''">. <span class="error-text">{{ CreateWorkOrderErrors.NoTitle }}</span></span> -->
                    </div>
                    <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model="account.username" class="input " type="text" placeholder="Text input" >

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
                    <strong>   Password (required)</strong> <span v-if="CreateAccountErrors.NoPassword != ''">. <span class="error-text">{{ CreateAccountErrors.NoPassword }}</span></span>
                <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model="account.password" class="input " type="password" placeholder="Text input" name="password" id="password">
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
                        </strong>    <span v-if="CreateAccountErrors.NoFullname != ''">. <span class="error-text">{{ CreateAccountErrors.NoFullname }}</span></span>
                    </div>
                    <div class="form-field-input">
                    <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model="account.fullname" class="input " type="text" placeholder="Text input" name="fullname" id="fullname">
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

                        </strong> <span v-if="CreateAccountErrors.NoPhone != ''">. <span class="error-text">{{ CreateAccountErrors.NoPhone }}</span></span>
                    </div>
                    <div class="form-field-input">
                    <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model="account.phone" class="input " type="number" placeholder="Text input" name="phone" id="phone">
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
                        </strong> <span v-if="CreateAccountErrors.NoEmail != ''">. <span class="error-text">{{ CreateAccountErrors.NoEmail }}</span></span>
                    </div>
                    <div class="form-field-input">
                    <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model="account.email" class="input" type="email" placeholder="Text input" name="email" id="email">
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
            <div>
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
                            <!-- <span class="icon is-small is-right">
                            <i class="fa fa-check"></i>
                            </span> -->
                            <!-- {{account.startdate}} -->
                        </div>
                    </div>
                    <!-- <h3>{{account.startdate}}</h3> -->
                </div>
                
            </div>
    
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
                        </strong><span v-if="CreateAccountErrors.NoRole != ''">. <span class="error-text">{{ CreateAccountErrors.NoRole }}</span></span>
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
        NoUsername: 'You must provide username for this account',
        NoPassword: 'You must provide password for this account',
        NoFullname: 'You must provide full name for this account',
        NoPhone: 'You must provide phone number for this account',
        NoEmail: 'You must provide email name for this account',
        NoRole: 'You must provide role for this account',


      },
      CreateAccountErrors: {
        NoUsername: '',
        NoPassword: '',
        NoFullname: '',
        NoPhone: null,
        NoEmail: '',
        NoRole: ''
      },
      account: {
        username: "",
        password: "",
        fullname: "",
        phone: null,
        email: "",
        startdate: "",
        roleid: null
      },
      roleOptions: []
    };
  },
  methods: {
    createAccount1() {
        if(this.account.username === ''){
            this.CreateAccountErrors.NoUsername = this.ErrorStrings.NoUsername;
        }
        if(this.account.password === ''){
            this.CreateAccountErrors.NoPassword = this.ErrorStrings.NoPassword;
        }
        if(this.account.fullname === ''){
            this.CreateAccountErrors.NoFullname = this.ErrorStrings.NoFullname;
        }
        if(this.account.phone === null){
            this.CreateAccountErrors.NoPhone = this.ErrorStrings.NoPhone;
        }
        if(this.account.email === ''){
            this.CreateAccountErrors.NoEmail = this.ErrorStrings.NoEmail;
        }
        if(!this.account.roleid  || this.account.roleid == ''){
            this.CreateAccountErrors.NoRole = this.ErrorStrings.NoRole;
        }
        if(this.validateAccount()){
            this.axios
                .post("http://localhost:3000/api/account", {
                account: this.account
                })
                .then(res => {
                this.$router.push("/account");
                });
        }
            // this.axios
            //     .post("http://localhost:3000/api/account", {
            //     account: this.account
            //     })
            //     .then(res => {
            //     this.$router.push("/account");
            //     });

    },
 validateAccount() {      
      return this.CreateAccountErrors.NoUsername === '' && this.CreateAccountErrors.NoPassword === ''
              && this.CreateAccountErrors.NoFullname === '' && this.CreateAccountErrors.NoPhone === ''
              && this.CreateAccountErrors.NoEmail === '' && this.CreateAccountErrors.NoRole === ''
    },
  },
  watch:{
      "account.username": function(){
          if(this.account.username != ''){
              this.CreateAccountErrors.NoUsername = ''
          }
      },
      'account.password': function(){
          if(this.account.password != ''){
              this.CreateAccountErrors.NoPassword = ''
          }
      },
      'account.fullname': function(){
          if(this.account.fullname != ''){
              this.CreateAccountErrors.NoFullname = ''
          }
      },
      'account.phone': function(){
          if(this.account.phone != null){
              this.CreateAccountErrors.NoPhone = ''
          }
      },
      'account.email': function(){
          if(this.account.email != ''){
              this.CreateAccountErrors.NoEmail = ''
          }
      },
      'account.roleid': function(){
          if(this.account.roleid && this.account.roleid != ''){
              this.CreateAccountErrors.NoRole = ''
          }
      },
      
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
