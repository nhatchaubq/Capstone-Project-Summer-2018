<template>

   <!-- <form @submit.prevent="editAccount()"> -->
  <div class="grid-wrapper">

  <!-- <button class="button " style="background-color:green;   position: fixed;
  top: 6rem;
  right: 2rem;" v-on:click="editMode = !editMode">edit</button> -->
<img :src="account.AvatarImage? account.AvatarImage: 'https://i.stack.imgur.com/l60Hf.png' " :alt="account.Name" style="width: 100%; height: 20rem; ">
<div class="material-box">
<div class="row" >
  <h2 > <strong style="text-transform: uppercase;  font-size: 20px; color: #26a69a; margin-left: 2rem" >{{account.Username}}</strong> </h2>
 <button class="button btn-edit btn-primary material-shadow-animate" v-on:click="editMode = !editMode">Edit</button>

</div>
<div  class="row" style="height: 36px" >
  <!-- <span class="icon is-small is-left">
    <i class="fa fa-user"></i>
  </span> -->
  <div class="col-3 text-right" style="margin-top:0.5rem" >
    Full name:  
  </div>

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
  <div class=" col-3 text-right" style="margin-top:0.5rem">
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

<div class="row" style="margin-top:0.5rem; " v-if="editMode">
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
<div class="row" v-if="editMode">
  <button class="button btn-confirm-edit btn-primary material-shadow-animate" v-on:click="editAccount()">Done</button>
    <button class="button btn-cancel btn-primary material-shadow-animate" v-on:click="editMode = !editMode">Cancel</button>
</div>
<div style="font-size: 20px;margin-top:0.5rem; margin-bot:0.5rem"><strong>Team</strong></div>
<div v-bind:key="team.id" v-for="team in account.Teams" >
  <div style="margin-left:1.5rem; color:#26a69a" v-if="team.TeamRole.TeamRole == 'Leader'">{{team.TeamRole.TeamRole}} of  {{team.Name}}</div>
  <div style="margin-left:1.5rem" v-else>{{team.TeamRole.TeamRole}} of  {{team.Name}}</div>
</div>
</div>


         



  </div>
  <!-- </form> -->







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
    editAccount() {
      this.axios
        .put(
          `http://localhost:3000/api/account/edit/id/${this.$route.params.id}`,
          {
            account: this.account
          }
        )
        .then(res => {
          this.$router.push("/account");
        });
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
  margin-left: 22rem;
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
.btn-confirm-edit {
  background-color: var(--primary-color);
  margin-left: 7rem;
  margin-top: 1rem;
  /* padding: 13px; */
  color: white;
  /* border-radius: 5px;
  z-index: 10;
  font-size: 1.3rem; */
}

.btn-confirm-edit:hover {
  cursor: pointer;
  background-color: #009688;
}

.btn-cancel {
  background-color: var(--shadow);
  margin-left: 1rem;
  margin-top: 1rem;
  /* padding: 13px; */
  color: white;
  /* border-radius: 5px;
  z-index: 10;
  font-size: 1.3rem; */
}

.btn-cancel:hover {
  cursor: pointer;
  background-color: #aca4a4;
}
</style>
