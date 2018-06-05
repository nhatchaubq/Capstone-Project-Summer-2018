<template>
   <div>
    <table class="table">
      <thead>
        <tr >
          <th><strong>Username</strong></th>
          <th><strong>Full Name</strong></th>
          <th><strong>Email</strong></th>
          <th><strong>Phone</strong></th>
          <th><strong>Status</strong></th>
          <th><strong>Start Date</strong></th>
          <th><strong>End Date</strong></th>
          <th><strong>Role</strong></th>
          <!-- <th><strong>teamName</strong></th> -->
          <th><strong>Department</strong></th>
        </tr>
      </thead>      
      <tbody>
        <tr v-bind:key="account.id" v-for="account in accountList">
          <td>{{account.Username}}</td>      
          <td>{{account.Fullname}}</td>    
          <td>{{account.Email}}</td>   
          <td>{{account.Phone}}</td>    
          <td>{{account.Status ? 'Active' : 'Inactive'}}</td>    
          <td>{{account.StartDate}}</td>    
          <td>{{account.EndDate}}</td>    
          <td>{{account.Role.Name}}</td>    
          <!-- <td>{{account.Team.Name}}</td>     -->
          <td>{{account.Department.Name}}</td>    
        </tr>
      </tbody>
    </table>        
    <router-link to='/accounts/add/'>
      <button id="btn-add-equipment">Add new account</button>
    </router-link>


    </div>
</template>

<script>
// import data from "@/models/accounts.js";
import Server from "@/config/config.js";

export default {
  created() {
    let url = Server.ACCOUNT_API_PATH;
    this.axios.get(url).then(response => {
      let data = response.data;
      data.forEach(element => {
        let account = element.Account;
        this.accountList.push(account);
      });
    });
  },
  data() {
    return {
      accountList: []
    };
  }
};
</script>

<style>
</style>
