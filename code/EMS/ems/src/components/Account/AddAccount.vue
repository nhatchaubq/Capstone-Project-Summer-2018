<template>
     <div class="form">
        <div class="form-title">
            <div class="form-title-start">
                Add New Account
            </div>
            <div></div>
            <div class="form-title-end">
                <router-link to='/account'>
                    <button id="btn-cancel" class="button" >Cancel</button>
                </router-link>

                <button id="btn-add" class="button">Create Account</button>
            </div>
        </div>
        <div>
            <div class="form-field">
                <div class="form-field-title">
                    Username <strong><span style="color:red;">*</span></strong>
                </div>
                <div class="form-field-input">
                    <input type="text" class="input">
                </div>
            </div>
            
        </div>
        <div>
            <div class="form-field">
                <div class="form-field-title">
                    Password <strong><span style="color:red;">*</span></strong>
                </div>
                    
                    <button id="btn-table-view">change random password</button>

            </div>
            
        </div>
         <div>
            <div class="form-field">
                <div class="form-field-title">
                    Fullname <strong><span style="color:red;">*</span></strong>
                </div>
                <div class="form-field-input">
                    <input type="text" class="input">
                </div>
            </div>
            
        </div>
         <div>
            <div class="form-field">
                <div class="form-field-title">
                    Phone <strong><span style="color:red;">*</span></strong>
                </div>
                <div class="form-field-input">
                    <input type="text" class="input">
                </div>
            </div>
            
        </div>
                 <div>
            <div class="form-field">
                <div class="form-field-title">
                    Email 
                </div>
                <div class="form-field-input">
                    <input type="text" class="input">
                </div>
            </div>
            
        </div>
         <div>
            <div class="form-field">
                <div class="form-field-title">
                    Status <strong><span style="color:red;">*</span></strong>
                </div>
                
                 <div class="field">
  <input class="is-checkradio" id="exampleCheckbox" type="checkbox" name="exampleCheckbox" checked="checked">
  <label for="exampleCheckbox">Check me</label>
</div>
<div class="field">
  <input class="is-checkradio" id="exampleRadioInline1" type="radio" name="exampleRadioInline" checked="checked">
  <label for="exampleRadioInline1">Option 1</label>
  <input class="is-checkradio" id="exampleRadioInline2" type="radio" name="exampleRadioInline">
  <label for="exampleRadioInline2">Option 2</label>
</div>
            </div>
            
        </div>
         <div>
            <div class="form-field">
                <div class="form-field-title">
                    Start date <strong><span style="color:red;">*</span></strong>
                </div>
                <div class="form-field-input">
                    <input type="text" class="input">
                </div>
            </div>
            
        </div>
         <div>
            <div class="form-field">
                <div class="form-field-title">
                    End date <strong><span style="color:red;">*</span></strong>
                </div>
                <div class="form-field-input">
                    <input type="text" class="input">
                </div>
            </div>
            
        </div>
         <div>
            <div class="form-field">
                <div class="form-field-title">
                    Role <strong><span style="color:red;">*</span></strong>
                </div>
                <div class="form-field-input">
                    <input type="text" class="input">
                </div>
            </div>
            
        </div>
         <div>
            <div class="form-field">
                <div class="form-field-title">
                    Team name <strong><span style="color:red;">*</span></strong>
                </div>
                <div class="form-field-input">
                    <input type="text" class="input">
                </div>
            </div>
            
        </div>
         <div>
            <div class="form-field">
                <div class="form-field-title">
                    Department name <strong><span style="color:red;">*</span></strong>
                </div>
                <div class="form-field-input">
                    <input type="text" class="input">
                </div>
            </div>
            
        </div>
        
    </div>
</template>

<script>

export default {

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
        display: flex;
        justify-content: flex-end;
        /* align-content: center; */
    }

    .form-title-end button {
        /* font-weight: bold;
        color: white;
        border: 1px solid transparent;
        border-radius: 10px;
        padding: .6rem 1.5rem; */
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
</style>
