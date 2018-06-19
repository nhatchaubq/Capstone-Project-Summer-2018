<template>
  <div class="grid-wrapper">
  
    <div class="material-box">
  
      <h2 style="text-transform: uppercase;font-size: 30px; color: #3960A4">{{team.Name}}</h2>
  
      <!-- <h2 style=" border-bottom: 1px solid #e0e0e0;"></h2> -->
  
      <!-- <h2>Team ID: {{team.Id}}</h2> -->
  
      <div>
  
        <h2>Create date: {{team.CreatedDate}} </h2>
  
        <strong style="color:var(--primary-color)">Leader</strong>
  
        <div v-bind:key="account.Id" v-for="account in team.Accounts">
  <div  v-if="account.TeamRole=='Leader'">
            <span>-</span>
            <router-link :to="`/account/${account.Id}`">
              {{account.Fullname ? account.Fullname :'N/A' }}
            </router-link>
  </div>
        </div>
        <br/>
        <strong>Members</strong>
                <div v-bind:key="account.Id" v-for="account in team.Accounts">
  <div v-if="account.TeamRole!='Leader'">
        <span>-</span>
        <router-link :to="`/account/${account.Id}`">
          {{account.Fullname ? account.Fullname :'N/A' }}
        </router-link>


  </div>
        </div>
      </div>
  
      <!-- <h2>test: {{team.Accounts[0].Id}}</h2> -->
  
  
  
    </div>
  
  
  
    <!-- <div class="grid-wrapper">
  
      <div class=" location-blocks material-box">
  
        <h3>Member of team {{team.Name}}:</h3>
  
        <div style="padding:7px">
  
          <div v-bind:key="account.Id" v-for="account in team.Accounts">
  
            <div class="material-shadow-animate" style="padding:10px" v-if="account.TeamRole == 'Leader'">
  
  
  
              <span class="icon is-small is-left" style="color:blue">
  
  <i class="fa fa-user"></i>
  
      </span> {{account.Fullname ? account.Fullname :'N/A' }}
  
  
  
              <div>
  
                <span class="icon is-small is-left" style="color:blue">
  
        <i class="fa fa-user-md"></i>
  
      </span> {{account.TeamRole }}</div>
  
            </div>
  
  
  
            <div class="material-shadow-animate" style="padding:10px" v-else>
  
  
  
              <span class="icon is-small is-left">
  
  <i class="fa fa-user"></i>
  
      </span> {{account.Fullname ? account.Fullname :'N/A' }}
  
  
  
              <div>
  
                <span class="icon is-small is-left">
  
        <i class="fa fa-user-md"></i>
  
      </span> {{account.TeamRole }}</div>
  
            </div>
  
          </div>
  
        </div>
  
      </div>
  
    </div> -->
  
  </div>
</template>

<script>
export default {
  created() {
    let URL = `http://localhost:3000/api/team/id/${this.$route.params.id}`;

    this.axios.get(URL).then(response => {
      let data = response.data.Team;

      this.team = data;
    });
  },

  data() {
    return {
      team: null
    };
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

.location-blocks {
  position: fixed;

  height: 88%;

  padding-right: 1rem;

  width: 40%;

  overflow-y: auto;
}

.location-blocks div {
  margin-bottom: 0.6rem;

  padding-left: 1rem;

  cursor: pointer;
}
</style>
