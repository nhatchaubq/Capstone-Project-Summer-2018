<template>
  <div v-if="equipment">
    <div class="equipment-card material-box" style="border: none !important;">
      <!-- <div class="equipment-card-title">
        <div v-bind:key="equipment.id" v-for="equipment in equipmentpools">
        <img src="{{equipment.thumbnail}}" alt="Crane">
        </div>
      </div> -->
        <div class="equipment-image-preview">
          <img :src="equipment.Image" :alt="equipment.Name" style="width: 100%; height: 14rem;">
        </div>
        <div class="equipment-card-content" >
                <div class="field is-grouped ">
        

      <!-- <div style="color: var(--danger-color); position: relative; top: -12.5rem">
        <i class="fa fa-close"></i>
      </div> -->      
      </div>
        <!-- <img src="{{equipment.thumbnail}}" alt="Crane"> -->
          <div class="equipment-name">{{equipment.Name}}</div>
          <!-- <div><span>ID: </span>{{equipment.Id}}</div> -->
          <div>Serial code: {{equipment.SerialNumber}}</div>  
          <div>Vendor: {{equipment.Vendor.Name}}</div>
          <div>Made In:{{equipment.MadeIn}}</div>
          <div>Price:{{equipment.Price ? equipment.Price : 'n/a'}}</div>
          <div>Description: {{equipment.Description ? equipment.Description : 'n/a'}}</div>
          <div>Category: {{equipment.Category.Name}}</div>
        <!-- <div><span>In department: </span>{{equipment.department}}</div> -->
      </div>
      <div class="">
        <router-link to='/'>  
            <button class="button btn-primary material-shadow-animate" style="margin-right: 1rem">Change status</button>
        </router-link>
        <router-link  to='/'>  
            <button class="button btn-primary material-shadow-animate" >Change position</button>
        </router-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "equipment-detail-popup",
  props: {
    equipment: null
  }
};
</script>

<style>
.equipment-card {
  /* border: 1px solid #bdbdbd; */
  /* height: 200px; */
  /* width: 100%; */
  /* height: 15.5rem; */
  /* border-bottom: 1px solid #e0e0e0; */
  /* background: white; */
  padding: 0 !important;
}

.equipment-card:hover {
  cursor: auto;
}

.equipment-card-content {
  padding: 0 0.6rem;
}

.equipment-image-preview img {
  border-radius: 3px 3px 0 0;
}

.equipment-name {
    font-size: 1.7rem;
    font-weight: 500;
}

.footer {
    /* display: flex; */
}
</style>
