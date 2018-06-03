<template>
     <div>
         <div class="equipment-block">
       <div class="field is-grouped" >
           <a href="/equipment"><button id="btn-table-view" >Table view</button></a>
            <a href="/equipment/card"><button id="btn-card-view" disabled="disabled">Card view</button></a>


        </div>
        
        </div>
        <div class="columns">
            <!-- <div class="column">
                <v-card class="dashboard-tile" style="border: none !important;">
                    <div class="dashboard-tile-title">
                        Items by status
                    </div>
                    <div class="dashboard-tile-content">
                        <div style="padding: 20px;">
                            <div class="circle-progress">
                                <p>2</p>
                                <p>Total</p>
                            </div>
                        </div>
                    </div>
                </v-card>

                <v-card class="dashboard-tile" style="border: none !important;">
                    <div class="dashboard-tile-title">
                        Items by status
                    </div>
                    <div class="dashboard-tile-content">
                        <div style="padding: 20px;">
                            <div class="circle-progress">
                                <p>2</p>
                                <p>Total</p>
                            </div>
                        </div>
                    </div>
                </v-card>
            </div> -->
            <div class="column columns">
                <div class="column">
                    <v-card class="dashboard-tile" style="border: none !important;">
                        <div class="dashboard-tile-title">
                            <img src="../../assets/image/truck.jpg"  alt="Truck">

                        </div>
                        <div class="dashboard-tile-content">
                            <h2><strong>Truck 2753</strong></h2>
                            <div><span>ID: </span>1</div>
                            <div><span>Vendor's name: </span>Toyota</div>
                            <div><span>Import's date: </span>22/03/2015</div>
                            <div><span>Price: </span>750 000 000</div>
                            <div><span>Description: </span>N/A</div>
                            <div><span>Category: </span>N/A</div>
                            <div><span>In department: </span>N/A</div>
       
                        </div>
                    </v-card>

                    <v-card class="dashboard-tile" style="border: none !important;">
                        <div class="dashboard-tile-title">
                            test5
                            
                        </div>
                        <div class="dashboard-tile-content">
                            Alo
                        </div>
                </v-card> 
                </div>
                 <div class="column">
                    <v-card class="dashboard-tile" style="border: none !important;">
                        <div class="dashboard-tile-title">
                            <img src="../../assets/image/Crane 1.jpg" alt="Crane">
                        </div>
                        <div class="dashboard-tile-content">
                            <h2><strong>Crane 8751</strong></h2>
                            <div><span>ID: </span>2</div>
                            <div><span>Vendor's name: </span>Yamaha</div>
                            <div><span>Import's date: </span>22/04/2015</div>
                            <div><span>Price: </span>950 000 000</div>
                            <div><span>Description: </span>N/A</div>
                            <div><span>Category: </span>N/A</div>
                            <div><span>In department: </span>N/A</div>
       
                        </div>
                    </v-card>

                    <v-card class="dashboard-tile" style="border: none !important;">
                        <div class="dashboard-tile-title">
                            Reservation
                        </div>
                        <div class="dashboard-tile-content">
                            Alo
                        </div>
                </v-card> 
                </div>
                 <div class="column">
                    <v-card class="dashboard-tile" style="border: none !important;">
                        <div class="dashboard-tile-title">
                            <img src="../../assets/image/Crane 1.jpg" alt="Crane">
                        </div>
                        <div class="dashboard-tile-content">
                            <h2><strong>Crane 5749</strong></h2>
                            <div><span>ID: </span>3</div>
                            <div><span>Vendor's name: </span>Yamaha</div>
                            <div><span>Import's date: </span>22/04/2015</div>
                            <div><span>Price: </span>920 000 000</div>
                            <div><span>Description: </span>N/A</div>
                            <div><span>Category: </span>N/A</div>
                            <div><span>In department: </span>N/A</div>
       
                        </div>
                    </v-card>

                    <v-card class="dashboard-tile" style="border: none !important;">
                        <div class="dashboard-tile-title">
                            Reservation
                        </div>
                        <div class="dashboard-tile-content">
                            Alo
                        </div>
                </v-card> 
                </div>
                <div class="column">
                    <v-card class="dashboard-tile" style="border: none !important;">
                        <div class="dashboard-tile-title">
                            <img src="../../assets/image/Crane 1.jpg" alt="Crane">
                        </div>
                        <div class="dashboard-tile-content">
                            <h2><strong>Crane 1357</strong></h2>
                            <div><span>ID: </span>4</div>
                            <div><span>Vendor's name: </span>Yamaha</div>
                            <div><span>Import's date: </span>22/04/2015</div>
                            <div><span>Price: </span>830 000 000</div>
                            <div><span>Description: </span>N/A</div>
                            <div><span>Category: </span>N/A</div>
                            <div><span>In department: </span>N/A</div>
       
                        </div>
                    </v-card>

                    <v-card class="dashboard-tile" style="border: none !important;">
                        <div class="dashboard-tile-title">
                            Check-outs
                        </div>
                        <div class="dashboard-tile-content">
                            Alo
                        </div>
                    </v-card>
                </div>
                
            </div>
        </div>
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
        border-radius:  50%;
        width: 200px;
        height: 200px;
    }

    .circle-progress p {
        text-align: center;
        position: relative;
        top: 65px;
    }
    img{
        height: 287px;
    width: 175px;
    }
</style>
