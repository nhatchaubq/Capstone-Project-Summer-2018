<template>
  <div v-if="!vendors">
    There is no account yet.
  </div>
  <div v-else>
    <table class="mytable">
      <thead>
        <tr>
          <th><strong>ID</strong></th>
          <th><strong>Business name</strong></th>
          <th><strong>Business address</strong></th>
          <th><strong>Website</strong></th>
          <th><strong>Contact name</strong></th>

          <!-- <th><strong>Department</strong></th> -->
        </tr>
      </thead>  
      <tbody>
          <tr v-bind:key="vendor.Id" v-for="vendor in vendors" class="txtText" v-on:click="gotoDetail(vendor.Id)">
            <td style="width:3rem">{{vendor.Id}}</td>    
            <!-- <router-link :to="`/team/${team.Id}`">   -->
            <td style="width:15rem">{{vendor.BusinessName}}</td>
            <!-- </router-link> -->
            <td style="width:20rem">{{vendor.BusinessAddress}}</td>
            <td style="width:20rem">{{vendor.Website}}</td>
            <td>{{vendor.ContactName}}</td>
          </tr>
      </tbody>
    </table>
    <router-link to='/vendor1/add/'>
      <button id="btn-add-vendor" class="button btn-primary material-shadow-animate">Add Vendor</button>
    </router-link>
  </div>
</template>

<script>
import Server from "@/config/config.js";
export default {
  created() {
    let url = Server.VENDOR_API_PATH;
    this.axios.get(url).then(res => {
      let data = res.data;
      data.forEach(element => {
        let vendor = element;
        this.vendors.push(vendor);
      });
    });
  },
  data() {
    return {
      vendors: []
    };
  },
  methods: {
    gotoDetail(vendorId) {
      this.$router.push(`/vendor/${vendorId}`);
    }
  }
};
</script>

<style scoped>
th {
  text-align: left;
  background-color: #cfd8dc;
  height: 30px;
  line-height: 30px;
  padding: 0.5rem !important;
}

td {
  vertical-align: middle;
  height: 40px;
  line-height: 25px;
  padding: 0.5rem;
}
td:hover {
  cursor: pointer;
}

tr:nth-child(odd) {
  background-color: white;
  color: #263238;
}

tr:nth-child(even) {
  background-color: #f5f5f5;
  color: #263238;
}

#th1:curve {
  text-align: justify;

  background-color: #b0bec5;
}

tr:hover {
  background-color: #eceff1;
}

.txtText {
  text-align: left;

  /*margin: 0.3rem;*/

  padding: 0.5rem;

  background-color: #cfd8dc;
}

table {
  /* border: 1px solid black; */

  width: 100%;

  font-size: 15px;

  /* text-align: right; */
}
#btn-add-vendor {
  position: fixed;
  right: 3rem;
  bottom: 2rem;
  /* background-color: var(--primary-color);
  padding: 13px;
  color: white;
  border-radius: 5px; */
  z-index: 1;
}

#btn-add-vendor:hover {
  cursor: pointer;
  /* background-color: #009688;
  color: white; */
}
</style>
