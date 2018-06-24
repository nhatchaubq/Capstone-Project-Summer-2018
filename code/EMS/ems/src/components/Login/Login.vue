<template>
  <div class="login-container">
      
      <div class="columns">
        <div class="column"></div>
        <div class="column is-one-quarter">            
            <div class="login-form material-box material-shadow">
                <h2 class="title is-2">Login</h2>
                <span v-show="showNotification" class="has-text-danger">
                    {{ message }}
                </span>
                <form @submit.prevent="login">
                    <div class="field">
                        <label class="label">Username</label>
                        <div class="control">
                            <input class="input" type="text" v-model="form.username" placeholder="JohnSmith" required/>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Password</label>
                        <div class="control">
                            <input class="input" type="password" v-model="form.password" placeholder="password" required/>
                        </div>
                    </div>
                    <div class="field">
                        <label class="checkbox">
                            <input type="checkbox"/>
                            Remember my login.
                        </label>
                    </div>
                    <div class="field">
                        <div class="control">
                            <button class="button is-primary">
                                Login
                                <i v-show="sending" class="fa fa-circle-o-notch fa-spin" style="margin-left: 5px;"></i>
                            </button>
                        </div>
                    </div>
                </form>            
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
.login-container {
  height: 100% !important;
}

.login-form {
  margin-top: -3rem;
  padding: 2rem 2rem;
  position: relative;
  /* top: 50%; */
  transform: perspective(1px) translateY(50%);
}
</style>
