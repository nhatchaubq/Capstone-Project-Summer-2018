<template>
  <div class="form">
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
    <div class="form-content" >
      <div class="form-field-picture">
        <div class="form-field-title">
          <span><strong>Picture</strong></span><span v-if="CreateAccountErrors.NoImage != ''"> <span class="error-text">{{ CreateAccountErrors.NoImage }}</span></span>
        </div>
        <div class="input_picture">                    
          <label class="file-label" style="width: 100% !important"> 
            <span class="file-cta">
              <input class="file-input" type="file" accept=".png, .jpg, .jpeg" ref="fileInput" style="opacity:0" v-on:change="inputFileChange"  />
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
            <strong>Username (required)</strong> <span v-if="CreateAccountErrors.UsernameMin != ''"> <span></span> <span class="error-text">{{ CreateAccountErrors.UsernameMin }}</span></span>  <span v-if="CreateAccountErrors.UsernameMax != ''"> <span></span> <span class="error-text">{{ CreateAccountErrors.UsernameMax }}</span></span><span v-if="CreateAccountErrors.UserNameTrim != ''"> <span></span> <span class="error-text">{{ CreateAccountErrors.UserNameTrim }}</span></span> <span class="error-text" v-if="CreateAccountErrors.duplicateUsername != ''"> {{ CreateAccountErrors.duplicateUsername }}</span> <span class="error-text" v-if="CreateAccountErrors.ValidUsername != ''"> {{ CreateAccountErrors.ValidUsername }}</span>
            <!-- <span v-if="CreateWorkOrderErrors.NoTitle != ''">. <span class="error-text">{{ CreateWorkOrderErrors.NoTitle }}</span></span> -->
          </div>
          <div class="control">
            <input v-model.trim="account.username" class="input " type="text" placeholder="ThanhNM" >
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
            <strong>Password (required)</strong> <span v-show="CreateAccountErrors.WeakAccount != ''"> <span class="error-text">{{ CreateAccountErrors.WeakAccount }}</span></span><span v-show="CreateAccountErrors.MaxPassword != ''"> <span class="error-text">{{ CreateAccountErrors.MaxPassword }}</span></span>
            <div class="control">
              <input v-model.trim="account.password" class="input " type="password" placeholder="Password" name="password" id="password">
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
            <strong>Fullname (required)</strong> <span v-if="CreateAccountErrors.FullNameMax != ''"> <span class="error-text">{{ CreateAccountErrors.FullNameMax }}</span></span> <span v-if="CreateAccountErrors.FullNameMin != ''"> <span class="error-text">{{ CreateAccountErrors.FullNameMin }}</span></span><span v-if="CreateAccountErrors.ValidFullName != ''"> <span class="error-text">{{ CreateAccountErrors.ValidFullName }}</span></span>
          </div>
          <div class="form-field-input">
            <div class="control">
              <input v-model.trim="account.fullname" class="input " type="text" placeholder="Nguyễn Minh Thành" name="fullname" id="fullname">
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
            <strong>Phone (required)</strong> <span v-if="CreateAccountErrors.PhoneMax != ''"> <span class="error-text">{{ CreateAccountErrors.PhoneMax }}</span></span> <span v-if="CreateAccountErrors.PhoneMin != ''"> <span class="error-text">{{ CreateAccountErrors.PhoneMin }}</span></span><span v-if="CreateAccountErrors.validPhone != ''"> <span class="error-text">{{ CreateAccountErrors.validPhone }}</span></span><span v-if="CreateAccountErrors.duplicatePhone != ''"> <span class="error-text">{{ CreateAccountErrors.duplicatePhone }}</span></span>
          </div>
          <div class="form-field-input">
            <div class="control">
              <input v-model.trim="account.phone" class="input " type="text" placeholder="0633824936" name="phone" id="phone">
            </div>
          </div>
        </div>
      </div>
      <div>
        <div class="form-field">
          <div class="form-field-title">
            <strong>Email (required)</strong> <span v-if="CreateAccountErrors.NoEmail != ''"> <span class="error-text">{{ CreateAccountErrors.NoEmail }}</span></span><span v-if="CreateAccountErrors.validEmail != ''"> <span class="error-text">{{ CreateAccountErrors.validEmail }}</span></span><span v-if="CreateAccountErrors.duplicateEmail != ''"> <span class="error-text">{{ CreateAccountErrors.duplicateEmail }}</span></span> <span v-if="CreateAccountErrors.EmailMax != ''"> <span class="error-text">{{ CreateAccountErrors.EmailMax }}</span></span>
          </div>
          <div class="form-field-input">
            <div class="control">
              <input v-model.trim="account.email" class="input"  type="text" placeholder="DPoint@gmail.com"  >
            </div>
          </div>
        </div>
      </div>            
      <div>
        <div class="form-field">
          <div class="form-field-title" >
            <strong>Role (required)</strong><span v-if="CreateAccountErrors.NoRole != ''"> <span class="error-text">{{ CreateAccountErrors.NoRole }}</span></span>
          </div> 
          <div class="field is-horizontal" >
            <model-select style="width: 100% !important; margin-bottom:12rem" :options="roleOptions" v-model="account.roleid" placeholder="Select a role"></model-select>                     
          </div>
        </div>            
      </div>
    </div>
    <simplert :useRadius="true" :useIcon="true" ref="simplert2"></simplert>
  </div>
