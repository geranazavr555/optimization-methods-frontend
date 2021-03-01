import UniqueId from "vue-unique-id";

import Vue from 'vue'
import App from './App.vue'

Vue.config.productionTip = false
Vue.use(UniqueId);

new Vue({
  render: h => h(App),
}).$mount('#app')
