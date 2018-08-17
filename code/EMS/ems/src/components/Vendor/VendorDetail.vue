<template>
  <div v-if="vendor" >
    <router-link to="/vendor">
      <a><span class="fa fa-chevron-left"></span> Back to vendors</a>
    </router-link>
    <simplert :useRadius="true" :useIcon="true" ref="simplert"></simplert>
    <div style="padding: 0; margin-top: 1rem">
      <div class="material-box" >
        <div class="row" style="margin: 0 !important; margin-bottom: 1rem;">
          <h2 class="col-11" style="padding: 0.5rem 0 0 0 !important"><strong style="text-transform: uppercase; font-size: 20px; color: #26a69a" >{{vendor.BusinessName}}</strong></h2>
          <!-- <h2 class="col-11" style="padding: 0.5rem 0 0 0 !important"><strong style="text-transform: uppercase;  font-size: 20px; color: #26a69a" >{{vendor.BusinessName}}  <span v-if="editMode" > <strong style="color: #26a69a">- Edit Information</strong> </span> </strong> </h2> -->
          <div style="padding: 0rem !important; text-align: right;" class="col-1"  v-if="authUser.Role =='Equipment Staff'">
            <button v-if="!editMode" class="button btn-edit btn-primary material-shadow-animate " v-on:click="editMode = !editMode">Edit</button>
          </div>
        </div>
        <div style="margin: 1rem 0" >
          <div>
            <strong>Business address</strong>
            <span v-if="editMode"> (required)
              <span class="error-text" v-if="CreateVendorErrors.InvalidBusinessAddressLength != ''"> {{ CreateVendorErrors.InvalidBusinessAddressLength }}</span>
              <span class="error-text" v-else-if="CreateVendorErrors.NoBusinessAddress != ''"> {{ CreateVendorErrors.NoBusinessAddress }}</span>
            </span>
          </div>
          <input style="margin-top: .3rem;" :style="(CreateVendorErrors.InvalidBusinessAddressLength != '' || CreateVendorErrors.NoBusinessAddress != '') ? 'border: 1px solid var(--danger-color)' : ''" class="input" v-model.trim="vendor.BusinessAddress" type="text" placeholder="150 To Ky, Tan Chanh Hiep, Quan 12, Ho Chi Minh" :disabled="!editMode">
        </div>
        <div style="margin: 1rem 0" >
          <div>
            <strong>Contact name</strong>
            <span v-if="editMode"> (required)
              <span class="error-text" v-if="CreateVendorErrors.InvalidContactName != ''"> {{ CreateVendorErrors.InvalidContactName }}</span>
              <span class="error-text" v-else-if="CreateVendorErrors.NoContactName != ''"> {{ CreateVendorErrors.NoContactName }}</span>
            </span>
          </div>
          <input style="margin-top: .3rem;" :style="(CreateVendorErrors.InvalidContactName != '' || CreateVendorErrors.NoContactName != '') ? 'border: 1px solid var(--danger-color)' : ''" v-model.trim="vendor.ContactName" class="input" type="text" placeholder="Mr. John Snow" :disabled="!editMode"/>
        </div>
        <div style="margin: 1rem 0" >
          <div>
            <strong>Contact email</strong>
            <span v-if="editMode"> (required)
              <span class="error-text" v-if="CreateVendorErrors.NoEmail != ''"> {{ CreateVendorErrors.NoEmail }}</span>
              <span class="error-text" v-else-if="CreateVendorErrors.InvalidEmail != ''"> {{ CreateVendorErrors.InvalidEmail }}</span>
              <span class="error-text" v-else-if="CreateVendorErrors.DuplicateEmail != ''"> {{ CreateVendorErrors.DuplicateEmail }}</span>
            </span>
          </div>
          <input style="margin-top: .3rem;" :style="(CreateVendorErrors.NoEmail != '' || CreateVendorErrors.InvalidEmail != '' || CreateVendorErrors.DuplicateEmail != '') ? 'border: 1px solid var(--danger-color)' : ''" v-model.trim="vendor.ContactEmail" class="input" type="email" placeholder="contact@dpoint.com" :disabled="!editMode">
        </div>
        <div style="margin: 1rem 0" >
          <div>
            <strong>Phone</strong>
            <span v-if="editMode"> (required)
              <span class="error-text" v-if="CreateVendorErrors.NoPhoneNumber != ''"> {{ CreateVendorErrors.NoPhoneNumber }}</span>
              <span class="error-text" v-else-if="CreateVendorErrors.InvalidPhone != ''"> {{ CreateVendorErrors.InvalidPhone }}</span>
              <span class="error-text" v-else-if="CreateVendorErrors.DuplicatePhone != ''"> {{ CreateVendorErrors.DuplicatePhone }}</span>     
            </span>
          </div>
          <input style="margin-top: .3rem;" :style="(CreateVendorErrors.InvalidPhone != '' || CreateVendorErrors.DuplicatePhone != '' || CreateVendorErrors.NoPhoneNumber != '') ? 'border: 1px solid var(--danger-color)' : ''" v-model.trim="vendor.Phone" class="input" type="text" placeholder="0927 234 924" :disabled="!editMode"/>
        </div>
        <div v-if="editMode"> 
          <strong>Status: </strong>
          <label style="margin-left: 1rem" class="radio">
            <input type="radio" name="vendorstatus" v-on:change="vendor.Status = true" :checked="vendor.Status" :disabled="!editMode">
            Active
          </label>
          <label class="radio">
            <input type="radio" style="margin-top: 0.5rem" name="vendorstatus" v-on:change="vendor.Status = false" :checked="!vendor.Status" :disabled="!editMode">
            Inactive
          </label>
        </div>
        <div style="margin: 1rem 0" >
          <div style="padding: 0" >
            <strong>Website</strong>
            <span v-if="editMode"> (optional)
              <span class="error-text" v-if="CreateVendorErrors.WebsiteMaximum != ''"> {{ CreateVendorErrors.WebsiteMaximum }}</span>
              <span class="error-text" v-else-if="CreateVendorErrors.InvalidWebsite != ''"> {{ CreateVendorErrors.InvalidWebsite }}</span>
            </span>
          </div>
          <input style="margin-top: .3rem;" :style="(CreateVendorErrors.WebsiteMaximum != '' || CreateVendorErrors.InvalidWebsite != '') ? 'border: 1px solid var(--danger-color)' : ''" v-model.trim="vendor.Website" class="input" type="text" placeholder="www.d-point.co.jp" :disabled="!editMode"/>
        </div>
        <div style="margin: 1rem 0">
          <div>
            <strong>Description</strong>
            <span v-if="editMode"> (optional)
              <span class="error-text" v-if="CreateVendorErrors.DescriptionMaximum != ''"> {{ CreateVendorErrors.DescriptionMaximum }}</span>
            </span>
          </div>
          <textarea style="margin-top: .3rem; min-height: 7rem; max-height: 7rem;" 
                 :style="CreateVendorErrors.DescriptionMaximum != '' ? 'border: 1px solid var(--danger-color)' : ''"
                v-model.trim="vendor.Description" class="input" type="text" :disabled="!editMode"></textarea>
        </div> 
        <div v-if="editMode" style="padding: 0">
          <button class="button btn-primary material-shadow-animate" v-on:click="updateVendor()">Save changes</button>
          <button class="button material-shadow-animate" style="margin-left: 1rem;" v-on:click="() => {
            this.CreateVendorErrors.InvalidEmail = '';
            this.CreateVendorErrors.InvalidWebsite = '';
            this.CreateVendorErrors.InvalidContactName = '';
            getVendorDetail($route.params.id);
            editMode = false;
          }">Cancel</button>
        </div>
      </div>    
    </div>
    <div v-if="!editMode" style="margin-top: 1rem;">
      <div class="material-box" style="padding: 1rem .5rem;">
        <div v-if="!vendorItem">
          This vendor has no equipment in system.
        </div>
        <div v-else>
          <strong>Vendor's equipment: total {{ vendor.Equipment.Quantity }} equipment</strong> 
          <table class="mytable" v-if="vendor.Equipment.Quantity">
            <thead>
              <tr>
                <th style="width:3% !important"><strong>No.</strong></th>
                <th style="width:47% !important"><strong>Equipment Name </strong></th>
                <th style="width:15% !important"><strong>Made in</strong></th>
                <th style="width:20% !important"><strong>Category</strong></th>
              </tr>
            </thead>  
            <tbody>
                <tr :key="equipment.Id" v-for="(equipment, index) in toDisplayData" class="txtText" v-on:click="gotoDetail(equipment.Id)">
                  <td style="text-align: center;">{{index + 1}}</td>
                  <td>{{ equipment.Name ? equipment.Name : "n/a" }}</td>
                  <td>{{ equipment.MadeIn ? equipment.MadeIn : "n/a" }}</td>
                  <td>{{ equipment.ecName ? equipment.ecName : "n/a" }}</td>
                </tr>
            </tbody>
          </table>

          <div v-if="vendorItem.length > 9" style="margin-top: 1.5rem">
            <Page :current="1" :total="vendorItem.length" show-elevator 
              @on-change="(newPageNumber) => {
                let start = 10 * (newPageNumber - 1);
                let end = start + 10;
                
                toDisplayData = vendorItem.slice(start, end);
              }">
            </Page>
          </div>
        </div>
      </div>
    </div>
  </div>  
