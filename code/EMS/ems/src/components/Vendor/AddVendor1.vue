<template>
<div class="form"> 
    <!-- <form @submit.prevent="createVendor()"> -->
        <div class="form-title">
            <div class="form-title-start">
                Add New Vendor
            </div>
        </div>

            <div class="form-field">
                <div class="form-field-title">
                <strong>  Business name <span style="color:red;">*</span></strong>
                </div>
                <div class="control has-icons-left has-icons-right" style="padding:8px">
                    <input v-model="Vendor.BusinessName" class="input " type="text" placeholder="Text input" >

                        <span class="icon is-small is-left">
                        <i class="fa fa-address-card"></i>
                        </span>
                        <!-- <span class="icon is-small is-right">
                        <i class="fa fa-check"></i>
                        </span> -->

                </div>
            </div>
            

        <div>
            <div class="form-field">
                <div class="form-field-title">
                <strong>Business address <span style="color:red;">*</span></strong>
            <div class="control has-icons-left has-icons-right" style="padding:8px">
                    <input v-model="Vendor.BusinessAddress" class="input " type="text" placeholder="Text input">
                        <span class="icon is-small is-left">
                        <i class="fa fa-address-card"></i>
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
                     <strong>Website<span style="color:red;">*</span></strong>
                </div>
                <div class="form-field-input">
                <div class="control has-icons-left has-icons-right" style="padding:8px">
                    <input v-model="Vendor.Website" class="input " type="text" placeholder="Text input" >
                        <span class="icon is-small is-left">
                        <i class="fa fa-firefox"></i>
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
                     <strong>Contact name<span style="color:red;">*</span></strong>
                </div>
                <div class="form-field-input">
                <div class="control has-icons-left has-icons-right" style="padding:8px">
                    <input v-model="Vendor.ContactName" class="input " type="text" placeholder="Text input" >
                        <span class="icon is-small is-left">
                        <i class="fa fa-address-card"></i>
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
                    <strong>Email</strong>  
                </div>
                <div class="form-field-input">
                <div class="control has-icons-left has-icons-right" style="padding:8px">
                    <input v-model="Vendor.ContactEmail" class="input" type="email" placeholder="Text input" >
                        <span class="icon is-small is-left">
                        <i class="fa fa-envelope"></i>
                        </span>

                    </div>
                </div>

            </div>
            
        </div>
       
        <div>

        </div>
        <div>
            <div class="form-field" >
                <div class="form-field-title">
                     <strong>Description</strong>
                </div>   
                    <textarea class="control has-icons-left" id="text-descrip" rows="4" v-model="Vendor.Description" >
                    </textarea>
                <!-- <h3>{{account.startdate}}</h3> -->
            </div>
            
        </div>

        <div class="form-title-end" style="margin-bottom:2rem">
                <router-link to='/vendor'>
                    <button id="btn-cancel" class="button" >Cancel</button>
                </router-link>

                <!-- <button id="btn-add" class="button" v-on:click="createAccount()">Create Account</button>
                <button id="btn-add" class="button" v-on:click="createAccountTrueEnd()">Create Account true end</button> -->
                <!-- <router-link to='/account/'>
                <button id="btn-add" class="button">Create Account</button>
                </router-link> -->
                <button id="btn-add"  class="button" v-on:click="createVendor()" >Create Vendor</button>
            </div>
    <!-- <div>&nbsp</div> -->
    <!-- </form> -->
    <!-- </form> -->
    </div>
</template>

<script>
export default {
  data() {
    return {
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
      this.axios
        .post("http://localhost:3000/api/Vendor", {
          Vendor: this.Vendor
        })
        .then(res => {
          this.$router.push("/vendor");
        });
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
#text-descrip {
  border: 0.5px solid lightgray;
  border-radius: 5px;
  padding: 0.3rem;
  width: 100%;
}
#text-descrip:hover {
  border: 1px solid grey;
}
</style>
