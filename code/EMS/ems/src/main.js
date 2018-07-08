import Vue from 'vue';
import App from './App.vue';
// import 'bulma/css/bulma.css'
import VueAxios from 'vue-axios';
import axios from 'axios';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';
import 'material-design-icons-iconfont/dist/material-design-icons.css';
import VueBar from 'vuebar';
import router from './router';
import store from './store';
import "./styles/style.scss";
import * as VueGoogleMaps from 'vue2-google-maps';
import iView from 'iview';
import 'iview/dist/styles/iview.css';

Vue.use(VueGoogleMaps, {
  load: {
    key: 'AIzaSyDRqzJSGR-awKXq6mXNO9kgCpkDpR00faU',
    libraries: 'places',
  },
});

Vue.use(VueAxios, axios);
Vue.use(Vuetify);
Vue.use(iView);
Vue.component('v-bar', VueBar);

Vue.config.productionTip = false;

router.beforeEach((to, from, next) => {
  store.state.showSearchBar = to.meta.showSearchBar;
  let authUser = JSON.parse(window.localStorage.getItem('user'));
  if (authUser) {
    if (to.name == 'login') {
      next('/');
    } else if (to.name == 'create_work_order' && authUser.RoleID != 5 && authUser.RoleID != 6) {
      next('/work_order');
    } 
    else {
      next();
    }
  }
});

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')