</template>

<script>
import Server from "@/config/config.js";
import Utils from "@/utils.js";
import Simplert from "vue2-simplert";
export default {
  components: {
    Simplert
  },
  computed: {
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    }
  },
  async created() {
    let url = Server.VENDOR_API_PATH;
    await this.axios.get(url).then(res => {
      this.vendors = res.data;
    }).catch(error => {
      this.$router.push('/500');
      console.log(error);
    });
    await this.getVendorDetail(this.$route.params.id);
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
        WebMax: " Use 200 characters or fewer for your website ",
        DesMax: " Use 500 characters or fewer for your description ",
        validEmail: "Valid email required. ",
        validWeb: "Valid website required. ",
        validContactName:
          "Contact name not accepting special characters and number. ",
        PhoneMin: "Use from 9 to 13 characters for your phonenumber. ",
        duplicatePhone: "Duplicate phone number.",
        duplicateEmail: "Duplicate email."

      },
      CreateVendorErrors: {
        InvalidBusinessAddressLength: "",
        NoContactName: '',
        NoBusinessAddress: "",
        InvalidContactName: "",
        NoEmail: "",
        WebsiteMaximum: "",
        DescriptionMaximum: "",
        InvalidEmail: "",
        InvalidWebsite: "",
        InvalidPhone: "",
        NoPhoneNumber: '',
        DuplicatePhone: "",
        DuplicateEmail: ""
      },
      vendor: null,
      checkedActive: [],
      editMode: false,
      contactNameRegex: /^[^~`!#$%@0-9()\^&*+=\-\[\]\\';,/{}|\\":<>\?]*?$/,
      emailRegex: /^(([^<>()\[\]\\.,;!#$%\^&*:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
      webRegex: /^(?:(?:https?|ftp):\/\/)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/\S*)?$/,
      phoneRegex: /^\(?[+]?([0-9]{2,4})\)?[-. ]?([0-9]{3,4})[-. ]?([0-9]{3,7})$/,
    };
  },
  methods: {
    async updateVendor() {
      if (!this.vendor.BusinessAddress) {
        this.CreateVendorErrors.NoBusinessAddress = this.ErrorStrings.NoBusinessAddress;
      } else if (this.vendor.BusinessAddress && (this.vendor.BusinessAddress.length < 6 || this.vendor.BusinessAddress.length > 200)) {
        this.CreateVendorErrors.InvalidBusinessAddressLength = this.ErrorStrings.InvalidBusinessAddressLength;
      }
      if (!this.vendor.ContactName) {
        this.CreateVendorErrors.NoContactName = this.ErrorStrings.NoContactName;
      } else if (this.vendor.ContactName && (this.vendor.ContactName.length < 6 || this.vendor.ContactName.length > 50 || !this.contactNameRegex.test(this.vendor.ContactName))) {
        this.CreateVendorErrors.InvalidContactName = this.ErrorStrings.InvalidContactName;
      }
      if (!this.vendor.ContactEmail) {
        this.CreateVendorErrors.NoEmail = this.ErrorStrings.NoEmail;
      } else if (this.vendor.ContactEmail && !this.emailRegex.test(this.vendor.ContactEmail)) {
        this.CreateVendorErrors.InvalidEmail = this.ErrorStrings.InvalidEmail;
      } else {
        for (const vendor of this.vendors) {
          if (vendor.Id != this.vendor.Id && vendor.ContactEmail == this.vendor.ContactEmail) {
            this.CreateVendorErrors.DuplicateEmail = this.ErrorStrings.DuplicateEmail;
            break;
          }
        }        
      }
      if (!this.vendor.Phone) {
        this.CreateVendorErrors.NoPhoneNumber = this.ErrorStrings.NoPhoneNumber;
      } else if (this.vendor.Phone && (this.vendor.Phone.length < 10 || this.vendor.Phone.length > 17 || !this.phoneRegex.test(this.vendor.Phone))) {
        this.CreateVendorErrors.InvalidPhone = this.ErrorStrings.InvalidPhone;
      } else {
        for (const vendor of this.vendors) {
          if (vendor.Id != this.vendor.Id && vendor.Phone == this.vendor.Phone) {
            this.CreateVendorErrors.DuplicatePhone = this.ErrorStrings.DuplicatePhone;
            break;
          }
        }
      }
      if (this.vendor.Website && this.vendor.Website.length > 200) {
        this.CreateVendorErrors.WebsiteMaximum = this.ErrorStrings.WebsiteMaximum;
      } else if (this.vendor.Website && !this.webRegex.test(this.vendor.Website)) {
        this.CreateVendorErrors.InvalidWebsite = this.ErrorStrings.InvalidWebsite;
      }
      if (this.vendor.Description && this.vendor.Description.length > 500) {
        this.CreateVendorErrors.DescriptionMaximum = this.ErrorStrings.DescriptionMaximum;
      } 
      if (this.validateVendor())
        this.axios
          .put(`http://localhost:3000/api/vendor/${this.$route.params.id}`, {
            Vendor: this.vendor
          })
          .then(async (res) => {
            // this.$router.push(`/vendor/${this.$route.params.id}`);
            if (res.status == 200) {
              let obj = {
                  title: "Success",
                  message: "Vendor has been updated successfully!",
                  type: "success",
              };
              this.$refs.simplert.openSimplert(obj);
              await this.getVendorDetail(this.$route.params.id);
              this.editMode = false;
            }
          }).catch(error => {
            this.$router.push('/500');
            console.log(error);
          });
    },
    async getVendorDetail(vendorId) {
      let URL = `http://localhost:3000/api/vendor/${vendorId}`;
      return await this.axios.get(URL).then(response => {
        this.vendor = response.data;
      }).catch(error => {
        this.$router.push('/500');
        console.log(error);
      });
    },
    async getItemOfVendor(vendorId) {
      let URL = `http://localhost:3000/api/vendor/${vendorId}`;
      return await this.axios.get(URL).then(response => {
        if (response.data.Equipments && response.data.Equipments.length > 0) {
          this.vendorItem = response.data.Equipments;
          this.toDisplayData = this.vendorItem.slice(0, 10);
        }
      }).catch(error => {
        this.$router.push('/500');
        console.log(error);
      });
    },
    getAccountAvatar(equip) {
      return equip.AvatarImage
        ? equip.AvatarImage
        : "http://citizen.edisha.gov.in/Content/assets/stylesheet/img/placeholder-user.png";
    },
    validateVendor() {
      return (
        this.CreateVendorErrors.NoBusinessAddress === "" &&
        this.CreateVendorErrors.InvalidBusinessAddressLength === "" &&
        this.CreateVendorErrors.WebsiteMaximum === "" &&
        this.CreateVendorErrors.DescriptionMaximum === "" &&
        this.CreateVendorErrors.NoEmail === "" &&
        this.CreateVendorErrors.InvalidEmail == "" &&
        this.CreateVendorErrors.InvalidWebsite == "" &&
        this.CreateVendorErrors.NoContactName == "" &&
        this.CreateVendorErrors.InvalidContactName == "" &&
        this.CreateVendorErrors.NoContactName == "" &&
        this.CreateVendorErrors.InvalidPhone == "" &&
        this.CreateVendorErrors.NoPhoneNumber == "" &&
        this.CreateVendorErrors.DuplicatePhone == "" &&
        this.CreateVendorErrors.DuplicateEmail == ""
      );
    },
    gotoDetail(EquipmentId) {
      this.$router.push(`/equipment/${EquipmentId}`);
    }
  },
  watch: {
    // "vendor.BusinessName": function() {
    //   if (this.vendor.BusinessName != "") {
    //     this.CreateVendorErrors.NoBusinessName = "";
    //   }
    // },
    "vendor.BusinessAddress": function() {
      if (this.vendor.BusinessAddress && this.CreateVendorErrors.NoBusinessAddress != '') {
        this.CreateVendorErrors.NoBusinessAddress = '';
      }
      if (this.vendor.BusinessAddress.length <= 6 && this.vendor.BusinessAddress.length >= 200) {
        this.CreateVendorErrors.InvalidBusinessAddressLength = "";
      }
    },
    "vendor.ContactName": function() {
      if (this.vendor.ContactName != '' && this.CreateVendorErrors.NoContactName != '') {
        this.CreateVendorErrors.NoContactName = '';
      }
      if ((this.vendor.ContactName.length >= 6 && this.vendor.ContactName.length <= 50) 
          && this.contactNameRegex.test(this.vendor.ContactName) && this.CreateVendorErrors.InvalidContactName != '') {
        this.CreateVendorErrors.InvalidContactName = "";
      }
    },
    "vendor.ContactEmail": function() {
      if (this.vendor.ContactEmail != "" && this.CreateVendorErrors.NoEmail != '') {
        this.CreateVendorErrors.NoEmail = "";
      }
      if (this.emailRegex.test(this.vendor.ContactEmail) && this.CreateVendorErrors.InvalidEmail != '') {
        this.CreateVendorErrors.InvalidEmail = "";
      }
      if (this.CreateVendorErrors.DuplicateEmail != '') {
        let isDupEmail = false;
        for (const vendor of this.vendors) {
          if (
            vendor.Id != this.vendor.Id &&
            vendor.ContactEmail == this.vendor.ContactEmail
          ) {
            isDupEmail = true;
            break;
          }
        }
        if (!isDupEmail) {
          this.CreateVendorErrors.DuplicateEmail = "";
        }
      }
    },
    "vendor.Website": function() {
      if (this.vendor.Website.length <= 200 && this.CreateVendorErrors.WebsiteMaximum != '') {
        this.CreateVendorErrors.WebsiteMaximum = "";
      }
      if (this.webRegex.test(this.vendor.Website) && this.CreateVendorErrors.InvalidWebsite != '') {
        this.CreateVendorErrors.InvalidWebsite = "";
      }
    },
    "vendor.Description": function() {
      if (this.vendor.Description.length <= 500 && this.CreateVendorErrors.DescriptionMaximum != '') {
        this.CreateVendorErrors.DescriptionMaximum = "";
      }
    },
    "vendor.Phone": function() {
      if (this.vendor.Phone != '' && this.CreateVendorErrors.NoPhoneNumber != '') {
        this.CreateVendorErrors.NoPhoneNumber = '';
      }
      if (this.vendor.Phone.length >= 10 && this.vendor.Phone.length <= 17 && this.phoneRegex.test(this.vendor.Phone) && this.CreateVendorErrors.InvalidPhone != '') {
        this.CreateVendorErrors.InvalidPhone = "";
      }
      if (this.CreateVendorErrors.DuplicatePhone != '') {
        let isDupPhone = false;
        for (const vendor of this.vendors) {
          if (vendor.Id != this.vendor.Id && vendor.Phone == this.vendor.Phone) {
            isDupPhone = true;
            break;
          }
        }
        if (!isDupPhone) {
          this.CreateVendorErrors.DuplicatePhone = "";
        }
      }
    }
  }
};
</script>

<style scoped>
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
  background-color: var(--primary-color);
}

#btn-add-member:hover {
  cursor: pointer;
}
#btn-kick-member {
  background-color: var(--danger-color);
}

#btn-kick-member:hover {
  cursor: pointer;
}

.btn-edit {
  background-color: var(--primary-color);
  color: white;
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
  padding: 0.5rem;
  background-color: #cfd8dc;
}

table {
  width: 100%;
  font-size: 15px;
}
#btn-add-vendor {
  position: fixed;
  right: 3rem;
  bottom: 2rem;
  z-index: 1;
}

#btn-add-vendor:hover {
  cursor: pointer;
}
</style>
