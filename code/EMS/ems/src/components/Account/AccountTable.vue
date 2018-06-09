<template>
    <div v-if="accounts">
        <table class="table">
             <thead>
                <tr>
                    <th><strong>ID</strong></th>
                    <th><strong>User name</strong></th>
                    <th><strong>Full name </strong></th>
                    <th><strong>Email </strong></th>
                    <th><strong>Phone</strong></th>
                    <th><strong>Role</strong></th>
                    <th><strong>Department</strong></th>
                </tr>
            </thead>  
            <tbody>
                <tr v-bind:key="account.id" v-for="account in accounts">
                    <td>{{account.Id}}</td>    
                    <td>{{account.Username}}</td>
                    <td>{{account.Fullname}}</td>
                    <td>{{account.Email}}</td>
                    <td>{{account.Phone}}</td>
                    <td>{{account.Role.Name}}</td>
                    <td>{{account.Department.Name }}</td>
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
  }
}
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
