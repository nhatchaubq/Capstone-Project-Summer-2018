<template>
<div v-if="Vendor" >
    <router-link to="/vendor">
      <a><span class="material-icons" style="position: relative; top: .4rem">keyboard_arrow_left</span> Back to Vendors</a>
    </router-link>
  <!-- <form @submit.prevent="editVendor()"> -->

  <div class="grid-wrapper1 col-12" style="margin-bottom:1rem">
    <div class="material-box" >
      <div class="row" style="margin: 0 !important; height:36px ">
        <h2 class="col-11" style="padding: 0.5rem 0 0 0 !important"><strong style="text-transform: uppercase;  font-size: 20px; color: #26a69a" >{{Vendor.BusinessName}}   </strong> </h2>
        <!-- <h2 class="col-11" style="padding: 0.5rem 0 0 0 !important"><strong style="text-transform: uppercase;  font-size: 20px; color: #26a69a" >{{Vendor.BusinessName}}  <span v-if="editMode" > <strong style="color: #26a69a">- Edit Information</strong> </span> </strong> </h2> -->
      <div style="padding: 0rem !important" class="col-1"  v-if="authUser.Role =='Equipment Staff'">
        <button  v-if="!editMode" class="button btn-edit btn-primary material-shadow-animate " v-on:click="editMode = !editMode">Edit</button>
      </div>
      </div>

        <div  class="row" style="height: 36px; margin-bottom: 0.5rem" >
          <div class="col-12" style="margin-top:0.5rem" >
            <strong>
              Business address 
            </strong>
            <span v-if="editMode"> (required)<span v-if="CreateVendorErrors.BusinessAddressMin != ''"> <span class="error-text">{{ CreateVendorErrors.BusinessAddressMin }}</span></span> <span v-if="CreateVendorErrors.BusinessAddressMax != ''"> <span class="error-text">{{ CreateVendorErrors.BusinessAddressMax }}</span></span></span>
          </div>
        </div>
          <input v-if="!editMode" v-model.trim="Vendor.BusinessAddress" class="input col-7 " type="text"  placeholder="160/5 Tan Chanh Hiep, Quan 12, Ho Chi Minh" disabled="disabled">
          <input v-else v-model.trim="Vendor.BusinessAddress" class="input col-7 " type="text"  placeholder="160/5 Tan Chanh Hiep, Quan 12, Ho Chi Minh" >
        <div  class="row" style="height: 36px; margin-bottom: 0.5rem" >
          <div class="col-12" style="margin-top:0.5rem" >
            <strong>
                Website 

            </strong>
            <span v-if="CreateVendorErrors.WebMax != ''"> <span class="error-text">{{ CreateVendorErrors.WebMax }}</span></span> <span v-if="editMode"><span v-if="CreateVendorErrors.validWeb != ''"> <span class="error-text">{{ CreateVendorErrors.validWeb }}</span></span></span>
          </div>
        </div>
          <input v-if="!editMode" v-model.trim="Vendor.Website" class="input col-7 " type="text"  placeholder="www.d-point.co.jp" disabled="disabled"> 
          <input v-else v-model.trim="Vendor.Website" class="input col-7 " type="text"  placeholder="www.d-point.co.jp" >
        <div  class="row" style="height: 36px; margin-bottom: 0.5rem" >
          <div class="col-12" style="margin-top:0.5rem;" >
            <strong>
              Contact name 

            </strong>
            <span v-if="editMode"> (required)<span v-if="CreateVendorErrors.ContactNameMin != ''"> <span class="error-text">{{ CreateVendorErrors.ContactNameMin }}</span></span> <span v-if="CreateVendorErrors.ContactNameMax != ''"> <span class="error-text">{{ CreateVendorErrors.ContactNameMax }}</span></span> <span v-if="CreateVendorErrors.validContactName != ''"> <span class="error-text">{{ CreateVendorErrors.validContactName }}</span></span></span>
          </div>
        </div>
          <input v-if="!editMode" v-model.trim="Vendor.ContactName" class="input col-7 " type="text"  placeholder="D point" disabled="disabled">
          <input v-else v-model.trim="Vendor.ContactName" class="input col-7 " type="text"  placeholder="D point" >
        <div  class="row" style="height: 36px; margin-bottom: 0.5rem" >
          <div class="col-12" style="margin-top:0.5rem"  >
            <strong>
              Contact email 

            </strong>
            <span v-if="editMode"> (required)<span v-if="CreateVendorErrors.NoEmail != ''"> <span class="error-text">{{ CreateVendorErrors.NoEmail }}</span></span><span v-if="CreateVendorErrors.duplicateEmail != ''"> <span class="error-text">{{ CreateVendorErrors.duplicateEmail }}</span></span></span>      
          </div>
        </div>
          <input v-if="!editMode" v-model.trim="Vendor.ContactEmail" class="input col-7 " type="email"  placeholder="dpoint@gmail.com" disabled="disabled">
          <input v-else v-model.trim="Vendor.ContactEmail" class="input col-7 " type="email"  placeholder="dpoint@gmail.com" >
        <div  class="row" style="height: 36px; margin-bottom: 0.5rem" >
          <div class="col-12" style="margin-top:0.5rem"  >
            <strong>
              Phone 

            </strong><span v-if="editMode"> (required)</span><span v-if="CreateVendorErrors.PhoneMin != ''"> <span class="error-text">{{ CreateVendorErrors.PhoneMin }}</span></span><span v-if="CreateVendorErrors.duplicatePhone != ''"> <span class="error-text">{{ CreateVendorErrors.duplicatePhone }}</span></span>
            
          </div>
        </div>
         <input v-if="!editMode" v-model.trim="Vendor.Phone" class="input col-7 " type="number"  placeholder="123456789" disabled="disabled">
          <input v-else v-model.trim="Vendor.Phone" class="input col-7 " type="number"  placeholder="123456789" >
          <div v-if="editMode"> 
          <strong>Status: </strong>
          <label style="margin-right: 0rem; margin-left: 1rem" class="radio"  >
            <input type="radio" name="active" v-on:change="Vendor.Status = true" :checked="Vendor.Status" :disabled="!editMode">
            Active
          </label>
          <label class="radio">
            <input type="radio" style="margin-top: 0.5rem" name="active" v-on:change="Vendor.Status = false" :checked="!Vendor.Status" :disabled="!editMode">
            Inactive
          </label>
        </div>

        <div  class="row" style="height: 36px; margin-bottom: 0.5rem" >
          <div class="col-12" style="margin-top:0.5rem" >
            <strong>
              Description 

            </strong>
            <span v-if="CreateVendorErrors.DesMax != ''"> <span class="error-text">{{ CreateVendorErrors.DesMax }}</span></span>  
          </div> 
        </div> 
          <input v-if="!editMode" v-model.trim="Vendor.Description" class="input col-7 " type="text"  placeholder="D-point is a small company ... " style="margin-bottom:1rem" disabled="disabled">
          <input v-else v-model.trim="Vendor.Description" class="input col-7 " type="text"  placeholder="D-point is a small company ... " >
        <div class="row" v-if="editMode">
          <button class="button btn-confirm-edit btn-primary material-shadow-animate"  v-on:click="editVendor()">Save change</button>
          <button class="button btn-cancel material-shadow-animate" v-on:click="() => {
        this.CreateVendorErrors.validEmail = false;
        this.CreateVendorErrors.validWeb = false;
        this.CreateVendorErrors.validContactName = false;
         reload($route.params.id);
         editMode = false;
      }">Cancel</button>
        </div>


 


    </div>
    
  </div>


    <!-- <div class="material-box" style="width: 50%"> 
        <div class="row">
          <h2 class="col-10" style="font-size: 30px; color: #3960A4">{{vendor.BusinessName}}</h2>
          <button class="button btn-edit btn-primary material-shadow-animate " v-on:click="$store.state.vendorPage.detailPage.editMode = !editMode">Edit</button>
        </div>

      <div class="row">
        <div class="col-4" >Business address</div>
        <div class="col-7"> {{vendor.BusinessAddress}} </div>
      </div>
      <div class="row">
        <div class="col-4" >Website</div>
        <div class="col-7"> {{vendor.Website}} </div>
      </div>
      <div class="row">
        <div class="col-4" >Contact name</div>
        <div class="col-7"> {{vendor.ContactName}} </div>
      </div>
      <div class="row">
        <div class="col-4" >Contact email</div>
        <div class="col-7"> {{vendor.ContactEmail}} </div>
      </div>
      <div class="row">
        <div class="col-4" >Description</div>
        <div class="col-7"> {{vendor.Description}} </div>
      </div>



    </div> -->
        <!-- test- start -->
  <div v-if="!editMode">
  <div class="grid-wrapper1 col-12">
    <div class="material-box">
      <!-- <div class="grid-wrapper1"> -->
        <!--
        <strong>Vendor's equipment (This vendor have {{Vendor.Equipment.Quantity}} equipment(s) and {{Vendor.EquipmentItems.Quantity}} equipment item(s) ) </strong> 
        <div v-if="Vendor.Equipments" >
          <div >

            <div :key="Equipment.Id" v-for="Equipment in Vendor.Equipments">
              <div class="row" style="height:40px; ">


                
                <router-link :to="`/equipment/${Equipment.Id}`">
                <div class="col-12">
                  <span>-</span> {{Equipment.Name}} <span>-</span> {{Equipment.MadeIn? Equipment.MadeIn : "N/A"}}
                </div>
                </router-link>

            </div>
          </div>
        </div>
      </div>
      -->


    <div v-if="!vendorItem">
      This vendor has no equipment in system.
    </div>
    <div v-else>
      <strong>Vendor's equipment (This vendor have {{Vendor.Equipment.Quantity}} equipment(s) and {{Vendor.EquipmentItems.Quantity}} equipment item(s) ) </strong> 
      <table class="mytable">
        <thead>
          <tr>
            <!-- <th><strong>ID</strong></th> -->
            <th style="width:3% !important"><strong>#</strong></th>
            <th style="width:47% !important"><strong>Equipment name </strong></th>
            <th style="width:15% !important"><strong>Made in</strong></th>
            <th style="width:20% !important"><strong>Equipment category</strong></th>



            <!-- <th><strong>Department</strong></th> -->
          </tr>
        </thead>  
        <tbody>
            <tr :key="Equipment.Id" v-for="(Equipment, index) in toDisplayData" class="txtText" v-on:click="gotoDetail(Equipment.Id)" >
              <td >{{index + 1}}</td>
              <td >{{Equipment.Name ? Equipment.Name : "N/A" }}</td>
              <td >{{Equipment.MadeIn ? Equipment.MadeIn : "N/A"}} </td>
              <td >{{Equipment.ecName ? Equipment.ecName : "N/A"}} </td>

            </tr>
        </tbody>
      </table>

