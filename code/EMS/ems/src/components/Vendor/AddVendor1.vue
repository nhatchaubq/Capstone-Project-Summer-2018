<template>
<div class="form"> 
    <!-- <form @submit.prevent="createVendor()"> -->
      <div class="form-title">
        <div class="form-title-start ">
          <div>
            Add New Vendor
          </div>
        </div>
          <div class="form-title-end">
                <router-link to='/vendor'>
                    <button id="btn-cancel" class="button" >Cancel</button>
                </router-link>
            <button id="btn-add"  class="button" v-on:click="createVendor()" >Create Vendor</button>
        </div>
      </div>
        <!-- <div class="form-title">
            <div class="form-title-start">
                Add New Vendor
            </div>
        </div> -->
        <div class="form-content">
            <div class="form-field">
                <div class="form-field-title">
                <strong>  Business name (required)</strong><span v-if="CreateVendorErrors.NoBusinessName != ''"> <span class="error-text">{{ CreateVendorErrors.NoBusinessName }}</span></span> <span v-if="CreateVendorErrors.BusinessNameMin != ''"> <span class="error-text">{{ CreateVendorErrors.BusinessNameMin }}</span></span> <span v-if="CreateVendorErrors.BusinessNameMax != ''"> <span class="error-text">{{ CreateVendorErrors.BusinessNameMax }}</span></span>
                </div>
                <div class="control has-icons-right" style="padding:8px">
                    <input v-model.trim="Vendor.BusinessName" class="input " type="text" placeholder="DPoint Company" >

                        <!-- <span class="icon is-small is-left">
                        <i class="fa fa-address-card"></i>
                        </span> -->
                        <!-- <span class="icon is-small is-right">
                        <i class="fa fa-check"></i>
                        </span> -->

                </div>
            </div>
            

        <div>
            <div class="form-field">
                <div class="form-field-title">
                <strong>Business address  (required)</strong><span v-if="CreateVendorErrors.NoBusinessAddress != ''"> <span class="error-text">{{ CreateVendorErrors.NoBusinessAddress }}</span></span> <span v-if="CreateVendorErrors.BusinessAddressMin != ''"> <span class="error-text">{{ CreateVendorErrors.BusinessAddressMin }}</span></span> <span v-if="CreateVendorErrors.BusinessAddressMax != ''"> <span class="error-text">{{ CreateVendorErrors.BusinessAddressMax }}</span></span>
            <div class="controlhas-icons-right" style="padding:8px">
                    <input v-model.trim="Vendor.BusinessAddress" class="input " type="text" placeholder="160/5 Tan Chanh Hiep, Quan 12, Ho Chi Minh">
                        <!-- <span class="icon is-small is-left">
                        <i class="fa fa-address-card"></i>
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
                     <strong>Website</strong> <span v-if="CreateVendorErrors.WebMax != ''"> <span class="error-text">{{ CreateVendorErrors.WebMax }}</span></span><span v-if="CreateVendorErrors.validWeb != ''"> <span class="error-text">{{ CreateVendorErrors.validWeb }}</span></span>
                </div>
                <div class="form-field-input">
                <div class="control has-icons-right" style="padding:8px">
                    <input v-model.trim="Vendor.Website" class="input " type="text" placeholder="www.d-point.co.jp" >
                        <!-- <span class="icon is-small is-left">
                        <i class="fa fa-firefox"></i>
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
                     <strong>Contact name (required)</strong><span v-if="CreateVendorErrors.NoContactName != ''"> <span class="error-text">{{ CreateVendorErrors.NoContactName }}</span></span> <span v-if="CreateVendorErrors.ContactNameMin != ''"> <span class="error-text">{{ CreateVendorErrors.ContactNameMin }}</span></span> <span v-if="CreateVendorErrors.ContactNameMax != ''"> <span class="error-text">{{ CreateVendorErrors.ContactNameMax }}</span></span> <span v-if="CreateVendorErrors.validContactName != ''"> <span class="error-text">{{ CreateVendorErrors.validContactName }}</span></span>
                </div>
                <div class="form-field-input">
                <div class="control  has-icons-right" style="padding:8px">
                    <input v-model.trim="Vendor.ContactName" class="input " type="text" placeholder="D point" >
                        <!-- <span class="icon is-small is-left">
                        <i class="fa fa-address-card"></i>
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
                    <strong>Email (required)</strong><span v-if="CreateVendorErrors.NoEmail != ''"> <span class="error-text">{{ CreateVendorErrors.NoEmail }}</span></span><span v-if="CreateVendorErrors.validEmail != ''"> <span class="error-text">{{ CreateVendorErrors.validEmail }}</span></span><span class="error-text" v-if="CreateVendorErrors.duplicateEmail != ''"> {{ CreateVendorErrors.duplicateEmail }}</span>    
                </div>
                <div class="form-field-input">
                <div class="control has-icons-right" style="padding:8px">
                    <input v-model.trim="Vendor.ContactEmail" class="input" type="email" placeholder="dpoint@gmail.com" >
                        <!-- <span class="icon is-small is-left">
                        <i class="fa fa-envelope"></i>
                        </span> -->

                    </div>
                </div>

            </div>
            
        </div>
       
        <div>

        </div>
        <div>
            <div class="form-field" >
                <div class="form-field-title ">
                     <strong>Description </strong>
                </div>   <span v-if="CreateVendorErrors.DesMax != ''"> <span class="error-text">{{ CreateVendorErrors.DesMax }}</span></span>  
                    <textarea  id="text-descrip" rows="4" cols="55" v-model.trim="Vendor.Description"   >
                    </textarea>
                <!-- <h3>{{account.startdate}}</h3> -->
            </div>
            
        </div>
        <!-- test -->
        <!-- <div>
            <div class="form-field" >
                <div class="form-field-title " v-bind:key="Vendor.Id" v-for="Vendor in Vendors">
                     <div>{{Vendor.ContactEmail}} </div>
                </div>   

            </div>
            
        </div> -->
        <!-- test-end -->

        <!-- <div class="form-title-end" style="margin-bottom:2rem">

        </div> -->

                <!-- <button id="btn-add" class="button" v-on:click="createAccount()">Create Account</button>
                <button id="btn-add" class="button" v-on:click="createAccountTrueEnd()">Create Account true end</button> -->
                <!-- <router-link to='/account/'>
                <button id="btn-add" class="button">Create Account</button>
                </router-link> -->
                
            <!-- </form> -->
    <!-- <div>&nbsp</div> -->
      </div>
    <!-- </form> -->
    </div>
