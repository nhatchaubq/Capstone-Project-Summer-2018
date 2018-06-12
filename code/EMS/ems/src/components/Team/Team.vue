<template>

    <div class="">
      <div class="field is-grouped view-mode">
        <!-- <router-link to='/account/'>     
        <button class="btn-view-mode-left" >Table view</button>

        <button class="btn-view-mode-right" >Card view</button>
        </router-link> -->
      <router-link to='/account/'>  
        <button class="btn-view-mode" >Account view</button>
      </router-link>
      <router-link to='/team/'>  
        <button class="btn-view-mode" disabled="disabled">Team view</button>
      </router-link>

      </div>
        <!-- <div v-if="!teams">
      There is no team yet.
    </div> -->
        <!-- <div v-else> -->
            <div>
<div >
        <table class="table">
             <thead>
                <tr>
                    <th><strong>ID</strong></th>
                    <th><strong>User name</strong></th>
                    <th><strong>Create date </strong></th>

                    <!-- <th><strong>Department</strong></th> -->
                </tr>
            </thead>  
            <tbody>
                <tr v-bind:key="team.Id" v-for="team in teams">
                    <td>{{team.Id}}</td>    
                    <td>{{team.Name}}</td>
                    <td>{{team.CreatedDate}}</td>


                </tr>
            </tbody>
        </table>
    </div>
    </div>
  
    <router-link to='/team/add/'>
      <button id="btn-add-account" class=" material-shadow-animate">Add Team</button>
    </router-link>

          <!-- <button id="btn-add-account" class=" material-shadow-animate">Add Team</button> -->

</div>
</template>

<script>
export default {
  name: "team",
  created() {
    let URL = "http://localhost:3000/api/team";
    this.axios.get(URL).then(res => {
      let data = res.data;
      data.forEach(element => {
        let team = element.Team;
        this.teams.push(team);
      });
    });
  },
  data() {
    return {
      teams: []
    };
  }
};
</script>

<style scoped>
.view-mode {
  margin-bottom: 2rem;
}

.btn-view-mode-left {
  background-color: white;
  padding: 0.4rem 0.6rem;
  /* height: 2rem; */
  font-size: 15px;
  /* line-height: 2rem; */
  color: var(--primary-color);
  border-radius: 5px 0 0 5px;
  border: 1px solid #26a69a;
  z-index: 1;
  /* padding-right: 20px;
      padding-left: 20px; */
}

.btn-view-mode-left:hover {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}
.btn-view-mode-right {
  background-color: white;
  padding: 0.4rem 0.6rem;
  /* height: 2rem; */
  font-size: 15px;
  /* line-height: 2rem; */
  color: var(--primary-color);
  border-radius: 0 5px 5px 0;
  border: 1px solid #26a69a;
  z-index: 1;
  /* padding-right: 20px;
      padding-left: 20px; */
  margin-right: 5px;
}

.btn-view-mode-right:hover {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}
.btn-view-mode {
  background-color: white;
  padding: 0.4rem 0.6rem;
  /* height: 2rem; */
  font-size: 15px;
  /* line-height: 2rem; */
  color: var(--primary-color);
  border-radius: 5px 5px 5px 5px;
  border: 1px solid #26a69a;
  z-index: 1;
  /* padding-right: 20px;
      padding-left: 20px; */
  margin-right: 5px;
}

.btn-view-mode:hover {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}
.btn-view-mode:disabled {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}

.is-active {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}

#btn-add-account {
  position: fixed;
  right: 3rem;
  bottom: 2rem;
  background-color: var(--primary-color);
  padding: 13px;
  color: white;
  border-radius: 5px;
  z-index: 1;
}

#btn-add-account:hover {
  cursor: pointer;
  background-color: #009688;
  color: white;
}
#btn-add-account1 {
  background-color: white;
  padding: 0.4rem 0.6rem;
  /* height: 2rem; */
  font-size: 15px;
  /* line-height: 2rem; */
  color: var(--primary-color);
  border-radius: 5px 5px 5px 5px;
  border: 1px solid #26a69a;
  z-index: 1;
  /* padding-right: 20px;
      padding-left: 20px; */
  margin-right: 5px;
}

#btn-add-account1:hover {
  cursor: pointer;
  background-color: var(--primary-color);
  color: white;
}
#btn-add-account1:disabled {
  cursor: pointer;
  background-color: var(--primary-color);
  color: white;
}
</style>
