<template>
<div>
  <div class="row" style="margin-bottom:1rem">
    <div class="col-4">
      <router-link to="/team" v-if="authUser.Role =='Admin' || authUser.Role == 'Manager'">
        <span class="material-icons" style="position: relative; top: .4rem">keyboard_arrow_left</span> Back to Teams
      </router-link>
      <router-link :to="`/account/${authUser.Id}`" v-if="authUser.Role =='Staff' || authUser.Role == 'Equipment Staff' || authUser.Role == 'Maintainer'">
        <a><span class="material-icons" style="position: relative; top: .4rem;">keyboard_arrow_left</span> Back to profile</a>
      </router-link>
    </div>
    <!-- <div class="col-8">
      <button v-if="!editMode" class="button btn-edit btn-primary material-shadow-animate " v-on:click="$store.state.teamPage.detailPage.editMode = !editMode">Edit</button>
    </div> -->
  </div>
  <div class="row">


  <div v-if="team" class="material-box col-12" style="margin-bottom: 1rem !important">
        <div class="col-6" style="font-size: 20px; ">  <strong v-if="editMode">Edit details of this team</strong> </div>
        <div class="row" style="margin: 0 1rem 0 0rem">
          <div class="col-11">
            <strong style="font-size: 20px; ">Team Name</strong> <span  v-if="CreateTeamErrors.NameMin != ''"> <span class="error-text">{{ CreateTeamErrors.NameMin }}</span></span> <span v-else-if="CreateTeamErrors.NameMax != ''"> <span class="error-text">{{ CreateTeamErrors.NameMax }}</span></span> <span v-else-if="CreateTeamErrors.ValidName != ''"> <span class="error-text">{{ CreateTeamErrors.ValidName }}</span></span><span v-else-if="CreateTeamErrors.DuplicateName != ''"> <span class="error-text">{{ CreateTeamErrors.DuplicateName }}</span></span>

          </div>
          <div class="col-1" style="display: flex; justify-content: flex-end; padding:0rem" >
            <div v-if="authUser.Role =='Manager'  ">
              <button v-if="!editMode" class="button btn-edit btn-primary material-shadow-animate "  v-on:click="editMode = !editMode" >Edit</button>
            </div>
          </div>
        </div>
      <div class="row" >
        <div v-if="!editMode" class="col-6 input" style="font-size: 20px; color: var(--primary-color);  padding: 0 0 0 1rem !important; font-weight: bold; margin-left: 1rem; margin-bottom:0.5rem" disabled="true">{{team.Name}} </div>
        <input v-if="editMode" v-model.trim="team.Name" class="col-7 input" style="font-size: 20px; color: var(--primary-color);font-weight: bold; padding: 0 0 0 1rem !important; margin-left: 1rem; margin-bottom:0.5rem" > 
        <!-- <div class="col-5 input2" style="display: flex; max-width:480px !important; justify-content: flex-end; margin-top:0.5rem; padding-left: 0rem !important">
          <button v-if="!editMode" class="button btn-edit btn-primary material-shadow-animate "  v-on:click="$store.state.teamPage.detailPage.editMode = !editMode">Edit</button>
        </div> -->
        <!-- <span v-if="editMode" > <strong style="color: #26a69a">- Edit Information</strong> </span> -->
        
      </div>


        <div style="margin-left:1rem"> <strong>Create date: </strong>  {{getDate(team.CreatedDate)}} </div>
          <strong ><div v-if="!editMode" style="margin:0 0.2rem 0 1rem"> Status: <span  :style="{color: team.Status? 'var(--primary-color)' : '#607D8B'}">  {{team.Status? 'Active': 'Inactive'}}   </span></div></strong>
        <div v-if="editMode" style="margin-left:1rem"> 
          <strong >Status: </strong>
          <strong><div v-if="deleteFlag && editMode" style="color:red">Can not change to "inactive" because of holding work orders</div></strong> 
          <label style="margin-right: 0rem; margin-left: 1rem" class="radio"  >
            <input type="radio" name="active" v-on:change="team.Status = true" :checked="team.Status" :disabled="!editMode || deleteFlag">
            Active
          </label>
          <label class="radio">
            <input type="radio" style="margin-top: 0.5rem" name="active" v-on:change="team.Status = false" :checked="!team.Status" :disabled="!editMode || deleteFlag">
            Inactive
          </label>
        </div>
    <strong v-if="editMode">Add new members: </strong>
    <div class="field is-horizontal">
      <multi-select  v-if="editMode" style="width: 44rem !important; height:36px; margin-right: 1rem"  :options="memberOptions" :selected-options="selectedMemberList" @select="onSelect" placeholder="Select a member"></multi-select> 
        <!-- <button v-if="editMode" class="button btn-primary material-shadow-animate pull-right" style="margin-top: 4px" v-on:click="addNew()">add new</button>  -->
    </div>
               <div class="row" style="margin: 0 0 0.5rem 0">
        <button v-if="editMode" class="button btn-confirm-edit  material-shadow-animate" style="margin: 0 0 1rem 1rem; background-color: var(--primary-color); color: white; border-style: none " v-on:click="editTeam()">Save changes</button>
        <button v-if="editMode" id=" btn-cancel" class="button btn-confirm-edit material-shadow-animate" style="margin:0 0 1rem 1rem" v-on:click="() => {
          //this.$router.go(this.$router.currentRoute)
          //location.reload()
          this.editMode =!editMode;
          this.loadTeamDetail();
      }">Cancel</button>
      </div>

        <div class="row">
            <div class="col-6" >  <strong v-if="!editMode">Member of this team</strong> </div>
            <div class="col-6"> <strong v-if="!editMode">Location of this team</strong></div>

        </div>
            <!-- <div class="col-6" >  <strong v-if="editMode">Edit member of this team</strong> </div> -->




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
                    <th style="width:3% !important"><strong>No. </strong></th>
                    <th style="width:15% !important"><strong>Username</strong></th>
                    <!-- <th style="width: 30% !important"><strong>Full Name</strong></th> -->
                    <th style="width: 5% !important"><strong>Role</strong></th>
                    <th style="width: 5% !important"><strong>Status</strong></th>
                    <th style="width: 20% !important" v-if="editMode"><strong>Action</strong></th>
                  </tr>
                </thead>  
                <!-- test -->
                <tbody v-if="authUser.Role =='Admin' || authUser.Role =='Manager'">
                    <tr :key="'member2' + index" v-for="(member, index) in toDisplayMember"  v-if="teamOnly">
                      <td v-on:click="toDetail(member.Id)" >{{ 5*(currentPageMember -1) + (index + 1)}}</td>
                      <td v-on:click="toDetail(member.Id)">{{member.Username}}</td>
                      <td v-on:click="toDetail(member.Id)"> <strong >{{member.TeamRole}}</strong> </td>
                      <strong v-on:click="toDetail(member.Id)"><td :style="{color: member.IsActive? 'var(--primary-color)' : '#607D8B'}">{{member.IsActive ? "Active" : "Inactive"}}</td></strong> 
                      <td v-if="editMode" style="padding-top: 0rem important">
                        <button v-if="editMode" style="margin-left:1rem !important" class="button btn-edit btn-primary material-shadow-animate "   v-on:click="gotoDetail(member.Id, member.Username)">Set to leader</button>
                          <button v-if="editMode" class="button material-shadow-animate "  style="background-color:var(--danger); color:white ; margin-left:1rem !important; border-style: none" v-on:click="confirmKick(member.Id, member.Username)">Remove</button>
                      </td>
                    </tr>
                </tbody>
                <!-- test-end -->
                <!-- test -->
                <tbody v-else>
                    <tr :key="'member2' + index" v-for="(member, index) in toDisplayMember"  v-if="teamOnly">
                      <td  >{{ 5*(currentPageMember -1) + (index + 1)}}</td>
                      <td >{{member.Username}}</td>
                      <td > <span >{{member.TeamRole}}</span> </td>
                      <strong ><td :style="{color: member.IsActive? 'var(--primary-color)' : '#607D8B'}">{{member.IsActive ? "Active" : "Inactive"}}</td></strong> 
                      <td v-if="editMode" style="padding-top: 0rem important">
                        <button v-if="editMode" style="margin-left:1rem !important" class="button btn-edit btn-primary material-shadow-animate "   v-on:click="gotoDetail(member.Id, member.Username)">Set to leader</button>
                          <button v-if="editMode" class="button material-shadow-animate "  style="background-color:var(--danger); color:white ; margin-left:1rem !important; border-style: none" v-on:click="confirmKick(member.Id, member.Username)">Remove</button>
                      </td>
                    </tr>
                </tbody>
                <!-- test-end -->
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
                <th style="width:3% !important; cursor: context-menu !important"><strong>No. </strong></th>
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
    <div v-if="location1 && location1.length > 4" class="">
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

  <!-- <div class="col-12">
    <div v-if="editMode">

      <div v-if="(!team.MemberAccounts || (team.MemberAccounts && team.MemberAccounts.length ==0)) && (!team.LeaderAccount || (team.LeaderAccount && team.LeaderAccount.length ==0))">
        There is no member yet
      </div>
      <div v-else>
        
            <table class="mytable" style="margin-bottom:1rem">
              <thead>
                <tr>
                  <th style="width:3% !important; cursor: context-menu !important"><strong>No. </strong></th>
                  <th style="width:15% !important; cursor: context-menu !important"><strong>Username</strong></th>
                  <th style="width: 15% !important; cursor: context-menu !important"><strong>Full Name</strong></th>
                  <th style="width: 5% !important; cursor: context-menu !important"><strong>Role</strong></th>
                  <th style="width: 5% !important; cursor: context-menu !important"><strong>Status</strong></th>
                  <th style="width: 20% !important; cursor: context-menu !important" v-if="editMode"><strong>Action</strong></th>
                </tr>
              </thead>  
              <tbody>
                  <tr v-if="team.LeaderAccount" >
                    <td style="cursor: context-menu !important">1</td>
                    <td style="cursor: context-menu !important">{{team.LeaderAccount.Username}}</td>
                    <td style="cursor: context-menu !important">{{team.LeaderAccount.Fullname ? team.LeaderAccount.Fullname :'N/A'}}</td>
                    <td  style="color:#26a69a; cursor: context-menu !important"><span style="font-size: 25px; "></span> Leader</td>
                    <strong style="cursor: context-menu !important"><td :style="{color: team.LeaderAccount.IsActive? 'var(--primary-color)' : '#607D8B'}">{{team.LeaderAccount.IsActive ? "Active" : "Inactive"}}</td></strong> 
                    <td v-if="editMode" style="padding-top: 0rem important">
                     
                        <button v-if="editMode" class="button material-shadow-animate "  style="background-color:var(--danger); color:white ; margin-left:9.1rem !important; border-style: none" v-on:click="confirmKick1(team.LeaderAccount.Id, team.LeaderAccount.Username)">Remove</button>
                    </td>
                  </tr>
                  <tr :key="'member' + index" v-for="(member, index) in team.MemberAccounts"  v-if="team.MemberAccounts">
                    <td style="cursor: context-menu !important">{{index + 2}}</td>
                    <td style="cursor: context-menu !important">{{member.Username}}</td>
                    <td style="cursor: context-menu !important">{{member.Fullname ? member.Fullname :'N/A' }} </td>
                    <td  style="cursor: context-menu !important"><span style="font-size: 25px"></span>Member </td>
                    <strong style="cursor: context-menu !important"><td :style="{color: member.IsActive? 'var(--primary-color)' : '#607D8B'}">{{member.IsActive ? "Active" : "Inactive"}}</td></strong> 
                    <td v-if="editMode" style="padding-top: 0rem important">
                      <button v-if="editMode" style="margin-left:1rem !important" class="button btn-edit btn-primary material-shadow-animate "   v-on:click="gotoDetail(member.Id, member.Username)">Set to leader</button>
                        
                        <button v-if="editMode" class="button material-shadow-animate "  style="background-color:var(--danger); color:white ; margin-left:1rem !important; border-style: none" v-on:click="confirmKick(member.Id, member.Username)">Remove</button>

                    </td>
                  </tr>
              </tbody>
            </table>

      </div>
    </div>  
  </div> -->





       <!-- <div class="row" style="margin: 0 0 0.5rem 0">
        <button v-if="editMode" class="button btn-confirm-edit  material-shadow-animate" style="margin: 0 0 1rem 1rem; background-color: var(--primary-color); color: white; border-style: none " v-on:click="editTeam()">Save changes</button>
        <button v-if="editMode" id=" btn-cancel" class="button btn-confirm-edit material-shadow-animate" style="margin:0 0 1rem 1rem" v-on:click="() => {

          this.editMode =!editMode;
          this.loadTeamDetail();
      }">Cancel</button>
      </div> -->



  <div class="col-12">
    <div v-if="!editMode">
    <strong>
      Borrowing Equipment
    </strong>
      <div v-if="!items1 || (items1 && items1.length == 0)">
          There is no equipment yet.
      </div>
      <div v-else>
        <table  class="mytable" style="margin-bottom:1rem">
            <thead>
              <tr >
                <th style="width:5% !important;cursor: context-menu !important "><strong>No. </strong></th>
                <th style="width:30% !important; cursor: context-menu !important"><strong>Equipments </strong></th>
                <th style="width:15% !important; cursor: context-menu !important"><strong>Serial Number Of Item </strong></th>
                <th style="width:30% !important; cursor: context-menu !important"><strong>Work order </strong></th>
                <th style="width:20% !important; cursor: context-menu !important"><strong>Expecting Return Date  </strong></th>
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
                <td style="cursor: context-menu !important">
                  {{getDate(item.ExpectingCloseDate)}}
                  <!-- {{item.ExpectingCloseDate}} -->
                </td>
              </tr>
            </tbody>
        </table>

    <div v-if="items1 && items1.length > 9" class="">
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
                   
                    <span ><strong>Are you sure you want to change this member to leader?</strong></span>
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
                   
                    <span ><strong> Are you sure you want to remove this member?? </strong></span>
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
  <!-- modal-start -->
      <!-- change status dialog -->
      <!-- <modal v-model="cannotKickPopup" style="font-family: Roboto">
          <div slot="header" style="font-weight: bold">
                Remove a member 
            </div>
            <div style="font-size: 1rem">
                <div >
                   
                    <span ><strong> You can not delete the leader that is holding work order. </strong></span>
                    
                    
                </div>
            </div>
            <div slot="footer">
              <button class="button btn-edit material-shadow-animate "  style="background-color:white; color:black; margin-left: 4rem;  border-color: silver" v-on:click="cancelCannotKickPopup" >Cancel</button>
            
            </div>
      </modal>  -->
 <!-- modal-end -->

  </div>
  <div v-if="team && editMode" class="material-box col-12">
  <div class="col-6" style="font-size: 20px; " >  <strong v-if="editMode">Edit member of this team</strong> </div>
  <div class="col-12">
    <div v-if="editMode">
      <!-- <div v-if="!team.LeaderAccount ">
        There is no team leader yet.
      </div> -->
      <div v-if="(!team.MemberAccounts || (team.MemberAccounts && team.MemberAccounts.length ==0)) && (!team.LeaderAccount || (team.LeaderAccount && team.LeaderAccount.length ==0))">
        There is no member yet
      </div>
      <div v-else>
        
            <table class="mytable" style="margin-bottom:1rem">
              <thead>
                <tr>
                  <th style="width:3% !important; cursor: context-menu !important"><strong>No. </strong></th>
                  <th style="width:15% !important; cursor: context-menu !important"><strong>Username</strong></th>
                  <th style="width: 15% !important; cursor: context-menu !important"><strong>Full Name</strong></th>
                  <th style="width: 5% !important; cursor: context-menu !important"><strong>Role</strong></th>
                  <th style="width: 5% !important; cursor: context-menu !important"><strong>Status</strong></th>
                  <th style="width: 20% !important; cursor: context-menu !important" v-if="editMode"><strong>Action</strong></th>
                </tr>
              </thead>  
              <tbody>
                  <tr v-if="team.LeaderAccount" >
                    <td style="cursor: context-menu !important">1</td>
                    <td style="cursor: context-menu !important">{{team.LeaderAccount.Username}}</td>
                    <td style="cursor: context-menu !important">{{team.LeaderAccount.Fullname ? team.LeaderAccount.Fullname :'N/A'}}</td>
                    <td  style="color:#26a69a; cursor: context-menu !important"><span style="font-size: 25px; "></span> Leader</td>
                    <strong style="cursor: context-menu !important"><td :style="{color: team.LeaderAccount.IsActive? 'var(--primary-color)' : '#607D8B'}">{{team.LeaderAccount.IsActive ? "Active" : "Inactive"}}</td></strong> 
                    <td v-if="editMode" style="padding-top: 0rem important">
                     
                        <button v-if="editMode" class="button material-shadow-animate "  style="background-color:var(--danger); color:white ; margin-left:9.1rem !important; border-style: none" v-on:click="confirmKick1(team.LeaderAccount.Id, team.LeaderAccount.Username)">Remove</button>
                    </td>
                  </tr>
                  <tr :key="'member' + index" v-for="(member, index) in team.MemberAccounts"  v-if="team.MemberAccounts">
                    <td style="cursor: context-menu !important">{{index + 2}}</td>
                    <td style="cursor: context-menu !important">{{member.Username}}</td>
                    <td style="cursor: context-menu !important">{{member.Fullname ? member.Fullname :'N/A' }} </td>
                    <td  style="cursor: context-menu !important"><span style="font-size: 25px"></span>Member </td>
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

  </div>



  </div>



    <simplert :useRadius="true" :icon="true" ref="simplert"></simplert>    
