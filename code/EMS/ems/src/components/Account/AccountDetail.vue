<template>

  <div v-if="account" >
    <router-link to="/account" v-if="authUser.Role =='Admin' || authUser.Role == 'Manager'">
      <a><span class="material-icons" style="position: relative; top: .4rem;">keyboard_arrow_left</span> Back to Accounts</a>
    </router-link>


<div class="grid-wrapper1">

  <div>

  <div>
  <img :src="account.AvatarImage? account.AvatarImage: 'https://i.stack.imgur.com/l60Hf.png' " :alt="account.Username" style="width: 100%; height: 20rem ">
</div>
<div v-if="editMode">
 
                         
</div>



<div>
  <div v-if="!editMode">
 <div style="font-size: 20px;margin-top:0.5rem; margin-bot:0.5rem"><strong>Team</strong></div>
  <div v-if="!teamAccount">
    This account has no team.
  </div>
  <div v-else>
    <table class="mytable" >

      <thead>
        <tr>

          <th ><strong>#</strong></th>
          <th ><strong>Team name </strong></th>
          <th><strong>Team role </strong></th>
        </tr>
      </thead>  
      <tbody>
          <tr  :key="team.Id" v-for="(team, index) in toDisplayData" v-on:click="gotoDetail(team.Id)" >
            <td width=7%>{{ 5*(currentPage -1) + (index + 1)}}</td>
            <td width=40%>{{team.Name? team.Name: "N/A" }}</td>
            <td width=15% v-if="team.TeamRole.TeamRole == 'Leader'"> <strong> <span style="color: var(--primary-color); font-size: 17px">Leader</span>   </strong> </td> 
            <td width=15% v-if="team.TeamRole.TeamRole == 'Member'"> <strong> <span style=" 20px; font-size: 17px ">Member</span> </strong> </td> 
          

          </tr>
      </tbody>
    </table>  

  <div v-if="teamAccount.length >4">
    <Page :current="currentPage" :total="teamAccount.length" show-elevator  
      @on-change="(newPageNumber) => {
        currentPage = newPageNumber
        let start = 5 * (currentPage - 1);
        let end = start + 5;
        
        toDisplayData = teamAccount.slice(start, end);
      }">
    </Page>
  </div>    

  </div>
</div>
</div>            


  </div>

<div class="material-box">
<div class="row" style="margin: 0 !important">
 
  <h2 class="col-6" v-if="authUser.Role !='Admin' && !editMode" style="padding: 0 !important"><strong style="text-transform: uppercase;  font-size: 20px; color: #26a69a;" >{{account.Username}}</strong>  </h2>
  <h2 class="col-12" v-if="authUser.Role !='Admin' && editMode"  style="padding: 0 !important"><strong style="text-transform: uppercase;  font-size: 20px; color: #26a69a;" >{{account.Username}}</strong>  </h2>
  <!-- <h2 class="col-12" v-if="authUser.Role !='Admin' && editMode"  style="padding: 0 !important"><strong style="text-transform: uppercase;  font-size: 20px; color: #26a69a;" >{{account.Username}}</strong>  <span v-if="editMode" > <strong style="color: #26a69a;font-size: 20px;"> - EDIT INFORMATION</strong> </span></h2> -->
  <div class="col-6 row" style="padding: 0rem !important" v-if ="!editMode && authUser.Role !='Admin'">
    <button class="button btn-edit btn-primary material-shadow-animate " style="margin-bottom:0.2rem !important; position: absolute; right: 4rem;"  v-on:click="gotoDetailP(account.Id, account.Username, account.Password )" v-if="authUser.Id == account.Id && authUser.Role !='Admin'">Change Password</button>
    <button class="button btn-edit btn-primary material-shadow-animate " style="margin-left:0.5rem !important; position: absolute; right: 0rem;" v-on:click="editMode = !editMode" v-if="authUser.Role =='Admin' || authUser.Id == account.Id">Edit</button>
  </div>
  <h2 class="col-11" v-if="authUser.Role =='Admin'" style="padding: 0 !important"><strong style="text-transform: uppercase;  font-size: 20px; color: #26a69a;" >{{account.Username}}</strong> </h2>
  <div class="col-1 row" style="padding: 0rem !important " v-if ="!editMode && authUser.Role =='Admin'">
    <button class="button btn-edit btn-primary material-shadow-animate " style="margin-bottom:0.2rem !important; float: right !important"  v-on:click="gotoDetailP(account.Id, account.Username, account.Password )" v-if="authUser.Id == account.Id && authUser.Role !='Admin'">Change Password</button>
    <button class="button btn-edit btn-primary material-shadow-animate " style="margin-left:0rem !important; float: right !important" v-on:click="editMode = !editMode" v-if="authUser.Role =='Admin' || authUser.Id == account.Id">Edit</button>
  </div>
