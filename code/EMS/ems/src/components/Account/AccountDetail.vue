<template>
  <div class="grid-wrapper">

<img :src="account.AvatarImage? account.AvatarImage: 'https://i.stack.imgur.com/l60Hf.png' " :alt="account.Name" style="width: 100%; height: 20rem; ">
<div class="material-box">

<h2 style="text-transform: uppercase;font-size: 30px; color: #3960A4">{{account.Username}}</h2>
<h2 style=" border-bottom: 1px solid #e0e0e0;"></h2>
<h2>Full name: {{account.Fullname}}</h2>
<h2>Status: {{account.IsActive? 'Active': 'Unactive'}}</h2>
<h2>Role: {{account.SystemRole.Name}}</h2>
<h2>Start date: {{account.StartDate ? account.StartDate: 'N/A' }}</h2>
<h2 style=" border-bottom: 1px solid #e0e0e0;"></h2>
<h2 >
  <!-- <span class="icon is-small is-left">
                            <i class="fa fa-envelope"></i>
                            </span> -->
  Email: {{account.Email ?account.Email: 'N/A' }}</h2>
<h2 >Phone number: {{account.Phone ? account.Phone: 'N/A' }}</h2>
</div>
<div class="material-box">
  <h2 style="text-transform: uppercase;font-size: 30px; color: #3960A4">Team</h2>
        <h2 style=" border-bottom: 1px solid #e0e0e0;"></h2>
<h1 v-bind:key="team.id" v-for="team in account.Teams" >
  <div style="padding:10px" v-if="team.TeamRole.TeamRole == 'Leader'">
    <h1> 
            <span class="icon is-small is-left" style="color:blue" >
      <i class="fa fa-users"></i>
    </span>
      Team name: {{team.Name}}</h1>  
      <h1>
              <span class="icon is-small is-left" style="color:blue" >
      <i class="fa fa-user-md"></i>
    </span>
         Role in team: {{team.TeamRole.TeamRole}}</h1>
      <h2 style=" border-bottom: 1px solid #e0e0e0;"></h2>
      </div>
      <div style="padding:10px" v-else>
    <h1> 
            <span class="icon is-small is-left"  >
      <i class="fa fa-users"></i>
    </span>
      Team name: {{team.Name}}</h1>  
      <h1>
              <span class="icon is-small is-left"  >
      <i class="fa fa-user-md"></i>
    </span>
         Role in team: {{team.TeamRole.TeamRole}}</h1>
      <h2 style=" border-bottom: 1px solid #e0e0e0;"></h2>
      </div>
  </h1>
      <router-link to='/account/add/'>
      <button id="btn-add-account" class=" material-shadow-animate" v-on:click="ondelete()">Delete account</button>
    </router-link>


</div>





<!-- <h1>{{account.Id}}</h1> -->
  <!-- <td>{{account.Id}}</td>    
  <td>{{account.Username}}</td>
  <td>{{account.Password}}</td> -->



</div>
</template>

<script>
export default {
  created() {
    //   let URL = "http://localhost:3000/api/account/id/:id";
    //   this.axios.get(URL).then(response => {
    //     let data = response.data;
    //     // alert('in');
    //     data.forEach(element => {
    //       let account = element.Account;
    //       this.accounts.push(account);
    //     });
    //   });
    // },
    let URL = `http://localhost:3000/api/account/id/${this.$route.params.id}`;
    this.axios.get(URL).then(response => {
      let data = response.data;
      this.account = data;
    });
  },

  data() {
    return {
      account: null
    };
  },
  methods: {
    onDelete() {
      this.axios.delete(
        "`http://localhost:3000/api/account/delete/id/${this.$route.params.id}`"
      );
    }
  }
};
</script>

<style scoped>
.grid-wrapper {
  display: grid;
  grid-template-columns: 50% 50%;
  grid-column-gap: 1rem;
  grid-row-gap: 2rem;
}
#btn-add-account {
  position: fixed;
  right: 3rem;
  bottom: 2rem;
  background-color: #ff1d1d;
  padding: 13px;
  color: white;
  border-radius: 5px;
  z-index: 1;
}

#btn-add-account:hover {
  cursor: pointer;
  background-color: var(--danger-color);
  color: white;
}
</style>
