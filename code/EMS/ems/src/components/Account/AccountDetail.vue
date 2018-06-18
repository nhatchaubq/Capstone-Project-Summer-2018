<template>
  <div class="grid-wrapper">
  <!-- <button class="button " style="background-color:green;   position: fixed;
  top: 6rem;
  right: 2rem;" v-on:click="editMode = !editMode">edit</button> -->
<img :src="account.AvatarImage? account.AvatarImage: 'https://i.stack.imgur.com/l60Hf.png' " :alt="account.Name" style="width: 100%; height: 20rem; ">
<div class="material-box">
<div >
  <h2 > <strong style="text-transform: uppercase;  font-size: 20px; color: #26a69a">{{account.Username}}</strong> </h2>


</div>
<div  class="row" style="height: 36px" >
  <!-- <span class="icon is-small is-left">
    <i class="fa fa-user"></i>
  </span> -->
  <div class="col-3 text-right" style="margin-top:0.5rem" >
    Full name:  
  </div>
  <!-- <span v-if="!editMode" class="col-7" style="margin-top:0.3rem">
    {{account.Fullname}}
  </span> -->
  <input v-if="!editMode" v-model="account.Fullname" class="input col-7 " type="text"  placeholder="Text input" disabled="disabled">
  <input v-else v-model="account.Fullname" class="input col-7 " type="text"  placeholder="Text input" >
  
  </div>  
  <div class="row" style="margin-top:0.5rem; margin-bot:0.5rem">
  <div class="col-3 text-right" style="margin-top:0.5rem">Password: </div>
  <!-- <div class="col-7"> {{account.Password ? account.Password: 'N/A' }}</div> -->
  <input v-if="!editMode" v-model="account.Password" class="input col-7 " type="text"  placeholder="Text input" disabled="disabled">
  <input v-else v-model="account.Password" class="input col-7 " type="text"  placeholder="Text input">
</div>
 <!-- <h2 class="field is-horizontal" style="margin:0px">

<div style="padding-top:1rem; ">
             <span class="icon is-small is-left">
        <i class="fa fa-user"></i>
        </span>
   Full name:</div>  -->
 
<!-- <input v-model="account.Fullname" type="text" placeholder="Search" style="    border-style: solid;
    border-width: 2; border-radius: 3px;"/> -->
<!-- <div class="control  " style="padding:8px">
    <input v-model="account.Fullname" class="input " type="text" placeholder="Text input" style="margin:0px" >
</div> 
</h2>-->

<div class="row" style="margin-top:0.5rem; " v-if="!editMode">
  <div class=" col-3 text-right" >
  Status: 
  </div>

  <div class=" col-7 " >
  <!-- <div class="row col-7 " style="height: 36px"> -->
      <label class="row"  v-if="account.IsActive==true" >
      <div style="margin-right: 1rem" >
        <input type="radio" name="active" v-on:change="account.IsActive = true" checked="checked" >
        Active
      </div>
    <div >
      <input type="radio" name="active" v-on:change="account.IsActive = false" disabled="disabled">
      Inactive
    </div>
    </label>
    <label class="row" style="margin-top:0.5rem;" v-else >
      <div style="margin-right: 1rem">
        <input type="radio" name="active" v-on:change="account.IsActive = true"  disabled="disabled">
        Active
      </div>
    <div >
      <input type="radio" name="active" v-on:change="account.IsActive = false" checked="checked">
      Inactive
    </div>
    </label>

  </div>

</div >

<div class="row" style="margin-top:0.5rem; margin-bot:0.5rem" v-if="editMode">
  <div class=" col-3 text-right" style="margin-top:0.5rem">
  Status: 
  </div>

  <div class=" col-7 "  >

      <label class="row" v-if="account.IsActive==true" >
      <div style="margin-right: 1rem">
        <input type="radio" name="active" v-on:change="account.IsActive = true" checked="checked" >
        Active
      </div>
    <div >
      <input type="radio" name="active" v-on:change="account.IsActive = false" >
      Inactive
    </div>
    </label>
    <label class="row" v-else >
      <div style="margin-right: 1rem">
        <input type="radio" name="active" v-on:change="account.IsActive = true"  >
        Active
      </div>
    <div >
      <input type="radio" name="active" v-on:change="account.IsActive = false" checked="checked">
      Inactive
    </div>
    </label>

  </div>

</div >

<div class="row" style="margin-top:0.5rem; margin-bot:0.5rem">
  <div class="col-3 text-right" >Role:</div>
  <div class="col-7"> {{account.SystemRole.Name}}</div>
</div>
<div class="row" style="margin-top:0.5rem; margin-bot:0.5rem">
  <div class="col-3 text-right">Start date: </div>
  <div class="col-7"> {{account.StartDate ? account.StartDate: 'N/A' }}</div>
</div>
<!-- <h2 style="padding-top:0.9rem;padding-bottom: 0.9rem">Start date: {{account.StartDate ? account.StartDate: 'N/A' }}</h2> -->
<div class="row" style="margin-top:0.5rem; margin-bot:0.5rem">
  <div class="col-3 text-right" style="margin-top:0.5rem">Email: </div>
  <!-- <div class="col-7">{{account.Email ?account.Email: 'N/A' }} </div> -->
  <input v-if="!editMode" v-model="account.Email" class="input col-7 " type="text"  placeholder="Text input" disabled="disabled">
  <input v-else v-model="account.Email" class="input col-7 " type="text"  placeholder="Text input">
</div>
<div class="row" style="margin-top:0.5rem; margin-bot:0.5rem">
  <div class="col-3 text-right" style="margin-top:0.5rem">Phone: </div>
  <!-- <div class="col-7">{{account.Phone ? account.Phone: 'N/A' }} </div> -->
  <input v-if="!editMode" v-model="account.Phone" class="input col-7 " type="text"  placeholder="Text input" disabled="disabled">
  <input v-else v-model="account.Phone" class="input col-7 " type="text"  placeholder="Text input">
</div>
<div style="font-size: 20px;margin-top:0.5rem; margin-bot:0.5rem"><strong>Team</strong></div>
<div v-bind:key="team.id" v-for="team in account.Teams" >
  <div style="margin-left:1.5rem; color:#26a69a" v-if="team.TeamRole.TeamRole == 'Leader'">{{team.TeamRole.TeamRole}} of  {{team.Name}}</div>
  <div style="margin-left:1.5rem" v-else>{{team.TeamRole.TeamRole}} of  {{team.Name}}</div>
</div>
</div>
<!-- <div class="material-box">
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
  </h1> -->
  

          <button class="button btn-edit btn-primary material-shadow-animate" v-on:click="editMode = !editMode">Edit</button>




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
      account: null,
      checkedActive: [],
      editMode: false
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
/* #btn-add-account {
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
} */

.btn-edit {
  position: fixed;
  top: 6rem;
  right: 2rem;
  background-color: var(--primary-color);
  /* padding: 13px; */
  color: white;
  /* border-radius: 5px;
  z-index: 10;
  font-size: 1.3rem; */
}

.btn-edit:hover {
  cursor: pointer;
  background-color: #009688;
}
</style>
