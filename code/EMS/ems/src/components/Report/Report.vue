<template>
    <div class="father">
        <div class="children material-shadow-animate">
            <div class="header-children">Equipment</div>
            <div class="content-children">
                <li>
                    <router-link to="/report/equipment/equipment_overview">
                        Equipment Overview Reports
                    </router-link>                
                </li>
                <li>
                    <router-link to="/report/equipment/equipment_status">                    
                        Equipment Status Reports
                    </router-link>
                </li>
                <li>
                 <router-link to="/report/equipment/equipment_using">                    
                        Equipment Using Reports
                    </router-link>               
                </li>
                <li>
                 <router-link to="/report/equipment/equipment_maintenance_calendar">                    
                        Equipment Maintenance Calender Reports
                    </router-link> 
                </li>
                <li>
                 <router-link to="/report/equipment/equipment_available">                    
                        Available Equipment Reports
                    </router-link> 
                </li>
            </div>
        </div>
        <div class="children material-shadow-animate" style="background-color:#FFCDD2">
            <div class="header-children" style="background-color:#E57373">Work Order</div>
            <div class="content-children">
                <li>
                    <router-link to="/report/workorder/workorder_overview">
                         Work Order Overview Reports
                    </router-link>               
                </li>
                <li>
                    <router-link to="/report/workorder/late_workorder">
                        Late Work Order Reports
                    </router-link>
                </li>
                <li>
                    <router-link to="/report/workorder/returned_workorder">
                        Returned Work Order Reports
                    </router-link>
                </li>
               
            </div>
        </div>
        <div class="children material-shadow-animate" style="background-color:#FFE0B2">
            <div class="header-children" style="background-color:#FFB74D">Location</div>
            <div class="content-children">
                <li>
                Coming Soon
                </li>
                
            </div>
        </div>
        <div class="children material-shadow-animate" style="background-color:#C5CAE9">
            <div class="header-children" style="background-color:#7986CB">Account/Team</div>
            <div class="content-children">
                <li>
                    Coming Soon
                </li>                
            </div>
        </div>
    </div>
</template>

<script>
export default {};
</script>

<style scoped>
.material-shadow-animate {
  box-shadow: 1px 1px 1px var(--shadow) !important;
  transition: all 0.2s ease-in-out;
}

.material-shadow-animate:hover {
  box-shadow: 4px 4px 8px var(--shadow) !important;
}

.father {
  width: 83%;
  height: 90.6%;
  display: grid;
  grid-template-columns: auto auto;
  grid-gap: 3rem;
  position: fixed;
  background-color: #fafafa;
}
.children {
  border-radius: 10px;
  background-color: #e0f2f1;
}
.children:hover {
}
.header-children {
  font-size: 1.5rem;
  text-align: center;
  font-weight: bold;
  padding: 0.5rem;
  color: #263238;
  background-color: #b2dfdb;
  border-bottom: 1px solid #9e9e9e;
  border-radius: 10px 10px 0px 0px;
}
.content-children {
  padding: 1.5rem;
  font-size: 1rem;
  color: #263238;
}
.content-children li a {
  color: #263238 !important;
  text-decoration: none;
}

.content-children li:hover {
  color: #78909c;
  font-style: oblique;
  cursor: pointer;
}
</style>
