<template>
    <div v-if="allUnits">        
        <div style="padding-left:10rem; padding-right: 10rem">
              <table class="mytable">
            <thead>
              <tr>
                
                <th ><strong>#</strong></th>
                <th ><strong>Unit Name</strong></th>                     
                <th colspan="2" style="text-align:center"><strong>Action</strong></th>                   
                
              </tr>
              
            </thead>  
            <tbody>
                <tr v-bind:key="unit.Id" v-for="(unit, index) in tmpUnits" class="txtText" >          
                  <td >{{ 10*(currentPage -1) + (index + 1) }}</td>
                  <td >{{unit.Name}}</td>                        
                  <td width=6% v-on:click="editShow(unit)"><button class="button" style="padding:0px 5px 0px 5px ">Edit</button></td>
                  <td width=6%><button class="button" style="padding:0px 5px 0px 5px " v-on:click="deleteCate(unit)">Delete</button></td>               
                </tr>
            </tbody>
          </table>        
        </div>        
        <div v-if="allUnits.length >9" class="number-page" style="padding-left:10rem; padding-right: 10rem"> 
          <Page :current="currentPage" :total="allUnits.length" show-elevator 
            @on-change="(newPageNumber) => {
              currentPage = newPageNumber
              let start = 10 * (newPageNumber - 1);
              let end = start + 10;
              
              tmpUnits = allUnits.slice(start, end);
            }">
          </Page>
        </div> 
        <div>            
                <button v-if="authUser.Role =='Equipment Staff'" id="btn-add-category" class="button btn-primary material-shadow-animate" v-on:click="createShow()">Add Unit</button>
      </div>

       <modal v-model="editPopup" >
                
          <div slot="header" style=" font-size: 24px; font-weight: bold"> 
            Edit Unit 
          </div>
          <div class="form-content" v-if="tmpUnit" >   
            <div class="form-field" style="padding-top:1.5rem">
                <div class="form-field-title">
                    <strong>New Name (required)</strong>  
                    <span v-if="CreateUnitErrors.NoName != ''"><span class="error-text">  {{ CreateUnitErrors.NoName }}</span></span>
                </div>
                <div class="form-field-input">
                    <input v-model.trim="tmpUnit.Name" type="text" class="input">
                </div>
            </div>                                         
        </div> 
        <div class="form-title-end" slot="footer">                      
                <button id="" class="button is-primary"  v-on:click="editUnit()">Save changes</button>                       
                <button id="" class="button" style="margin-right: .6rem"  v-on:click="editPopup = false">Cancel</button>             
        </div>        
        </modal>

        <modal v-model="deletePopup">                          
          <div slot="header" style=" font-size: 24px; font-weight: bold"> 
            Delete A Unit 
          </div>         
          <div style="font-size:18px;"  v-if="tmpUnit">
            Do you want to delete unit '{{tmpUnit.Name}}' ?
          </div>
          <div class="form-title-end" slot="footer" style="border-top: 0px !important" >                      
                <button id="" class="button is-primary" v-on:click="deleteThis()">Delete</button>
                     
                <button id="" class="button"   v-on:click="deletePopup = false">Cancel</button>             
          </div>
        </modal>

        <modal v-model="createPopup">          
          <div slot="header" style=" font-size: 24px; font-weight: bold" >
              Add New Unit
            </div>
          <div class="form-content" v-if="newUnit">   
              <div class="form-field" style="padding-top:1.5rem">
                  <div class="form-field-title">
                      <strong>Name (required)</strong>  <span v-if="CreateUnitErrors.NoName != ''"><span class="error-text">  {{ CreateUnitErrors.NoName }}</span></span>
                  </div>
                  <div class="form-field-input">
                      <input v-model.trim="newUnit.name" type="text" class="input">
                  </div>
              </div>                                                
          </div>
          <div slot="footer">
              <div class="form-title-end">                              
                <button id="" class="button is-primary"  v-on:click="createUnit()">Add New Category</button>
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
      sure: false,
      currentPage: 1,
      allUnits: [],
      tmpUnits: [],
      allItems: [],
      tmpUnit: null,
      CreateUnitErrors: {
        NoName: ""
      },
      ErrorStrings: {
        NoName: "Please enter name of unit!",
        ShortName: "Use 2 characters or more for unit's name",
        LongName: "Use 15 characters or fewer for unit's name"
      },
      newUnit: {
        name: ""
      }
    };
  },
  created() {
    this.getAllUnit();
    this.axios
      .get("http://localhost:3000/api/unit/getAllItems")
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
    getAllUnit() {
      this.axios
        .get("http://localhost:3000/api/unit/")
        .then(res => {
          this.allUnits = [];
          let data = res.data;
          data.forEach(unit => {
            this.allUnits.push(unit);
            let start = 10 * (this.currentPage - 1);
            let end = start + 10;

            this.tmpUnits = this.allUnits.slice(start, end);
          });
        })
        .catch(error => {
          console.log(error);
        });
    },
    editShow(unit) {
      this.tmpUnit = JSON.stringify(unit);
      this.tmpUnit = JSON.parse(this.tmpUnit);
      this.editPopup = true;
    },
    editUnit() {
      for (const unit of this.allUnits) {
        if (
          this.tmpUnit.Name.trim().toUpperCase() == unit.Name.toUpperCase() &&
          this.tmpUnit.Id != unit.Id
        ) {
          this.duplicate = true;
          break;
        }
      }

      if (this.tmpUnit.Name.trim() == "") {
        this.CreateUnitErrors.NoName = this.ErrorStrings.NoName;
      } else if (this.tmpUnit.Name.trim().length < 2) {
        this.CreateUnitErrors.NoName = this.ErrorStrings.ShortName;
      } else if (this.tmpUnit.Name.trim().length > 15) {
        this.CreateUnitErrors.NoName = this.ErrorStrings.LongName;
      } else if (this.duplicate) {
        this.CreateUnitErrors.NoName = "Name already exists.";
        this.duplicate = false;
      }
      if (this.CreateUnitErrors.NoName == "") {
        this.axios
          .put(Server.EQUIPMENT_UNIT_UPDATE_API_PATH, {
            newUnit: {
              id: this.tmpUnit.Id,
              name: this.tmpUnit.Name
            }
          })
          .then(async res => {
            this.editPopup = false;
            let obj = {
              title: "Update Unit",
              message: "Successfully!!!",
              type: "success"
            };

            this.$refs.simplert.openSimplert(obj);
            this.getAllUnit();
            await Utils.sleep(2000);
            // this.$router.push("/category");
          })
          .catch(error => {
            console.log(error);
          });
      }
    },
    deleteCate(unit) {
      this.tmpUnit = unit;
      for (const item of this.allItems) {
        if (unit.Id == item.UnitId) {
          this.deleteFlag = true;
          break;
        }
      }
      if (this.deleteFlag) {
        let obj = {
          title: "Delete A Unit",
          message: "You can not delete the unit that is being used.",
          type: "error"
        };
        this.$refs.simplert.openSimplert(obj);
      } else {
        this.deletePopup = true;
      }
      this.deleteFlag = false;
    },
    deleteThis() {
      if (this.tmpUnit) {
        this.axios
          .delete(
            `http://localhost:3000/api/unit/deleteUnit/${this.tmpUnit.Id}`
          )
          .then(async res => {
            this.tmpUnit = null;
            this.deletePopup = false;
            let obj = {
              title: "Delete A Unit",
              message: "Successfully!!!",
              type: "success"
            };
            this.$refs.simplert.openSimplert(obj);
            this.getAllUnit();
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
    createUnit() {
      for (const unit of this.allUnits) {
        if (this.newUnit.name.toUpperCase() == unit.Name.toUpperCase()) {
          this.duplicate = true;
          break;
        }
      }

      if (this.newUnit.name == "") {
        this.CreateUnitErrors.NoName = this.ErrorStrings.NoName;
      } else if (this.newUnit.name.length < 2) {
        this.CreateUnitErrors.NoName = this.ErrorStrings.ShortName;
      } else if (this.newUnit.name.length > 15) {
        this.CreateUnitErrors.NoName = this.ErrorStrings.LongName;
      } else if (this.duplicate) {
        this.CreateUnitErrors.NoName = "Name already exists.";
        this.duplicate = false;
      }
      if (this.CreateUnitErrors.NoName == "") {
        this.axios
          .post(Server.EQUIPMENT_UNIT_CREATE_API_PATH, {
            newUnit: {
              name: this.newUnit.name.trim()
            }
          })
          .then(async res => {
            // alert(this.selectedTeams.length);
            this.createPopup = false;
            let obj = {
              title: "Create Unit",
              message: "Successfully!!!",
              type: "success"
            };
            this.newUnit.name = "";
            this.$refs.simplert.openSimplert(obj);
            this.getAllUnit();
            await Utils.sleep(2000);
          })
          .catch(error => {
            console.log(error);
          });
      }
    }
  },
  watch: {
    "tmpUnit.Name": function() {
      if (this.tmpUnit && this.tmpUnit.Name.trim() != "") {
        this.CreateUnitErrors.NoName = "";
      }
    },
    "newUnit.name": function() {
      if (this.newUnit.name.trim() != "") {
        this.CreateUnitErrors.NoName = "";
      }
    },
    createPopup: function() {
      if (!this.createPopup) {
        this.CreateUnitErrors.NoName = "";
        this.newUnit.name = "";
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
