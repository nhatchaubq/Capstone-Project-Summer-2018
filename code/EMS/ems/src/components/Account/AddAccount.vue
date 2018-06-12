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
                    <strong>  Username <span style="color:red;">*</span></strong>
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
                    <strong>   Password <span style="color:red;">*</span></strong>
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
                        Fullname <strong><span style="color:red;">*</span></strong>
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
                        Phone <strong><span style="color:red;">*</span></strong>
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
                        Email 
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
    <div>
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
                
    </div>
         <!-- /test    -->
            <div>

            </div>
            <div>
                <div class="form-field">
                    <div class="form-field-title">
                        Start date <strong><span style="color:red;">*</span></strong>
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
                    <div class="form-field-title">
                        Role <strong><span style="color:red;">*</span></strong>
                    </div>
                    <div class="form-field-input">
                    <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model="account.role" class="input" type="text" placeholder="Text input" >
                            <span class="icon is-small is-left">
                            <i class="fa fa-user-md"></i>
                            </span>
                            <!-- {{account.role}} -->
                        </div>
                    </div>
                </div>            
            </div>

            
    
    <div class="form-title-end">
                    <router-link to='/account'>
                        <button id="btn-cancel" class="button" >Cancel</button>
                    </router-link>

                    <!-- <button id="btn-add" class="button" v-on:click="createAccount()">Create Account</button>
                    <button id="btn-add" class="button" v-on:click="createAccountTrueEnd()">Create Account true end</button> -->
                    <router-link to='/account/'>
                    <button id="btn-add" class="button">Create Account</button>
                    </router-link>
                    <!-- <button id="btn-add" class="button">Create Account</button> -->
                </div>
            <div>&nbsp</div>
         </form>
        
    </div>
</template>

<script>
export default {
  data() {
    return {
      account: {
        username: "",
        password: "",
        fullname: "",
        phone: null,
        email: "",
        startdate: "",
        role: null
      }
    };
  },
  methods: {
    createAccount() {
      this.axios.put("http://localhost:3000/api/account/6", {
        password: "abc"
      });
    },
    createAccountTrueEnd() {
      this.axios.post("http://localhost:3000/api/account", {
        username: "Dien159",
        password: 123456,
        fullname: "Doan Dien",
        phone: 12345678910,
        email: "abc@abc",
        startdate: "2018/03/02",
        roleid: 1
        // avatarimage: "https://www.ebay.co.uk/p/Watchmen-Smiley-Face-25mm-1-Pin-Badge-Button-DC-Comics/1588249551",
        // teamid: 1,
      });
    },
    createAccount1() {
      this.axios.post("http://localhost:3000/api/account", {
        // username: this.username,
        // password: this.password,
        // fullname: this.fullname,
        // phone: this.phone,
        // email: this.email,
        // startdate: this.startdate,
        // role: this.role,
        account: this.account
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
