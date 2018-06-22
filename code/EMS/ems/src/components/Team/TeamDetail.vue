<template>
  <div v-if="team">
    <router-link to="/team">
      <a><span class="material-icons" style="position: relative; top: .4rem">keyboard_arrow_left</span> Back to Teams</a>
    
    </router-link>

    <div class="material-box" style="width: 50%">
      <div class="row">
        
        <h2 class="col-10" style="font-size: 30px; color: #3960A4">{{team.Name}}</h2>
        <button class="button btn-edit btn-primary material-shadow-animate " v-on:click="$store.state.teamPage.detailPage.editMode = !editMode
        ">Edit</button>

      </div>
      <!-- <h2 style=" border-bottom: 1px solid #e0e0e0;"></h2> -->
  
      <!-- <h2>Team ID: {{team.Id}}</h2> -->
  
      <div>
  
        <h2>Create date: {{team.CreatedDate}} </h2>
  
        <strong style="color:var(--primary-color)">Leader</strong>
        
      <div >
        <!-- <div class="row">
           <model-select v-if="editMode" class="col-9" style="margin-right:1rem; "  :options="toLeaderOptions" v-model="selectedToLeader"  placeholder="Select a leader"></model-select>  
            
            <button v-if="editMode" class="button btn-primary " style="margin-top: 1rem; padding :-1rem" v-on:click="console.error(this.account.id)">add new</button> 
         
        </div> -->
        
        <div  v-bind:key="leader.Id" v-for="leader in team.LeaderAccounts" >
          <div class="row " style="height:43.42px">
            <div class="col-8 ">

              <span>-</span>
            <router-link :to="`/account/${leader.Id}`">
              {{leader.Fullname ? leader.Fullname :'N/A' }}
            </router-link>
              <span>({{leader.Username}})</span>
            
            </div>
          </div>


        </div>

      </div>  

        <!-- <br/> -->

        <strong>Members</strong>
        <div :key="member.Id" v-for="member in team.MemberAccounts">
          <div class="row" style="height:36px; ">
            <div class="col-8">
                <span>-</span>
                <router-link :to="`/account/${member.Id}`">
                  {{member.Fullname ? member.Fullname :'N/A' }}
                </router-link>
                  <span>({{member.Username}})</span>

            </div >
            <div class="col-3" >
              <button v-if="editMode" class="button"  style="color: var(--primary-color); text-align: center; padding-bottom: 3px" v-on:click="changeToLeader(team.LeaderAccounts[0].Id, member.Id)">Set to leader</button>
            </div>
            <div class="col-1">
              <button v-if="editMode" class="material-icons"  style="color: var(--danger); text-align: center; padding-bottom: 3px" v-on:click="kick(member.Id)">close</button>
            </div>

          </div>
  
        </div>
      </div>
  
      <!-- <h2>test: {{team.Accounts[0].Id}}</h2> -->
  
  
              <strong v-if="editMode">Add new members: </strong>

                <multi-select  v-if="editMode" style="width: 100% !important"  :options="memberOptions" :selected-options="selectedMemberList" @select="onSelect" placeholder="Select a member"></multi-select> 
              

                  <button v-if="editMode" class="button btn-primary material-shadow-animate pull-right" style="margin-top: 1rem" v-on:click="addNew()">add new</button> 

              </div>
              
              
        <!-- <div :key="m.value" v-for="m in selectedMemberList">{{m.text}}</div> -->
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
import { sync } from "vuex-pathify";
import VueBase64FileUpload from "vue-base64-file-upload";
import { BasicSelect, MultiSelect, ModelSelect } from "vue-search-select";
export default {
  components: {
    VueBase64FileUpload,
    MultiSelect,
    BasicSelect,
    ModelSelect
  },
  created() {
    let teamApiUrl = `http://localhost:3000/api/team/id/${
      this.$route.params.id
    }`;

    this.axios.get(teamApiUrl).then(response => {
      let data = response.data.Team;
      this.team = data;
      // data.forEach(member => {
      //     let option = {
      //       text: member.Name,
      //       value: member.Id
      //     };
      //     this.memberOptions.push(option);
      //   });
    });

    let outsideTeamApiUrl = `http://localhost:3000/api/AllAccExceptThatTeam/${
      this.$route.params.id
    }`;
    this.axios.get(outsideTeamApiUrl).then(res => {
      let data = res.data;
      data.forEach(element => {
        let option = {
          value: element.Id,
          text: element.Fullname
        };
        this.memberOptions.push(option);
      });
    });
    // let getMembersInTeamApiUrl = `http://localhost:3000/api/getMembersInTeam/${
    //   this.$route.params.id
    // }`;
    // this.axios.get(getMembersInTeamApiUrl).then(res => {
    //   let data = res.data;
    //   data.forEach(element => {
    //     let option = {
    //       value: element.account.Id,
    //       text: element.account.Fullname
    //     };
    //     this.toLeaderOptions.push(option);
    //   });
    // });
    this.axios
      .get(
        `http://localhost:3000/api/team/id/getMembersInTeam/${
          this.$route.params.id
        }`
      )
      .then(response => {
        let data = response.data;
        data.forEach(element => {
          let option = {
            value: element.Id,
            text: element.Fullname
          };
          this.toLeaderOptions.push(option);
          console.log(this.toLeaderOptions.length);
        });
      })
      .catch(error => {
        alert(error);
      });
  },

  data() {
    return {
      team: null,
      memberOptions: [],
      toLeaderOptions: [],
      selectedMember: {
        value: "",
        text: ""
      },
      selectedMemberList: [],
      lastSelectItem: {},
      selectedToLeader: {
        value: "",
        text: ""
      }
    };
  },
  computed: {
    editMode: sync("teamPage.detailPage.editMode")
  },
  methods: {
    createAccount1() {
      this.axios
        .post(
          `http://localhost:3000/api/AllAccExceptThatTeam/${
            this.$route.params.id
          }`,
          {
            account: this.account
          }
        )
        .then(res => {
          this.$router.push("/team/:id");
        });
    },
    onSelect(items, lastSelectItem) {
      this.selectedMemberList = items;
      this.lastSelectItem = lastSelectItem;
    },
    onSelect1(item) {
      this.item = item;
    },
    addNew() {
      this.selectedMemberList.forEach(element => {
        this.axios
          .post(
            `http://localhost:3000/api/AllAccExceptThatTeam/${
              this.$route.params.id
            }`,
            {
              accountID: element.value
            }
          )
          .then(res => {
            // this.$router.push(`/team/`);
            location.reload();
          });
      });
    },
    kick(accountID) {
      this.axios
        .delete(
          `http://localhost:3000/api/team/id/${
            this.$route.params.id
          }/${accountID}`
        )
        .then(res => {
          // this.$router.push(`/team/${this.$route.params.id}`);
          location.reload();
        });
    },
    changeToLeader(leaderId, memberID) {
      this.axios
        .put(
          `http://localhost:3000/api/team/id/${
            this.$route.params.id
          }/${memberID}/${leaderId}`
        )
        .then(res => {
          // this.$router.push(`/team/${this.$route.params.id}`);
          location.reload();
        });
    }
    // changeNewLeader(leaderId, memberID) {
    //   this.axios.push(
    //     `http://localhost:3000/api/team/id/${
    //       this.$route.params.id
    //     }/${memberID}/${leaderId}`
    //   );
    // }
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
#btn-add-member {
  /* position: fixed;
  right: 3rem;
  bottom: 2rem; */
  background-color: var(--primary-color);
  /* padding: 13px; */
  color: white;
  /* border-radius: 5px; */
  /* z-index: 1; */
}

#btn-add-member:hover {
  cursor: pointer;
  /* background-color: #009688;
  color: white; */
}
#btn-kick-member {
  /* position: fixed;
  right: 3rem;
  bottom: 2rem; */
  background-color: var(--danger-color);
  /* padding: 13px; */
  /* color: white; */
  /* border-radius: 5px; */
  /* z-index: 1; */
}

#btn-kick-member:hover {
  cursor: pointer;
  /* background-color: #009688;
  color: white; */
}
</style>