</template>

<script>
import VueBase64FileUpload from "vue-base64-file-upload";
import { ModelSelect } from "vue-search-select";
import moment from "moment";
import Simplert from "vue2-simplert";
import Utils from "@/utils.js";
export default {
  components: {
    Simplert,
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
      imageUrl: "",
      files: [],
      accounts: [],
      sending: false,
      ErrorStrings: {
        FullNameMax: " Use from 6 to 250 characters for your full name ",
        FullNameMin: " Use from 6 to 250 characters for your full name ",
        UsernameMax: " Use from 6 to 50 characters for your  username ",
        UsernameMin: " Use from 6 to 50 characters for your username ",
        MaxPassword: " Use from 6 to 50 characters for your password ",
        WeakAccount: " Use from 6 to 50 characters for your password ",
        PhoneMin: " Use from 10 to 17 characters for your phone number",
        PhoneMax: " Use from 10 to 17 characters for your phone number",
        NoEmail: " Please enter email ",
        NoRole: " Please select role ",
        NoImage: " You must choose an image ",
        validEmail: " Email is invalid",
        validPhone: " Phone number is invalid",
        duplicateUsername: "This username already belongs to another account.",
        duplicatePhone:
          " This phone number already belongs to another account.",
        duplicateEmail: " This email already belongs to another account.",
        ValidUsername: " Username cannot contain special character ",
        ValidFullName: " Fullname cannot contain special character ",
        EmailMax: "Use 250 characters or fewer for your email "
      },
      CreateAccountErrors: {
        UsernameMax: "",
        UsernameMin: "",
        UserNameTrim: "",
        WeakAccount: "",
        MaxPassword: "",
        FullNameMax: "",
        FullNameMin: "",
        PhoneMin: "",
        PhoneMax: "",
        NoEmail: "",
        NoRole: "",
        NoImage: "",
        validEmail: "",
        validPhone: "",
        duplicateUsername: "",
        duplicatePhone: "",
        duplicateEmail: "",
        ValidUsername: "",
        ValidFullName: "",
        EmailMax: ""
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
      let emailRegex = /^(([^<>()\[\]\\.,;!#$%:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      let UsernameRegex = /^[^~`!#$%@()\^&*+=\-\[\]\\';,/{}|\\":<>\?]*?$/;
      let FullNameRegex = /^[^~`!#$%@0-9()\^&*+=\-\[\]\\';,/{}|\\":<>\?]*?$/;
      let phoneRegex = /^\(?[+]?([0-9]{2,4})\)?[-. ]?([0-9]{3,4})[-. ]?([0-9]{3,7})$/;
      if (this.account.username.length < 6) {
        this.CreateAccountErrors.UsernameMin = this.ErrorStrings.UsernameMin;
      }
      if (this.account.username.length > 50) {
        this.CreateAccountErrors.UsernameMax = this.ErrorStrings.UsernameMax;
      }
      if (this.account.password.length < 6) {
        this.CreateAccountErrors.WeakAccount = this.ErrorStrings.WeakAccount;
      }
      if (this.account.password.length > 50) {
        this.CreateAccountErrors.MaxPassword = this.ErrorStrings.MaxPassword;
      }
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
      if (
        this.account.fullname.length < 6 ||
        this.account.fullname.length > 250
      ) {
        this.CreateAccountErrors.FullNameMin = this.ErrorStrings.FullNameMin;
      }
      if (this.account.phone.length < 10 || this.account.phone.length > 17) {
        this.CreateAccountErrors.PhoneMin = this.ErrorStrings.PhoneMin;

        //  } else if (!phoneRegex.test(this.account.phone)) {
      } else if (
        this.account.phone.length > 9 &&
        this.account.phone.length < 18 &&
        !phoneRegex.test(this.account.phone)
      ) {
        this.CreateAccountErrors.validPhone = this.ErrorStrings.validPhone;
      } else {
        this.CreateAccountErrors.validPhone = "";
        this.CreateAccountErrors.PhoneMin = "";
      }
      if (this.account.email.length > 250) {
        this.CreateAccountErrors.EmailMax = this.ErrorStrings.EmailMax;
      }
      if (this.account.email === "") {
        this.CreateAccountErrors.NoEmail = this.ErrorStrings.NoEmail;
      } else if (!emailRegex.test(this.account.email)) {
        this.CreateAccountErrors.validEmail = this.ErrorStrings.validEmail;
      } else {
        this.CreateAccountErrors.validEmail = "";
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
      if (this.validateAccount()) {
        this.imageUrl = "https://i.stack.imgur.com/l60Hf.png";
        if (this.files[0] && this.files[0].name) {
          let formData = new FormData();
          formData.append("api_key", "982394881563116");
          formData.append("file", this.files[0]);
          formData.append("public_id", this.files[0].name);
          formData.append("timestamp", moment().valueOf());
          formData.append("upload_preset", "ursbvd4a");
          let url = "https://api.cloudinary.com/v1_1/dmlopvmdy/image/upload";
          try {
            let uploadRespose = await this.axios.post(url, formData);
            if (uploadRespose.status == 200) {
              this.imageUrl = uploadRespose.data.url;
            }
          } catch (error) {
            console.log(error);
          }
        }
        this.axios
          .post("http://localhost:3000/api/account", {
            account: this.account,
            avatarimage: this.imageUrl
          })
          .then(async res => {
            let obj = {
              message: "Create new account successfully",
              type: "success",
              hideAllButton: true,
              showXclose: false
            };
            this.$refs.simplert2.openSimplert(obj);
            await Utils.sleep(1300);
            this.$router.push("/account");
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
        this.CreateAccountErrors.NoImage == "" &&
        this.CreateAccountErrors.EmailMax == ""
      );
    }
  },
  watch: {
    "account.username": function() {
      // if (this.account.username.trim() != "") {
      //   this.CreateAccountErrors.UserNameTrim = "";
      // }
      let UsernameRegex = /^[^~`!#$%@()\^&*+=\-\[\]\\';,/{}|\\":<>\?]*?$/;
      if (
        UsernameRegex.test(this.account.username) &&
        this.CreateAccountErrors.ValidUsername != ""
      ) {
        this.CreateAccountErrors.ValidUsername = "";
      }
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
      let FullNameRegex = /^[^~`!#$%@0-9()\^&*+=\-\[\]\\';,/{}|\\":<>\?]*?$/;
      if (
        FullNameRegex.test(this.account.fullname) &&
        this.CreateAccountErrors.ValidFullName != ""
      ) {
        this.CreateAccountErrors.ValidFullName = "";
      }

      if (
        this.account.fullname.length < 251 &&
        this.account.fullname.length > 5 &&
        this.CreateAccountErrors.FullNameMin != ""
      ) {
        this.CreateAccountErrors.FullNameMin = "";
      }
    },
    "account.phone": function() {
      let phoneRegex = /^\(?[+]?([0-9]{2,4})\)?[-. ]?([0-9]{3,4})[-. ]?([0-9]{3,7})$/;

      if (
        phoneRegex.test(this.account.phone) &&
        this.CreateAccountErrors.validPhone != ""
      ) {
        this.CreateAccountErrors.validPhone = "";
      }
      if (
        this.account.phone.length > 9 &&
        this.account.phone.length < 18 &&
        this.CreateAccountErrors.PhoneMin != ""
      ) {
        this.CreateAccountErrors.PhoneMin = "";
      }
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
      let emailRegex = /^(([^<>()\[\]\\.,;!#$%:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      if (this.account.email != "") {
        this.CreateAccountErrors.NoEmail = "";
      }
      if (
        emailRegex.test(this.account.email) &&
        this.CreateAccountErrors.validEmail != ""
      ) {
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
      if (this.account.email != "") {
        this.CreateAccountErrors.EmailMax = "";
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
  /* background-color: white; */
  padding: 0 !important;
}
.form-title {
  display: grid;
  grid-template-columns: 65% 35%;
  border-bottom: 1px solid #e0e0e0;
  padding: .5rem 2rem;
  box-shadow: 0px 3px 5px var(--shadow);
  z-index: 5;
}

.form-title-start {
  padding-top: .25rem;
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
  font-size: 1rem;
  position: fixed;
  max-height: 82.5%;
  width: 82%;
  overflow-y: auto;
  /* display: flex;
        flex-direction: column;  */
}
.error-text {
  font-size: 14px;
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
  padding: 1rem 2rem;
  width: 50%;
}

.form-field-title {
  font-size: 14px;  
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
  padding: 1rem 2rem;
  border: none;
}
.file-upload {
  padding-left: 2rem;  
}
.input_picture {
  padding: 1rem 2rem;
  outline: 1px dashed #a8a8a8fb;
  background-color: #f0efeffb;
  width: 50%;
}
.file-cta {
  border: none;
  background-color: #a8a8a8fb;
  margin: auto;
}
</style>
