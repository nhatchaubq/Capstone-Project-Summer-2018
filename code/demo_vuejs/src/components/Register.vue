<template>
  <div class="container">
      <div v-show="showNotification" v-bind:class="status" class="notification">
          <button class="delete" v-on:click="closeNotification"></button>
          {{ message }}
      </div>
      <div class="columns">
          <div class="column"></div>
          <div class="column is-half register-form">
              <h2 class="title is-2">Register</h2>
              <form @submit.prevent="register">
                  <div class="field">
                    <label class="label">Email</label>
                    <div class="control">
                        <input type="email" class="input" v-model="form.email"/>
                    </div>
                  </div>
                  <div class="field">
                    <label class="label">Username</label>
                    <div class="control">
                        <input type="text" class="input" v-model="form.username"/>
                    </div>
                  </div>
                  <div class="field">
                    <label class="label">Password</label>                      
                    <div class="control">
                        <input type="password" class="input" v-model="form.password"/>
                    </div> 
                  </div>
                  <div class="field">
                    <label class="label">Confirm Password</label>                      
                    <div class="control">
                        <input type="password" class="input" v-model="form.confirmPassword"/>
                    </div>
                  </div>
                  <hr class="divider"/>
                  <div class="field">
                    <label class="label">Fullname</label>                      
                    <div class="control">
                        <input type="text" class="input" v-model="form.fullName"/>
                    </div>
                  </div>
                  <div class="field">
                    <label class="label">Birthday</label>                      
                    <div class="control">
                        <input type="text" class="input" v-model="form.birthday" />
                    </div>
                  </div>
                  <div class="field">
                      <label class="checkbox">
                          <input type="checkbox" v-model="form.checked"/>
                          I agree with <a href="#">terms and conditions</a>.
                      </label>
                  </div>
                  <div class="field">
                      <div class="control">
                          <button class="button is-primary is-rounded">
                            Submit
                            <i v-show="sending" class="fa fa-circle-o-notch fa-spin"  style="margin-left: 5px;"></i>
                          </button>
                      </div>
                  </div>
              </form>
          </div>
          <div class="column"></div>
      </div>
  </div>
</template>

<script>
import Server from '../config/config.js';
import Utils from '../utils.js';
export default {
    name: 'register',
    data() {
        return {
            form: {
                email: null,
                username: null,
                password: null,
                confirmPassword: null,
                fullName: null,
                birthday: null,
                checked: false,
            },
            sending: false,
            error: false,
            validated: false,
            message: false,
            showNotification: false,
        }
    },
    computed: {
        status() {
            if (!this.error) {
                return 'is-success';
            } else {
                return 'is-danger';
            }
        }
    },
    methods: {
        register: async function() {
            this.sending = true;
            await Utils.sleep(2000);
            let uri = Server.CREATE_USER_API_PATH;
            this.axios.post(uri, {
                username: this.form.username,
                password: this.form.password,
                email: this.form.email,
                fullname: this.form.fullName,
                birthday: this.form.birthday
            })
                .then(response => {
                    if (response.status == 200) {
                        this.sending = false;
                        this.message = 'Account created successfully!';
                        this.showNotification = true;
                        setTimeout(() => {
                            this.$router.push('/');                            
                        }, 2000);
                    }
                })
                .catch(error => {
                    this.sending = false;
                    this.message = error.response.data;
                    this.showNotification = true;
                })
        },
        closeNotification: function() {
            this.showNotification = false;
        }
    }
    
}
</script>

<style scoped>
    .register-form {
        margin-top: 1rem;
    }
</style>
