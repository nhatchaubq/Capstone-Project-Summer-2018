<template>
    <div v-if="allDurations">        
        <div style="padding-left:10rem; padding-right: 10rem">
              <table class="mytable">
            <thead>
              <tr>
                
                <th ><strong>#</strong></th>
                <th ><strong>Maintenance Duration (Month)</strong></th>                     
                <th colspan="2" style="text-align:center"><strong>Action</strong></th>                   
                
              </tr>
              
            </thead>  
            <tbody>
                <tr v-bind:key="dura.Id" v-for="(dura, index) in tmpDurations" class="txtText" >          
                  <td >{{ 10*(currentPage -1) + (index + 1) }}</td>
                  <td >{{dura.Months}}</td>                        
                  <td width=6% v-on:click="editShow(dura)"><button class="button" style="padding:0px 5px 0px 5px ">Edit</button></td>
                  <td width=6%><button class="button" style="padding:0px 5px 0px 5px " v-on:click="deleteDura(dura)">Delete</button></td>               
                </tr>
            </tbody>
          </table>        
        </div>        
        <div v-if="allDurations.length >9" class="number-page" style="padding-left:10rem; padding-right: 10rem"> 
          <Page :current="currentPage" :total="allDurations.length" show-elevator 
            @on-change="(newPageNumber) => {
              currentPage = newPageNumber
              let start = 10 * (newPageNumber - 1);
              let end = start + 10;
              
              tmpDurations = allDurations.slice(start, end);
            }">
          </Page>
        </div> 
        <div>            
                <button v-if="authUser.Role =='Equipment Staff'" id="btn-add-category" class="button btn-primary material-shadow-animate" v-on:click="createShow()">Add Maintenance Duration</button>
      </div>

       <modal v-model="editPopup" >
                
          <div slot="header" style=" font-size: 24px; font-weight: bold"> 
            Edit Maintenance Duration 
          </div>
          <div class="form-content" v-if="tmpDuration" >   
            <div class="form-field" style="padding-top:1.5rem">
                <div class="form-field-title">
                    <strong>New Maintenance Duration </strong>  
                    <span v-if="CreateDurationErrors.NoName != ''"><span class="error-text">  {{ CreateDurationErrors.NoName }}</span></span>
                </div>
                <div class="form-field-input">
                    <input v-model.trim="tmpDuration.Months" type="text" class="input" v-on:input="() => {
                            if (tmpDuration.Months < 1 || tmpDuration.Months == '') {
                               tmpDuration.Months = 0;
                            } else if (tmpDuration.Months > 60) {
                                tmpDuration.Months = 60;
                            }
                           tmpDuration.Months = getNumberFormattedThousand(tmpDuration.Months);
                        }">
                </div>
            </div>                                         
        </div> 
        <div class="form-title-end" slot="footer">                      
                <button id="" class="button is-primary"  v-on:click="editMtDura()">Save changes</button>                       
                <button id="" class="button" style="margin-right: .6rem"  v-on:click="editPopup = false">Cancel</button>             
        </div>        
        </modal>

        <modal v-model="deletePopup">                          
          <div slot="header" style=" font-size: 24px; font-weight: bold"> 
            Delete A Maintenance Duration 
          </div>         
          <div style="font-size:18px;"  v-if="tmpDuration">
            Do you want to delete maintenance duration '{{tmpDuration.Months}}' ?
          </div>
          <div class="form-title-end" slot="footer" style="border-top: 0px !important" >                      
                <button id="" class="button is-primary" v-on:click="deleteThis()">Delete</button>                     
                <button id="" class="button"   v-on:click="deletePopup = false">Cancel</button>             
          </div>
        </modal>

        <modal v-model="createPopup">          
          <div slot="header" style=" font-size: 24px; font-weight: bold" >
              Add New Maintenance 
            </div>
          <div class="form-content" v-if="newDuration">   
              <div class="form-field" style="padding-top:1.5rem">
                  <div class="form-field-title">
                      <strong>Maintenance Duration (Month) </strong>  <span v-if="CreateDurationErrors.NoName != ''"><span class="error-text">  {{ CreateDurationErrors.NoName }}</span></span>
                  </div>
                  <div class="form-field-input">
                      <input v-model.trim="newDuration.month" type="text" class="input" v-on:input="() => {
                            if (newDuration.month < 1 || newDuration.month == '') {
                                newDuration.month = 0;
                            } else if (newDuration.month > 60) {
                                newDuration.month = 60;
                            }
                            newDuration.month = getNumberFormattedThousand(newDuration.month);
                        }">
                  </div>
              </div>                                                
          </div>
          <div slot="footer">
              <div class="form-title-end">                              
                <button id="" class="button is-primary"  v-on:click="createDura()">Add New Maintenance Duration</button>
                <button id="" class="button"  v-on:click="createPopup = false">Cancel</button>                                   
            </div> 
          </div>                
        </modal>
    <simplert :useRadius="true" :icon="true" ref="simplert"></simplert>          
    </div>
