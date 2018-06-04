<template>
  <div class="sidebar">
    <div class="sidebar-header">
      <span>EMS</span>
    </div>
    <div class="sidebar-list">
      <ul>
        <li>
          <router-link to='/'>
            <div class="sidebar-list-content" v-bind:class="isActive('Dashboard')">
              <i class="material-icons">dashboard</i>
              Dashboard
            </div>
          </router-link>
        </li>
        <div class="divider"></div>
        
        <li>
          <router-link to='/work_order'>
            <div class="sidebar-list-content" v-bind:class="isActive('Work Order')">
              <i class="material-icons">assignment</i>
              Work Orders
            </div>
          </router-link>
        </li>
        <li>
          <router-link to='/calendar'>
            <div class="sidebar-list-content" v-bind:class="isActive('Calendar')">
            <i class="material-icons">event</i>            
            Calendar
          </div>
          </router-link>
        </li>
        <li>
          <router-link to='/report'>
            <div class="sidebar-list-content" v-bind:class="isActive('Report')">
              <i class="material-icons">poll</i>
              Report
            </div>
          </router-link>
        </li>
        <div class="divider"></div>
            
        <li>
          <router-link to='/equipment'>
            <div class="sidebar-list-content" v-bind:class="isActive('Equipment')">
            <i class="material-icons">domain</i>
            Equipment
          </div>
          </router-link>
        </li>
        <li>
          <router-link to='/location'>
            <div class="sidebar-list-content" v-bind:class="isActive('Location')">
              <i class="material-icons">location_on</i>
              Location
            </div>
          </router-link>
        </li>
        <div class="divider"></div>
        
        <li>
          <router-link to='/vendors'>
            <div class="sidebar-list-content" v-bind:class="isActive('Vendors')">
            <i class="material-icons">domain</i>
            Vendors
          </div>
          </router-link>
        </li>
        <li>
          <router-link to='/teams'>
            <div class="sidebar-list-content" v-bind:class="isActive('Teams')">
            <i class="material-icons">people</i>
            Teams 
          </div>
          </router-link>
        </li>
        <li>
          <router-link to='/accounts'>
            <div class="sidebar-list-content" v-bind:class="isActive('Accounts')">
            <i class="material-icons">account_box</i>
            Accounts
          </div>
          </router-link>
        </li>
        
      </ul>
    </div>
    <div class="sidebar-end">
        <img class="circle-avatar" src="@/assets/man-avatar.png"/>
    </div>
  </div>
</template>

<script>
import { sync } from 'vuex-pathify';
export default {
  name: 'sidebar',
  computed: {
      currentSelected: sync('title'),    
  },
  methods: {
    isActive(title) {
      if (title === this.currentSelected) {
        return 'is-active';
      }
      return '';
    }
  }
}
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
    width: 100%;
    text-align: center;
    color: #b2dfdb;
    font-size: 25px;
    padding: 20px 0 20px 0;
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
    transition: all .15s ease-in-out;
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

  .circle-avatar {
    position: relative;
    left: 5rem;
    border-radius: 50%;
    width: 50px;
    height: 50px;
  }
</style>
