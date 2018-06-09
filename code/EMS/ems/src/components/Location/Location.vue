<template>
    <div class="location-page">
      <div class="location-list">
        <div class="location-sort">
          <b>Sort By</b>
        </div>
        <div class="location-blocks">
          <div class="material-box material-shadow-animate"  v-bind:key='location.id' v-for="location in locations" v-on:click="setSelectedLocation(location)">
            <div class="location-name" >
              {{location.name}}
            </div>
            <div class="location-address">
              <i class="material-icons">place</i>
              {{location.address}}
            </div>
          </div>         
        </div>
      </div>
   
      <div v-if="selectedLocation != null" class="location-detail material-box material-shadow">  
          <div style="display: grid; grid-template-columns: 94% auto">
            <div style="font-size: 1.8rem;" >{{selectedLocation.name}}</div>
            <div id="edit-text">Edit</div>
            <div class="location-address">
              {{selectedLocation.address}}
            </div><br/>
            <div>
              Site Manager: {{selectedLocation.siteManager}}            
            </div>
            <br/> <br/>
            
            <div class="type-bar">
              <div>Equipment</div>
              <div>Work Order</div>
              <div>People</div>
              <div>Team</div>

            </div>

            

          </div>
          
      </div>
      

    </div>
</template>

<script>
import data from "@/models/location.js";
import Server from '@/config/config.js';

export default {
  data() {
    return {
      locations: [],
      selectedLocation: null,
    };
  },
  methods: {
    setSelectedLocation(location) {
      this.selectedLocation = location;
      // alert(this.selectedLocation);
    }
  },
  created( ){
    this.axios.get(Server.LOCATION_API_PATH)
      .then((response) => {
        let data = response.data.locations;
        data.forEach(location =>{
          this.locations.push(location);
        })
      }).catch((error) => {
      console.log(error);
    });
  }
};
</script>

<style scoped>
#edit-text {
  font-size: 1.3rem;
  cursor: pointer;
  text-indent: 1px;
  color: teal;
}
.location-page {
}
.location-list {
  width: 36rem;
}

.location-sort {
  height: 2.6rem;
  line-height: 2.6rem;
  /* text-justify:  */
  width: 36rem;
  background-color: lightgrey;
  text-align: center;
  font-size: 1.4rem;
}
.location-blocks {
  /* display: grid;
  grid-gap: 10px; */
  position: fixed;
  height: 37.5rem;
  padding-right: 1rem;
  width: 36rem;
  overflow-y: auto;
}

.location-blocks div {
  margin-bottom: 0.6rem;
  cursor: pointer;
}

.block {
}
.location-name {
  font-size: 1.5rem;
}
.location-address {
  font-size: 1rem;
  color: grey;
}
.location-address i {
  font-size: 1rem;
}

.location-detail {
  position: fixed;
  left: 53rem;
  top: 5.1rem;
  height: 39.5rem;
  overflow-y: auto;
  width: 40rem;
  z-index: 2;
}
.type-bar {
  border: 0.5px solid;
  border-radius: 5px;
  display: grid;
  grid-template-columns: auto auto auto auto;
  color: var(--primary-color);
  border-color: var(--primary-color);
}
.type-bar div {
  border-right: 1px solid;
  border-color: var(--primary-color);
  text-align: center;
}
.type-bar div:last-child {
  border-right: 0px;
}
.type-bar div:hover {
  cursor: pointer;
  color: white;
  background-color: var(--primary-color);
}
</style>