<!-- test1 -->
  <div v-if="vendorItem.length >9" class="">
    <Page :current="1" :total="vendorItem.length" show-elevator 
      @on-change="(newPageNumber) => {
        let start = 10 * (newPageNumber - 1);
        let end = start + 10;
        
        toDisplayData = vendorItem.slice(start, end);
      }">
    </Page>
  </div>  
<!-- test1-end -->


      <!-- <router-link to='/vendor1/add/'>
        <button id="btn-add-vendor" class="button btn-primary material-shadow-animate">Add Vendor</button>
      </router-link> -->
    </div>
  </div>


<!--

         <div v-if="Vendor.EMayXayDung" >
          <div>
            Construction Machine
          </div>

            <div :key="Equipment.Id" v-for="Equipment in Vendor.EMayXayDung">
              <div class="row" style="height:40px; ">


                
                <router-link :to="`/equipment/${Equipment.Id}`">
                <div class="col-12">
                  <span>-</span> {{Equipment.Name}}
                </div>
                </router-link>


              </div>
            </div>
        </div>

        <div v-if="Vendor.EMayCoKhi" >
          <div>
            Mechanical Machine
          </div>
            <div :key="Equipment.Id" v-for="Equipment in Vendor.EMayCoKhi">
              <div class="row" style="height:40px; ">
                <router-link :to="`/equipment/${Equipment.Id}`">
                <div class="col-12">
                  <span>-</span> {{Equipment.Name}}
                </div>
                </router-link>
              </div>
            </div>
        </div>

        <div v-if="Vendor.EMayHan" >
          <div>
            Welder
          </div>
            <div :key="Equipment.Id" v-for="Equipment in Vendor.EMayHan">
              <div class="row" style="height:40px; ">
                <router-link :to="`/equipment/${Equipment.Id}`">
                <div class="col-12">
                  <span>-</span> {{Equipment.Name}}
                </div>
                </router-link>
              </div>
            </div>
        </div>

        <div v-if="Vendor.EMayNenKhi" >
          <div>
            compressor Machine
          </div>
            <div :key="Equipment.Id" v-for="Equipment in Vendor.EMayNenKhi">
              <div class="row" style="height:40px; ">
                <router-link :to="`/equipment/${Equipment.Id}`">
                <div class="col-12">
                  <span>-</span> {{Equipment.Name}}
                </div>
                </router-link>
              </div>
            </div>
        </div>

        <div v-if="Vendor.EMayBom" >
          <div>
            Pump Machine
          </div>
            <div :key="Equipment.Id" v-for="Equipment in Vendor.EMayBom">
              <div class="row" style="height:40px; ">
                <router-link :to="`/equipment/${Equipment.Id}`">
                <div class="col-12">
                  <span>-</span> {{Equipment.Name}}
                </div>
                </router-link>
              </div>
            </div>
        </div>

        <div v-if="Vendor.EMayFax" >
          <div>
            Fax Machine
          </div>
            <div :key="Equipment.Id" v-for="Equipment in Vendor.EMayFax">
              <div class="row" style="height:40px; ">
                <router-link :to="`/equipment/${Equipment.Id}`">
                <div class="col-12">
                  <span>-</span> {{Equipment.Name}}
                </div>
                </router-link>
              </div>
            </div>
        </div>

        <div v-if="Vendor.ECrane" >
          <div>
            Crane Machine
          </div>
            <div :key="Equipment.Id" v-for="Equipment in Vendor.ECrane">
              <div class="row" style="height:40px; ">
                <router-link :to="`/equipment/${Equipment.Id}`">
                <div class="col-12">
                  <span>-</span> {{Equipment.Name}}
                </div>
                </router-link>
              </div>
            </div>
        </div>

        <div v-if="Vendor.EExcavator" >
          <div>
            Excavator Machine
          </div>
            <div :key="Equipment.Id" v-for="Equipment in Vendor.EExcavator">
              <div class="row" style="height:40px; ">
                <router-link :to="`/equipment/${Equipment.Id}`">
                <div class="col-12">
                  <span>-</span> {{Equipment.Name}}
                </div>
                </router-link>
              </div>
            </div>
        </div>

        <div v-if="Vendor.EForklift" >
          <div>
            Forklift Machine
          </div>
            <div :key="Equipment.Id" v-for="Equipment in Vendor.EForklift">
              <div class="row" style="height:40px; ">
                <router-link :to="`/equipment/${Equipment.Id}`">
                <div class="col-12">
                  <span>-</span> {{Equipment.Name}}
                </div>
                </router-link>
              </div>
            </div>
        </div>

        <div v-if="Vendor.EDungCuDo" >
          <div>
            Measure Tools
          </div>
            <div :key="Equipment.Id" v-for="Equipment in Vendor.EDungCuDo">
              <div class="row" style="height:40px; ">
                <router-link :to="`/equipment/${Equipment.Id}`">
                <div class="col-12">
                  <span>-</span> {{Equipment.Name}}
                </div>
                </router-link>
              </div>
            </div>
        </div>

        <div v-if="Vendor.EDungCuDien" >
          <div>
            electric Tools
          </div>
            <div :key="Equipment.Id" v-for="Equipment in Vendor.EDungCuDien">
              <div class="row" style="height:40px; ">
                <router-link :to="`/equipment/${Equipment.Id}`">
                <div class="col-12">
                  <span>-</span> {{Equipment.Name}}
                </div>
                </router-link>
              </div>
            </div>
        </div>


