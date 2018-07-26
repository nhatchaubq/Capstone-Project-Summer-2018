<template>
  <div v-if ="!teams">
    There is no team yet.
  </div>
  <div v-else>
    <div class="field is-grouped view-mode" style="margin-bottom:0.2rem">
      <router-link to='/account/'>  
        <button class="btn-view-mode-left" style="margin-right: 0rem !important" >Account view</button>
      </router-link>
      <router-link to='/team/'>  
        <button class="btn-view-mode-right" disabled="disabled">Team view</button>
      </router-link>
    </div>
    <!-- <table class="mytable">
          <thead>
            <tr>
                <th><strong>#</strong></th>
                <th><strong>Team name</strong></th>
                <th><strong>Leader </strong></th>
                <th><strong>Members </strong></th>
                <th><strong>Create date </strong></th>
            </tr>
        </thead>  
        <tbody>
            <tr v-bind:key="team.Id" v-for="(team, index) in teams" v-on:click="gotoDetail(team.Id)">
              <td>{{ index + 1 }}</td>   
              <td>{{team.Name}}</td>
                <td>{{ team.TeamLeader ? team.TeamLeader.Username : 'n/a'}}</td>
              <td>{{team.Members.Quantity}}</td>
              <td>{{getDate(team.CreatedDate)}}</td>

            </tr>
        </tbody>
    </table> -->


<!-- test1 -->

    <table class="mytable">
          <thead>
            <tr>
                <!-- <th><strong>ID</strong></th> -->

                <th><strong>#</strong></th>
                <th><strong>Team name</strong></th>
                <th><strong>Leader </strong></th>
                <th><strong>Members </strong></th>
                <th><strong>Create date </strong></th>




                <!-- <th><strong>Department</strong></th> -->
            </tr>
        </thead>  
        <tbody>
            <tr v-bind:key="team.Id" v-for="(team, index) in toDisplayData" v-on:click="gotoDetail(team.Id)">
              <!-- <td>{{team.Id}}</td>     -->
              <td>{{ index + 1}}</td>   
              <td>{{team.Name}}</td>
              <!-- <router-link :to="`/account/${team.TeamLeader.Id}`">   -->
                <td>{{ team.TeamLeader ? team.TeamLeader.Username : 'n/a'}}</td>
              <!-- </router-link> -->
              <td>{{team.Members.Quantity}}</td>
              <td>{{getDate(team.CreatedDate)}}</td>

            </tr>
        </tbody>
    </table>
  <div v-if="teams.length >9" class="pageNa">
    <Page :current="1" :total="teams.length" show-elevator 
      @on-change="(newPageNumber) => {
        let start = 10 * (newPageNumber - 1);
        let end = start + 10;
        
        toDisplayData = teams.slice(start, end);
      }">
    </Page>
  </div>  
<!-- test1-end -->




    <button v-on:click="$router.push('/team/add')" id="btn-add-account" class=" button btn-primary material-shadow-animate">Add Team</button>


</div>
</template>

<script>
import moment from "moment";
export default {
  components: {
    moment
  },
  name: "team",
  created() {
    let URL = "http://localhost:3000/api/team";
    this.axios.get(URL).then(res => {
      // alert("alao alo");
      let data = res.data;
      data.forEach(element => {
        let team = element.Team;
        this.teams.push(team);
        this.toDisplayData = this.teams.slice(0, 10);
      });
    });
  },
  data() {
    return {
      teams: [],
      toDisplayData: []
    };
  },
  methods: {
    gotoDetail(teamId) {
      this.$router.push(`/team/${teamId}`);
    },
    getDate(date) {
      return moment(date).format("L");
    }
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
  border-radius: 5px 0px 0px 5px;
  border: 1px solid #26a69a;
  z-index: 1;
  /* padding-right: 20px;
      padding-left: 20px; */
  margin-right: 5px;
}
.btn-view-mode-right {
  background-color: white;
  padding: 0.4rem 0.6rem;
  /* height: 2rem; */
  font-size: 15px;
  /* line-height: 2rem; */
  color: var(--primary-color);
  border-radius: 0px 5px 5px 0px;
  border: 1px solid #26a69a;
  z-index: 1;
  /* padding-right: 20px;
      padding-left: 20px; */
  margin-right: 5px;
}
td:hover {
  cursor: pointer;
}
.btn-view-mode-left:hover {
  background-color: #26a69a;
  color: white;
  cursor: pointer;
}
.btn-view-mode-right:disabled {
  background-color: #26a69a;
  color: white;
  cursor: context-menu;
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
  /* background-color: var(--primary-color);
  padding: 13px;
  color: white;
  border-radius: 5px; */
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
.pageNa {
  position: fixed;
  left: 17rem;
  bottom: 0.5rem;
}
</style>
