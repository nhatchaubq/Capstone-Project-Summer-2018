<template>
<div>
    <router-link to="/team">
      <a><span class="material-icons" style="position: relative; top: .4rem">keyboard_arrow_left</span> Back to Teams</a>
    </router-link>
  <div v-if="team" class="material-box" style="width: 50%">

      <div class="row">
        <h2 class="col-10" style="font-size: 30px; color: #3960A4">{{team.Name}}</h2>
        <button class="button btn-edit btn-primary material-shadow-animate " v-on:click="$store.state.teamPage.detailPage.editMode = !editMode">Edit</button>
      </div>
      <div>
        <h2>Create date: {{getDate(team.CreatedDate)}} </h2>

        <strong >Leader</strong>
        
        <div >
          <!-- <div class="row">
            <model-select v-if="editMode" class="col-9" style="margin-right:1rem; "  :options="toLeaderOptions" v-model="selectedToLeader"  placeholder="Select a leader"></model-select>  
              <button v-if="editMode" class="button btn-primary " style="margin-top: 1rem; padding :-1rem" v-on:click="console.error(this.account.id)">add new</button>     
          </div> -->
          <div v-if="team.LeaderAccount">
            <div  class="row " style="height:43.42px">
              <div class="col-8">
                <span>-</span>
              <router-link :to="`/account/${team.LeaderAccount.Id}`">
                {{team.LeaderAccount.Fullname ? team.LeaderAccount.Fullname :'N/A' }}
              </router-link>
                <span>({{team.LeaderAccount.Username}})</span>
              </div>
            </div>
          </div>
        </div>  
        <div v-if="team.MemberAccounts">
            <strong>Members</strong>
            <div :key="member.Id" v-for="member in team.MemberAccounts">
              <div class="row" style="height:40px; ">
                <div class="col-12 row">
                  <div class="col-8">
                      <span>-</span>
                      <router-link :to="`/account/${member.Id}`">
                        {{member.Fullname ? member.Fullname :'N/A' }}
                      </router-link>
                        <span>({{member.Username}})</span>
                  </div>
                  <div class="col-3" >
                    <!-- <button v-if="editMode" class="button btn-edit btn-primary material-shadow-animate "   v-on:click="changeToLeader(member.Id)">Set to leader</button> -->
                    <button v-if="editMode" class="button btn-edit btn-primary material-shadow-animate "   v-on:click="gotoDetail(member.Id, member.Username)">Set to leader</button>
                  </div>
                  <div class="col-1">
                    <button v-if="editMode" class="material-icons"  style="color: var(--danger); text-align: center; padding-bottom: 3px; margin-top: 4px" v-on:click="confirmKick(member.Id, member.Username)">close</button>
                    <!-- <button v-if="editMode" class="material-icons"  style="color: var(--danger); text-align: center; padding-bottom: 3px; margin-top: 4px" v-on:click="kick(member.Id)">close</button> -->
                  </div>
                </div >
              </div>
            </div>
        </div>
      </div>
    <strong v-if="editMode">Add new members: </strong>
    <div class="field is-horizontal">
      <multi-select  v-if="editMode" style="width: 100% !important; height:36px; margin-right: 1rem"  :options="memberOptions" :selected-options="selectedMemberList" @select="onSelect" placeholder="Select a member"></multi-select> 
        <button v-if="editMode" class="button btn-primary material-shadow-animate pull-right" style="margin-top: 4px" v-on:click="addNew()">add new</button> 

    </div>
    <!-- <button v-on:click="gotoDetail">1</button> -->
    <vodal :show="show" animation="rotate" @hide="show = false">
    <div class="col-12" style="margin-top: 0.5rem; padding-left: 2rem; border-bottom-style: double; ">Are you sure you want to change new leader??</div>
    <div class="row">
      <div class="col-5" style="text-align: right; padding-left:0rem !important">Member Id: </div>
      <div class="col-7">{{SelectedMemberId}}</div>
    </div>
    <div class="row">
      <div class="col-5" style="text-align: right; padding-left:0rem !important">Member Name: </div>
      <div class="col-7">{{SelectedMemberName}}</div>
    </div>
    <div class="row !important" style="margin-top:2rem">
      <button class="button btn-edit btn-primary material-shadow-animate "  style="margin-left: 5rem" v-on:click="changeToLeader(SelectedMemberId)">Change</button>

        <button class="button btn-edit material-shadow-animate "  style="background-color:silver; margin-left: 3rem; border: none" v-on:click="cancel" >Cancel</button>

      

    </div>
  </vodal>
  <!-- confirm kick popup- start -->
      <vodal :show="showConfirm" animation="rotate" @hide="showConfirm = false">
    <div class="col-12" style="margin-top: 0.5rem; padding-left: 2rem; border-bottom-style: double; ">Are you sure you want to kick this member??</div>
    <div class="row">
      <div class="col-5" style="text-align: right; padding-left:0rem !important">Member Id: </div>
      <div class="col-7">{{SelectedMemberId}}</div>
    </div>
    <div class="row">
      <div class="col-5" style="text-align: right; padding-left:0rem !important">Member Name: </div>
      <div class="col-7">{{SelectedMemberName}}</div>
    </div>
    <div class="row !important" style="margin-top:2rem">
      <button class="button btn-edit btn-primary material-shadow-animate "  style="margin-left: 5rem" v-on:click="kick(SelectedMemberId)">Change</button>

        <button class="button btn-edit material-shadow-animate "  style="background-color:silver; margin-left: 3rem; border: none" v-on:click="cancelConfirm" >Cancel</button>

      

    </div>
  </vodal>
  <!-- confirm kick popup-end -->

  </div>
