<template>
  <div class="sidebar">
    <div class="sidebar-header">
      <img :src="require('@/assets/ems-logo.png')"/>
    </div>
    <div class="sidebar-list">
      <ul>
        <li>
          <router-link to='/'>
            <div class="sidebar-list-content" :class="isActive(menu.Dashboard)">
              <i class="material-icons">dashboard</i>
              {{ menu.Dashboard }}
            </div>
          </router-link>
        </li>
        <div class="divider"></div>
        
        <li v-if="authUser.Role != 'Admin'">
          <router-link to='/work_order'>
            <div class="sidebar-list-content" :class="isActive(menu.WorkOrder)">
              <i class="material-icons">assignment</i>
              {{ menu.WorkOrder }}
            </div>
          </router-link>
        </li>
        <li v-if="authUser.Role != 'Admin'">
          <router-link to='/schedule'>
            <div class="sidebar-list-content" :class="isActive(menu.Schedule)">
              <i class="material-icons">event</i>            
              {{ menu.Schedule }}
            </div>
          </router-link>
        </li>
        <li v-if="false">
          <router-link to='/report'>
            <div class="sidebar-list-content" :class="isActive(menu.Report)">
              <i class="material-icons">poll</i>
              {{ menu.Report }}
            </div>
          </router-link>
        </li>   
        <div class="divider" v-if="authUser.Role != 'Admin'"></div>
            
        <li>
          <div style="display:grid; grid-template-columns: 85% 15%">
            <div>
              <router-link to='/equipment'>
                <div class="sidebar-list-content" :class="isActive(menu.Equipment)">
                <i class="material-icons">build</i>
                {{ menu.Equipment }}
                </div>
              </router-link>
            </div>          
            <div class="submenu-show" v-on:click="submenu = !submenu" v-if="authUser.Role =='Equipment Staff'">
              <i class="material-icons">expand_more</i>
            </div>
          </div>              
        </li>
        <li v-if="submenu" >
           <div class="submenu sidebar-list-content">
            <ul>
              <li>
                <router-link to="/category">                  
                  <i class="material-icons">chevron_right</i>
                  Category
                </router-link>
              </li>
              <li>
                <router-link to="/Unit">
                  <i class="material-icons">chevron_right</i>
                  Unit
                </router-link>
              </li>  
              <li>
                <router-link to="/duration">
                  <i class="material-icons">chevron_right</i>
                  Duration Maintenance
                </router-link>
              </li>    
            </ul>  
          </div>     
        </li>        
        <li v-if="authUser.Role != 'Admin' && authUser.Role != 'Maintainer'">

          <router-link to='/location'>
            <div class="sidebar-list-content" :class="isActive(menu.Location)">
              <i class="material-icons">location_on</i>
              {{ menu.Location }}
            </div>
          </router-link>
        </li>
        <div class="divider"></div>
        
        <li v-if="authUser.Role =='Equipment Staff'">
          <router-link to='/vendor'>
            <div class="sidebar-list-content" :class="isActive(menu.Vendors)">
            <i class="material-icons">domain</i>
            {{ menu.Vendors }}
          </div>
          </router-link>
        </li>
        <li v-if="authUser.Role =='Manager'">
          <router-link to='/account'>
            <div class="sidebar-list-content" v-bind:class="isActive(menu.Accounts)">
            <i class="material-icons">people</i>
           {{ menu.AccountsTeams }}
          </div>
          </router-link>
        </li>
        <li v-if="authUser.Role =='Admin'">
          <router-link to='/account'>
            <div class="sidebar-list-content" v-bind:class="isActive(menu.Accounts)">
            <i class="material-icons">people</i>
           {{ menu.Accounts }}
          </div>
          </router-link>
        </li>
        <li v-if="authUser.Role =='Admin'">
          <router-link to='/configuration'>
            <div class="sidebar-list-content" v-bind:class="isActive(menu.Configuration)">
            <i class="material-icons">settings_applications</i>
           {{ menu.Configuration }}
          </div>
          </router-link>
        </li>
        

      </ul>
    </div>
    <!-- <div class="sidebar-end">
      <div class="circle-avatar-container" v-on:click="logout()">
        <img class="circle-avatar" v-bind:src="getUserAvatar()"/>
      </div>
    </div> -->
  </div>
</template>

<script>
import menuData from "@/models/menu.js";
import { sync } from "vuex-pathify";
export default {
  name: "sidebar",
  computed: {
    currentSelected: sync("title"),
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    }
  },
  data() {
    return {
      menu: menuData,
      submenu: false
    };
  },
  methods: {
    isActive(title) {
      if (title === this.currentSelected) {
        return "is-active";
      }
      return "";
    }
    // getUserAvatar() {
    //   const authUser = JSON.parse(window.localStorage.getItem("user"));
    //   if (authUser && authUser.AvatarImage) {
    //     return authUser.AvatarImage;
    //   } else {
    //     return require("@/assets/avatar-user.png");
    //   }
    // },
    // logout() {
    //   this.$store.state.isLoggedIn = false;
    //   window.localStorage.removeItem("user");
    //   this.$router.push("/");
    // }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.x {
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
  color: #b2dfdb !important;
  text-decoration: none;
  transition: all 0.15s ease-in-out;
}

.submenu ul li:hover a {
  cursor: pointer;
  color: #26a69a !important;
}

.is-active {
  color: #26a69a !important;
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
  /* position: fixed;
  bottom: 0;
  width: 100%; */
}

.circle-avatar-container {
  position: fixed;
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
.submenu-show {
  color: #b2dfdb !important;
}
.submenu-show i {
  position: relative;
  top: 0.5rem;
  left: 0.5rem;
}
.submenu-show :hover {
  cursor: pointer;
  color: #26a69a !important;
}

.submenu {
  position: relative;

  z-index: 99;
}
.submenu ul li {
  color: #b2dfdb;
  padding-left: 1.7rem;
  font-size: 0.9rem;
  line-height: 1.3rem;
}
li :hover {
  cursor: pointer;
  color: #26a69a !important;
}
.submenu i {
  position: relative;
  top: 0.4rem;
}
</style>