</div>

  <div  class="row " style="height: 36px" >
      <div class="col-12" style="margin-top:0.5rem" >
      <strong>Full name</strong>   <span v-if="CreateAccountErrors.FullNameMax != ''"> <span class="error-text">{{ CreateAccountErrors.FullNameMax }}</span></span> <span v-if="CreateAccountErrors.FullNameMin != ''"> <span class="error-text">{{ CreateAccountErrors.FullNameMin }}</span></span><span v-if="CreateAccountErrors.ValidFullName != ''"> <span class="error-text">{{ CreateAccountErrors.ValidFullName }}</span></span>
      </div>  
  </div>
  <input v-if="!editMode" disabled v-model="account.Fullname" class="input col-7 " type="text"  placeholder="James Cole"/>
  <input v-else :disabled="authUser.Role != 'Admin'" v-model.trim="account.Fullname" class="input col-7 " type="text"  placeholder="James Cole" >
  <div v-if="authUser.Role == 'Admin'">
    <div v-if="editMode" class="row" style="margin-top:0.5rem;  height: 36px">
        <div class="col-12" style="margin-top:0.5rem"> <strong>Password</strong>  <span v-if="editMode"><strong style="color:red"> *</strong></span> <span v-show="CreateAccountErrors.WeakAccount != ''"> <span class="error-text">{{ CreateAccountErrors.WeakAccount }}</span></span><span v-show="CreateAccountErrors.MaxPassword != ''"> <span class="error-text">{{ CreateAccountErrors.MaxPassword }}</span></span> </div> 
    </div>
      <input v-if="editMode" v-model.trim ="account.Password" class="input col-7 " type="password"  placeholder="Chow@321">
  </div>




  <div class="row" style="margin-top:0.5rem; height: 36px" v-if="authUser.Role =='Admin' ">
    <div class=" col-12" style="margin-top:0.5rem">
      <strong>
        Status 
      </strong>
    </div>
  </div >
  <div class="col-7" style="padding-left: 0 !important" v-if="authUser.Role =='Admin' ">
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
  <div class="col-12" style="margin-top:0.5rem"> <strong>Email</strong> <span v-if="editMode"> <strong style="color:red"> *</strong> <span v-if="CreateAccountErrors.NoEmail != ''"> <span class="error-text">{{ CreateAccountErrors.NoEmail }}</span></span>  <span v-if="CreateAccountErrors.validEmail != ''"> <span  class="error-text">{{ CreateAccountErrors.validEmail }}</span></span> <span v-if="CreateAccountErrors.duplicateEmail != ''"> <span class="error-text">{{ CreateAccountErrors.duplicateEmail }}</span></span> </span>  </div> 
  
</div>
  <input v-if="!editMode" v-model="account.Email" class="input col-7 " type="email"  placeholder="DPoint@gmail.com" disabled="disabled">
  <input v-else v-model.trim="account.Email" class="input col-7 " type="email"  placeholder="DPoint@gmail.com">
