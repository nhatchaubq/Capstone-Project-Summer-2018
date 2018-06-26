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

Vue.use(VueGoogleMaps, {
  load: {
    key: 'AIzaSyDRqzJSGR-awKXq6mXNO9kgCpkDpR00faU',
    libraries: 'places',
  },
});

Vue.use(VueAxios, axios);
Vue.use(Vuetify);
Vue.component('v-bar', VueBar);

Vue.config.productionTip = false;

router.beforeEach((to, from, next) => {
  if (to.name == 'login') {
    next('/');
  } else {
    store.state.showSearchBar = to.meta.showSearchBar;
    next();
  }
});

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')