<template>
  <div v-if="!team" class="material-box" style="width: 50%"> 
      <div class="row">
        <h2 class="col-10" style="font-size: 30px; color: #3960A4">{{vendor.BusinessName}}</h2>
        <button class="button btn-edit btn-primary material-shadow-animate " v-on:click="$store.state.vendorPage.detailPage.editMode = !editMode">Edit</button>
      </div>

    <div class="row">
      <div class="col-4" >Business address</div>
      <div class="col-7"> {{vendor.BusinessAddress}} </div>
    </div>
    <div class="row">
      <div class="col-4" >Website</div>
      <div class="col-7"> {{vendor.Website}} </div>
    </div>
    <div class="row">
      <div class="col-4" >Contact name</div>
      <div class="col-7"> {{vendor.ContactName}} </div>
    </div>
    <div class="row">
      <div class="col-4" >Contact email</div>
      <div class="col-7"> {{vendor.ContactEmail}} </div>
    </div>
    <div class="row">
      <div class="col-4" >Description</div>
      <div class="col-7"> {{vendor.Description}} </div>
    </div>





  </div>
</template>

<script>
export default {
  created() {
    let URL = `http://localhost:3000/api/vendor/${this.$route.params.id}`;
    this.axios.get(URL).then(response => {
      let data = response.data;
      this.vendor = data;
    });
  },
  data() {
    return {
      vendor: null,
      checkedActive: []
    };
  }
};
</script>

<style scoped>
.grid-wrapper {
  display: grid;

  grid-template-columns: 50% 50%;

  grid-column-gap: 1rem;

  grid-row-gap: 2rem;
}

.location-blocks {
  position: fixed;

  height: 88%;

  padding-right: 1rem;

  width: 40%;

  overflow-y: auto;
}

.location-blocks div {
  margin-bottom: 0.6rem;

  padding-left: 1rem;

  cursor: pointer;
}
#btn-add-member {
  /* position: fixed;
  right: 3rem;
  bottom: 2rem; */
  background-color: var(--primary-color);
  /* padding: 13px; */
  color: white;
  /* border-radius: 5px; */
  /* z-index: 1; */
}

#btn-add-member:hover {
  cursor: pointer;
  /* background-color: #009688;
  color: white; */
}
#btn-kick-member {
  /* position: fixed;
  right: 3rem;
  bottom: 2rem; */
  background-color: var(--danger-color);
  /* padding: 13px; */
  /* color: white; */
  /* border-radius: 5px; */
  /* z-index: 1; */
}

#btn-kick-member:hover {
  cursor: pointer;
  /* background-color: #009688;
  color: white; */
}
</style>