</template>

<script>
import Server from "@/config/config.js";
export default {
  created() {
    let url = Server.VENDOR_API_PATH;
    this.axios.get(url).then(res => {
      let data = res.data;
      this.Vendors = data;
      // alert();
    });
  },
  data() {
    return {
      sending: false,
      ErrorStrings: {
        // NoBusinessName: "You must provide business name for this vendor",
        BusinessNameMin: " Use from 6 to 50 characters for your business name",
        BusinessNameMax: " Use from 6 to 50 characters for your business name",
        // NoBusinessAddress: "You must provide business address for this vendor",
        BusinessAddressMax:
          " Use from 6 to 50 characters for your business address",
        BusinessAddressMin:
          " Use from 6 to 50 characters for your business address",
        // NoContactName: "You must provide contact name for this vendor",
        ContactNameMin: " Use from 6 to 50 characters for your contact name ",
        ContactNameMax: " Use from 6 to 50 characters for your contact name ",

        WebMax: " Use 200 characters or fewer for your website",
        DesMax: " Use 500 characters or fewer for your description",

        NoEmail: " Enter email ",
        validEmail: "Valid email required",
        validWeb: "Valid website required",
        validContactName: "Valid characters required",
        duplicateEmail: "The email already exists"
      },
      CreateVendorErrors: {
        // NoBusinessName: "",
        BusinessNameMin: "",
        BusinessNameMax: "",
        // NoBusinessAddress: "",
        BusinessAddressMin: "",
        BusinessAddressMax: "",

        WebMax: "",
        // NoContactName: "",
        ContactNameMin: "",
        ContactNameMax: "",
        NoEmail: "",
        DesMax: "",
        validEmail: "",
        validWeb: "",
        validContactName: "",
        duplicateEmail: ""
      },
      Vendor: {
        BusinessName: "",
        BusinessAddress: "",
        Website: "",
        ContactName: "",
        ContactEmail: "",
        Description: ""
      }
    };
  },
  methods: {
    createVendor() {
      // let emailRegex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      let emailRegex = /^(([^<>()\[\]\\.,;!#$%:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      let webRegex = /^(?:(?:https?|ftp):\/\/)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/\S*)?$/;
      // let contactNameRegex = /^[^~`!#$%()0-9@\^&*+=\-\[\]\\';,/{}|\\":<>\?]*\s*?$/;
      let contactNameRegex = /^[^~`!#$%()0-9@\^&*+=\-\[\]\\';,/{}|\\":<>\?]*.[\s{1,}]*?$/;
      // let contactNameRegex = /^[a-zA-Z-a-eghik-vxyàáâãèéêìíòóôõùúýỳỹỷỵựửữừứưụủũợởỡờớơộổỗồốọỏịỉĩệểễềếẹẻẽặẳẵằắăậẩẫầấạảđ₫]+$/;
      if (this.Vendor.BusinessName.length < 6) {
        this.CreateVendorErrors.BusinessNameMin = this.ErrorStrings.BusinessNameMin;
      }
      if (this.Vendor.BusinessName.length > 50) {
        this.CreateVendorErrors.BusinessNameMax = this.ErrorStrings.BusinessNameMax;
      }
      // if (this.Vendor.BusinessAddress === "") {
      //   this.CreateVendorErrors.NoBusinessAddress = this.ErrorStrings.NoBusinessAddress;
      // }
      if (this.Vendor.BusinessAddress.length < 6) {
        this.CreateVendorErrors.BusinessAddressMin = this.ErrorStrings.BusinessAddressMin;
      }
      if (this.Vendor.BusinessAddress.length > 50) {
        this.CreateVendorErrors.BusinessAddressMax = this.ErrorStrings.BusinessAddressMax;
      }
      // if (this.Vendor.ContactName === "") {
      //   this.CreateVendorErrors.NoContactName = this.ErrorStrings.NoContactName;
      // }
      if (this.Vendor.ContactName.length < 6) {
        this.CreateVendorErrors.ContactNameMin = this.ErrorStrings.ContactNameMin;
      }
      if (this.Vendor.ContactName.length > 50) {
        this.CreateVendorErrors.ContactNameMax = this.ErrorStrings.ContactNameMax;
      }
      if (!contactNameRegex.test(this.Vendor.ContactName)) {
        this.CreateVendorErrors.validContactName = this.ErrorStrings.validContactName;
      } else {
        this.CreateVendorErrors.validContactName = "";
      }
      if (this.Vendor.Website.length > 200) {
        this.CreateVendorErrors.WebMax = this.ErrorStrings.WebMax;
      }
      if (this.Vendor.Description.length > 500) {
        this.CreateVendorErrors.DesMax = this.ErrorStrings.DesMax;
      }
      if (this.Vendor.ContactEmail == "") {
        this.CreateVendorErrors.NoEmail = this.ErrorStrings.NoEmail;
      }
      // test
      for (const Vendor of this.Vendors) {
        if (Vendor.ContactEmail == this.Vendor.ContactEmail) {
          this.CreateVendorErrors.duplicateEmail = this.ErrorStrings.duplicateEmail;
          break;
        }
      }

      // test-end
      if (!emailRegex.test(this.Vendor.ContactEmail)) {
        this.CreateVendorErrors.validEmail = this.ErrorStrings.validEmail;
      } else {
        this.CreateVendorErrors.validEmail = "";
      }
      if (!webRegex.test(this.Vendor.Website)) {
        this.CreateVendorErrors.validWeb = this.ErrorStrings.validWeb;
      } else {
        this.CreateVendorErrors.validWeb = "";
      }
      if (this.validateVendor())
        this.axios
          .post("http://localhost:3000/api/Vendor", {
            Vendor: this.Vendor
          })
          .then(res => {
            this.$router.push("/vendor");
          });
    },

    validateVendor() {
      return (
        // this.CreateVendorErrors.NoBusinessName === "" &&
        this.CreateVendorErrors.BusinessNameMin === "" &&
        this.CreateVendorErrors.BusinessNameMax === "" &&
        // this.CreateVendorErrors.NoBusinessAddress === "" &&
        this.CreateVendorErrors.BusinessAddressMin === "" &&
        this.CreateVendorErrors.BusinessAddressMax === "" &&
        // this.CreateVendorErrors.NoContactName === "" &&
        this.CreateVendorErrors.ContactNameMin === "" &&
        this.CreateVendorErrors.ContactNameMax === "" &&
        this.CreateVendorErrors.WebMax === "" &&
        this.CreateVendorErrors.DesMax === "" &&
        this.CreateVendorErrors.NoEmail === "" &&
        this.CreateVendorErrors.validEmail == "" &&
        this.CreateVendorErrors.validWeb == "" &&
        this.CreateVendorErrors.validContactName == "" &&
        this.CreateVendorErrors.duplicateEmail == ""
      );
    }
  },

  watch: {
    "Vendor.BusinessName": function() {
      // if (this.Vendor.BusinessName != "") {
      //   this.CreateVendorErrors.NoBusinessName = "";
      // }
      if (this.Vendor.BusinessName.length > 5) {
        this.CreateVendorErrors.BusinessNameMin = "";
      }
      if (this.Vendor.BusinessName.length < 51) {
        this.CreateVendorErrors.BusinessNameMax = "";
      }
    },
    "Vendor.BusinessAddress": function() {
      // if (this.Vendor.BusinessAddress != "") {
      //   this.CreateVendorErrors.NoBusinessAddress = "";
      // }
      if (this.Vendor.BusinessAddress.length > 5) {
        this.CreateVendorErrors.BusinessAddressMin = "";
      }
      if (this.Vendor.BusinessAddress.length < 51) {
        this.CreateVendorErrors.BusinessAddressMax = "";
      }
    },
    "Vendor.ContactName": function() {
      // if (this.Vendor.ContactName != "") {
      //   this.CreateVendorErrors.NoContactName = "";
      // }
      if (this.Vendor.ContactName.length > 5) {
        this.CreateVendorErrors.ContactNameMin = "";
      }
      if (this.Vendor.ContactName.length < 51) {
        this.CreateVendorErrors.ContactNameMax = "";
      }
      if (this.Vendor.ContactName == this.contactNameRegex) {
        this.CreateVendorErrors.validContactName = "";
      }
    },
    "Vendor.ContactEmail": function() {
      if (this.Vendor.ContactEmail != "") {
        this.CreateVendorErrors.NoEmail = "";
      }
      if (this.Vendor.ContactEmail == this.emailRegex) {
        this.CreateVendorErrors.validEmail = "";
      }
      let isDupEmail = false;
      for (const Vendor in this.Vendors) {
        if (Vendor.ContactEmail == this.Vendor.ContactEmail) {
          isDupEmail = true;
          break;
        }
      }
      if (!isDupEmail) {
        this.CreateVendorErrors.duplicateEmail = "";
      }
    },
    "Vendor.Website": function() {
      if (this.Vendor.Website.length < 201) {
        this.CreateVendorErrors.WebMax = "";
      }
      if (this.Vendor.Website == this.webRegex) {
        this.CreateVendorErrors.validWeb = "";
      }
    },
    "Vendor.Description": function() {
      if (this.Vendor.Description.length < 501) {
        this.CreateVendorErrors.DesMax = "";
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
#text-descrip {
  border: 0.5px solid;
  border-color: silver;
  border-width: 1px;
  border-radius: 5px;
  padding: 0.3rem;
  /* width: 100%; */
  margin: 0 0.5rem 0 0.5rem;
}
#text-descrip:hover {
  border: 1px solid grey;
}
</style>