</template>

<script>
import Server from "@/config/config.js";
import Simplert from "vue2-simplert";
import Utils from "@/utils.js";
import numeral from "numeral";

export default {
  components: {
    Simplert
  },
  computed: {
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    }
  },
  data() {
    return {
      duplicate: false,
      deleteFlag: false,
      createPopup: false,
      deletePopup: false,
      editPopup: false,
      currentPage: 1,
      allDurations: [],
      tmpDurations: [],
      allItems: [],
      tmpDuration: null,
      CreateDurationErrors: {
        NoName: ""
      },
      ErrorStrings: {
        NoName: "Please enter months!",
        ShortName: "Use 2 characters or more for unit's name",
        LongName: "Use 15 characters or fewer for unit's name"
      },
      newDuration: {
        month: ""
      }
    };
  },
  created() {
    this.getAllDura();
    this.axios
      .get("http://localhost:3000/api/duration/getAllItems")
      .then(res => {
        let data = res.data;
        data.forEach(item => {
          this.allItems.push(item);
        });
      })
      .catch(error => {
        console.log(error);
      });
  },
  methods: {
    getNumberFormattedThousand(str) {
      let value = numeral(str).value();
      return numeral(value).format("0,0");
    },
    getAllDura() {
      this.axios
        .get("http://localhost:3000/api/duration/")
        .then(res => {
          this.allDurations = [];
          let data = res.data;
          data.forEach(duration => {
            this.allDurations.push(duration);
            let start = 10 * (this.currentPage - 1);
            let end = start + 10;

            this.tmpDurations = this.allDurations.slice(start, end);
          });
        })
        .catch(error => {
          console.log(error);
        });
    },
    editShow(dura) {
      this.tmpDuration = JSON.stringify(dura);
      this.tmpDuration = JSON.parse(this.tmpDuration);
      this.editPopup = true;
    },
    editMtDura() {
      // this.tmpDuration.Months = numeral(this.tmpDuration.Months).value();
      for (const dura of this.allDurations) {
        if (
          this.tmpDuration.Months == dura.Months &&
          this.tmpDuration.Id != dura.Id
        ) {
          this.duplicate = true;
          break;
        }
      }
      if (this.tmpDuration.Months < 1 || this.tmpDuration.Months > 60) {
        this.CreateDurationErrors.NoName =
          "Maintaince duration must be from 1 to 60 months";
      } else if (this.duplicate) {
        this.CreateDurationErrors.NoName =
          "Maintenance duration already exists.";
        this.duplicate = false;
      }
      if (this.CreateDurationErrors.NoName == "") {
        this.axios
          .put(Server.EQUIPMENT_MAINTENANCE_DURATION_UPDATE_API_PATH, {
            newDuration: {
              id: this.tmpDuration.Id,
              month: this.tmpDuration.Months
            }
          })
          .then(async res => {
            this.editPopup = false;
            let obj = {
              title: "Update Maintenance Duration",
              message: "Successfully!!!",
              type: "success"
            };

            this.$refs.simplert.openSimplert(obj);
            this.getAllDura();
            await Utils.sleep(2000);
            // this.$router.push("/category");
          })
          .catch(error => {
            console.log(error);
          });
      }
    },
    deleteDura(dura) {
      this.tmpDuration = dura;
      for (const item of this.allItems) {
        if (dura.Id == item.DurationId) {
          this.deleteFlag = true;
          break;
        }
      }
      if (this.deleteFlag) {
        let obj = {
          title: "Delete A Maintenance Duration",
          message:
            "You can not delete the maintenance duration that is being used.",
          type: "error"
        };
        this.$refs.simplert.openSimplert(obj);
      } else {
        this.deletePopup = true;
      }
      this.deleteFlag = false;
    },
    deleteThis() {
      if (this.tmpDuration) {
        this.axios
          .delete(
            `http://localhost:3000/api/duration/deleteDuration/${
              this.tmpDuration.Id
            }`
          )
          .then(async res => {
            this.tmpDuration = null;
            this.deletePopup = false;
            let obj = {
              title: "Delete A Maintenance Duration",
              message: "Successfully!!!",
              type: "success"
            };
            this.$refs.simplert.openSimplert(obj);
            this.getAllDura();
          })
          .catch(error => {
            console.log(error);
            this.$router.push("/500");
          });
      }
    },
    createShow() {
      this.createPopup = true;
    },
    createDura() {
      // this.newDuration.month = numeral(this.newDuration.month).value();
      for (const dura of this.allDurations) {
        if (this.newDuration.month == dura.Months) {
          this.duplicate = true;
          break;
        }
      }
      if (this.newDuration.month < 1 || this.newDuration.month > 60) {
        this.CreateDurationErrors.NoName =
          "Maintaince duration must be from 1 to 60 months";
      } else if (this.duplicate) {
        this.CreateDurationErrors.NoName =
          "Maintenance duration already exists.";
        this.duplicate = false;
      }
      if (this.CreateDurationErrors.NoName == "") {
        this.axios
          .post(Server.EQUIPMENT_MAINTENANCE_DURATION_CREATE_API_PATH, {
            newDuration: {
              month: this.newDuration.month
            }
          })
          .then(async res => {
            // alert(this.selectedTeams.length);
            this.createPopup = false;
            let obj = {
              title: "Create Maintenance Duration",
              message: "Successfully!!!",
              type: "success"
            };
            this.newDuration.month = "";
            this.$refs.simplert.openSimplert(obj);
            this.getAllDura();
            await Utils.sleep(2000);
          })
          .catch(error => {
            console.log(error);
          });
      }
    }
  },
  watch: {
    "tmpDuration.Months": function() {
      if (this.tmpDuration && this.tmpDuration.Months != "") {
        this.CreateDurationErrors.NoName = "";
      }
    },
    "newDuration.month": function() {
      if (this.newDuration.month != "") {
        this.CreateDurationErrors.NoName = "";
      }
    },
    createPopup: function() {
      if (!this.createPopup) {
        this.CreateDurationErrors.NoName = "";
        this.newDuration.month = "";
      }
    }
  }
};
</script>

<style scoped>
.mytable {
  /* padding-left: 5rem !important; */
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
table {
  /* border: 1px solid black; */

  width: 100%;

  font-size: 15px;

  /* text-align: right; */
}
#btn-add-category {
  position: fixed;
  right: 3rem;
  bottom: 2rem;

  /* background-color: var(--primary-color);
  padding: 13px;
  color: white;
  border-radius: 5px; */
  z-index: 1;
}

#btn-add-category:hover {
  cursor: pointer;
  /* background-color: #009688;
  color: white; */
}
.number-page {
  padding-top: 20px;
}
#text-descrip {
  border: 0.5px solid lightgray;
  border-radius: 5px;
  padding: 0.3rem;
}
#text-descrip:hover {
  border: 1px solid grey;
}
input {
  font-size: 15px;
}

.form-field {
  /* margin-bottom: 5px; */

  margin-bottom: 1.5rem;
}

.form-title {
  display: grid;
  grid-template-columns: 65% 35%;
  border-bottom: 1px solid #e0e0e0;
  padding: 1rem 2rem;
}

.form-field-title {
  font-size: 15px;
}
</style>
