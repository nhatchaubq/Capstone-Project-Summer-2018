<template>
<div>
  <div class="row" style="margin-bottom:1rem">
    <div class="col-4">
      <router-link to="/team">
        <span class="material-icons" style="position: relative; top: .4rem">keyboard_arrow_left</span> Back to Teams
      </router-link>
    </div>
    <!-- <div class="col-8">
      <button v-if="!editMode" class="button btn-edit btn-primary material-shadow-animate " v-on:click="$store.state.teamPage.detailPage.editMode = !editMode">Edit</button>
    </div> -->
  </div>
  <div class="row">


  <div v-if="team" class="material-box col-12" >

      <div class="row" >
        <div v-if="!editMode" class="col-7 input2" style="font-size: 30px; color: var(--primary-color); height:46.42px; width: 443.54px; padding: 0 0 0 0.25rem !important; margin: 0 1rem 0 0.75rem !important">{{team.Name}} </div>
        <input v-if="editMode" v-model.trim="team.Name" class="col-7 input1" style="font-size: 30px; color: var(--primary-color);height:46.42px; width: 443.54px; padding: 0 0 0 0.25rem !important; margin: 0 1rem 0.5rem 0.75rem !important" > 
        <div class="col-4" style="display: flex; justify-content: flex-end;">
          <button v-if="!editMode" class="button btn-edit btn-primary material-shadow-animate "  v-on:click="$store.state.teamPage.detailPage.editMode = !editMode">Edit</button>
        </div>
        <!-- <span v-if="editMode" > <strong style="color: #26a69a">- Edit Information</strong> </span> -->
        <span  v-if="CreateTeamErrors.NameMin != ''"> <span class="error-text">{{ CreateTeamErrors.NameMin }}</span></span> <span v-if="CreateTeamErrors.NameMax != ''"> <span class="error-text">{{ CreateTeamErrors.NameMax }}</span></span>
      </div>
      <!-- <div class="row" style="margin: 0 0 0.5rem 0">
        <button v-if="editMode" class="button btn-confirm-edit btn-primary material-shadow-animate" style="margin: 0 0 1rem 1rem" v-on:click="editTeam()">Save changes</button>
        <button v-if="editMode" id=" btn-cancel" class="button btn-confirm-edit material-shadow-animate" style="margin:0 0 1rem 1rem" v-on:click="() => {
          this.$router.go(this.$router.currentRoute)
      }">Cancel</button>
      </div> -->
      <div>
        <h2>Create date: {{getDate(team.CreatedDate)}} </h2>

    <strong v-if="editMode">Add new members: </strong>
    <div class="field is-horizontal">
      <multi-select  v-if="editMode" style="width: 44rem !important; height:36px; margin-right: 1rem"  :options="memberOptions" :selected-options="selectedMemberList" @select="onSelect" placeholder="Select a member"></multi-select> 
        <button v-if="editMode" class="button btn-primary material-shadow-animate pull-right" style="margin-top: 4px" v-on:click="addNew()">add new</button> 
    </div>
        

        <strong >Member of this team</strong>
            <div class="">
      <div v-if="!team.LeaderAccount && !team.MemberAccounts">
        There is no team member yet.
      </div>
      <div v-else>

      <table class="mytable" style="margin-bottom:1rem">
        <thead>
          <tr>
            <th style="width:3% !important"><strong># </strong></th>
            <th style="width:27% !important"><strong>Username</strong></th>
            <th style="width: 30% !important"><strong>Full Name</strong></th>
            <th style="width: 5% !important"><strong>Status</strong></th>
            <th style="width: 5% !important"><strong>Role</strong></th>
            <th style="width: 20% !important" v-if="editMode"><strong>Action</strong></th>
          </tr>
        </thead>  
        <tbody>
            <tr >
              <td v-on:click="toDetail(team.LeaderAccount.Id)">1</td>
              <td v-on:click="toDetail(team.LeaderAccount.Id)">{{team.LeaderAccount.Username}}</td>
              <td v-on:click="toDetail(team.LeaderAccount.Id)">{{team.LeaderAccount.Fullname ? team.LeaderAccount.Fullname :'N/A'}}</td>
              <td v-on:click="toDetail(team.LeaderAccount.Id)" style="color:#26a69a"><span style="font-size: 25px; ">♛</span> Leader</td>
              <strong v-on:click="toDetail(team.LeaderAccount.Id)"><td :style="{color: team.LeaderAccount.IsActive? 'var(--primary-color)' : '#607D8B'}">{{team.LeaderAccount.IsActive ? "Active" : "Inactive"}}</td></strong> 
              <td v-if="editMode">&nbsp</td>
            </tr>
            <tr :key="member.Id" v-for="(member, index) in team.MemberAccounts"  >
              <td v-on:click="toDetail(member.Id)">{{index + 2}}</td>
              <td v-on:click="toDetail(member.Id)">{{member.Username}}</td>
              <td v-on:click="toDetail(member.Id)">{{member.Fullname ? member.Fullname :'N/A' }} </td>
              <td v-on:click="toDetail(member.Id)"><span style="font-size: 25px">♟</span>Member </td>
               <strong v-on:click="toDetail(member.Id)"><td :style="{color: member.IsActive? 'var(--primary-color)' : '#607D8B'}">{{member.IsActive ? "Active" : "Inactive"}}</td></strong> 
              <td v-if="editMode" style="padding-top: 0rem important">
                <button v-if="editMode" style="margin-left:1rem !important" class="button btn-edit btn-primary material-shadow-animate "   v-on:click="gotoDetail(member.Id, member.Username)">Set to leader</button>
                  <!-- <button v-if="editMode" class="material-icons"  style="color: var(--danger); margin-left:1rem !important" v-on:click="confirmKick(member.Id, member.Username)">close</button> -->
                  <button v-if="editMode" class="button material-shadow-animate "  style="background-color:var(--danger); color:white ; margin-left:1rem !important" v-on:click="confirmKick(member.Id, member.Username)">kick</button>

              </td>
            </tr>
        </tbody>
      </table>

      <div class="row" style="margin: 0 0 0.5rem 0">
        <button v-if="editMode" class="button btn-confirm-edit btn-primary material-shadow-animate" style="margin: 0 0 1rem 1rem" v-on:click="editTeam()">Save changes</button>
        <button v-if="editMode" id=" btn-cancel" class="button btn-confirm-edit material-shadow-animate" style="margin:0 0 1rem 1rem" v-on:click="() => {
          this.$router.go(this.$router.currentRoute)
          //location.reload()
      }">Cancel</button>
      </div>
    </div>

    <strong v-if="!editMode">Location of this team</strong>

    <div v-if="!team.Location"  >
      <div v-if="!editMode">
          There is no location yet.
        </div>
        <div v-else>
        <table   class="mytable" style="margin-bottom:1rem">
          <thead>
            <tr>
              <th style="width:3% !important"><strong># </strong></th>
              <th style="width:30% !important"><strong>Location Name </strong></th>
              <th style="width: 57% !important"><strong>Location Address</strong></th>
              <th style="width: 10% !important"><strong>Status</strong></th>
            </tr>
          </thead>  
          <tbody>
              <tr :key="Loca.Id" v-for="(Loca, index) in team.Location" class="txtText" >
                <td >{{index + 1}}</td>
                <td >{{Loca.Name ? Loca.Name : "N/A" }}</td>
                <td >{{Loca.Address ? Loca.Address : "N/A"}} </td>
                <td > <strong :style="{color: Loca.IsActive ? 'var(--primary-color)' : '#607D8B'}">{{Loca.IsActive ? "Active" : "Inactive"}}</strong></td>
              </tr>
          </tbody>
        </table>
      </div>
    </div>

    <strong>
      Equipment item
    </strong>
        <table   class="mytable" style="margin-bottom:1rem">
          <thead>
            <tr>
              <th style="width:3% !important"><strong># </strong></th>
              <th style="width:30% !important"><strong>Location Name </strong></th>
              <th style="width: 57% !important"><strong>Location Address</strong></th>
              <th style="width: 10% !important"><strong>Status</strong></th>
            </tr>
          </thead>  
          <tbody>
              <tr :key="Loca.Id" v-for="(Loca, index) in team.Location" class="txtText" >
                <td >{{index + 1}}</td>
                <td >{{Loca.Name ? Loca.Name : "N/A" }}</td>
                <td >{{Loca.Address ? Loca.Address : "N/A"}} </td>
                <td > <strong :style="{color: Loca.IsActive ? 'var(--primary-color)' : '#607D8B'}">{{Loca.IsActive ? "Active" : "Inactive"}}</strong></td>
              </tr>
          </tbody>
        </table>



  </div>
        
        <!-- <div >
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
        </div>   -->
        <!-- <div v-if="team.MemberAccounts">
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
                  
                    <button v-if="editMode" class="button btn-edit btn-primary material-shadow-animate "   v-on:click="gotoDetail(member.Id, member.Username)">Set to leader</button>
                  </div>
                  <div class="col-1">
                    <button v-if="editMode" class="material-icons"  style="color: var(--danger); text-align: center; padding-bottom: 3px; margin-top: 4px" v-on:click="confirmKick(member.Id, member.Username)">close</button>
              
                  </div>
                </div >
              </div>
            </div>
        </div> -->

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
      <button class="button material-shadow-animate "  style="background-color:var(--danger); color:white; margin-left: 5rem " v-on:click="kick(SelectedMemberId)">Kick</button>

        <button class="button btn-edit material-shadow-animate "  style="background-color:silver; margin-left: 3rem; border: none" v-on:click="cancelConfirm" >Cancel</button>

      

    </div>
  </vodal>
  <!-- confirm kick popup-end -->
 

  </div>



  </div>


  <!-- test -->

  <!-- <div class="grid-wrapper1 col-12">
    <div class="">
      <div v-if="!team.Location">
        There is no team member yet.
      </div>
      <div v-else>
      <table class="mytable">
        <thead>
          <tr>
            <th style="width:3% !important"><strong># </strong></th>
            <th style="width:20% !important"><strong>Username</strong></th>
            <th style="width: 67% !important"><strong>Full Name</strong></th>
            <th style="width: 10% !important"><strong>Role</strong></th>
          </tr>
        </thead>  
        <tbody>
            <tr>
              <td>1</td>
              <td>{{team.LeaderAccount.Username}}</td>
              <td>{{team.LeaderAccount.Fullname ? team.LeaderAccount.Fullname :'N/A'}}</td>
              <td><span style="font-size: 25px; color:#26a69a">♛</span> Leader</td>
            </tr>
            <tr :key="member.Id" v-for="(member, index) in team.MemberAccounts"  >
              <td >{{index + 2}}</td>
              <td >{{member.Username}}</td>
              <td >{{member.Fullname ? member.Fullname :'N/A' }} </td>
              <td ><span style="font-size: 25px">♟</span>Member </td>
            </tr>
        </tbody>
      </table>
        <i class="material-icons" style="color: gray;position: relative;top: 0.3rem;font-size: 25px\">crown</i> 
    </div>

  </div>
