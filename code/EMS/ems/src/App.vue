<template>
  <div id="app">
    <v-app>
      <div class="grid-wrapper">
        <sidebar></sidebar>
        <div>
          <router-view></router-view>
        </div>
      </div>
    </v-app>
  </div>
</template>

<script>
import Sidebar from './components/Sidebar/Sidebar.vue'

export default {
  name: 'app',
  components: {
    Sidebar
  }
}
</script>

<style>
#app {
  font-family: 'Roboto';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.grid-wrapper {
  display: grid;
  height: 100%;
  grid-template-columns: 1fr 6fr;
}
</style>
