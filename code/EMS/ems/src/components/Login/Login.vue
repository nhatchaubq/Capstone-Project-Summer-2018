<template>
  <div class="login-container" style="height: 100% !important; margin: 0; padding: 0">      
      <div class="columns">
        <div class="column"></div>
        <div class="column is-3">            
            <div class="login-form" style="background: #263238 !important;">
                <div><img :src="require('@/assets/ems-logo.png')"/></div>                
                <!-- <h2 style="font-size: 1.5rem; color: white; margin: 1rem 0">Login</h2> -->
                <div style="margin-top: 2rem">
                  <span v-show="showNotification" class="error-text">
                      {{ message }}
                  </span>
                  <form @submit.prevent="login">
                      <div class="field">
                          <label style="color: white">Username</label>
                          <div class="control">
                              <input class="input" type="text" v-model="form.username" placeholder="JohnSmith" required/>
                          </div>
                      </div>
                      <div class="field">
                          <label style="color: white">Password</label>
                          <div class="control">
                              <input class="input" type="password" v-model="form.password" placeholder="Password" required/>
                          </div>
                      </div>
                      <div class="" style="margin: 1rem 0">
                          <label class="checkbox" style="color: white">
                              <input type="checkbox"/>
                              Remember my login.
                          </label>
                      </div>
                      <div class="field">
                          <div class="control">
                              <button class="button is-primary" long style="font-size: 1rem; width: 100%">
                                  Login
                                  <i v-show="sending" class="fa fa-circle-o-notch fa-spin" style="margin-left: 5px;"></i>
                              </button>
                          </div>
                      </div>
                  </form>
                </div>
            </div>            
        </div>
        <div class="column"></div>
      </div>
  </div>
</template>

<script>
import Server from "@/config/config.js";
import Utils from "@/utils.js";
export default {
  name: "login",
  data: function() {
    return {
      form: {
        username: null,
        password: null
      },
      sending: false,
      showNotification: false,
      message: null,
      error: false
    };
  },
  computed: {
    status() {
      if (!this.error) {
        return "is-success";
      } else {
        return "is-danger";
      }
    }
  },
  methods: {
    closeNotification: function() {
      this.showNotification = !this.showNotification;
    },
    login: async function() {
      this.sending = true;
      this.showNotification = false;
      await Utils.sleep(1000);
      let uri = `${Server.LOGIN_API_PATH}/${this.form.username}/${
        this.form.password
      }`;
      this.axios
        .get(uri)
        .then(response => {
          if (response.data.Username) {
            const authUser = response.data;
            window.localStorage.setItem("user", JSON.stringify(authUser));
            this.$store.state.isLoggedIn = true;
            this.$router.push("/");
            this.error = false;
          } else {
            this.message = "Username or password is incorrect!";
            this.error = true;

            this.form.password = null;
            this.showNotification = true;
          }
          this.sending = false;
        })
        .catch(error => {
          this.message = error.response.data;
          this.sending = false;
          this.showNotification = true;
          this.error = true;
        });
    }
  }
};
</script>

<style scoped>
html {
  background: #616161 !important;
  height: 100% !important;
}

.login-container {
  /* height: 100% !important; */
}

.login-form {
  margin-top: 40%;
  padding: 2rem;
  border-radius: 5px;
  border: 1px solid #424242;
  box-shadow: 4px 4px 8px #212121 !important;
}
</style>