<div class="row" style="margin-top:0.5rem; height: 36px">
  <div class="col-12" style="margin-top:0.5rem"> <strong>Phone</strong> <span v-if="editMode"><strong style="color:red"> *</strong> <span v-if="CreateAccountErrors.PhoneMin != ''"> <span class="error-text">{{ CreateAccountErrors.PhoneMin }}</span></span>  <span v-if="CreateAccountErrors.PhoneMax != ''"> <span class="error-text">{{ CreateAccountErrors.PhoneMax }}</span></span> <span v-if="CreateAccountErrors.duplicatePhone != ''"> <span class="error-text">{{ CreateAccountErrors.duplicatePhone }}</span></span></span></div>
  <!-- <div class="col-12" style="margin-top:0.5rem"> <strong>Phone</strong> <span v-if="editMode"><strong style="color:red"> *</strong> <span v-if="CreateAccountErrors.PhoneMin != ''"> <span class="error-text">{{ CreateAccountErrors.PhoneMin }}</span></span>  <span v-if="CreateAccountErrors.PhoneMax != ''"> <span class="error-text">{{ CreateAccountErrors.PhoneMax }}</span></span>   <span v-if="CreateAccountErrors.validPhone != ''"> <span class="error-text">{{ CreateAccountErrors.validPhone }}</span></span><span v-if="CreateAccountErrors.duplicatePhone != ''"> <span class="error-text">{{ CreateAccountErrors.duplicatePhone }}</span></span></span></div> -->

</div>
  <input v-if="!editMode" v-model="account.Phone" class="input col-7 " type="number"  placeholder="123456789" disabled="disabled">
  <input v-else v-model.trim="account.Phone" class="input col-7 " type="number"  placeholder="123456789">

 <div v-if="editMode">

<div class="row" style="margin-top:0.5rem; height: 36px">
  <div class="col-12" style="margin-top:0.5rem"> <strong>Picture</strong>  </div> 
</div>
                <div class="">                  
                  <label class="file-label"  > 
                  <span class="file-cta">
                      <input v-if="!editMode" class="file-input" type="file" accept="image/*" style="opacity:0" ref="fileInput"  disabled="disabled" />
                      <input v-else class="file-input" type="file" accept="image/*"  style="opacity: 0" ref="fileInput" v-on:change="inputFileChange" />
                      <span class="file-icon" style="margin-right=0;">
                          <i class="fa fa-upload"></i>
                      </span>
                      <span class="file-label">
                                Choose images...
                      </span>
                  </span>
                      <div class="file-upload" v-bind:key="file.name" v-for="file in files" style="width: 100% !important; margin-top:0.5rem">
                          {{ file.name }}
                      </div>
                  </label>              
                </div>
 </div>




 
 
 
 
 
 
 <div class="row" style="margin-top:0.5rem; height: 36px">
    <div class="col-12" > <strong>Role</strong> </div>
  </div>
  <div v-if="account.SystemRole" class="col-7" style="padding-left: 0 !important;"> {{account.SystemRole.Name}}</div>
  <div class="row" style="margin-top:0.5rem; height: 36px">
    <div class="col-12"> <strong>Start date</strong>  </div>
  </div>
  <div class="col-7" style="padding-left: 0 !important;"> {{account.StartDate ? getDate(account.StartDate): 'N/A' }}</div>

<div class="row" v-if="editMode">
 
  <button class="button btn-confirm-edit btn-primary material-shadow-animate"  v-on:click="editAccount()" >Save changes</button>
    <button v-if="editMode" class="button btn-cancel btn-primary material-shadow-animate" v-on:click="() => {
        this.CreateAccountErrors.validEmail = false;
         getAccountDetail($route.params.id);
         editMode = false;

      }">Cancel</button>
