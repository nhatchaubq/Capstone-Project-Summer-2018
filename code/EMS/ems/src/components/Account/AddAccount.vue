<template>
     <div class="form">
        <div class="form-title">
            <div class="form-title-start">
                Add New Account
            </div>
            <div></div>
            <!-- <div class="form-title-end">
                <router-link to='/account'>
                    <button id="btn-cancel" class="button" >Cancel</button>
                </router-link>

                <button id="btn-add" class="button" v-on:click="createAccount()">Create Account</button>
            </div> -->
        </div>
        <div>
            <div class="form-field">
                <div class="form-field-title">
                  <strong>  Username <span style="color:red;">*</span></strong>
                </div>
                <div class="control has-icons-left has-icons-right" style="padding:8px">
                    <input class="input " type="text" placeholder="Text input" >
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
                    <input class="input " type="text" placeholder="Text input" >
                        <span class="icon is-small is-left">
                        <i class="fa fa-expeditedssl"></i>
                        </span>
                        <!-- <span class="icon is-small is-right">
                        <i class="fa fa-check"></i>
                        </span> -->
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
                    <input class="input " type="text" placeholder="Text input" >
                        <span class="icon is-small is-left">
                        <i class="fa fa-user"></i>
                        </span>
                        <!-- <span class="icon is-small is-right">
                        <i class="fa fa-check"></i>
                        </span> -->
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
                    <input class="input " type="text" placeholder="Text input" >
                        <span class="icon is-small is-left">
                        <i class="fa fa-mobile"></i>
                        </span>
                        <!-- <span class="icon is-small is-right">
                        <i class="fa fa-check"></i>
                        </span> -->
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
                    <input class="input " type="text" placeholder="Text input" >
                        <span class="icon is-small is-left">
                        <i class="fa fa-envelope"></i>
                        </span>
                        <!-- <span class="icon is-small is-right">
                        <i class="fa fa-check"></i>
                        </span> -->
                    </div>
                </div>

            </div>
            
        </div>
         <div>
            <!-- <div class="form-field">
                <div class="form-field-title">
                    Status <strong><span style="color:red;">*</span></strong>
                </div>
                
                 <div class="field">
  <input class="is-checkradio" id="exampleCheckbox" type="checkbox" name="exampleCheckbox" checked="checked">
  <label for="exampleCheckbox">Active</label>
</div>

            </div> -->
            
        </div>
         <div>
            <div class="form-field">
                <div class="form-field-title">
                    Start date <strong><span style="color:red;">*</span></strong>
                </div>
                <div class="form-field-input">
                    <div class="control has-icons-left has-icons-right" style="padding:8px">
                    <input class="input " type="date" placeholder="Text input" >
                        <span class="icon is-small is-left">
                        <i class="fa fa-calendar"></i>
                        </span>
                        <!-- <span class="icon is-small is-right">
                        <i class="fa fa-check"></i>
                        </span> -->
                    </div>
                </div>

            </div>
            
        </div>
 
         <div>
            <div class="form-field">
                <div class="form-field-title">
                    Role <strong><span style="color:red;">*</span></strong>
                </div>
                <div class="form-field-input">
                   <div class="control has-icons-left has-icons-right" style="padding:8px">
                    <input class="input " type="text" placeholder="Text input" >
                        <span class="icon is-small is-left">
                        <i class="fa fa-user-md"></i>
                        </span>
                        
                    </div>
                </div>

            </div>
            
        </div>

        
        <!-- <div><strong style="color:red">/none</strong></div>
        <div class="field">
  <label class="label">Name</label>
  <div class="control">
    <div class="control has-icons-left has-icons-right" style="padding:8px">
                    <input class="input " type="text" placeholder="Text input" >
                        <span class="icon is-small is-left">
                        <i class="fa fa-expeditedssl"></i>
                        </span>

                    </div>
                </div>

</div>

<div class="field">
  <label class="label">Username</label>
  <div class="control has-icons-left has-icons-right" style="padding:8px">
    <input class="input is-success" type="text" placeholder="Text input" value="bulma">
    <span class="icon is-small is-left">
      <i class="fa fa-user"></i>
    </span>
    <span class="icon is-small is-right">
      <i class="fa fa-check"></i>
    </span>
  </div>
  <p class="help is-success">This username is available</p>
</div>

<div class="field">
  <label class="label">Email</label>
  <div class="control has-icons-left has-icons-right">
    <input class="input is-danger" type="email" placeholder="Email input" value="hello@">
    <span class="icon is-small is-left">
      <i class="fas fa-envelope"></i>
    </span>
    <span class="icon is-small is-right">
      <i class="fas fa-exclamation-triangle"></i>
    </span>
  </div>
  <p class="help is-danger">This email is invalid</p>
</div>

<div class="field">
  <label class="label">Subject</label>
  <div class="control">
    <div class="select">
      <select>
        <option>Select dropdown</option>
        <option>With options</option>
      </select>
    </div>
  </div>
</div>

<div class="field">
  <label class="label">Message</label>
  <div class="control">
    <textarea class="textarea" placeholder="Textarea"></textarea>
  </div>
</div>

<div class="field">
  <div class="control">
    <label class="checkbox">
      <input type="checkbox">
      I agree to the <a href="#">terms and conditions</a>
    </label>
  </div>
</div>

<div class="field">
  <div class="control">
    <label class="radio">
      <input type="radio" name="question">
      Yes
    </label>
    <label class="radio">
      <input type="radio" name="question">
      No
    </label>
  </div>
</div> 

<div class="field is-grouped">
  <div class="control">
    <button class="button is-link">Submit</button>
  </div>
  <div class="control">
    <button class="button is-text">Cancel</button>
  </div>
</div> -->
<div class="form-title-end">
                <router-link to='/account'>
                    <button id="btn-cancel" class="button" >Cancel</button>
                </router-link>

                <button id="btn-add" class="button" v-on:click="createAccount()">Create Account</button>
                <button id="btn-add" class="button" v-on:click="createAccountTrueEnd()">Create Account true end</button>
            </div>
        <div>&nbsp</div>
    </div>
</template>

<script>

export default {
    methods: {
        createAccount() {
            this.axios.put("http://localhost:3000/api/account/6", {
                password: "abc",                
            });
        },
        createAccountTrueEnd(){
            this.axios.post("http://localhost:3000/api/account",{
                username: "Dien159",
                password: 123456,
                email: "abc@abc",
                fullname: "Doan Dien",
                phone: 12345678910,
                isactive: "True",
                startdate: "2018/03/02",
                enddate: "2018/04/04",
                roleid: 1,
                avatarimage: "https://www.ebay.co.uk/p/Watchmen-Smiley-Face-25mm-1-Pin-Badge-Button-DC-Comics/1588249551",
                teamid: 1,
            });
        },
    }
}
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

    .form-title-start{
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
        margin-right: .6rem
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
