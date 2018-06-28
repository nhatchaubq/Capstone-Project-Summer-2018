<template>
  <div id="app" class="has-background-white-ter">
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

export default {
  name: "app",
  components: {
    Sidebar,
    HeaderBar,
    Login
  },
  computed: {
      isLoggedIn: sync('isLoggedIn'),
  },
  data() {
    return {
    };
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
  --lighten-danger-color: #FF6762;
  --darken-danger-color: #DA3630;
  --shadow: #9e9e9e;
  --status-request: #f44336;
  --status-checked: #304ffe;
  --status-approved: #00c853;
  --status-delivered: #ab47bc;
  --status-closed: #ffd600;
  --blue: #2196f3;
}

:focus {
  outline: 0;
}

html,
body {
  width: 100%;
  height: 100%;
  /* background-color: var(--light-background);   */
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
  background-color: white;
  border-radius: 3px;
  /* border-left: 4px solid #f44336; */
  border: 1px solid #eeeeee;
  padding: 0.3rem 0.6rem;
  /* margin: 0 5rem .5rem 5rem; */
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
  transition: all .15s ease-in-out;
}

.button.btn-danger {
  border: 0;
  color: white !important;
  background-color: var(--danger-color);
  z-index: 99;
  transition: all .15s ease-in-out;
}

.button.btn-blue {
  border: 0;
  color: white !important;
  background-color: #1976d2;
  z-index: 99;
  transition: all .15s ease-in-out;
}

.button.btn-green {
  border: 0;
  color: white !important;
  background-color: #00e676;
  z-index: 99;
  transition: all .15s ease-in-out;
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
  background-color: #328BE5;
}

button.btn-green:hover {
  cursor: pointer;
  color: white !important;
  background-color: #59BC5C;
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
  background-color: #1471CD !important;
  box-shadow: 1px 1px 1px var(--shadow) !important;
}

button.btn-green:active {
  color: white !important;
  background-color: #3EA542 !important;
  box-shadow: 1px 1px 1px var(--shadow) !important;
}

.badge {
  color: white;
  border-radius: 5px;
  font-size: 12px;
  padding: 0.2rem 0.3rem 0 0.3rem !important;
}

.emtpy-text {
  font-size: 1.1em;
  color: #9e9e9e;
  /* font-style: italic; */
}
</style>
