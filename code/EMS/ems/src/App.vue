<template>
  <div id="app">
    <login v-if="!isLoggedIn"></login>
    <div v-else>
      <v-app>
        <div>
          <sidebar id="sidebar"></sidebar>
          <div id="main">
            <header-bar></header-bar>
            <router-view class="router-view"></router-view>
          </div>
        </div>
      </v-app>
    </div>
  </div>
</template>

<script>
import { sync } from "vuex-pathify";
import Login from "./components/Login/Login";
import Sidebar from "./components/Sidebar/Sidebar.vue";
import HeaderBar from "./components/HeaderBar/HeaderBar";

import Server from "@/config/config";
import Vue from "vue";
var VueTruncate = require("vue-truncate-filter");
Vue.use(VueTruncate);

export default {
  name: "app",
  components: {
    Sidebar,
    HeaderBar,
    Login
  },
  computed: {
    isLoggedIn: sync("isLoggedIn"),
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    }
  },
  created() {
    this.getNotifications();
  },
  sockets: {
    NEW_NOTIFICATION: function() {
      if (this.authUser.Role != 'Admin') {
        this.getNotifications();
      }
    },
    WEB_CONFIG: function(data) {
      this.$store.state.config = data;
    },
  },
  data() {
    return {};
  },
  methods: {
    getNotifications() {
      let url = `${Server.NOTIFICATION_API_PATH}/top50/${this.authUser.Id}`;
      this.axios
        .get(url)
        .then(res => {
          if (res.status == 200) {
            let notifications = [];
            res.data.forEach(value => {
              let noti = {
                Id: value.Id,
                Content: value.Content,
                CreatedDate: value.CreatedDate,
                TimeString: null,
                Status: value.Status,
                Metadata: value.Metadata
              };
              notifications.push(noti);
            });
            this.$store.state.notifications = notifications;
          }
        })
        .catch(error => {
          console.log(error);
        });
    }
  }
};
</script>

<style>
:root {
  --primary-color: #26a69a;
  --darken-primary-color: #229488;
  --lighten-primary-color: #2ebaac;
  --secondary-color: #80deea;
  --light-background: #fafafa;
  --dark-background: #263238;
  --success-color: #00c853;
  --danger-color: #ef5350;
  --cancel-color: #ffab91;

  --warning-color: #ffc107;
  --strong-warning-color: #ff7b07;
  --lighten-danger-color: #ff6762;
  --darken-danger-color: #da3630;

  --shadow: #9e9e9e;
  --status-requested: #7b1fa2;
  --status-checked: #3f51b5;
  --status-approved: #689f38;
  --status-rejected: #b71c1c;
  --status-in-progress: #ffc107;
  --status-closed: #424242;
  --status-cancelled: #9e9e9e;
  --blue: #2196f3;
}

/* :focus {
  outline: 0 !important; */

:focus {
  /* outline: none !important; */
  outline: 0 !important;
  outline-style: none !important;
}

html,
body {
  width: 100%;
  height: 100%;
  font-size: 1rem !important;
  background-color: #616161 !important;
}

a {
  color: hsl(217, 71%, 53%) !important;
}
a:hover {
  color: hsl(217, 79%, 58%) !important;
}
a:active {
  color: hsl(217, 71%, 30%) !important;
}

.ivu-page-item-active a {
  color: white !important;
}
.ivu-page-item-active {
  background-color: var(--primary-color) !important;
}

#app {
  font-family: "Roboto";
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  height: 100%;
}

.grid-wrapper {
  display: grid;
  /* height: 100%; */
  grid-template-columns: 20% 80%;
  /* position: relative; */
}

#sidebar {
  position: fixed;
  width: 18%;
  height: 100%;
  z-index: 1;
  top: 0;
  left: 0;
}

#main {
  margin-left: 18%;
  width: 82%;
  /* background: #26a69a */
}

.router-view {
  padding: 1rem 2rem;
  height: 100%;
  /* position: relative;
  top: 3rem; */
  z-index: 1;
}

.material-box {
  background: white !important;
  border-radius: 3px;
  /* border-left: 4px solid #f44336; */
  border: 1px solid #eeeeee;
  padding: 0.3rem 0.6rem;
  transition: all 0.2s;
  /* margin: 0 5rem .5rem 5rem; */
}

.is-active-block {
  /* background-color: #e0e0e0 !important; */
  background-color: #bdbdbd !important;
  /* border: 1px solid #e0e0e0 !important; */
  border: 1px solid #bdbdbd !important;
  box-shadow: 1px 1px 1px var(--shadow) !important;
}

.is-active-block:hover {
  background-color: #e0e0e0 !important;
  box-shadow: 1px 1px 2px var(--shadow) !important;
}