</div>
         


</template>

<script>
import Server from "@/config/config.js";
import { sync } from "vuex-pathify";
import moment from "moment";
import "vodal/common.css";
import "vodal/slide-up.css";
import Vodal from "vodal";
import Simplert from "vue2-simplert";
import VueBase64FileUpload from "vue-base64-file-upload";
import { BasicSelect, MultiSelect, ModelSelect } from "vue-search-select";

export default {
  components: {
    VueBase64FileUpload,
    MultiSelect,
    BasicSelect,
    ModelSelect,
    Vodal,
    moment,
    Simplert
  },
  created() {
    this.loadTeamDetail();
  },

  data() {
    return {
      deleteFlag: false,
      deleteFlagLocation: false,
      // editMode: true,
      NameRegex: /^[^~`!#$%@()\^&*+=\-\[\]\\';,/{}|\\":<>\?]*?$/,
      cannotKickPopup: false,
      currentPageMember: 1,
      Equipments: [],
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
      teams: [],
      teamdetails: [],
      sending: false,
      ErrorStrings: {
        NameMax: " Use from 6 to 50 characters for your team name",
        NameMin: " Use from 6 to 50 characters for your team name",
        ValidName: " Team's name cannot contain special character. ",
        DuplicateName: " This team's name already belongs to another team. "
      },
      CreateTeamErrors: {
        NameMax: "",
        NameMin: "",
        ValidName: "",
        DuplicateName: ""
      },
      team: null,
      // team: [],
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
      showConfirm: false,
      teamOnly: [],
      editMode: false
    };
  },
  computed: {
    // editMode: sync("teamPage.detailPage.editMode"),
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    }
  },
  methods: {
    // getAllWorkOrderThatLeaderHad() {
    //   this.axios.get(
    //     `http://localhost:3000/api/team/wo/getAllWorkOrderThatLeaderHad/${
    //       this.$route.params.id
    //     }`.then(res => {
    //       let data = res.data;
    //       this.Equipments = data;
    //     })
    //   );
    // },
    async loadTeamDetail() {
      let url1 = Server.TEAM_API_PATH;
      await this.axios.get(url1).then(response => {
        // this.teams = [];
        if (response.data) {
          this.teams = [];
          response.data.forEach(value => this.teams.push(value.Team));
        }
        // response.data.forEach(value => this.teamdetails.push(value.Team));
      });
      let teamApiUrl = `http://localhost:3000/api/team/id/${
        this.$route.params.id
      }`;

      await this.axios.get(teamApiUrl).then(response => {
        let data = response.data.team;
        this.team = data;
      });

      let outsideTeamApiUrl = `http://localhost:3000/api/AllAccExceptThatTeam/${
        this.$route.params.id
      }`;
      await this.axios.get(outsideTeamApiUrl).then(res => {
        let data = res.data;
        if (data) {
          this.memberOptions = [];
          data.forEach(element => {
            let option = {
              value: element.Id,
              text: element.Username
            };

            this.memberOptions.push(option);
          });
        }
      });

      let urlEquipmentItem = `http://localhost:3000/api/team/id/${
        this.$route.params.id
      }/equipmentitem`;
      await this.axios.get(urlEquipmentItem).then(res => {
        let data = res.data;
        if (data) {
          this.EquiItems = [];
          data.forEach(element => {
            let EquiItem = element;
            var totalItem = 0;
            if (EquiItem.Equipment) {
              EquiItem.Equipment.forEach(eq => {
                totalItem += eq.EquipmentItems.length;
              });
              let workOrder = {
                totalItem: totalItem,
                workOrder: EquiItem
              };
              this.EquiItems.push(workOrder);
            }
          });
        }
      });
      let itemUrl = `http://localhost:3000/api/team/id/${
        this.$route.params.id
      }/item`;
      await this.axios.get(itemUrl).then(response => {
        if (response.data) {
          let data = response.data;
          this.items1 = data;
          this.toDisplayData = this.items1.slice(0, 10);
        }
      });

      let team1ApiUrl = `http://localhost:3000/api/team/id/${
        this.$route.params.id
      }`;
      await this.axios.get(team1ApiUrl).then(response => {
        if (response.data.team && response.data.team.Location) {
          let data = response.data.team.Location;
          this.location1 = data;
          this.toDisplayLocation = this.location1.slice(0, 5);
        }
      });
      let onlymemURL = `http://localhost:3000/api/team/id/${
        this.$route.params.id
      }/OnlyteamMember`;

      await this.axios.get(onlymemURL).then(response => {
        if (response.data) {
          let data = response.data;
          this.teamOnly = data;
          this.toDisplayMember = this.teamOnly.slice(0, 5);
        }
      });
      await this.axios
        .get(
          `http://localhost:3000/api/team/wo/getAllWorkOrderThatLeaderHad/${
            this.$route.params.id
          }`
        )
        .then(res => {
          let data = res.data;
          this.WorkOrders = data;
        });

      if (this.WorkOrders && this.WorkOrders.length != 0) {
        console.log(this.WorkOrders);
        this.deleteFlag = true;
      }
      await this.axios
        .get(
          `http://localhost:3000/api/team/wo/getAllLocationThatTeamHad/${
            this.$route.params.id
          }`
        )
        .then(res => {
          let data = res.data;
          this.CheckLocations = data;
        });

      if (this.CheckLocations && this.CheckLocations.length != 0) {
        console.log(this.CheckLocations);
        this.deleteFlagLocation = true;
      }
    },
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
      if (!this.NameRegex.test(this.team.Name)) {
        this.CreateTeamErrors.ValidName = this.ErrorStrings.ValidName;
      } else {
        this.CreateTeamErrors.ValidName = "";
      }
      for (const team of this.teams) {
        if (team.Id != this.team.Id && team.Name == this.team.Name) {
          this.CreateTeamErrors.DuplicateName = this.ErrorStrings.DuplicateName;
          break;
        }
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
          // location.reload();
          // this.editMode = false;
          this.loadTeamDetail();
          this.editMode = !this.editMode;
          this.selectedMemberList = [];
        }
      }
    },
    validateTeam() {
      return (
        this.CreateTeamErrors.NameMax === "" &&
        this.CreateTeamErrors.NameMin === "" &&
        this.CreateTeamErrors.ValidName == "" &&
        this.CreateTeamErrors.DuplicateName == ""
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
            // location.reload();
            this.loadTeamDetail();
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
          // location.reload();
          this.loadTeamDetail();
          this.kickPopUp = false;
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
          // location.reload();
          this.ChangeLeadPopUp = false;
          this.loadTeamDetail();
          this.show = false;
        });
    },
    cancel() {
      // this.show = false;
      this.ChangeLeadPopUp = false;
      this.editmode = false;
      this.loadTeamDetail();
    },
    cancelConfirm() {
      // this.showConfirm = false;
      this.kickPopUp = false;
    },
    cancelCannotKickPopup() {
      // this.showConfirm = false;
      this.cannotKickPopup = false;
    },
    gotoDetail(memberID, memberName) {
      // this.show = true;
      this.SelectedMemberId = memberID;
      this.SelectedMemberName = memberName;
      this.ChangeLeadPopUp = true;
    },
    confirmKick1(memberID, memberName) {
      // let deleteFlag = false;
      //  this.axios
      //   .get(
      //     `http://localhost:3000/api/team/wo/getAllWorkOrderThatLeaderHad/${memberID}`
      //   )
      //   .then(res => {
      //     let data = res.data;
      //     this.WorkOrders = data;
      //   });

      // if (this.WorkOrders && this.WorkOrders.length != 0) {
      //   console.log(this.WorkOrders);
      //   this.deleteFlag = true;
      // }
      // if (this.deleteFlag || this.deleteFlagLocation) {
      if (this.deleteFlag) {
        let obj = {
          title: "Delete A member",
          message:
            "You can not remove the account because this team is holding work order.",
          type: "error"
        };
        this.$refs.simplert.openSimplert(obj);
      } else {
        this.SelectedMemberId = memberID;
        this.SelectedMemberName = memberName;
        this.kickPopUp = true;
      }
      // this.deleteFlag = false;
      // if (this.deleteFlag == false) {
      //   this.SelectedMemberId = memberID;
      //   this.SelectedMemberName = memberName;
      //   this.kickPopUp = true;
      // }
    },
    confirmKick(memberID, memberName) {
      this.SelectedMemberId = memberID;
      this.SelectedMemberName = memberName;
      this.kickPopUp = true;
      this.loadTeamDetail();
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
      if (this.NameRegex.test(this.team.Name)) {
        this.CreateTeamErrors.ValidName = "";
      }
      let isDupName = false;
      for (const team in this.teams) {
        if (team.Id != this.team.Id && team.Name == this.team.Name) {
          isDupName = true;
          break;
        }
      }
      if (!isDupName) {
        this.CreateTeamErrors.DuplicateName = "";
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
