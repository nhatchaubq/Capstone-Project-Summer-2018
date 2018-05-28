import Vue from 'vue'
import App from './App.vue'
// import 'bulma/css/bulma.css'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import 'material-design-icons-iconfont/dist/material-design-icons.css'

import router from './router'
 
Vue.use(Vuetify)

require('./styles/style.scss')
Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