</div>


      <modal v-model="ChangeLeadPopUp" style="font-family: Roboto">
          <div slot="header" style="font-weight: bold">
                Change Your Password
            </div>
            <div style="font-size: 1rem">
                <div >
                   
                  

                    <div class="row" style="margin-bottom:0.4rem">
                        <div class="col-3" style="margin-top:0.4rem; text-align: right !important;font-weight: bold">Current </div>

                      <input v-model="currentPassInput"  class="input col-7 " type="password"   placeholder="Chow@321" >
        
        
                    </div>
                    <div style="margin-left:8rem" v-if="CreatePassErrors.NotSameOldPass != ''"> <span class="error-text">{{ CreatePassErrors.NotSameOldPass }}</span></div>
                    
                    <div class="row" style="margin-bottom:0.4rem">
                      <div class="col-3" style="margin-top:0.4rem; text-align: right !important;font-weight: bold">New </div>
                      
                        <input v-model.trim="SelectedMemberPassword1"  class="input col-7 " type="password"  placeholder="Chow@321" >
  
                    </div>
                   <div style="margin-left:8rem" v-if="CreatePassErrors.MinMaxNewPass != ''"> <span class="error-text">{{ CreatePassErrors.MinMaxNewPass }}</span></div>
                    <div class="row" style="margin-bottom:0.4rem">
                      <div class="col-3" style="margin-top:0.4rem; text-align: right !important;font-weight: bold">Retype new </div>
                        <input v-model.trim="retypePass"  class="input col-7 " type="password"  placeholder="Chow@321" >
                    </div>
                    <div style="margin-left:8rem" v-if="CreatePassErrors.NotSameValueRe != ''"> <span class="error-text">{{ CreatePassErrors.NotSameValueRe }}</span></div>
                </div>
            </div>
            <div slot="footer">
        <button class="button btn-edit material-shadow-animate "  style="background-color:white; color: black; margin-left: 3rem; border-color: silver" v-on:click="cancel" >Cancel</button>
                   <button class="button btn-edit btn-primary material-shadow-animate "  style="margin-left: 1rem" v-on:click="changePass(SelectedMemberId,SelectedMemberPassword1)">Change</button>
            </div>
      </modal> 



      <modal v-model="showOkPopup"  style="font-family: Roboto">
          <div slot="header" style="font-weight: bold">
                Saved changed
            </div>
            <div style="font-size: 1rem">
                <div >
                   
                    <div>Update successfully</div>
                </div>
            </div>
            <div slot="footer">
        <button class="button btn-primary btn-edit material-shadow-animate "   v-on:click="ok" >Close</button>
                  
            </div>
      </modal>

         



  </div>
  




  </div>  



  </div>
</template>

