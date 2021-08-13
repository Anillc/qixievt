import Vue from 'vue'
import Vuetify from 'vuetify'

import App from './App.vue'

Vue.use Vuetify

Vue.config.productionTip = false

vuetify = new Vuetify
  theme:
    themes:
      light:
        primary: '#000000'
        secondary: '#000000'
        accent: '#000000'
        error: '#000000'
        warning: '#000000'
        info: '#000000'
        success: '#000000'

vue = new Vue {
  render: (h) -> h App
  vuetify
}

vue.$mount '#app'