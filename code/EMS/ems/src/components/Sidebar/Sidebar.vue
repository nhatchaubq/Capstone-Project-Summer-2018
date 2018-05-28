<template>
  <div class="sidebar">
    <div class="sidebar-header">
      <span>EMS</span>
    </div>
    <div class="sidebar-list">
      <ul>
        <li>
          <router-link to='/'>
            <div class="sidebar-list-content">
              <i class="material-icons">dashboard</i>
              Dashboard
            </div>
          </router-link>
        </li>
        <div class="divider"></div>
        
        <li>
          <router-link to='/work_order'>
            <div class="sidebar-list-content">
            <i class="material-icons">assignment</i>
            Work Orders
          </div>
          </router-link>
        </li>
        <li>
          <router-link to='/calendar'>
            <div class="sidebar-list-content">
            <i class="material-icons">event</i>            
            Calendar
          </div>
          </router-link>
        </li>
        <li>
          <router-link to='/report'>
            <div class="sidebar-list-content">
              <i class="material-icons">poll</i>
              Report
            </div>
          </router-link>
        </li>
        <div class="divider"></div>
        
        <li>
          <router-link to='/equipment'>
            <div class="sidebar-list-content">
            <i class="material-icons">build</i>
            Equipment
          </div>
          </router-link>
        </li>
        <li>
          <router-link to='/equipment'>
            <div class="sidebar-list-content">
            <i class="material-icons">location_on</i>
            Location
          </div>
          </router-link>
        </li>
        <div class="divider"></div>
        
        <li>
          <router-link to='/equipment'>
            <div class="sidebar-list-content">
            <i class="material-icons">domain</i>
            Vendors
          </div>
          </router-link>
        </li>
        <li>
          <router-link to='/equipment'>
            <div class="sidebar-list-content">
            <i class="material-icons">people</i>
            Team & People
          </div>
          </router-link>
        </li>

      </ul>
    </div>
    <div class="sidebar-end">
      <div class="container">
        <img class="circle-avatar" src="@/assets/man-avatar.png"/>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'sidebar',
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
    border-radius: 50%;
    width: 50px;
    height: 50px;
  }
</style>
