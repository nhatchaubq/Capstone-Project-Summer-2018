<template>
  <div >
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

        <div  v-bind:key="account.Id" v-for="account in team.Accounts">
          <div class="row " style="height:36px; margin-bottom: 3px" v-if="account.TeamRole=='Leader'">
            <div class="col-8 ">
              <span>-</span>
            <router-link :to="`/account/${account.Id}`">
              {{account.Fullname ? account.Fullname :'N/A' }}
            </router-link>
            </div>
          <div class="col-4 ">
            <!-- <button v-if="editMode" class="button btn-danger " >Kick</button> -->

          </div>
          </div>


        </div>

      </div>  

        <!-- <br/> -->
        <strong>Members</strong>
        <div  v-bind:key="account.Id" v-for="account in team.Accounts">
          <div class="row" style="height:36px; margin-bottom: 3px" v-if="account.TeamRole!='Leader'">
            <div class="col-8">
                <span>-</span>
                <router-link :to="`/account/${account.Id}`">
                  {{account.Fullname ? account.Fullname :'N/A' }}
                </router-link>
            </div>
                  <div class="col-4">
                    <!-- <button v-if="editMode" class="button btn-edit btn-primary" style="margin-right: 3px">Leader</button> -->
                    <!-- <button v-if="editMode" class="button btn-kick-member  " v-on:click="kick(account.Id)">Kick</button> -->
                    <button v-if="editMode" class="material-icons"  style="color: var(--danger); text-align: center; padding-bottom: 3px" v-on:click="kick(account.Id)">close</button>
                  </div>

          </div>
  
        </div>
      </div>
  
      <!-- <h2>test: {{team.Accounts[0].Id}}</h2> -->
  
  

              <multi-select v-if="editMode" style="width: 100% !important"  :options="memberOptions" :selected-options="selectedMemberList" @select="onSelect" placeholder="Select a member"></multi-select> 
              <div class="col-12  ">
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
import { MultiSelect } from "vue-search-select";
export default {
  components: {
    VueBase64FileUpload,
    MultiSelect
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
  },

  data() {
    return {
      team: null,
      memberOptions: [],
      selectedMember: {
        value: "",
        text: ""
      },
      selectedMemberList: [],
      lastSelectItem: {}
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