.material-shadow {
  box-shadow: 2px 2px 4px var(--shadow) !important;
}

.material-shadow-animate {
  box-shadow: 2px 2px 4px var(--shadow) !important;
  transition: all 0.2s ease-in-out;
}

.material-shadow-animate:hover {
  box-shadow: 4px 4px 8px var(--shadow) !important;
}

.button.btn-primary {
  border: 0;
  color: white !important;
  background-color: var(--primary-color);
  z-index: 99;
  transition: all 0.15s ease-in-out;
}

.button.btn-danger {
  border: 0;
  color: white !important;
  background-color: var(--danger-color);
  z-index: 99;
  transition: all 0.15s ease-in-out;
}

.button.btn-blue {
  border: 0;
  color: white !important;
  background-color: #1976d2;
  z-index: 99;
  transition: all 0.15s ease-in-out;
}

.button.btn-green {
  border: 0;
  color: white !important;
  background-color: #00e676;
  z-index: 99;
  transition: all 0.15s ease-in-out;
}

button.btn-primary:hover {
  cursor: pointer;
  color: white !important;
  background-color: var(--lighten-primary-color);
}

button.btn-danger:hover {
  cursor: pointer;
  color: white !important;
  background-color: var(--lighten-danger-color);
}

button.btn-blue:hover {
  cursor: pointer;
  color: white !important;
  background-color: #328be5;
}

button.btn-green:hover {
  cursor: pointer;
  color: white !important;
  background-color: #59bc5c;
}

button.btn-primary:active {
  color: white !important;
  background-color: var(--darken-primary-color) !important;
  box-shadow: 1px 1px 1px var(--shadow) !important;
}

button.btn-danger:active {
  color: white !important;
  background-color: var(--darken-danger-color) !important;
  box-shadow: 1px 1px 1px var(--shadow) !important;
}

button.btn-blue:active {
  color: white !important;
  background-color: #1471cd !important;
  box-shadow: 1px 1px 1px var(--shadow) !important;
}

button.btn-green:active {
  color: white !important;
  background-color: #3ea542 !important;
  box-shadow: 1px 1px 1px var(--shadow) !important;
}

.badge {
  color: white;
  border-radius: 5px;
  font-size: 12px;
  padding: 0.2rem 0.3rem 0 0.3rem !important;
}

.error-text {
  color: var(--danger-color);
  font-size: 0.9rem;
  font-weight: 500;
  font-style: italic;
}

.warning-text {
  color: var(--warning-color);
  font-size: 0.9rem;
  font-weight: 500;
  font-style: italic;
}

.strong-warning-text {
  color: var(--strong-warning-color);
  font-size: 0.9rem;
  font-weight: 500;
  font-style: italic;
}

.emtpy-text {
  font-size: 1.1em;
  color: #9e9e9e;
  /* font-style: italic; */
}

.tag {
  user-select: none;
}

.tag.requested {
  background-color: var(--status-requested);
  border: 1px solid var(--status-requested) !important;
  color: white;
}

.tag.checked {
  background-color: var(--status-checked);
  border: 1px solid var(--status-checked) !important;
  color: white;
}

.tag.approved {
  background-color: var(--status-approved);
  border: 1px solid var(--status-approved) !important;
  color: white;
}

.tag.rejected {
  background-color: var(--status-rejected) !important;
  border: 1px solid var(--status-rejected) !important;
  color: white;
}

.tag.in-progress {
  background-color: var(--status-in-progress);
  border: 1px solid var(--status-in-progress) !important;
  color: white;
}

.tag.closed {
  background-color: var(--status-closed);
  border: 1px solid var(--status-closed) !important;
  color: white;
}

.tag.cancelled {
  background-color: var(--status-cancelled);
  border: 1px solid var(--status-cancelled) !important;
  color: white;
}

thead {
  cursor: default;
  user-select: none;
  background: #eeeeee;
  border-bottom: 2px solid #e0e0e0;
}

th {
  font-size: 0.95rem !important;
  font-weight: 450 !important;
  height: 3rem;
  padding: 0 0.5rem !important;
  vertical-align: middle !important;
}

tr {
  cursor: pointer;
}

td {
  height: 3rem;
  padding: 0.8rem 0.5rem 0 0.5rem !important;
}

.row-odd {
  background: white;
}

.row-even {
  background: #eeeeee;
}
.ivu-page-item-active {
  /* background-color: #26a69a; */
  background-color: #26a69a !important;
}
.ivu-page-item-active a {
  /* background-color: #26a69a; */
  color: white !important;
}

.form-title {
  display: grid;
  grid-template-columns: 65% 35%;
  border-bottom: 1px solid #e0e0e0;
  padding: .5rem 2rem;
  box-shadow: 0px 3px 5px var(--shadow);
  z-index: 5;
}
</style>
