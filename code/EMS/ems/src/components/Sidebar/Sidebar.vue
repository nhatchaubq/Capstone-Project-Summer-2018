<template>
  <div class="sidebar">
    <div class="sidebar-header">
      <img :src="require('@/assets/ems-logo.png')"/>
    </div>
    <div class="sidebar-list">
      <ul>
        <li>
          <router-link to='/'>
            <div class="sidebar-list-content" :class="isActive('Dashboard')">
              <i class="material-icons">dashboard</i>
              Dashboard
            </div>
          </router-link>
        </li>
        <div class="divider"></div>
        
        <li>
          <router-link to='/work_order'>
            <div class="sidebar-list-content" :class="isActive('Work Order')">
              <i class="material-icons">assignment</i>
              Work Orders
            </div>
          </router-link>
        </li>
        <li>
          <router-link to='/calendar'>
            <div class="sidebar-list-content" :class="isActive('Calendar')">
            <i class="material-icons">event</i>            
            Calendar
          </div>
          </router-link>
        </li>
        <li>
          <router-link to='/report'>
            <div class="sidebar-list-content" :class="isActive('Report')">
              <i class="material-icons">poll</i>
              Report
            </div>
          </router-link>
        </li>
        <div class="divider"></div>
            
        <li>
          <router-link to='/equipment'>
            <div class="sidebar-list-content" :class="isActive('Equipment')">
            <i class="material-icons">domain</i>
            Equipment
          </div>
          </router-link>
        </li>
        <li>
          <router-link to='/location'>
            <div class="sidebar-list-content" :class="isActive('Location')">
              <i class="material-icons">location_on</i>
              Location
            </div>
          </router-link>
        </li>
        <div class="divider"></div>
        
        <li>
          <router-link to='/vendors'>
            <div class="sidebar-list-content" :class="isActive('Vendors')">
            <i class="material-icons">domain</i>
            Vendors
          </div>
          </router-link>
        </li>
        <li>
          <router-link to='/teams'>
            <div class="sidebar-list-content" v-bind:class="isActive('Teams')">
            <i class="material-icons">people</i>
            Teams & People
          </div>
          </router-link>
        </li>
        
      </ul>
    </div>
    <div class="sidebar-end">
      <div class="circle-avatar-container" v-on:click="logout()">
        <img class="circle-avatar" v-bind:src="getUserAvatar()"/>
      </div>
    </div>
  </div>
</template>

<script>
import { sync } from "vuex-pathify";
export default {
  name: "sidebar",
  computed: {
    currentSelected: sync("title")
  },
  methods: {
    isActive(title) {
      if (title === this.currentSelected) {
        return "is-active";
      }
      return "";
    },
    getUserAvatar() {
      const authUser = JSON.parse(window.localStorage.getItem("user"));
      if (authUser && authUser.AvatarImage) {
        return authUser.AvatarImage;
      } else {
        return require("@/assets/avatar-user.png");
      }
    },
    logout() {
      this.$store.state.isLoggedIn = false;
      window.localStorage.removeItem("user");
      // this.$router.push('/');
      vm.$forceUpdate();
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.divider {
  border-bottom: 1px solid #b2dfdb;
  margin: 10px 0 10px 0;
}

.sidebar {
  /* width: 100%; */
  /* height: 100%; */
  background-color: var(--dark-background);
  user-select: none;
}

.sidebar-header {
  /* width: 100%; */
  /* text-align: center;
  color: #b2dfdb; */
  /* font-size: 25px; */
  padding: 1rem 0;
}

.sidebar-list {
  width: 100%;
}

.sidebar-list ul li {
  list-style-type: none;
  font-size: 1rem;
  line-height: 3.2rem;
}

.sidebar li a {
  color: #b2dfdb;
  text-decoration: none;
  transition: all 0.15s ease-in-out;
}

.sidebar-list ul li:hover a {
  cursor: pointer;
  color: #26a69a;
}

.is-active {
  color: #26a69a;
}
.sidebar-list-content {
  padding-left: 20px;
}

.sidebar-list-content > i {
  position: relative;
  top: 7px;
  margin-right: 20px;
}

.sidebar-end {
  position: fixed;
  bottom: 0;
  width: 100%;
}

.circle-avatar-container {
  position: relative;
  left: 5rem;
  bottom: 0.8rem;
  border-radius: 50%;
  border: 1px solid var(--primary-color);
  width: 2.7rem;
  height: 2.7rem;
}

.circle-avatar-container:hover {
  cursor: pointer;
}

.circle-avatar {
  position: relative;
  border-radius: 50%;
  /* left: 5rem;
    bottom: .8rem; */
}
</style>
