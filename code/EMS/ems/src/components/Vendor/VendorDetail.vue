<template>
<div v-if="Vendor" >
    <router-link to="/vendor">
      <a><span class="material-icons" style="position: relative; top: .4rem">keyboard_arrow_left</span> Back to Vendors</a>
    </router-link>
      <div class="row" style="margin: 0 !important; margin-bottom: 0.5rem">
        <h2 class="col-11" style="padding: 0 !important"><strong style="text-transform: uppercase;  font-size: 20px; color: #26a69a;" >{{Vendor.BusinessName}}</strong> </h2>
      <button  v-if="!editMode" class="button btn-edit btn-primary material-shadow-animate col-1" v-on:click="editMode = !editMode">Edit</button>
      </div>
  <form @submit.prevent="editVendor()">

  <div class="grid-wrapper1 col-12" style="margin-bottom:1rem">
    <div class="material-box" >

        <div  class="row" style="height: 36px; margin-bottom: 0.5rem" >
          <div class="col-12" style="margin-top:0.5rem" >
            Business address  <span v-if="editMode"> (required)</span><span v-if="CreateVendorErrors.BusinessAddressMin != ''"> <span class="error-text">{{ CreateVendorErrors.BusinessAddressMin }}</span></span> <span v-if="CreateVendorErrors.BusinessAddressMax != ''"> <span class="error-text">{{ CreateVendorErrors.BusinessAddressMax }}</span></span>
          </div>
        </div>
          <input v-if="!editMode" v-model.trim="Vendor.BusinessAddress" class="input col-7 " type="text"  placeholder="Text input" disabled="disabled">
          <input v-else v-model.trim="Vendor.BusinessAddress" class="input col-7 " type="text"  placeholder="Text input" >
        <div  class="row" style="height: 36px; margin-bottom: 0.5rem" >
          <div class="col-12" style="margin-top:0.5rem" >
            Website <span v-if="CreateVendorErrors.WebMax != ''"> <span class="error-text">{{ CreateVendorErrors.WebMax }}</span></span>
          </div>
        </div>
          <input v-if="!editMode" v-model.trim="Vendor.Website" class="input col-7 " type="text"  placeholder="Text input" disabled="disabled"> 
          <input v-else v-model.trim="Vendor.Website" class="input col-7 " type="text"  placeholder="Text input" >
        <div  class="row" style="height: 36px; margin-bottom: 0.5rem" >
          <div class="col-12" style="margin-top:0.5rem;" >
            Contact name <span v-if="editMode"> (required)</span><span v-if="CreateVendorErrors.ContactNameMin != ''"> <span class="error-text">{{ CreateVendorErrors.ContactNameMin }}</span></span> <span v-if="CreateVendorErrors.ContactNameMax != ''"> <span class="error-text">{{ CreateVendorErrors.ContactNameMax }}</span></span>
          </div>
        </div>
          <input v-if="!editMode" v-model.trim="Vendor.ContactName" class="input col-7 " type="text"  placeholder="Text input" disabled="disabled">
          <input v-else v-model.trim="Vendor.ContactName" class="input col-7 " type="text"  placeholder="Text input" >
        <div  class="row" style="height: 36px; margin-bottom: 0.5rem" >
          <div class="col-12" style="margin-top:0.5rem"  >
            Contact email <span v-if="editMode"> (required)</span><span v-if="CreateVendorErrors.NoEmail != ''"> <span class="error-text">{{ CreateVendorErrors.NoEmail }}</span></span>  
          </div>
        </div>
          <input v-if="!editMode" v-model.trim="Vendor.ContactEmail" class="input col-7 " type="email"  placeholder="Text input" disabled="disabled">
          <input v-else v-model.trim="Vendor.ContactEmail" class="input col-7 " type="email"  placeholder="Text input" >
        <div  class="row" style="height: 36px; margin-bottom: 0.5rem" >
          <div class="col-12" style="margin-top:0.5rem" >
            Description <span v-if="CreateVendorErrors.DesMax != ''"> <span class="error-text">{{ CreateVendorErrors.DesMax }}</span></span>  
          </div> 
        </div> 
          <input v-if="!editMode" v-model.trim="Vendor.Description" class="input col-7 " type="text"  placeholder="Text input" disabled="disabled">
          <input v-else v-model.trim="Vendor.Description" class="input col-7 " type="text"  placeholder="Text input" >
        <div class="row" v-if="editMode">
          <button class="button btn-confirm-edit btn-primary material-shadow-animate" >Save change</button>
          <button class="button btn-cancel material-shadow-animate" v-on:click="() => {
         created($route.params.id);
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
  <div class="grid-wrapper1 col-12">
    <div class="material-box">
      <!-- <div class="grid-wrapper1"> -->
        <strong>Vendor's equipment (This vendor have {{Vendor.Equipment.Quantity}} equipment(s) and {{Vendor.EquipmentItems.Quantity}} equipment item(s) ) </strong> 
        <!-- <div v-if="Vendor.Equipments" >
          <div >

            <div :key="Equipment.Id" v-for="Equipment in Vendor.Equipments">
              <div class="row" style="height:40px; ">


                
                <router-link :to="`/equipment/${Equipment.Id}`">
                <div class="col-12">
                  <span>-</span> {{Equipment.Name}}
                </div>
                </router-link>

              </div>
            </div>
          </div>
        </div> -->

         <div v-if="Vendor.EMayXayDung" >
          <div>
            Construction Machine
          </div>

            <div :key="Equipment.Id" v-for="Equipment in Vendor.EMayXayDung">
              <div class="row" style="height:40px; ">
                <!-- <div class="col-12 row"> -->

                
                <router-link :to="`/equipment/${Equipment.Id}`">
                <div class="col-12">
                  <span>-</span> {{Equipment.Name}}
                </div>
                </router-link>

                <!-- </div > -->
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



        
      <!-- </div> -->
    </div>
  </div>

    <!-- test end -->
 </form>
