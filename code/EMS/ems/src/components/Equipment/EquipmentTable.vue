<template>
    <div v-if="equipments">
        <table class="table">
            <thead>
                <tr>
                    <th><strong>Order #</strong></th>
                    <th><strong>Equipment name</strong></th>
                    <th><strong>Vendor name</strong></th>
                    <th><strong>Made In</strong></th>
                    <th><strong>Description</strong></th>
                    <th><strong>Category</strong></th>
                </tr>
            </thead>  
            <tbody>
                <tr v-bind:key="equipment.id" v-for="(equipment, index) in equipments">
                    <td>{{ index + 1 }}</td>    
                    <td>{{equipment.Name}}</td>
                    <td>{{equipment.Vendor.Name}}</td>
                    <td>{{equipment.MadeIn}}</td>
                    <!-- <td>{{equipment.Price ? equipment.Price : 'n/a'}}</td> -->
                    <td>{{equipment.Description ? equipment.Description : 'n/a' }}</td>
                    <td>{{equipment.Category.Name}}</td>
                </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
export default {
  name: "equipment-table",
  props: {
    equipments: null
  }
};
</script>

<style>
table {
  /* border: 1px solid black; */
  width: 100%;
  /* text-align: right; */
}

th {
  text-align: left;
  background-color: #cfd8dc;
}

td {
  vertical-align: middle;
  /* text-align: justify; */
}

tr:nth-child(odd) {
  background-color: white;
  color: #263238;
}

tr:nth-child(even) {
  background-color: #eceff1;
  color: #263238;
}

#th1:curve {
  text-align: justify;
  background-color: #b0bec5;
}
</style>
