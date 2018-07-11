<template>
<div v-if="Vendor" >
    <router-link to="/vendor">
      <a><span class="material-icons" style="position: relative; top: .4rem">keyboard_arrow_left</span> Back to Vendors</a>
    </router-link>


  <div class="grid-wrapper1 col-12" style="margin-bottom:1rem">
    <div class="material-box" >
      <div class="row" style="margin: 0 !important; margin-bottom: 0.5rem">
        <h2 class="col-11" style="padding: 0 !important"><strong style="text-transform: uppercase;  font-size: 20px; color: #26a69a;" >{{Vendor.BusinessName}}</strong> </h2>
      <button class="button btn-edit btn-primary material-shadow-animate col-1" v-on:click="editMode = !editMode">Edit</button>
      </div>
      <div  class="row" style="height: 36px; margin-bottom: 0.5rem" >
        <div class="col-12" style="margin-top:0.5rem" >
          Business address  <span v-if="editMode"> (required)</span><span v-if="CreateVendorErrors.NoBusinessAddress != ''">. <span class="error-text">{{ CreateVendorErrors.NoBusinessAddress }}</span></span>
        </div>
      </div>
        <input v-if="!editMode" v-model="Vendor.BusinessAddress" class="input col-7 " type="text"  placeholder="Text input" disabled="disabled">
        <input v-else v-model="Vendor.BusinessAddress" class="input col-7 " type="text"  placeholder="Text input" >
      <div  class="row" style="height: 36px; margin-bottom: 0.5rem" >
        <div class="col-12" style="margin-top:0.5rem" >
          Website
        </div>
      </div>
        <input v-if="!editMode" v-model="Vendor.Website" class="input col-7 " type="text"  placeholder="Text input" disabled="disabled">
        <input v-else v-model="Vendor.Website" class="input col-7 " type="text"  placeholder="Text input" >
      <div  class="row" style="height: 36px; margin-bottom: 0.5rem" >
        <div class="col-12" style="margin-top:0.5rem;" >
          Contact name <span v-if="editMode"> (required)</span><span v-if="CreateVendorErrors.NoContactName != ''">. <span class="error-text">{{ CreateVendorErrors.NoContactName }}</span></span>
        </div>
      </div>
        <input v-if="!editMode" v-model="Vendor.ContactName" class="input col-7 " type="text"  placeholder="Text input" disabled="disabled">
        <input v-else v-model="Vendor.ContactName" class="input col-7 " type="text"  placeholder="Text input" >
      <div  class="row" style="height: 36px; margin-bottom: 0.5rem" >
        <div class="col-12" style="margin-top:0.5rem" >
          Contact email <span v-if="editMode"> (required)</span><span v-if="CreateVendorErrors.NoEmail != ''">. <span class="error-text">{{ CreateVendorErrors.NoEmail }}</span></span>  
        </div>
      </div>
        <input v-if="!editMode" v-model="Vendor.ContactEmail" class="input col-7 " type="text"  placeholder="Text input" disabled="disabled">
        <input v-else v-model="Vendor.ContactEmail" class="input col-7 " type="text"  placeholder="Text input" >
      <div  class="row" style="height: 36px; margin-bottom: 0.5rem" >
        <div class="col-12" style="margin-top:0.5rem" >
          Description
        </div>
      </div>
        <input v-if="!editMode" v-model="Vendor.Description" class="input col-7 " type="text"  placeholder="Text input" disabled="disabled">
        <input v-else v-model="Vendor.Description" class="input col-7 " type="text"  placeholder="Text input" >
      <div class="row" v-if="editMode">
        <button class="button btn-confirm-edit btn-primary material-shadow-animate" v-on:click="editVendor()">Done</button>
        <button class="button btn-cancel btn-primary material-shadow-animate" v-on:click="editMode = !editMode">Cancel</button>
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
        <strong>Vendor's equipment</strong> 
        <div v-if="Vendor.Equipments" >
          <div >

            <div :key="Equipment.Id" v-for="Equipment in Vendor.Equipments">
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
        </div>
      <!-- </div> -->
    </div>
  </div>

    <!-- test end -->

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
        NoContactName: "You must provide contact name for this vendor",
        NoEmail: "You must provide contact email for this vendor"
      },
      CreateVendorErrors: {
        // NoBusinessName: "",
        NoBusinessAddress: "",
        NoContactName: "",
        NoEmail: ""
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
      if (this.Vendor.BusinessAddress === "") {
        this.CreateVendorErrors.NoBusinessAddress = this.ErrorStrings.NoBusinessAddress;
      }
      if (this.Vendor.ContactName === "") {
        this.CreateVendorErrors.NoContactName = this.ErrorStrings.NoContactName;
      }
      if (this.Vendor.ContactEmail === "") {
        this.CreateVendorErrors.NoEmail = this.ErrorStrings.NoEmail;
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
        this.CreateVendorErrors.NoContactName === "" &&
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
    },
    "Vendor.ContactName": function() {
      if (this.Vendor.ContactName != "") {
        this.CreateVendorErrors.NoContactName = "";
      }
    },
    "Vendor.ContactEmail": function() {
      if (this.Vendor.ContactEmail != "") {
        this.CreateVendorErrors.NoEmail = "";
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