<script>
import moment from "moment";
export default {
  computed: {
    data1() {
      let array = [];
      for (var i = 0; i < 100; i++) {
        array.push(i);
      }
      return array;
    },
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    }
  },
  components: {
    moment
  },
  created() {
    this.getAccountDetail(this.$route.params.id);
    this.getAllTeamOfThisAccount(this.$route.params.id);
    this.axios.get("http://localhost:3000/api/account").then(res => {
      this.existedAccounts = [];
      res.data.forEach(value => this.accounts.push(value.Account));
    });
  },

  data() {
    return {
      showOkPopup: false,
      accounts: [],
      currentPassInput: "",
      retypePass: "",
      SelectedMemberPassword1: "",
      // currentPass = author.Password,
      SelectedMemberId: null,
      SelectedMemberName: "",
      SelectedMemberPassword: "",
      files: [],
      currentPage: 1,
      teamAccount: [],
      toDisplayData: [],
      NewPassWord1: "",
      ChangeLeadPopUp: false,
      sending: false,
      ErrorStrings: {
        // NoUsername: 'You must provide username for this account',
        // NoFullname: "You must provide full name for this account",
        FullNameMax: " Use from 6 to 50 characters for your full name ",
        FullNameMin: " Use from 6 to 50 characters for your full name ",
        ValidFullName: "Valid characters required ",

        // NoPassword: "You must provide password for this account",
        MaxPassword: " Use from 6 to 50 characters for your password ",
        WeakAccount: " Use from 6 to 50 characters for your password ",

        // NoPhone: "You must provide phone number for this account",
        PhoneMin: " Use from 9 to 13 characters for your phone number ",
        PhoneMax: " Use from 9 to 13 characters for your phone number ",
        duplicatePhone: "Duplicate phone number.",
        validPhone: "Valid phone required ",

        NoEmail: " Enter email ",
        validEmail: "Valid email required ",
        duplicateEmail: "Duplicate email.",

        NotSameOldPass: "Enter correct current password ",
        MinMaxNewPass: "Use from 6 to 50 characters for your new password ",

        // NoImage: "You must choose an image",
        // NoRole: "You must provide role for this account"
        // NotSamePass: "pass not the same",
        NotSameValueRe: "Please enter the same value again. "
      },
      CreatePassErrors: {
        NotSameOldPass: "",
        NotSameValueRe: "",
        MinMaxNewPass: ""
      },
      CreateAccountErrors: {
        // NoUsername: '',
        // NoFullname: "",
        FullNameMax: "",
        FullNameMin: "",
        ValidFullName: "",
        // NotSamePass: "",

        // NoPassword: "",
        WeakAccount: "",
        MaxPassword: "",

        // NoPhone: "",
        PhoneMin: "",
        PhoneMax: "",
        duplicatePhone: "",
        validPhone: "",

        NoEmail: "",
        validEmail: "",
        duplicateEmail: ""
        // NoImage: ""
        // NoRole: ""
      },
      account: {
        fullname: "",
        imageUrl: "",
        password: "",
        phone: "",
        email: ""
      },
      checkedActive: [],
      editMode: false
    };
  },
  methods: {
    async editAccount() {
      // if(this.account.username === ''){
      //     this.CreateAccountErrors.NoUsername = this.ErrorStrings.NoUsername;
      // }
      // if (this.account.Fullname === "") {
      //   this.CreateAccountErrors.NoFullname = this.ErrorStrings.NoFullname;
      // }
      // if (!this.files[0]) {
      //   this.CreateAccountErrors.NoImage = this.ErrorStrings.NoImage;
      // }
      // let phoneRegex = /^(\([0-9]{3}\)\s*|[0-9]{3}\-)([0-9]{7}|[0-9]{8}|[0-9]{9})$/;
      let emailRegex = /^(([^<>()\[\]\\.,;!#$%:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      let FullNameRegex = /^[^~`!#$%@0-9()\^&*+=\-\[\]\\';,/{}|\\":<>\?]*?$/;
      if (this.account.Fullname.length < 6) {
        this.CreateAccountErrors.FullNameMin = this.ErrorStrings.FullNameMin;
      }
      if (this.account.Fullname.length > 50) {
        this.CreateAccountErrors.FullNameMax = this.ErrorStrings.FullNameMax;
      }
      if (!FullNameRegex.test(this.account.Fullname)) {
        this.CreateAccountErrors.ValidFullName = this.ErrorStrings.ValidFullName;
      } else {
        this.CreateAccountErrors.ValidFullName = "";
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
      for (const account of this.accounts) {
        if (
          account.Id != this.account.Id &&
          account.Phone == this.account.Phone
        ) {
          this.CreateAccountErrors.duplicatePhone = this.ErrorStrings.duplicatePhone;
          break;
        }
      }
      for (const account of this.accounts) {
        if (
          account.Id != this.account.Id &&
          account.Email == this.account.Email
        ) {
          this.CreateAccountErrors.duplicateEmail = this.ErrorStrings.duplicateEmail;
          break;
        }
      }
      if (!emailRegex.test(this.account.Email)) {
        this.CreateAccountErrors.validEmail = this.ErrorStrings.validEmail;
      } else {
        this.CreateAccountErrors.validEmail = "";
      }
      // if (!phoneRegex.test(this.account.Phone)) {
      //   this.CreateAccountErrors.validPhone = this.ErrorStrings.validPhone;
      // } else {
      //   this.CreateAccountErrors.validPhone = "";
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

      //       if (this.account.Password != this.SelectedMemberPassword) {
      //   this.CreateAccountErrors.NotSamePass = this.ErrorStrings.NotSamePass;
      // }

      if (this.validateAccount()) {
        let imageUrl = this.account.AvatarImage;

        if (this.files[0] && this.files[0].name) {
          let formData = new FormData();
          formData.append("api_key", "982394881563116");
          formData.append("file", this.files[0]);
          formData.append("public_id", this.files[0].name);
          formData.append("timestamp", moment().valueOf());
          formData.append("upload_preset", "ursbvd4a");

          let url = "https://api.cloudinary.com/v1_1/dmlopvmdy/image/upload";
          await this.axios
            .post(url, formData)
            .then(async res => {
              if (res.status == 200) {
                imageUrl = res.data.url;
              }
            })
            .catch(error => {
              this.$router.push("/500");
              console.log(error);
            });
        }
        await this.axios
          .put(`http://localhost:3000/api/account/${this.$route.params.id}`, {
            account: this.account,
            avatarimage: imageUrl
          })
          .then(async res => {
            // this.$router.push("/account");
            if (res.status == 200) {
              this.editMode = false;
              await this.getAccountDetail(this.$route.params.id);
              this.files = [];
              alert("update successfully");
            }
          });
      }
    },
    inputFileChange() {
      this.files = this.$refs.fileInput.files;
    },

    // onFileChanged() {
    //   this.selectedFile = this.$refs.file.files[0];
    // },
    getFilePath(file) {
      return window.URL.createObjectURL(file);
    },
    onUpload() {
      let formData = new FormData();
      formData.append("file", this.file);

      this.axios.post(
        "https://api.cloudinary.com/v1_1/deanwflps/image/upload",
        formData
      );
    },
    validateAccount() {
      return (
        // this.CreateAccountErrors.NoPassword === "" &&
        // this.CreateAccountErrors.NoFullname === "" &&
        this.CreateAccountErrors.FullNameMin === "" &&
        this.CreateAccountErrors.FullNameMax === "" &&
        this.CreateAccountErrors.ValidFullName == "" &&
        this.CreateAccountErrors.PhoneMin === "" &&
        this.CreateAccountErrors.PhoneMax === "" &&
        this.CreateAccountErrors.duplicatePhone == "" &&
        this.CreateAccountErrors.validPhone == "" &&
        // this.CreateAccountErrors.NoPhone === "" &&
        this.CreateAccountErrors.NoEmail === "" &&
        this.CreateAccountErrors.validEmail == "" &&
        this.CreateAccountErrors.duplicateEmail == "" &&
        //&& this.CreateAccountErrors.NoRole === ""
        this.CreateAccountErrors.WeakAccount === "" &&
        this.CreateAccountErrors.MaxPassword === ""

        // this.CreateAccountErrors.NoImage == ""

        //  && this.CreateAccountErrors.NoUsername === ''
      );
    },
    validatePass() {
      return (
        this.CreatePassErrors.NotSameOldPass == "" &&
        this.CreatePassErrors.NotSameValueRe == "" &&
        this.CreatePassErrors.MinMaxNewPass == ""
      );
    },
    getAccountDetail(accountId) {
      let URL = `http://localhost:3000/api/account/id/${accountId}`;
      this.axios.get(URL).then(response => {
        let data = response.data;
        this.account = data;
      });
    },

    changePass(Id, SelectedMemberPassword1) {
      if (this.currentPassInput != this.SelectedMemberPassword) {
        this.CreatePassErrors.NotSameOldPass = this.ErrorStrings.NotSameOldPass;
      }
      if (this.retypePass != this.SelectedMemberPassword1) {
        this.CreatePassErrors.NotSameValueRe = this.ErrorStrings.NotSameValueRe;
      }
      if (
        !this.SelectedMemberPassword1 ||
        (this.SelectedMemberPassword1 &&
          (this.SelectedMemberPassword1.length < 6 ||
            this.SelectedMemberPassword1.length > 50))
      ) {
        this.CreatePassErrors.MinMaxNewPass = this.ErrorStrings.MinMaxNewPass;
      }
      if (this.validatePass()) {
        let URLChange = "http://localhost:3000/api/changeYourPass";

        this.axios
          .put(URLChange, {
            tmpAcc: {
              id: Id,
              password: SelectedMemberPassword1
            }
          })
          .then(res => {
            if (res.status == 200) {
              this.getAccountDetail(this.$route.params.id);
              this.ChangeLeadPopUp = false;
              this.showOkPopup = true;
            }
          });
      }
    },
    getAllTeamOfThisAccount(accountId) {
      let URL = `http://localhost:3000/api/account/id/${accountId}`;
      this.axios.get(URL).then(response => {
        let data2 = response.data.Teams;
        this.teamAccount = data2;
        this.toDisplayData = this.teamAccount.slice(0, 5);
      });
    },
    getDate(date) {
      return moment(date).format("L");
    },
    gotoDetail(teamId) {
      this.$router.push(`/team/${teamId}`);
    },
    gotoDetailP(memberID, memberName, Password) {
      this.SelectedMemberId = memberID;
      this.SelectedMemberName = memberName;
      this.SelectedMemberPassword = Password;
      this.ChangeLeadPopUp = true;
    },
    cancel() {
      this.ChangeLeadPopUp = false;
    },
    ok() {
      this.showOkPopup = false;
    }
  },
  watch: {
    currentPassInput: function() {
      if (this.currentPassInput == this.SelectedMemberPassword) {
        this.CreatePassErrors.NotSameOldPass = "";
      }
    },
    SelectedMemberPassword1: function() {
      if (this.SelectedMemberPassword1.length > 5) {
        this.CreatePassErrors.MinMaxNewPass = "";
      }
      if (this.SelectedMemberPassword1.length < 51) {
        this.CreatePassErrors.MinMaxNewPass = "";
      }
    },
    retypePass: function() {
      if (this.retypePass == this.SelectedMemberPassword1) {
        this.CreatePassErrors.NotSameValueRe = "";
      }
    },
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
      // if (this.account.Phone == this.phoneRegex) {
      //   this.CreateAccountErrors.validPhone = "";
      // }
      let isDupPhone = false;
      for (const account of this.accounts) {
        if (
          account.Id != this.account.Id &&
          account.Phone == this.account.Phone
        ) {
          isDupPhone = true;
          break;
        }
      }
      if (!isDupPhone) {
        this.CreateAccountErrors.duplicatePhone = "";
      }
    },
    ChangeLeadPopUp: function() {
      if (!this.ChangeLeadPopUp) {
        this.SelectedMemberPassword1 = "";
        this.retypePass = "";
        this.currentPassInput = "";
      }
    },
    // files: function() {
    //   if (
    //     !this.files[0] &&
    //     !this.files[0].name &&
    //     this.CreateAccountErrors.NoImage != ""
    //   ) {
    //     this.CreateAccountErrors.Image = "";
    //   }
    // },
    "account.Email": function() {
      if (this.account.Email != "") {
        this.CreateAccountErrors.NoEmail = "";
      }
      if (this.account.Email == this.emailRegex) {
        this.CreateAccountErrors.validEmail = "";
      }
      let isDupEmail = false;
      for (const account of this.accounts) {
        if (
          account.Id != this.account.Id &&
          account.Email == this.account.Email
        ) {
          isDupEmail = true;
          break;
        }
      }
      if (!isDupEmail) {
        this.CreateAccountErrors.duplicateEmail = "";
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
  margin-left: 1rem;
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
}
.file-cta {
  border: none;
  background-color: #a8a8a8fb;
  margin: auto;
}
.file-label {
}
</style>
