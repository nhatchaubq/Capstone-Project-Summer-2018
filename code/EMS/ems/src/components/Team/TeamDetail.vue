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
        <div class="row" style="margin: 0 1rem 0 0rem">
          <div class="col-11">
            <strong style="font-size: 20px; ">Team Name</strong> <span  v-if="CreateTeamErrors.NameMin != ''"> <span class="error-text">{{ CreateTeamErrors.NameMin }}</span></span> <span v-if="CreateTeamErrors.NameMax != ''"> <span class="error-text">{{ CreateTeamErrors.NameMax }}</span></span>

          </div>
          <div class="col-1" style="display: flex; justify-content: flex-end; padding:0rem" >
            <div v-if="authUser.Role =='Admin'  ">
              <button v-if="!editMode" class="button btn-edit btn-primary material-shadow-animate "  v-on:click="$store.state.teamPage.detailPage.editMode = !editMode" >Edit</button>
            </div>
          </div>
        </div>
      <div class="row" >
        <div v-if="!editMode" class="col-7 input" style="font-size: 20px; color: var(--primary-color);  padding: 0 0 0 1rem !important; font-weight: bold; margin-left: 1rem; margin-bottom:0.5rem" disabled="true">{{team.Name}} </div>
        <input v-if="editMode" v-model.trim="team.Name" class="col-7 input" style="font-size: 20px; color: var(--primary-color);font-weight: bold; padding: 0 0 0 1rem !important; margin-left: 1rem; margin-bottom:0.5rem" > 
        <!-- <div class="col-5 input2" style="display: flex; max-width:480px !important; justify-content: flex-end; margin-top:0.5rem; padding-left: 0rem !important">
          <button v-if="!editMode" class="button btn-edit btn-primary material-shadow-animate "  v-on:click="$store.state.teamPage.detailPage.editMode = !editMode">Edit</button>
        </div> -->
        <!-- <span v-if="editMode" > <strong style="color: #26a69a">- Edit Information</strong> </span> -->
        
      </div>
      <!-- <div class="row" style="margin: 0 0 0.5rem 0">
        <button v-if="editMode" class="button btn-confirm-edit btn-primary material-shadow-animate" style="margin: 0 0 1rem 1rem" v-on:click="editTeam()">Save changes</button>
        <button v-if="editMode" id=" btn-cancel" class="button btn-confirm-edit material-shadow-animate" style="margin:0 0 1rem 1rem" v-on:click="() => {
          this.$router.go(this.$router.currentRoute)
      }">Cancel</button>
      </div> -->

        <h2> <strong>Create date: </strong>  {{getDate(team.CreatedDate)}} </h2>

    <strong v-if="editMode">Add new members: </strong>
    <div class="field is-horizontal">
      <multi-select  v-if="editMode" style="width: 44rem !important; height:36px; margin-right: 1rem"  :options="memberOptions" :selected-options="selectedMemberList" @select="onSelect" placeholder="Select a member"></multi-select> 
        <!-- <button v-if="editMode" class="button btn-primary material-shadow-animate pull-right" style="margin-top: 4px" v-on:click="addNew()">add new</button>  -->
    </div>
        

        <div class="row">
            <div class="col-6">  <strong >Member of this team</strong> </div>
            <div class="col-6"> <strong v-if="!editMode">Location of this team</strong></div>

        </div>




  <div class="row" > 
    <div class="col-6">   
      <div v-if="!editMode">
        <!-- <div v-if="!teamOnly || teamOnly.length == 0"> -->
        <div v-if="(!team.MemberAccounts ||team.MemberAccounts.length ==0) && (!team.LeaderAccount  || team.LeaderAccount.length ==0)">
          There is no team member yet.
        </div>
        <!-- <div v-if="!team.LeaderAccount ">
          There is no team leader yet.
        </div>
        <div v-if="!team.MemberAccounts">
          There is no team member yet
        </div> -->

        <div v-else>

              <table class="mytable" style="margin-bottom:1rem">
                <thead>
                  <tr>
                    <th style="width:3% !important"><strong># </strong></th>
                    <th style="width:15% !important"><strong>Username</strong></th>
                    <!-- <th style="width: 30% !important"><strong>Full Name</strong></th> -->
                    <th style="width: 5% !important"><strong>Role</strong></th>
                    <th style="width: 5% !important"><strong>Status</strong></th>
                    <th style="width: 20% !important" v-if="editMode"><strong>Action</strong></th>
                  </tr>
                </thead>  
                <tbody>
                    <!-- <tr v-if="teamOnly" >
                      <td v-on:click="toDetail(team.LeaderAccount.Id)">1</td>
                      <td v-on:click="toDetail(team.LeaderAccount.Id)">{{team.LeaderAccount.Username}}</td>
                      <td v-on:click="toDetail(team.LeaderAccount.Id)" style="color:#26a69a"><span style="font-size: 25px; ">♛</span> Leader</td>
                      <strong v-on:click="toDetail(team.LeaderAccount.Id)"><td :style="{color: team.LeaderAccount.IsActive? 'var(--primary-color)' : '#607D8B'}">{{team.LeaderAccount.IsActive ? "Active" : "Inactive"}}</td></strong> 
                      <td v-if="editMode">&nbsp;</td>
                    </tr> -->

                    <tr :key="'member2' + index" v-for="(member, index) in toDisplayMember"  v-if="teamOnly">
                      <td v-on:click="toDetail(member.Id)">{{ 5*(currentPageMember -1) + (index + 1)}}</td>
                      <td v-on:click="toDetail(member.Id)">{{member.Username}}</td>
                    
                      <!-- <td v-on:click="toDetail(member.Id)"><span v-if="member.TeamRoleID =2" style="font-size: 25px">♟Member</span> </td> -->
                      <td v-on:click="toDetail(member.Id)"> <span >{{member.TeamRole}}</span> </td>
                      <strong v-on:click="toDetail(member.Id)"><td :style="{color: member.IsActive? 'var(--primary-color)' : '#607D8B'}">{{member.IsActive ? "Active" : "Inactive"}}</td></strong> 
                      <td v-if="editMode" style="padding-top: 0rem important">
                        <button v-if="editMode" style="margin-left:1rem !important" class="button btn-edit btn-primary material-shadow-animate "   v-on:click="gotoDetail(member.Id, member.Username)">Set to leader</button>
                          <button v-if="editMode" class="button material-shadow-animate "  style="background-color:var(--danger); color:white ; margin-left:1rem !important; border-style: none" v-on:click="confirmKick(member.Id, member.Username)">Remove</button>

                      </td>
                    </tr>
                </tbody>
              </table>
                  <div v-if="teamOnly.length > 4" class="">
    <Page :current="currentPageMember" :total="teamOnly.length" show-elevator 
      @on-change="(newPageNumber) => {
        currentPageMember = newPageNumber;
        let start = 5 * (newPageNumber - 1);
        let end = start + 5;
        
        toDisplayMember = teamOnly.slice(start, end);
      }">
    </Page>
  </div>  

        </div>
      </div>
    </div>

    <div class="col-6">
      <div v-if="!editMode">
        <div v-if="location1 && location1.length ==0"  >
          There is no location yet.
        </div>
        <div v-else>
          <!-- page-navi -->
    <!-- <div v-if="location.length > 9" class="">
      <Page :current="currentPageLoca" :total="location.length" show-elevator 
        @on-change="(newPageNumber) => {
          currentPageLoca = newPageNumber;
          let start = 10 * (newPageNumber - 1);
          let end = start + 10;
          
          toDisplayLocation = location.slice(start, end);
        }">
      </Page>
    </div>   -->
    <!-- page-navi-end -->
          <table class="mytable" style="margin-bottom:1rem">
            <thead>
              <tr>
                <th style="width:3% !important; cursor: context-menu !important"><strong># </strong></th>
                <th style="width:30% !important; cursor: context-menu !important"><strong>Location Name </strong></th>
                <th style="width: 57% !important; cursor: context-menu !important"><strong>Location Address</strong></th>
                <th style="width: 10% !important; cursor: context-menu !important"><strong>Status</strong></th>
              </tr>
            </thead>  
            <tbody>
                <tr :key="'Loca'+ index" v-for="(Loca, index) in toDisplayLocation" class="txtText" >
                  <td style="cursor: context-menu !important">{{ 5*(currentPageLoca - 1) + (index + 1)}}</td>
                  <td style="cursor: context-menu !important">{{Loca.Name | truncate(17) }}</td>
                  <td style="cursor: context-menu !important">{{Loca.Address | truncate(38)}} </td>
                  <td style="cursor: context-menu !important"> <strong :style="{color: Loca.IsActive ? 'var(--primary-color)' : '#607D8B'}">{{Loca.IsActive ? "Active" : "Inactive"}}</strong></td>
                </tr>
            </tbody>
          </table>
    <div v-if="location1.length > 4" class="">
      <Page :current="currentPageLoca" :total="location1.length" show-elevator 
        @on-change="(newPageNumber) => {
          currentPageLoca = newPageNumber;
          let start = 5 * (newPageNumber - 1);
          let end = start + 5;
              showarlet(`start: ${start } end: ${end} total:${total} location: ${location1}`)
          
          toDisplayLocation = location1.slice(start, end);
        }">
      </Page>
    </div>  
        </div>
      </div>
    </div>
  </div>

  <div class="col-12">
    <div v-if="editMode">
      <!-- <div v-if="!team.LeaderAccount ">
        There is no team leader yet.
      </div> -->
      <div v-if="!team.MemberAccounts && !team.LeaderAccount && team.MemberAccounts.length ==0 && team.LeaderAccount.length ==0">
        There is no member yet
      </div>
      <div v-else>
        
            <table class="mytable" style="margin-bottom:1rem">
              <thead>
                <tr>
                  <th style="width:3% !important; cursor: context-menu !important"><strong># </strong></th>
                  <th style="width:15% !important; cursor: context-menu !important"><strong>Username</strong></th>
                  <th style="width: 15% !important; cursor: context-menu !important"><strong>Full Name</strong></th>
                  <th style="width: 5% !important; cursor: context-menu !important"><strong>Status</strong></th>
                  <th style="width: 5% !important; cursor: context-menu !important"><strong>Role</strong></th>
                  <th style="width: 20% !important; cursor: context-menu !important" v-if="editMode"><strong>Action</strong></th>
                </tr>
              </thead>  
              <tbody>
                  <tr v-if="team.LeaderAccount" >
                    <td style="cursor: context-menu !important">1</td>
                    <td style="cursor: context-menu !important">{{team.LeaderAccount.Username}}</td>
                    <td style="cursor: context-menu !important">{{team.LeaderAccount.Fullname ? team.LeaderAccount.Fullname :'N/A'}}</td>
                    <td  style="color:#26a69a; cursor: context-menu !important"><span style="font-size: 25px; ">♛</span> Leader</td>
                    <strong style="cursor: context-menu !important"><td :style="{color: team.LeaderAccount.IsActive? 'var(--primary-color)' : '#607D8B'}">{{team.LeaderAccount.IsActive ? "Active" : "Inactive"}}</td></strong> 
                    <td v-if="editMode">&nbsp;</td>
                  </tr>
                  <tr :key="'member' + index" v-for="(member, index) in team.MemberAccounts"  v-if="team.MemberAccounts">
                    <td style="cursor: context-menu !important">{{index + 2}}</td>
                    <td style="cursor: context-menu !important">{{member.Username}}</td>
                    <td style="cursor: context-menu !important">{{member.Fullname ? member.Fullname :'N/A' }} </td>
                    <td  style="cursor: context-menu !important"><span style="font-size: 25px">♟</span>Member </td>
                    <strong style="cursor: context-menu !important"><td :style="{color: member.IsActive? 'var(--primary-color)' : '#607D8B'}">{{member.IsActive ? "Active" : "Inactive"}}</td></strong> 
                    <td v-if="editMode" style="padding-top: 0rem important">
                      <button v-if="editMode" style="margin-left:1rem !important" class="button btn-edit btn-primary material-shadow-animate "   v-on:click="gotoDetail(member.Id, member.Username)">Set to leader</button>
                        <!-- <button v-if="editMode" class="material-icons"  style="color: var(--danger); margin-left:1rem !important" v-on:click="confirmKick(member.Id, member.Username)">close</button> -->
                        <button v-if="editMode" class="button material-shadow-animate "  style="background-color:var(--danger); color:white ; margin-left:1rem !important; border-style: none" v-on:click="confirmKick(member.Id, member.Username)">Remove</button>

                    </td>
                  </tr>
              </tbody>
            </table>

      </div>
    </div>  
  </div>





       <div class="row" style="margin: 0 0 0.5rem 0">
        <button v-if="editMode" class="button btn-confirm-edit  material-shadow-animate" style="margin: 0 0 1rem 1rem; background-color: var(--primary-color); color: white; border-style: none " v-on:click="editTeam()">Save changes</button>
        <button v-if="editMode" id=" btn-cancel" class="button btn-confirm-edit material-shadow-animate" style="margin:0 0 1rem 1rem" v-on:click="() => {
          this.$router.go(this.$router.currentRoute)
          //location.reload()
      }">Cancel</button>
      </div>


     <!-- equipmentItem-start -->
         <!-- <div class="col-12">
    <div v-if="!editMode">
      <div v-if="!EquiItems ">
          Error
      </div>
      <div v-else>
        <table class="mytable" style="margin-bottom:1rem">
            <thead>
              <tr>

                <th style="width:30% !important"><strong>Work order(Status) </strong></th>
                <th style="width:30% !important"><strong>Equipments </strong></th>
                <th style="width:30% !important"><strong>Items </strong></th>
                <th style="width:30% !important"><strong>Returned </strong></th>


              </tr>
            </thead>  
            <tbody style="font-size:14px" :class="{'row-even': index % 2 != 0}" v-bind:key="WO.WorkOrderId" v-for="(WO, index1) in EquiItems" >
                <tr>

                  <td :rowspan="WO.totalItem + 1">{{WO.workOrder.WorkOrderName}}({{WO.workOrder.WorkOrderStatusName}})-{{WO.workOrder.Equipment.length+1}}</td>

                </tr>
                <tbody style="font-size:14px" :class="{'row-even': index % 2 != 0}" v-bind:key="'eq' + eq.Id" v-for="(eq, index2) in WO.workOrder.Equipment" >
                  <tr>  

                      <td :rowspan="eq.EquipmentItems.length + 1">{{eq.Name}}-{{eq.EquipmentItems.length +1}} </td>

                  </tr>
                  <tr :key="'eqi' + eqi.Id" v-for="(eqi, index3) in eq.EquipmentItems">
                    <td>#{{eqi.SerialNumber}}</td>
                  </tr>
                
                </tbody>


            </tbody>
          </table>

      </div>
    </div>  
  </div> -->
     <!-- equipmentItem-end -->
     <!-- equipmentItem-start -->
  <div class="col-12">
    <div v-if="!editMode">
    <strong>
      Borrowing Equipment
    </strong>
      <div v-if="items1 && items1.length == 0">
          There is no equipment yet.
      </div>
      <div v-else>
        <table  class="mytable" style="margin-bottom:1rem">
            <thead>
              <tr >
                <th style="width:5% !important;cursor: context-menu !important "><strong># </strong></th>
                <th style="width:30% !important; cursor: context-menu !important"><strong>Equipments </strong></th>
                <th style="width:30% !important; cursor: context-menu !important"><strong>Serial Number Of Item </strong></th>
                <th style="width:30% !important; cursor: context-menu !important"><strong>Work order </strong></th>
              </tr>
            </thead>  
            <tbody >
              <tr v-bind:key="'toDisplayData' + index + '' + item.Id" v-for="(item, index) in toDisplayData">
                <td style="cursor: context-menu !important">
                  {{ 10 * (currentPage - 1) + (index + 1) }}
                </td> 
                <td style="cursor: context-menu !important">
                  {{item.Name}}
                </td >
                <td style="cursor: context-menu !important">
                  {{item.SerialNumber}}
                </td>
                <td style="cursor: context-menu !important">
                  {{item.WordOrderName}}
                </td>
              </tr>
            </tbody>
        </table>

    <div v-if="items1.length > 9" class="">
    <Page :current="currentPage" :total="items1.length" show-elevator 
      @on-change="(newPageNumber) => {
        currentPage = newPageNumber;
        let start = 10 * (newPageNumber - 1);
        let end = start + 10;
        
        toDisplayData = items1.slice(start, end);
      }">
    </Page>
  </div>  
      </div>
    </div>  
  </div>
     <!-- equipmentItem-end -->




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

        <button class="button btn-edit material-shadow-animate "  style="background-color:white; color: black; margin-left: 3rem; border-color: silver" v-on:click="cancel" >Cancel</button>

      

    </div>
  </vodal>
  <!-- modal-start change lead -->
      <!-- change status dialog -->
      <modal v-model="ChangeLeadPopUp" style="font-family: Roboto">
          <div slot="header" style="font-weight: bold">
                Confirm 
            </div>
            <div style="font-size: 1rem">
                <div >
                   
                    <span ><strong> Are you sure you want to kick this member?? </strong></span>
                    <div style="font-size: .95rem; font-weight: 500; margin-top: 0.5rem;">
                      <div class="row">
                        <div class="col-5" style="text-align: right; padding-left:0rem !important">Member Id: </div>
                        <div class="col-7">{{SelectedMemberId}}</div>
                      </div>
                      <div class="row">
                        <div class="col-5" style="text-align: right; padding-left:0rem !important">Member Name: </div>
                        <div class="col-7">{{SelectedMemberName}}</div>
                      </div>
                    </div>
                    
                </div>
            </div>
            <div slot="footer">
        <button class="button btn-edit material-shadow-animate "  style="background-color:white; color: black; margin-left: 3rem; border-color: silver" v-on:click="cancel" >Cancel</button>
                   <button class="button btn-edit btn-primary material-shadow-animate "  style="margin-left: 1rem" v-on:click="changeToLeader(SelectedMemberId)">Change</button>
            </div>
      </modal> <!-- change status dialog -->
 <!-- modal-end -->

  <!-- modal-start -->
      <!-- change status dialog -->
      <modal v-model="kickPopUp" style="font-family: Roboto">
          <div slot="header" style="font-weight: bold">
                Confirm
            </div>
            <div style="font-size: 1rem">
                <div >
                   
                    <span ><strong> Are you sure you want to kick this member?? </strong></span>
                    <div style="font-size: .95rem; font-weight: 500; margin-top: 0.5rem;">
                      <div class="row">
                        <div class="col-5" style="text-align: right; padding-left:0rem !important">Member Id: </div>
                        <div class="col-7">{{SelectedMemberId}}</div>
                      </div>
                      <div class="row">
                        <div class="col-5" style="text-align: right; padding-left:0rem !important">Member Name: </div>
                        <div class="col-7">{{SelectedMemberName}}</div>
                      </div>
                    </div>
                    
                </div>
            </div>
            <div slot="footer">
              <button class="button btn-edit material-shadow-animate "  style="background-color:white; color:black; margin-left: 4rem;  border-color: silver" v-on:click="cancelConfirm" >Cancel</button>
              <button class="button material-shadow-animate "  style="background-color:var(--danger); color:white; margin-left: 1rem; border-style: none " v-on:click="kick(SelectedMemberId)">Remove</button>
            </div>
      </modal> <!-- change status dialog -->
 <!-- modal-end -->

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

    let urlEquipmentItem = `http://localhost:3000/api/team/id/${
      this.$route.params.id
    }/equipmentitem`;
    this.axios.get(urlEquipmentItem).then(res => {
      let data = res.data;
      data.forEach(element => {
        let EquiItem = element;
        var totalItem = 0;
        EquiItem.Equipment.forEach(eq => {
          totalItem += eq.EquipmentItems.length;
        });
        let workOrder = {
          totalItem: totalItem,
          workOrder: EquiItem
        };
        this.EquiItems.push(workOrder);
      });
    });
    let itemUrl = `http://localhost:3000/api/team/id/${
      this.$route.params.id
    }/item`;

    this.axios.get(itemUrl).then(response => {
      let data = response.data;
      this.items1 = data;
      this.toDisplayData = this.items1.slice(0, 10);
    });
    let team1ApiUrl = `http://localhost:3000/api/team/id/${
      this.$route.params.id
    }`;

    this.axios.get(team1ApiUrl).then(response => {
      let data = response.data.team.Location;
      this.location1 = data;
      this.toDisplayLocation = this.location1.slice(0, 5);
    });
    let onlymemURL = `http://localhost:3000/api/team/id/${
      this.$route.params.id
    }/OnlyteamMember`;

    this.axios.get(onlymemURL).then(response => {
      let data = response.data;
      this.teamOnly = data;
      this.toDisplayMember = this.teamOnly.slice(0, 5);
      // this.toDisplayTeam = this.teamOnly.slice(0, 5);
    });
    // this.axios.get(team1ApiUrl).then(response => {
    //   let data = response.data.team.Location;
    //   this.location1 = data;
    //   this.toDisplayLocation = this.location1.slice(0, 5);
    // });
  },

  data() {
    return {
      currentPageMember: 1,
      toDisplayMember: [],
      currentPageLoca: 1,
      toDisplayLocation: [],
      currentPage: 1,
      location1: [],
      toDisplayData: [],
      kickPopUp: false,
      ChangeLeadPopUp: false,
      EquiItems: [],
      items1: [],
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
      // editMode: false
    };
  },
  computed: {
    editMode: sync("teamPage.detailPage.editMode"),
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    }
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
      if (this.validateTeam()) {
        var checkName = true;
        var checkAccounts = true;
        this.axios
          .put(`http://localhost:3000/api/team/${this.$route.params.id}`, {
            team: this.team
          })
          .then(res => {
            if (res.status == 200) {
              checkName = true;
            }
          })
          .catch(error => {
            checkName = false;
            console.log(error);
          });
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
              // this.$router.push("/account");
              if (res.status == 200) {
                // this.editMode = false;
                checkAccounts = true;
              }
            });
        });
        if (checkName && checkAccounts) {
          alert("Change successful");
          // this.getTeamDetail(this.$route.params.id);
          location.reload();
        }
      }
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
    showarlet(msg) {
      console.log(msg);
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
      // this.show = false;
      this.ChangeLeadPopUp = false;
    },
    cancelConfirm() {
      // this.showConfirm = false;
      this.kickPopUp = false;
    },
    gotoDetail(memberID, memberName) {
      // this.show = true;
      this.SelectedMemberId = memberID;
      this.SelectedMemberName = memberName;
      this.ChangeLeadPopUp = true;
    },
    confirmKick(memberID, memberName) {
      // this.showConfirm = true;
      this.SelectedMemberId = memberID;
      this.SelectedMemberName = memberName;
      this.kickPopUp = true;
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
td1 {
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
