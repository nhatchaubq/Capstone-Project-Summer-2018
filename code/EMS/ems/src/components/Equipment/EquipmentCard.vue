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
        <!-- <img src="{{equipment.thumbnail}}" alt="Crane"> -->
          <h2><strong>{{equipment.Name}}</strong></h2>
          <!-- <div><span>ID: </span>{{equipment.Id}}</div> -->
          <div><span>Category: </span>{{equipment.Category.Name}}</div>
          <div><span>Vendor: </span>{{equipment.Vendor.Name}}</div>
          <div><span>Import date: </span>{{equipment.ImportDate}}</div>
          <div><span>Price: </span>{{equipment.Price ? equipment.Price : 'n/a'}}</div>
          <div><span>Description: </span>{{equipment.Description ? equipment.Description : 'n/a'}}</div>
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
</style>
