<template>
    <div>
      <div class="location-list">
        <div class="location-sort">
          <b>Sort By</b>
        </div>
        <div class="location-blocks" v-bind:key='location.id' v-for="location in locations">
          <div class="block">
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
      <div class="location-detail">

      </div>

    </div>
</template>

<script>
import data from "@/models/location.js";

export default {
  data() {
    return {
      locations: data,
      selectedLocation: null
    };
  }
};
</script>

<style scoped>
.location-list {
  width: 45%;
}
.location-sort {
  height: 2.6rem;
  line-height: 2.6rem;
  /* text-justify:  */
  background-color: lightgrey;
  text-align: center;
  font-size: 1.4rem;
}
.location-blocks {
  display: grid;
  grid-gap: 10px;
}
.block{
  border: 1px solid;
  border-radius: 5px;
  

}
</style>
