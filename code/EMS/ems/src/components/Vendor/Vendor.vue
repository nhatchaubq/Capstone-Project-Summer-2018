<template>
  <div v-if="!vendors">
    There is no account yet.
  </div>
  <div v-else>
    <table class="mytable">
      <thead>
        <tr>
          <!-- <th><strong>ID</strong></th> -->
          <th style="text-align: center;"><strong>No.</strong></th>
          <th ><strong>Business name</strong></th>
          <th ><strong>Quantity</strong></th>
          <th ><strong>Address</strong></th>
          <th><strong>Website</strong></th>
          <th ><strong>Contact name</strong></th>
          <th ><strong>Status</strong></th>

          <!-- <th><strong>Department</strong></th> -->
        </tr>
      </thead>  
      <tbody>
          <tr v-bind:key="vendor.Id" v-for="(vendor, index) in toDisplayData" class="txtText" v-on:click="gotoDetail(vendor.Id)">
            <!-- <td style="width:3rem">{{vendor.Id}}</td>     -->
            <!-- <router-link :to="`/team/${team.Id}`">   -->
            <td style="text-align: center;" width=3% >{{ 10*(currentPage -1) + (index + 1) }}</td>
            <td width=22%>{{vendor.BusinessName | truncate(25)}}</td>
            <td width=10%>{{vendor.Vendor.Quantityitems.Quantity ? vendor.Vendor.Quantityitems.Quantity : "n/a" }}</td>
            <!-- </router-link> -->
            <td width=30%>{{vendor.BusinessAddress ? vendor.BusinessAddress : "n/a" }}</td>
            <td width=20%>{{vendor.Website ? vendor.Website : "n/a"}} </td>
            <td width=15%>{{vendor.ContactName ? vendor.ContactName : "n/a"}}</td>
            <strong>
              <td :style="{color: vendor.Status? 'var(--primary-color)' : '#607D8B'}">{{vendor.Status? "Active" : "Inactive"}}</td>
              </strong>
          </tr>
      </tbody>
    </table>

<!-- test1 -->
  <div v-if="totalVendor > 9" style="margin-top: 1.5rem">
    <Page :current="currentPage" :total="totalVendor" show-elevator 
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
      <button v-if="authUser.Role =='Equipment Staff'" id="btn-add-vendor" class="button btn-primary material-shadow-animate">Add Vendor</button>
    </router-link>
  </div>
</template>

<script>
import Server from "@/config/config.js";
import { sync } from "vuex-pathify";
export default {
  computed: {
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    },
    searchValues: sync("vendorPage.searchValues")
  },
  created() {
    this.getVendorDetail();
  },
  data() {
    return {
      currentPage: 1,
      vendors: [],
      toDisplayData: [],
      totalVendor: 0
    };
  },
  methods: {
    gotoDetail(vendorId) {
      this.$router.push(`/vendor/${vendorId}`);
    },
    getVendorDetail() {
      let url = Server.VENDOR_API_PATH;
      this.axios.get(url).then(res => {
        this.vendors = res.data;
        this.totalVendor = this.vendors.length;
        this.toDisplayData = this.vendors.slice(0, 10);
      });
    }
  },
  watch: {
    searchValues: function() {
      if (this.searchValues && this.searchValues.length > 0) {
        let tmpVendors = [];
        for (const vendor of this.searchValues) {
          tmpVendors = tmpVendors.concat(
            this.vendors.filter(v => v.Id == vendor.Id)
          );
        }
        // this.vendors = tmpVendors;
        this.totalVendor = tmpVendors.length;
        this.toDisplayData = tmpVendors.slice(0, 10);
        this.currentPage = 1;
      } else {
        this.vendors = [];
        this.toDisplayData = [];
        this.totalVendor = 0;
        // this.getVendorDetail();
      }
    },
    "$store.state.vendorPage.searchText": function() {
      if (this.$store.state.vendorPage.searchText == "") {
        this.getVendorDetail();
      }
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
