<template>
  <div id="app">
    <v-app>
      <div>
        <sidebar id="sidebar"></sidebar>
        <div id="main">
          <header-bar></header-bar>
          <router-view class="router-view"></router-view>
        </div>
      </div>
    </v-app>
  </div>
</template>

<script>
import Sidebar from './components/Sidebar/Sidebar.vue';
import HeaderBar from './components/HeaderBar/HeaderBar';

export default {
  name: 'app',
  components: {
    Sidebar, HeaderBar
  }
}
</script>

<style>
:root {
  --primary-color: #26a69a;
  --light-background: #f5f5f5;
  --dark-background: #263238;
  --danger-color: #f44336;
}

input:focus,
select:focus,
textarea:focus,
button:focus {
    outline: none;
}

#app {
  font-family: 'Roboto';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color: var(--light-background);
  height: 100%;
}

.grid-wrapper {
  display: grid;
  /* height: 100%; */
  grid-template-columns: 20% 80%;
  /* position: relative; */
}

#sidebar {
  position: fixed;
  width: 13rem;
  height: 100%;
  z-index: 1;
  top: 0;
  left: 0;
}

#main {
  margin-left: 13rem;
}

.router-view {
  padding: 1rem 2rem 0 2rem;
}
</style>