-->
        
      <!-- </div> -->
    </div>
  </div>

    <!-- test end -->
 <!-- </form> -->
</div>
  
</template>

<script>
import Server from "@/config/config.js";
export default {
  computed: {
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    }
  },
  created() {
    let url = Server.VENDOR_API_PATH;
    this.axios.get(url).then(res => {
      this.Vendors = res.data;
    });
    let URL = `http://localhost:3000/api/vendor/${this.$route.params.id}`;
    this.axios.get(URL).then(response => {
      let data = response.data;
      this.Vendor = data;
    });
    this.getItemOfVendor(this.$route.params.id);
  },
  data() {
    return {
      vendorItem: [],
      toDisplayData: [],
      sending: false,
      ErrorStrings: {
        // NoBusinessName: "You must provide business name for this vendor",
        // NoBusinessAddress: "You must provide business address for this vendor",
        BusinessAddressMax:
          " Use from 6 to 200 characters for your business address",
        BusinessAddressMin:
          " Use from 6 to 200 characters for your business address",
        // NoContactName: "You must provide contact name for this vendor",
        ContactNameMin: " Use from 6 to 50 characters for your contact name ",
        ContactNameMax: " Use from 6 to 50 characters for your contact name ",
        NoEmail: " Enter email ",
        WebMax: " Use 200 characters or fewer for your website",
        DesMax: " Use 500 characters or fewer for your description",
        validEmail: "Valid email required",
        validWeb: "Valid website required",
        validContactName: "Valid characters required",
        PhoneMin: "Use from 9 to 13 characters for your phonenumber",
        duplicatePhone: "Duplicate phone number.",
        duplicateEmail: "Duplicate email."
      },
      CreateVendorErrors: {
        // NoBusinessName: "",
        BusinessAddressMin: "",
        BusinessAddressMax: "",
        NoBusinessAddress: "",
        // NoContactName: "",
        ContactNameMin: "",
        ContactNameMax: "",
        NoEmail: "",
        WebMax: "",
        DesMax: "",
        validEmail: "",
        validWeb: "",
        validContactName: "",
        PhoneMin: "",
        duplicatePhone: "",
        duplicateEmail: ""
      },
      Vendor: null,
      checkedActive: [],
      editMode: false
    };
  },
  methods: {
    editVendor() {
      // if (this.Vendor.BusinessName === "") {
      //   this.CreateVendorErrors.NoBusinessName = this.ErrorStrings.NoBusinessName;
      // }
      let webRegex = /^(?:(?:https?|ftp):\/\/)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/\S*)?$/;
      let emailRegex = /^(([^<>()\[\]\\.,;!#$%\^&*:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      // let contactNameRegex = /^[a-zA-Z]+$/;
      let contactNameRegex = /^[^~`!#$%@0-9()\^&*+=\-\[\]\\';,/{}|\\":<>\?]*?$/;

      if (
        !this.Vendor.BusinessAddress ||
        (this.Vendor.BusinessAddress && this.Vendor.BusinessAddress == "")
      ) {
        this.CreateVendorErrors.NoBusinessAddress = this.ErrorStrings.NoBusinessAddress;
      }
      if (
        !this.Vendor.BusinessAddress ||
        (this.Vendor.BusinessAddress &&
          (this.Vendor.BusinessAddress.length < 6 ||
            this.Vendor.BusinessAddress.length > 200))
      ) {
        this.CreateVendorErrors.BusinessAddressMin = this.ErrorStrings.BusinessAddressMin;
      }
      if (
        !this.Vendor.ContactName ||
        (this.Vendor.ContactName && this.Vendor.ContactName == "")
      ) {
        this.CreateVendorErrors.NoContactName = this.ErrorStrings.NoContactName;
      }
      if (
        !this.Vendor.ContactName ||
        (this.Vendor.ContactName &&
          (this.Vendor.ContactName.length < 6 ||
            this.Vendor.ContactName.length > 50))
      ) {
        this.CreateVendorErrors.ContactNameMin = this.ErrorStrings.ContactNameMin;
      }
      if (!contactNameRegex.test(this.Vendor.ContactName)) {
        this.CreateVendorErrors.validContactName = this.ErrorStrings.validContactName;
      } else {
        this.CreateVendorErrors.validContactName = "";
      }
      if (
        !this.Vendor.ContactEmail ||
        (this.Vendor.ContactEmail && this.Vendor.ContactEmail == "")
      ) {
        this.CreateVendorErrors.NoEmail = this.ErrorStrings.NoEmail;
      }
      if (this.Vendor.Website && this.Vendor.Website.length > 200) {
        this.CreateVendorErrors.WebMax = this.ErrorStrings.WebMax;
      }
      if (this.Vendor.Phone.length < 9 || this.Vendor.Phone.length > 13) {
        this.CreateVendorErrors.PhoneMin = this.ErrorStrings.PhoneMin;
      }
      for (const Vendor of this.Vendors) {
        if (Vendor.Id != this.Vendor.Id && Vendor.Phone == this.Vendor.Phone) {
          this.CreateVendorErrors.duplicatePhone = this.ErrorStrings.duplicatePhone;
          break;
        }
      }
      for (const Vendor of this.Vendors) {
        if (
          Vendor.Id != this.Vendor.Id &&
          Vendor.ContactEmail == this.Vendor.ContactEmail
        ) {
          this.CreateVendorErrors.duplicateEmail = this.ErrorStrings.duplicateEmail;
          break;
        }
      }
      if (this.Vendor.Description && this.Vendor.Description.length > 500) {
        this.CreateVendorErrors.DesMax = this.ErrorStrings.DesMax;
      }
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
          .put(`http://localhost:3000/api/vendor/${this.$route.params.id}`, {
            Vendor: this.Vendor
          })
          .then(res => {
            this.$router.push(`/vendor/${this.$route.params.id}`);
            alert("Save changes sucessfully");
            this.editMode = false;
          });
    },
    reload(vendorId) {
      let URL = `http://localhost:3000/api/vendor/${vendorId}`;
      this.axios.get(URL).then(response => {
        let data = response.data;
        this.Vendor = data;
      });
    },
    getItemOfVendor(vendorId) {
      let URL = `http://localhost:3000/api/vendor/${vendorId}`;
      this.axios.get(URL).then(response => {
        let data = response.data.Equipments;
        this.vendorItem = data;
        this.toDisplayData = this.vendorItem.slice(0, 10);
      });
    },
    getAccountAvatar(equip) {
      return equip.AvatarImage
        ? equip.AvatarImage
        : "http://citizen.edisha.gov.in/Content/assets/stylesheet/img/placeholder-user.png";
    },
    validateVendor() {
      return (
        // this.CreateVendorErrors.NoBusinessName === "" &&
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
        this.CreateVendorErrors.PhoneMin == "" &&
        this.CreateVendorErrors.duplicatePhone == "" &&
        this.CreateVendorErrors.duplicateEmail == ""
      );
    },
    gotoDetail(EquipmentId) {
      this.$router.push(`/equipment/${EquipmentId}`);
    }
  },
  watch: {
    // "Vendor.BusinessName": function() {
    //   if (this.Vendor.BusinessName != "") {
    //     this.CreateVendorErrors.NoBusinessName = "";
    //   }
    // },
    "Vendor.BusinessAddress": function() {
      // if (this.Vendor.BusinessAddress != "") {
      //   this.CreateVendorErrors.NoBusinessAddress = "";
      // }
      if (this.Vendor.BusinessAddress.length > 5) {
        this.CreateVendorErrors.BusinessAddressMin = "";
      }
      if (this.Vendor.BusinessAddress.length < 201) {
        this.CreateVendorErrors.BusinessAddressMax = "";
      }
    },
    "Vendor.ContactName": function() {
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
      for (const Vendor of this.Vendors) {
        if (
          Vendor.Id != this.Vendor.Id &&
          Vendor.ContactEmail == this.Vendor.ContactEmail
        ) {
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
    },
    "Vendor.Phone": function() {
      if (this.Vendor.Phone.length > 8) {
        this.CreateVendorErrors.PhoneMin = "";
      }
      if (this.Vendor.Phone.length < 14) {
        this.CreateVendorErrors.PhoneMin = "";
      }
      let isDupPhone = false;
      for (const Vendor of this.Vendors) {
        if (Vendor.Id != this.Vendor.Id && Vendor.Phone == this.Vendor.Phone) {
          isDupPhone = true;
          break;
        }
      }
      if (!isDupPhone) {
        this.CreateVendorErrors.duplicatePhone = "";
      }
    }
  }
};
</script>

<style scoped>
.grid-wrapper1 {
  /* display: grid; */
  /* grid-template-columns: 50% 50%; */
  grid-column-gap: 1rem;
  grid-row-gap: 2rem;
}
.grid-wrapper2 {
  display: grid;

  grid-column-gap: 1rem;
  grid-row-gap: 2rem;
}
.grid-wrapper {
  display: grid;

  grid-template-columns: 50% 50%;

  grid-column-gap: 1rem;

  grid-row-gap: 2rem;
}

.location-blocks {
  position: fixed;

  height: 88%;

  padding-right: 1rem;

  width: 40%;

  overflow-y: auto;
}

.location-blocks div {
  margin-bottom: 0.6rem;

  padding-left: 1rem;

  cursor: pointer;
}
#btn-add-member {
  /* position: fixed;
  right: 3rem;
  bottom: 2rem; */
  background-color: var(--primary-color);
  /* padding: 13px; */
  color: white;
  /* border-radius: 5px; */
  /* z-index: 1; */
}

#btn-add-member:hover {
  cursor: pointer;
  /* background-color: #009688;
  color: white; */
}
#btn-kick-member {
  /* position: fixed;
  right: 3rem;
  bottom: 2rem; */
  background-color: var(--danger-color);
  /* padding: 13px; */
  /* color: white; */
  /* border-radius: 5px; */
  /* z-index: 1; */
}

#btn-kick-member:hover {
  cursor: pointer;
  /* background-color: #009688;
  color: white; */
}
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
  margin-bottom: 1rem;
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
  background-color: white;
  margin-left: 1rem;
  margin-top: 1rem;
  /* padding: 13px; */
  color: black;
  /* border-radius: 5px;
  z-index: 10;
  font-size: 1.3rem; */
}

.btn-cancel:hover {
  cursor: pointer;
  /* background-color: #aca4a4; */
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
td:hover {
  cursor: pointer;
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
#btn-add-vendor {
  position: fixed;
  right: 3rem;
  bottom: 2rem;
  /* background-color: var(--primary-color);
  padding: 13px;
  color: white;
  border-radius: 5px; */
  z-index: 1;
}

#btn-add-vendor:hover {
  cursor: pointer;
  /* background-color: #009688;
  color: white; */
}
</style>
