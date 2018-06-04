<template>
   <div>


<!-- table -->
<table class="table">
  <thead>
    <tr >
      <th><strong>username</strong></th>
      <th><strong>fullname</strong></th>
      <th><strong>email</strong></th>
      <th><strong>phone</strong></th>
      <th><strong>status</strong></th>
      <th><strong>startDate</strong></th>
      <th><strong>endDate</strong></th>
      <th><strong>Role</strong></th>
      <th><strong>teamName</strong></th>
      <th><strong>departmentName</strong></th>

    </tr>

  </thead>
  
  <tbody>
      <tr v-bind:key="account.id" v-for="account in accountList">
        <td>{{account.username}}</td>      
        <td>{{account.fullname}}</td>    
        <td>{{account.email}}</td>   
        <td>{{account.phone}}</td>    
        <td>{{account.status}}</td>    
        <td>{{account.startDate}}</td>    
        <td>{{account.endDate}}</td>    
        <td>{{account.Role}}</td>    
        <td>{{account.teamName}}</td>    
        <td>{{account.departmentName}}</td>    


      </tr>
  </tbody>
</table>

<!-- /table -->
        
  <router-link to='/accounts/add/'>
    <button id="btn-add-equipment">Add new account</button>
  </router-link>


    </div>
</template>

<script>
import data from "@/models/accounts.js";

export default {
data() {
        return {
            accountList: data,
        }
}
}

</script>

<style>

</style>
