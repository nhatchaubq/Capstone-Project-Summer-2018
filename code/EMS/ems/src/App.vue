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
    Sidebar, HeaderBar,
  }
}
</script>

<style>
:root {
  --primary-color: #26a69a;
  /* --light-background: #e0f2f1; */
  --light-background: #fafafa;
  --dark-background: #263238;
  --danger-color: #f44336;
}

input:focus,
select:focus,
textarea:focus,
button:focus {
    outline: none;
}

html, body {
  width: 100%;
  height: 100%;
  /* background-color: var(--light-background);   */
}

#app {
  font-family: 'Roboto';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
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
  margin-left: 13.78rem;
}

.router-view {
  padding: 3rem 1.5rem;
  position: relative;
  top: 3rem;
  z-index: 1;
}

.material-box {
  background-color: white;
  border-radius: 3px;
  /* border-left: 4px solid #f44336; */
  border: 1px solid #eeeeee;
  padding: .3rem .6rem;
  box-shadow: 2px 2px 4px #bdbdbd;
  /* margin: 0 5rem .5rem 5rem; */
  transition: all .25s ease-in-out;
}

.material-box:hover {
    box-shadow: 4px 4px 8px #9e9e9e;    
    cursor: pointer;    
}

</style>
