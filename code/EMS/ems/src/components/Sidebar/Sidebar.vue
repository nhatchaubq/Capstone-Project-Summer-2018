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
        <li>
          <router-link to='/equipment'>
            <div class="sidebar-list-content">
            <i class="material-icons">build</i>
            Equipment
          </div>
          </router-link>
        </li>
        <li>
          <router-link to='/order'>
            <div class="sidebar-list-content">
            <i class="material-icons">assignment</i>
            Order
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
              <i class="material-icons">&#xe6c4;</i>
              Report
            </div>
          </router-link>
        </li>
      </ul>
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
  .sidebar {
    width: 100%;
    height: 100%;
    background-color: #35384C;
    user-select: none;
    
  }
  
  .sidebar-header {
    width: 100%;
    text-align: center;
    color: white;
    font-size: 25px;
    padding: 20px 0 20px 0;
  }

  .sidebar-list {
    width: 100%;    
  }
  
  .sidebar-list ul li {    
    list-style-type: none;
    color: white;
    font-size: 15px;  
    line-height: 60px; 
  }

  .sidebar-list ul li:hover {    
    cursor: pointer;
    background-color: cadetblue;
  }

  .sidebar li a {
    color: white;
    text-decoration: none;
  }

  .sidebar-list-content {   
    padding-left: 20px;
    height: 100%;
  }

  .sidebar-list-content > i {
    position: relative;
    top: 7px;
    margin-right: 10px;
  }
</style>