</div> -->
<!-- test-end -->
</div>
         


</template>

<script>
import { sync } from "vuex-pathify";
import "vodal/common.css";
import "vodal/slide-up.css";
import Vodal from "vodal";
import moment from "moment";
import VueBase64FileUpload from "vue-base64-file-upload";
import { BasicSelect, MultiSelect, ModelSelect } from "vue-search-select";
export default {
  components: {
    VueBase64FileUpload,
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
      sending: false,
      ErrorStrings: {
        NameMax: " Use from 6 to 50 characters for your team name",
        NameMin: " Use from 6 to 50 characters for your team name"
      },
      CreateTeamErrors: {
        NameMax: "",
        NameMin: ""
      },
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
    editTeam() {
      if (this.team.Name.length < 6) {
        this.CreateTeamErrors.NameMin = this.ErrorStrings.NameMin;
      }
      if (this.team.Name.length > 50) {
        this.CreateTeamErrors.NameMax = this.ErrorStrings.NameMax;
      }
      if (this.validateTeam())
        this.axios
          .put(`http://localhost:3000/api/team/${this.$route.params.id}`, {
            team: this.team
          })
          .then(res => {
            // this.$router.push("/account");
            if (res.status == 200) {
              // this.editMode = false;
              alert("Change successful");
              // this.getTeamDetail(this.$route.params.id);
              location.reload();
            }
          });
    },
    validateTeam() {
      return (
        this.CreateTeamErrors.NameMax === "" &&
        this.CreateTeamErrors.NameMin === ""
      );
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
      this.SelectedMemberId = memberID;
      this.SelectedMemberName = memberName;
    },
    confirmKick(memberID, memberName) {
      this.showConfirm = true;
      this.SelectedMemberId = memberID;
      this.SelectedMemberName = memberName;
    },
    toDetail(accountId) {
      this.$router.push(`/account/${accountId}`);
    },
    getDate(date) {
      return moment(date).format("L");
    }
  },
  watch: {
    "team.Name": function() {
      if (this.team.Name.length > 5) {
        this.CreateTeamErrors.NameMin = "";
      }
      if (this.team.Name.length < 51) {
        this.CreateTeamErrors.NameMax = "";
      }
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
.input1 {
  border-style: solid;
  border-width: 1px;
  border-color: silver;
  border-radius: 5px;
}
.input2 {
  border-style: solid;
  border-width: 1px;
  border-color: white;
}
.input1:hover {
  border-color: black;
}
#btn-cancel {
  background-color: white;
  color: black;
  margin-right: 0.6rem;
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
  /* padding: 0.5rem; */
  padding: 0 0 0 0.5rem !important;
}
td:hover {
  cursor: pointer;
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
.grid-wrapper1 {
  /* display: grid; */
  /* grid-template-columns: 50% 50%; */
  grid-column-gap: 1rem;
  grid-row-gap: 2rem;
}
</style>
