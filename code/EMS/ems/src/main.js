import Vue from 'vue';
import App from './App.vue';
// import 'bulma/css/bulma.css'
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';
import 'material-design-icons-iconfont/dist/material-design-icons.css';
import VueBar from 'vuebar';

import router from './router';
import store from './store';
import "./styles/style.scss";

Vue.use(Vuetify);
Vue.component('v-bar', VueBar);

Vue.config.productionTip = false;

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
