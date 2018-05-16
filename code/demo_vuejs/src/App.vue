<template>
  <div id="app">
    <app-nav />
    <router-view/>
  </div>
</template>

<script>
import AppNav from './components/AppNav.vue'

export default {
  name: 'app',
  components: {
    AppNav
  }
}
</script>

<style>
#app {
  font-family: 'Roboto';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}
</style>
