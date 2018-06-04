<template>
     <div>
         <div class="equipment-block">
       <div class="field is-grouped" >
            <router-link to='/equipment'>
            <button id="btn-table-view" >Table view  
            </button>
          </router-link>

          <router-link to='/equipment/card'>
            <button id="btn-table-view" disabled="disabled">Card view  
            </button>
          </router-link>
        </div>
        
        </div>

       <div class="columns">
                <div class="column is-narrow">
                    <v-card class="dashboard-tile" style="border: none !important;">
                        <div class="dashboard-tile-title">
                            <img src="../../assets/image/Crane 1.jpg" alt="Crane">
                        </div>
                        <div class="dashboard-tile-content">
                            <h2><strong>Crane 1357</strong></h2>
                            <div><span>ID: </span>1</div>
                            <div><span>Vendor's name: </span>Yamaha</div>
                            <div><span>Import's date: </span>22/04/2015</div>
                            <div><span>Price: </span>830 000 000</div>
                            <div><span>Description: </span>N/A</div>
                            <div><span>Category: </span>N/A</div>
                            <div><span>In department: </span>N/A</div>
       
                        </div>
                    </v-card>
                </div>




               

                
            </div>




        <button id="btn-add-equipment">Add Equipment</button>
    </div>
</template>

<script>
export default {
  name: "equipmentCard",
  data() {
    return {
      props: {
        name: null,
        imageUrl: null,
        status: null
      }
    };
  }
};
</script>

<style>
.dashboard-tile {
  /* border: 1px solid #bdbdbd; */
  height: 200px;
  width: 100%;
  margin-bottom: 20px;
}

.dashboard-tile-title {
  border-bottom: 1px solid #e0e0e0;
  padding: 10px 15px 10px 15px;
}

.dashboard-tile-content {
  padding: 10px 15px 10px 15px;
}

.circle-progress {
  border: 10px solid #bdbdbd;
  border-top: 10px solid green;
  border-right: 10px solid green;
  border-radius: 50%;
  width: 200px;
  height: 200px;
}

.circle-progress p {
  text-align: center;
  position: relative;
  top: 65px;
}
img {
  height: 287px;
  width: 175px;
}
</style>
