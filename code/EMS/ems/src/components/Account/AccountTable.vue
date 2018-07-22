<template>
  <div v-if="accounts">
  
    <table class="mytable ">
  
      <thead>
  
        <tr class="txtText">
  
          <!-- <th><strong>ID</strong></th> -->

  
          <th style="width:3% !important"><strong >#</strong></th>
          <th style="width:20% !important"><strong>User name</strong></th>
  
          <th style="width:25% !important"><strong>Full name </strong></th>
  
          <th style="width:20% !important"><strong>Email </strong></th>
  
          <th style="width:15% !important"><strong>Phone</strong></th>
  
          <th style="width:10% !important"><strong>Role</strong></th>
  
          <th style="width:7% !important"><strong>Status</strong></th>
          <!-- <th><strong>Department</strong></th> -->
  
        </tr>
  
      </thead>
  
      <tbody>
  
        <tr v-bind:key="account.id" v-for="(account, index) in accounts" class="txtText" v-on:click="gotoDetail(account.Id)">
          <!-- <td>{{ index + 1 }}</td>    -->
          <!-- <td>{{account.Id}}</td> -->
  
          <td>{{ index + 1 }}</td>   
  

  
            <td>{{account.Username }}</td>
  

  
  
  
          <td>{{account.Fullname ? account.Fullname: "N/A" }}</td>
  
          <td>{{account.Email ? account.Email : "N/A" }}</td>
  
          <td>{{account.Phone ? account.Phone : "N/A"}}</td>
  
          <td>{{account.Role.Name}}</td>

          <strong>
            <td :style="{color: account.IsActive? 'var(--primary-color)' : '#607D8B'}">{{account.IsActive? "Active" : "Inactive"}}</td>
          </strong> 


  
        </tr>
  
  
  
      </tbody>
  
    </table>

  
  </div>
</template>

<script>
export default {
  name: "account-table",

  props: {
    accounts: null
  },
  methods: {
    gotoDetail(accountId) {
      this.$router.push(`/account/${accountId}`);
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
td:hover {
  cursor: pointer;
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
</style>
