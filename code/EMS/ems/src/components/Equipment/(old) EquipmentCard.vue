<template>
  <div class="grid-wrapper" v-if="equipments">
    <div class="equipment-card material-box material-shadow-animate" style="border: none !important;" v-bind:key="equipment.id" v-for="equipment in equipments">
      <!-- <div class="equipment-card-title">
        <div v-bind:key="equipment.id" v-for="equipment in equipmentpools">
        <img src="{{equipment.thumbnail}}" alt="Crane">
        </div>
      </div> -->
        <div class="equipment-image-preview">
          <img :src="equipment.Image" :alt="equipment.Name" style="width: 100%; height: 12rem;">
        </div>
        <div class="equipment-card-content" >
                <div class="field is-grouped ">
        

      <div style="color: var(--danger-color); position: relative; top: -12.5rem">
        <i class="fa fa-close"></i>
      </div>
      <router-link to='/'>  
        <button class="btn-view-mode" >Change status</button>
      </router-link>
            <router-link to='/'>  
        <button class="btn-view-mode" >Change position</button>
      </router-link>
      </div>
        <!-- <img src="{{equipment.thumbnail}}" alt="Crane"> -->
          <h2><strong>{{equipment.Name}}</strong></h2>
          <!-- <div><span>ID: </span>{{equipment.Id}}</div> -->
          <div><span>Serial code:</span>{{equipment.SerialNumber}}</div>  
          <div><span>Vendor: </span>{{equipment.Vendor.Name}}</div>
          <div><span>Made In: </span>{{equipment.MadeIn}}</div>
          <!-- <div><span>Price: </span>{{equipment.Price ? equipment.Price : 'n/a'}}</div> -->
          <div><span>Description: </span>{{equipment.Description ? equipment.Description : 'n/a'}}</div>
          <div><span>Category: </span>{{equipment.Category.Name}}</div>
        <!-- <div><span>In department: </span>{{equipment.department}}</div> -->
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "equipment-card",
  props: {
    equipments: null
  }
};
</script>

<style>
.grid-wrapper {
  display: grid;
  grid-template-columns: auto auto auto auto;
  grid-column-gap: 1rem;
  grid-row-gap: 2rem;
}
.equipment-card {
  /* border: 1px solid #bdbdbd; */
  /* height: 200px; */
  width: 100%;
  /* height: 15.5rem; */
  /* border-bottom: 1px solid #e0e0e0; */
  padding: 0 !important;
}

.equipment-card:hover {
  cursor: pointer;
}

.equipment-card-content {
  padding: 0.6rem;
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

.equipment-image-preview img {
  border-radius: 3px 3px 0 0;
}

.btn-view-mode {
  background-color: white;
  padding: 0.4rem 0.6rem;
  /* height: 2rem; */
  font-size: 15px;
  /* line-height: 2rem; */
  color: var(--primary-color);
  border-radius: 5px 5px 5px 5px;
  border: 1px solid #26a69a;
  z-index: 1;
  /* padding-right: 20px;
      padding-left: 20px; */
  margin-right: 5px;
}

.btn-view-mode:hover {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}
</style>
