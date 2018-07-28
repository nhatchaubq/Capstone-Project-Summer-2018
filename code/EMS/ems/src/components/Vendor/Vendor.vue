<template>
  <div v-if="!vendors">
    There is no account yet.
  </div>
  <div v-else>
    <table class="mytable">
      <thead>
        <tr>
          <!-- <th><strong>ID</strong></th> -->
          <th ><strong>#</strong></th>
          <th ><strong>Business name</strong></th>
          <th ><strong>Quantity</strong></th>
          <th ><strong>Address</strong></th>
          <th><strong>Website</strong></th>
          <th ><strong>Contact name</strong></th>

          <!-- <th><strong>Department</strong></th> -->
        </tr>
      </thead>  
      <tbody>
          <tr v-bind:key="vendor.Id" v-for="(vendor, index) in toDisplayData" class="txtText" v-on:click="gotoDetail(vendor.Id)">
            <!-- <td style="width:3rem">{{vendor.Id}}</td>     -->
            <!-- <router-link :to="`/team/${team.Id}`">   -->
            <td width=3% >{{ 10*(currentPage -1) + (index + 1) }}</td>
            <td width=22%>{{vendor.BusinessName | truncate(25)}}</td>
            <td width=10%>{{vendor.Vendor.Quantityitems.Quantity ? vendor.Vendor.Quantityitems.Quantity : "N/A" }}</td>
            <!-- </router-link> -->
            <td width=30%>{{vendor.BusinessAddress ? vendor.BusinessAddress : "N/A" }}</td>
            <td width=20%>{{vendor.Website ? vendor.Website : "N/A"}} </td>
            <td width=15%>{{vendor.ContactName ? vendor.ContactName : "N/A"}}</td>
          </tr>
      </tbody>
    </table>

<!-- test1 -->
  <div v-if="vendors.length >9" class="pageNa">
    <Page :current="currentPage" :total="vendors.length" show-elevator 
      @on-change="(newPageNumber) => {
        currentPage =newPageNumber
        let start = 10 * (newPageNumber - 1);
        let end = start + 10;
        
        toDisplayData = vendors.slice(start, end);
      }">
    </Page>
  </div>  
<!-- test1-end -->



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
        this.toDisplayData = this.vendors.slice(0, 10);
      });
    });
  },
  data() {
    return {
      currentPage: 1,
      vendors: [],
      toDisplayData: []
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
  bottom: 0.5rem;
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
.pageNa {
  position: fixed;
  left: 17rem;
  bottom: 0.5rem;
}
</style>