</div>
  
</template>

<script>
export default {
  created() {
    let URL = `http://localhost:3000/api/vendor/${this.$route.params.id}`;
    this.axios.get(URL).then(response => {
      let data = response.data;
      this.Vendor = data;
    });
  },
  data() {
    return {
      sending: false,
      ErrorStrings: {
        // NoBusinessName: "You must provide business name for this vendor",
        NoBusinessAddress: "You must provide business address for this vendor",
        BusinessAddressMax:
          " Use from 6 to 200 characters for your business address",
        BusinessAddressMin:
          " Use from 6 to 200 characters for your business address",
        NoContactName: "You must provide contact name for this vendor",
        ContactNameMin: " Use from 6 to 50 characters for your contact name",
        ContactNameMax: " Use from 6 to 50 characters for your contact name",
        NoEmail: " Enter email",
        WebMax: " Use 200 characters or fewer for your website",
        DesMax: " Use 500 characters or fewer for your description"
      },
      CreateVendorErrors: {
        // NoBusinessName: "",
        BusinessAddressMin: "",
        BusinessAddressMax: "",
        NoBusinessAddress: "",
        NoContactName: "",
        ContactNameMin: "",
        ContactNameMax: "",
        NoEmail: "",
        WebMax: "",
        DesMax: ""
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
      if (!this.Vendor.BusinessAddress || (this.Vendor.BusinessAddress && this.Vendor.BusinessAddress == "")) {
        this.CreateVendorErrors.NoBusinessAddress = this.ErrorStrings.NoBusinessAddress;
      }
      if (!this.Vendor.BusinessAddress 
          || (this.Vendor.BusinessAddress 
              && (this.Vendor.BusinessAddress.length < 6 || this.Vendor.BusinessAddress.length > 200))) {
        this.CreateVendorErrors.BusinessAddressMin = this.ErrorStrings.BusinessAddressMin;
      }
      if (!this.Vendor.ContactName || (this.Vendor.ContactName && this.Vendor.ContactName == "")) {
        this.CreateVendorErrors.NoContactName = this.ErrorStrings.NoContactName;
      }
      if (!this.Vendor.ContactName 
          || (this.Vendor.ContactName 
              && (this.Vendor.ContactName.length < 6 || this.Vendor.ContactName.length > 50))) {
        this.CreateVendorErrors.ContactNameMin = this.ErrorStrings.ContactNameMin;
      }
      if (!this.Vendor.ContactEmail || (this.Vendor.ContactEmail && this.Vendor.ContactEmail == "")) {
        this.CreateVendorErrors.NoEmail = this.ErrorStrings.NoEmail;
      }
      if (this.Vendor.Website && this.Vendor.Website.length > 200) {
        this.CreateVendorErrors.WebMax = this.ErrorStrings.WebMax;
      }
      if (this.Vendor.Description && this.Vendor.Description.length > 500) {
        this.CreateVendorErrors.DesMax = this.ErrorStrings.DesMax;
      }
      if (this.validateVendor())
        this.axios
          .put(`http://localhost:3000/api/vendor/${this.$route.params.id}`, {
            Vendor: this.Vendor
          })
          .then(res => {
            this.$router.push("/vendor");
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
        this.CreateVendorErrors.NoBusinessAddress === "" &&
        this.CreateVendorErrors.BusinessAddressMin === "" &&
        this.CreateVendorErrors.BusinessAddressMax === "" &&
        this.CreateVendorErrors.NoContactName === "" &&
        this.CreateVendorErrors.ContactNameMin === "" &&
        this.CreateVendorErrors.ContactNameMax === "" &&
        this.CreateVendorErrors.WebMax === "" &&
        this.CreateVendorErrors.DesMax === "" &&
        this.CreateVendorErrors.NoEmail === ""
      );
    }
  },
  watch: {
    // "Vendor.BusinessName": function() {
    //   if (this.Vendor.BusinessName != "") {
    //     this.CreateVendorErrors.NoBusinessName = "";
    //   }
    // },
    "Vendor.BusinessAddress": function() {
      if (this.Vendor.BusinessAddress != "") {
        this.CreateVendorErrors.NoBusinessAddress = "";
      }
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
      if (this.Vendor.ContactName != "") {
        this.CreateVendorErrors.NoContactName = "";
      }
    },
    "Vendor.ContactEmail": function() {
      if (this.Vendor.ContactEmail != "") {
        this.CreateVendorErrors.NoEmail = "";
      }
    },
    "Vendor.Website": function() {
      if (this.Vendor.Website.length < 201) {
        this.CreateVendorErrors.WebMax = "";
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