</div>
         


</template>

<script>
import { sync } from "vuex-pathify";
import "vodal/common.css";
import "vodal/slide-up.css";
import Vodal from "vodal";
import moment from "moment";
// import VueBase64FileUpload from "vue-base64-file-upload";
import { BasicSelect, MultiSelect, ModelSelect } from "vue-search-select";
export default {
  components: {
    // VueBase64FileUpload,
    MultiSelect,
    BasicSelect,
    ModelSelect,
    Vodal,
    moment
  },
  created() {
    let teamApiUrl = `http://localhost:3000/api/team/id/${
      this.$route.params.id
    }`;

    this.axios.get(teamApiUrl).then(response => {
      let data = response.data.team;
      this.team = data;
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
      toLeaderOptions: [],
      SelectedMemberId: null,
      SelectedMemberName: "",
      selectedMember: {
        value: "",
        text: ""
      },
      selectedMemberList: [],
      lastSelectItem: {},
      show: false,
      showConfirm: false
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
          location.reload();
        });
    },
    changeToLeader(SelectedMemberId) {
      let leaderId = null;
      if (this.team.LeaderAccount) {
        // alert(this.team.LeaderAccount.Id);
        leaderId = this.team.LeaderAccount.Id;
      } else {
        //can chinh
        leaderId = 1248753;
        // alert(leaderId);
      }
      this.axios
        .put(
          `http://localhost:3000/api/team/id/${
            this.$route.params.id
          }/${SelectedMemberId}/${leaderId}`
        )
        .then(res => {
          this.show = false;
          location.reload();
        });
    },
    cancel() {
      this.show = false;
    },
    cancelConfirm() {
      this.showConfirm = false;
    },
    gotoDetail(memberID, memberName) {
      this.show = true;
      //alert(this.team.LeaderAccount.Id);
      this.SelectedMemberId = memberID;
      this.SelectedMemberName = memberName;
      // alert(memberID);
    },
    confirmKick(memberID, memberName) {
      this.showConfirm = true;
      this.SelectedMemberId = memberID;
      this.SelectedMemberName = memberName;
    },
    getDate(date) {
      return moment(date).format("L");
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
