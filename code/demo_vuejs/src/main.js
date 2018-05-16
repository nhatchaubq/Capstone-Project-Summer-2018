import Vue from 'vue'
import App from './App.vue'
// import VueMaterial from 'vue-material'
// import 'vue-material/dist/vue-material.min.css'
// import 'vue-material/dist/theme/default.css'
import axios from 'axios';
import VueAxios from 'vue-axios';
import 'bulma/css/bulma.css'

import router from './router'

Vue.use(VueAxios, axios);
Vue.config.productionTip = false
// Vue.use(VueMaterial)

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
