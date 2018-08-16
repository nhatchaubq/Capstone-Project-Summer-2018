<template>
     <div>
     <!-- <div class="form"> -->
 
         
         <!-- <form @submit.prevent="createAccount1()"> -->
            <div class="form-title" >
                <div class="form-title-start ">
                  <div>
                    Add New Account
                  </div>
                </div>
                  <div class="form-title-end">
                    <router-link to='/account'>
                      <button id="btn-cancel" class="button" >Cancel</button>
                    </router-link>
                    <button id="btn-add" class="button" v-on:click="createAccount1()">Create Account</button>
                </div>
            </div>
                <!-- <table class="mytable" style="margin-bottom:0.5rem !important">

      <tbody>
          <tr  :key="account.Id" v-for="(account, index) in accounts"  style="height:28px !important" v-on:click="gotoDetail(account.Id)"  >
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
    </table> -->
            <div class="form-content">
            <div class="form-field-picture">
              <div class="form-field-title">
                  <span><strong>  Picture (required) </strong></span><span v-if="CreateAccountErrors.NoImage != ''"> <span class="error-text">{{ CreateAccountErrors.NoImage }}</span></span>

              </div>
              <div class="input_picture">                    
                  <label class="file-label" style="width: 100% !important"> 
                  <span class="file-cta">
                      <input class="file-input" type="file" accept="image/*" ref="fileInput" style="opacity:0" v-on:change="inputFileChange"  />
                      <span class="file-icon">

                          <i class="fa fa-upload"></i>
                      </span>
                      <span class="file-label">
                          Choose images...
                      </span>
                  </span>
                      <div class="file-upload" v-bind:key="file.name" v-for="file in files" style="width: 100% !important;">
                          {{ file.name }}
                      <div>
                          <img class="file-upload" v-bind:src="getFilePath(file)" width="300px" height="450px"/>
                      </div>
                      </div>
                  </label>
              </div> 
            </div>
            <div >
                <div class="form-field">
                    <div class="form-field-title">
                    <strong>  Username (required)</strong> <span v-if="CreateAccountErrors.UsernameMin != ''"> <span></span> <span class="error-text">{{ CreateAccountErrors.UsernameMin }}</span></span>  <span v-if="CreateAccountErrors.UsernameMax != ''"> <span></span> <span class="error-text">{{ CreateAccountErrors.UsernameMax }}</span></span><span v-if="CreateAccountErrors.UserNameTrim != ''"> <span></span> <span class="error-text">{{ CreateAccountErrors.UserNameTrim }}</span></span> <span class="error-text" v-if="CreateAccountErrors.duplicateUsername != ''"> {{ CreateAccountErrors.duplicateUsername }}</span> <span class="error-text" v-if="CreateAccountErrors.ValidUsername != ''"> {{ CreateAccountErrors.ValidUsername }}</span>
                    <!-- <span v-if="CreateWorkOrderErrors.NoTitle != ''">. <span class="error-text">{{ CreateWorkOrderErrors.NoTitle }}</span></span> -->
                    </div>
                    <div class="control has-icons-right" style="padding:8px">
                        <input v-model.trim="account.username" class="input " type="text" placeholder="James123" >

                            <!-- <span class="icon is-small is-left">
                            <i class="fa fa-user"></i>
                            </span> -->
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
                <div class="control has-icons-right" style="padding:8px">
                        <input v-model.trim="account.password" class="input " type="password" placeholder="Chow@321" name="password" id="password">
                            <!-- <span class="icon is-small is-left">
                            <i class="fa fa-expeditedssl"></i>
                            </span> -->
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
                        </strong>     <span v-if="CreateAccountErrors.FullNameMax != ''"> <span class="error-text">{{ CreateAccountErrors.FullNameMax }}</span></span> <span v-if="CreateAccountErrors.FullNameMin != ''"> <span class="error-text">{{ CreateAccountErrors.FullNameMin }}</span></span><span v-if="CreateAccountErrors.ValidFullName != ''"> <span class="error-text">{{ CreateAccountErrors.ValidFullName }}</span></span>
                    </div>
                    <div class="form-field-input">
                    <div class="control  has-icons-right" style="padding:8px">
                        <input v-model.trim="account.fullname" class="input " type="text" placeholder="James Cole" name="fullname" id="fullname">
                            <!-- <span class="icon is-small is-left">
                            <i class="fa fa-user"></i>
                            </span> -->
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

                        </strong>  <span v-if="CreateAccountErrors.PhoneMax != ''"> <span class="error-text">{{ CreateAccountErrors.PhoneMax }}</span></span> <span v-if="CreateAccountErrors.PhoneMin != ''"> <span class="error-text">{{ CreateAccountErrors.PhoneMin }}</span></span><span v-if="CreateAccountErrors.validPhone != ''"> <span class="error-text">{{ CreateAccountErrors.validPhone }}</span></span><span v-if="CreateAccountErrors.duplicatePhone != ''"> <span class="error-text">{{ CreateAccountErrors.duplicatePhone }}</span></span>
                    </div>
                    <div class="form-field-input">
                    <div class="control has-icons-right" style="padding:8px">
                        <input v-model.trim="account.phone" class="input " type="number" placeholder="0633824936" name="phone" id="phone">
                            <!-- <span class="icon is-small is-left">
                            <i class="fa fa-mobile"></i>
                            </span> -->
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
                        </strong> <span v-if="CreateAccountErrors.NoEmail != ''"> <span class="error-text">{{ CreateAccountErrors.NoEmail }}</span></span><span v-if="CreateAccountErrors.validEmail != ''"> <span class="error-text">{{ CreateAccountErrors.validEmail }}</span></span><span v-if="CreateAccountErrors.duplicateEmail != ''"> <span class="error-text">{{ CreateAccountErrors.duplicateEmail }}</span></span>
                    </div>
                    <div class="form-field-input">
                    <div class="control has-icons-right" style="padding:8px">
                        <input v-model.trim="account.email" class="input"  type="text" placeholder="DPoint@gmail.com"  >
                  

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
                        <model-select style="width: 100% !important; margin-bottom:12rem" :options="roleOptions" v-model="account.roleid" placeholder="Select a role"></model-select>  
                        
                    </div>
