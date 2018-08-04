import Vue from "vue";
import App from "./App.vue";
// import 'bulma/css/bulma.css'
import VueAxios from "vue-axios";
import axios from "axios";
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import "material-design-icons-iconfont/dist/material-design-icons.css";
import VueBar from "vuebar";
import router from "./router";
import store from "./store";
import CroudGantt from "croud-vue-gantt";
import VueWaypoint from "vue-waypoint";
import "./styles/style.scss";
import * as VueGoogleMaps from "vue2-google-maps";
import iView from "iview";
import "iview/dist/styles/iview.css";

import locale from 'iview/src/locale/lang/en-US';

import VueSocketio from "vue-socket.io";
import VPopover from "vue-js-popover";
//calendar
import VCalendar from "v-calendar";
import "v-calendar/lib/v-calendar.min.css";
import VueTruncate from "vue-truncate-filter";

Vue.use(iView);
Vue.use(VueTruncate);
Vue.use(VCalendar, {
  formats: {
    title: "MMMM YYYY",
    weekdays: "W",
    navMonths: "MMM",
    input: ["L", "YYYY-MM-DD", "YYYY/MM/DD"],
    dayPopover: "L",
    data: ["L", "YYYY-MM-DD", "YYYY/MM/DD"]
  }
});
Vue.use(VPopover, {
  tooltip: true
});
Vue.use(VueSocketio, "http://localhost:3000");

Vue.use(VueGoogleMaps, {
  load: {
    key: "AIzaSyDNEXkpy7Eb76G8TciF6DzydzD4y4tZg4c",
    libraries: "places",
  }
});
Vue.use(VueAxios, axios);
Vue.use(Vuetify);
// import locale from 'iview/src/locale/lang/en-US';
Vue.use(iView, {
  locale
});
Vue.use(CroudGantt);
Vue.use(VueWaypoint);
Vue.component("v-bar", VueBar);

Vue.config.productionTip = false;

router.beforeEach((to, from, next) => {
  store.state.showSearchBar = to.meta.showSearchBar;
  let authUser = JSON.parse(window.localStorage.getItem("user"));
  if (authUser) {
    if (to.name == "login") {
      next("/");
    } else if (to.name == 'work_order' && authUser.Role == 'Admin') {
      next('/');
    } else if (
      to.name == "create_work_order" &&
      authUser.Role != "Staff" &&
      authUser.Role != "Maintainer"
    ) {
      next("/work_order");
    } else if (to.name == "create_location" && authUser.Role != "Manager") {
      next("/location");
    } else if (to.name == "edit_location" && authUser.Role != "Manager") {
      next("/location");
    } else if (
      to.name == "report" &&
      authUser.Role != "Manager" &&
      authUser.Role != "Equipment Staff"
    ) {
      next("/");
    } else if (
      to.name == "edit_order" &&
      (authUser.Role != "Staff" && authUser.Role != "Maintainer") &&
      !to.params.edit_order
    ) {
      next("/work_order");
    } else {
      next();
    }
  }
});

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount("#app");