<!-- /tien -->      
                </div>            
            </div>

            
    
    <!-- <div class="form-title-end" style="margin-bottom:2rem">
                    <router-link to='/account'>
                        <button id="btn-cancel" class="button" >Cancel</button>
                    </router-link>
                    <button id="btn-add" class="button">Create Account</button>
                </div> -->
          </div>
         <!-- </form> -->
    </div>
</template>

<script>
import VueBase64FileUpload from "vue-base64-file-upload";
import { ModelSelect } from "vue-search-select";
import moment from "moment";
export default {
  components: {
    VueBase64FileUpload,
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
    this.axios.get("http://localhost:3000/api/account").then(res => {
      this.existedAccounts = [];
      res.data.forEach(value => this.accounts.push(value.Account));
    });
  },

  data() {
    return {
      newAccount: "",
      files: [],
      accounts: [],
      sending: false,
      ErrorStrings: {
        // NoUsername: "You must provide username for this account",
        // NoPassword: "You must provide password for this account",
        // fullname-start
        FullNameMax: " Use from 6 to 50 characters for your full name ",
        FullNameMin: " Use from 6 to 50 characters for your full name ",
        // NoFullname: "You must provide full name for this account",
        // fullname-end
        // NoPhone: "You must provide phone number for this account",
        // username-start
        UsernameMax: " Use from 6 to 50 characters for your  username ",
        UsernameMin: " Use from 6 to 50 characters for your username ",
        // UserNameTrim: " No Space Allowed",
        // username-end
        //password
        MaxPassword: " Use from 6 to 50 characters for your password ",
        WeakAccount: " Use from 6 to 50 characters for your password ",
        //password-end

        // phone-start
        PhoneMin: " Use from 9 to 13 characters for your phonenumber ",
        PhoneMax: " Use from 9 to 13 characters for your phonenumber ",
        // phone-end
        NoEmail: " Enter email ",
        NoRole: " Select role ",
        NoImage: "You must choose an image ",
        validEmail: "Valid email required ",
        validPhone: "Valid phone required ",
        duplicateUsername: "Duplicate username.",
        duplicatePhone: "Duplicate phone number.",
        duplicateEmail: "Duplicate email.",
        ValidUsername: "Valid characters required ",
        ValidFullName: "Valid characters required "
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
        NoRole: "",
        NoImage: "",
        validEmail: "",
        validPhone: "",
        duplicateUsername: "",
        duplicatePhone: "",
        duplicateEmail: "",
        ValidUsername: "",
        ValidFullName: ""
      },
      account: {
        username: "",
        imageUrl: "",
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
    async createAccount1() {
      //   if (this.account.username === "") {
      //     this.CreateAccountErrors.NoUsername = this.ErrorStrings.NoUsername;
      //   }

      // let phoneRegex = /^(\([0-9]{3}\)\s*|[0-9]{3}\-)([0-9]{7}|[0-9]{8}|[0-9]{9})$/;
      let emailRegex = /^(([^<>()\[\]\\.,;!#$%:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      // let UsernameRegex = /[ !@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/g;
      // let UsernameRegex = /^[^~`!#$%@()\^&*+=\-\[\]\\';,/{}|\\":<>\?]*.[\s{1,}]*?$/;
      let UsernameRegex = /^[^~`!#$%@()\^&*+=\-\[\]\\';,/{}|\\":<>\?]*?$/;
      let FullNameRegex = /^[^~`!#$%@0-9()\^&*+=\-\[\]\\';,/{}|\\":<>\?]*?$/;
      if (!this.files[0]) {
        this.CreateAccountErrors.NoImage = this.ErrorStrings.NoImage;
      }
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
      if (!UsernameRegex.test(this.account.username)) {
        this.CreateAccountErrors.ValidUsername = this.ErrorStrings.ValidUsername;
      } else {
        this.CreateAccountErrors.ValidUsername = "";
      }
      if (!FullNameRegex.test(this.account.fullname)) {
        this.CreateAccountErrors.ValidFullName = this.ErrorStrings.ValidFullName;
      } else {
        this.CreateAccountErrors.ValidFullName = "";
      }
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

      for (const account of this.accounts) {
        if (account.Username == this.account.username) {
          this.CreateAccountErrors.duplicateUsername = this.ErrorStrings.duplicateUsername;
          break;
        }
      }
      for (const account of this.accounts) {
        if (account.Phone == this.account.phone) {
          this.CreateAccountErrors.duplicatePhone = this.ErrorStrings.duplicatePhone;
          break;
        }
      }
      for (const account of this.accounts) {
        if (account.Email == this.account.email) {
          this.CreateAccountErrors.duplicateEmail = this.ErrorStrings.duplicateEmail;
          break;
        }
      }

      if (!this.account.roleid || this.account.roleid == "") {
        this.CreateAccountErrors.NoRole = this.ErrorStrings.NoRole;
      }
      if (!emailRegex.test(this.account.email)) {
        this.CreateAccountErrors.validEmail = this.ErrorStrings.validEmail;
      } else {
        this.CreateAccountErrors.validEmail = "";
      }
      // if (!phoneRegex.test(this.account.phone)) {
      //   this.CreateAccountErrors.validPhone = this.ErrorStrings.validPhone;
      // } else {
      //   this.CreateAccountErrors.validPhone = "";
      // }

      if (this.validateAccount()) {
        this.CreateAccountErrors.NoImage = "";
        let formData = new FormData();
        formData.append("api_key", "982394881563116");
        formData.append("file", this.files[0]);
        formData.append("public_id", this.files[0].name);
        formData.append("timestamp", moment().valueOf());
        formData.append("upload_preset", "ursbvd4a");

        let url = "https://api.cloudinary.com/v1_1/dmlopvmdy/image/upload";
        await this.axios
          .post(url, formData)
          .then(response => {
            if (response.status == 200) {
              this.imageUrl = response.data.url;
              this.axios
                .post("http://localhost:3000/api/account", {
                  account: this.account,
                  avatarimage: response.data.url
                })
                .then(res => {
                  alert("Add account successful");
                  this.$router.push("/account");
                });
            }
          })
          .catch(error => {
            console.log(error);
          });
      }
    },
    inputFileChange() {
      this.files = this.$refs.fileInput.files;
    },

    onFileChanged() {
      this.selectedFile = this.$refs.file.files[0];
    },
    getFilePath(file) {
      return window.URL.createObjectURL(file);
    },
    onUpload() {
      let formData = new FormData();
      formData.append("file", this.file);
      alert("in");
      this.axios.post(
        "https://api.cloudinary.com/v1_1/deanwflps/image/upload",
        formData
      );
      alert(this.selectedFile.name);
    },
    validateAccount() {
      return (
        // this.CreateAccountErrors.NoUsername === "" &&
        // this.CreateAccountErrors.NoPassword === "" &&
        // this.CreateAccountErrors.NoFullname === "" &&
        // this.CreateAccountErrors.NoPhone === "" &&
        this.CreateAccountErrors.UsernameMax === "" &&
        this.CreateAccountErrors.UsernameMin === "" &&
        this.CreateAccountErrors.ValidUsername == "" &&
        this.CreateAccountErrors.duplicateUsername == "" &&
        // this.CreateAccountErrors.UserNameTrim === "" &&
        this.CreateAccountErrors.MaxPassword === "" &&
        this.CreateAccountErrors.WeakAccount === "" &&
        this.CreateAccountErrors.FullNameMax === "" &&
        this.CreateAccountErrors.FullNameMin === "" &&
        this.CreateAccountErrors.ValidFullName == "" &&
        this.CreateAccountErrors.PhoneMax === "" &&
        this.CreateAccountErrors.PhoneMin === "" &&
        this.CreateAccountErrors.duplicatePhone == "" &&
        this.CreateAccountErrors.validPhone == "" &&
        this.CreateAccountErrors.NoEmail === "" &&
        this.CreateAccountErrors.validEmail == "" &&
        this.CreateAccountErrors.duplicateEmail == "" &&
        this.CreateAccountErrors.NoRole === "" &&
        this.CreateAccountErrors.NoImage == ""
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
      let isDupUsername = false;
      for (const account in this.accounts) {
        if (account.Username == this.account.username) {
          isDupUsername = true;
          break;
        }
      }
      if (!isDupUsername) {
        this.CreateAccountErrors.duplicateUsername = "";
      }

      if (this.account.username == this.UsernameRegex) {
        this.CreateAccountErrors.ValidUsername = "";
      }
      if (this.account.fullname == this.FullNameRegex) {
        this.CreateAccountErrors.ValidFullName = "";
      }

      // if (this.username && this.account.username.length > 0) {
      //   let tmpAccounts = [];
      //   for (const account of this.account.username) {
      //   }
      // }
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
      // if (this.account.phone == this.phoneRegex) {
      //   this.CreateAccountErrors.validPhone = "";
      // }
      let isDupPhone = false;
      for (const account in this.accounts) {
        if (account.Phone == this.account.phone) {
          isDupPhone = true;
          break;
        }
      }
      if (!isDupPhone) {
        this.CreateAccountErrors.duplicatePhone = "";
      }
    },
    "account.email": function() {
      if (this.account.email != "") {
        this.CreateAccountErrors.NoEmail = "";
      }
      if (this.account.email == this.emailRegex) {
        this.CreateAccountErrors.validEmail = "";
      }
      let isDupEmail = false;
      for (const account in this.accounts) {
        if (account.Email == this.account.email) {
          isDupEmail = true;
          break;
        }
      }
      if (!isDupEmail) {
        this.CreateAccountErrors.duplicateEmail = "";
      }
    },
    files: function() {
      if (
        !this.files[0] &&
        !this.files[0].name &&
        this.CreateAccountErrors.NoImage != ""
      ) {
        this.CreateAccountErrors.Image = "";
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
  grid-template-columns: 65% 35%;
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
  display: flex;
  justify-content: flex-end;
  /* align-content: center; */
}
.form-content {
  font-size: 0.9rem;
  position: fixed;
  max-height: 82.5%;
  width: 82%;
  overflow-y: auto;
  /* display: flex;
        flex-direction: column;  */
}

#btn-cancel {
  background-color: white;
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
.form-field-picture {
  padding: 1rem 3rem;
  border: none;
}
.file-upload {
  padding-left: 2rem;
}
.input_picture {
  padding: 1rem 3rem 1rem 3rem;
  outline: 1px dashed #a8a8a8fb;
  background-color: #f0efeffb;
  display: flex;
}
.file-cta {
  border: none;
  background-color: #a8a8a8fb;
  margin: auto;
}
</style>
