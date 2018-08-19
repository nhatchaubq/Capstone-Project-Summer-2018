<template>
    <div v-if="allCategories">        
        <div style="padding-left:10rem; padding-right: 10rem">
        <table class="mytable">
      <thead>
        <tr>
          <!-- <th><strong>ID</strong></th> -->
          <th ><strong>#</strong></th>
          <th ><strong>Category Name</strong></th>
          <th ><strong>Description</strong></th>
          <th ><strong>Status</strong></th>       
          <th colspan="2" style="text-align:center"><strong>Action</strong></th>                   
          <!-- <th><strong>Department</strong></th> -->
        </tr>
        
      </thead>  
      <tbody>
          <tr v-bind:key="cate.Id" v-for="(cate, index) in tmpCategories" class="txtText" >          
            <td >{{ 10*(currentPage -1) + (index + 1) }}</td>
            <td >{{cate.Name}}</td>
            <td >{{cate.Description}}</td>
            <strong><td :style="{color: cate.Status? 'var(--primary-color)' : '#607D8B'}" >{{cate.Status? "Active" : "Inactive" }}</td></strong>
            <td width=6% v-on:click="editShow(cate)"><button class="button" style="padding:0px 5px 0px 5px ">Edit</button></td>
            <td width=6%><button class="button" style="padding:0px 5px 0px 5px " v-on:click="deleteCate(cate)">Delete</button></td>               
          </tr>
      </tbody>
    </table>        
        </div>        
        <div v-if="allCategories.length >9" class="number-page" style="padding-left:10rem; padding-right: 10rem"> 
          <Page :current="currentPage" :total="allCategories.length" show-elevator 
            @on-change="(newPageNumber) => {
              currentPage = newPageNumber
              let start = 10 * (newPageNumber - 1);
              let end = start + 10;
              
              tmpCategories = allCategories.slice(start, end);
            }">
          </Page>
        </div> 
        <div>            
                <button v-if="authUser.Role =='Equipment Staff'" id="btn-add-category" class="button btn-primary material-shadow-animate" v-on:click="createShow()">Add Category</button>
      </div>

      <modal v-model="editPopup" >
                
          <div slot="header" style=" font-size: 24px; font-weight: bold"> 
            Edit Category 
          </div>
          <div class="form-content" v-if="tmpCategory" >   
            <div class="form-field" style="padding-top:1.5rem">
                <div class="form-field-title">
                    <strong>New Name <span style="color:red;">*</span></strong>  
                    <span v-if="CreateCategoryErrors.NoName != ''"><span class="error-text">  {{ CreateCategoryErrors.NoName }}</span></span>
                </div>
                <div class="form-field-input">
                    <input v-model.trim="tmpCategory.Name" type="text" class="input">
                </div>
            </div>

            <div class="form-field" >
              <div>
                <div class="form-field-title">
                <strong> Status </strong> <span v-if="changeStatus" class="error-text"> (You can not change status the category that is being used.)</span>
                </div>
                <div class="form-field-input" style="padding-left:30px;padding-top:10px;">
                  <label class="radio" v-on:click="isActive = true" style="margin-right:25px;">
                    <input type="radio" name="status" style="margin-right:0.5rem"  :checked="tmpCategory.Status">Active
                  </label>
                  <label class="radio" v-on:click="() => {
                      if (!changeStatus) {
                        isActive = false
                      }
                    }">
                    <input type="radio" name="status" style="margin-right:0.5rem" :disabled="changeStatus" :checked="!tmpCategory.Status">Inactive
                  </label>                                                  
                </div>
              </div>            
            </div>

            <div class="form-field">
                <div class="form-field-title">
                   <strong>New Description</strong>
                </div>
                <div class="form-field-input">
                    <!-- <input type="text" class="input" > -->
                    <textarea id="text-descrip" v-model.trim="tmpCategory.Description"  cols="70" rows="8"></textarea>
                </div>
            </div>                       
        </div> 
        <div class="form-title-end" slot="footer">                      
                <button id="" class="button is-primary"  v-on:click="editCategory()">Save changes</button>                       
                <button id="" class="button" style="margin-right: .6rem"  v-on:click="editPopup = false">Cancel</button>             
        </div>        
        </modal>

        <modal v-model="deletePopup">                          
          <div slot="header" style=" font-size: 24px; font-weight: bold"> 
            Delete A Category 
          </div>         
          <div style="font-size:18px;"  v-if="tmpCategory">
            Do you want to delete category '{{tmpCategory.Name}}' ?
          </div>
          <div class="form-title-end" slot="footer" style="border-top: 0px !important" >                      
                <button id="" class="button is-primary" v-on:click="deleteThis()">Delete</button>
                     
                <button id="" class="button"   v-on:click="deletePopup = false">Cancel</button>             
          </div>
        </modal>

        <modal v-model="createPopup">          
          <div slot="header" style=" font-size: 24px; font-weight: bold" >
              Add New Category
            </div>
          <div class="form-content" v-if="newCategory">   
              <div class="form-field" style="padding-top:1.5rem">
                  <div class="form-field-title">
                      <strong>Name (required)</strong>  <span v-if="CreateCategoryErrors.NoName != ''"><span class="error-text">  {{ CreateCategoryErrors.NoName }}</span></span>
                  </div>
                  <div class="form-field-input">
                      <input v-model.trim="newCategory.name" type="text" class="input">
                  </div>
              </div>            
              <div class="form-field">
                  <div class="form-field-title">
                    <strong>Description</strong>
                  </div>
                  <div class="form-field-input">
                      <!-- <input type="text" class="input" > -->
                      <textarea id="text-descrip" v-model.trim="newCategory.description"  cols="70" rows="8"></textarea>
                  </div>
              </div>                       
          </div>
          <div slot="footer">
              <div class="form-title-end">                              
                <button id="" class="button is-primary"  v-on:click="createCate()">Add New Category</button>
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
      changeStatus: false,
      deleteFlag: false,
      createPopup: false,
      deletePopup: false,
      editPopup: false,
      sure: false,
      currentPage: 1,
      allCategories: [],
      tmpCategories: [],
      allItems: [],
      tmpCategory: null,
      CreateCategoryErrors: {
        NoName: ""
      },
      ErrorStrings: {
        NoName: "Please enter name of category!",
        ShortName: "Use 6 characters or more for category's name",
        LongName: "Use 50 characters or fewer for category's name"
      },
      newCategory: {
        name: "",
        description: ""
      }
    };
  },
  created() {
    this.getAllCategory();
    this.axios
      .get("http://localhost:3000/api/EquipmentCategory/getAllItems")
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
    getAllCategory() {
      this.axios
        .get("http://localhost:3000/api/EquipmentCategory/getAllCate")
        .then(res => {
          this.allCategories = [];
          let data = res.data;
          data.forEach(cate => {
            this.allCategories.push(cate);
            // this.tmpCategories = this.allCategories.slice(0, 10);
            let start = 10 * (this.currentPage - 1);
            let end = start + 10;

            this.tmpCategories = this.allCategories.slice(start, end);
          });
        })
        .catch(error => {
          console.log(error);
        });
    },
    editShow(category) {
      this.changeStatus = false;
      this.tmpCategory = JSON.stringify(category);
      this.tmpCategory = JSON.parse(this.tmpCategory);
      if (this.tmpCategory) {
        for (const item of this.allItems) {
          if (this.tmpCategory.Id == item.CategoryId) {
            this.changeStatus = true;
            break;
          }
        }
      }

      this.editPopup = true;
    },
    editCategory() {
      for (const cate of this.allCategories) {
        if (
          this.tmpCategory.Name.trim().toUpperCase() ==
            cate.Name.toUpperCase() &&
          this.tmpCategory.Id != cate.Id
        ) {
          this.duplicate = true;
          break;
        }
      }

      if (this.tmpCategory.Name.trim() == "") {
        this.CreateCategoryErrors.NoName = this.ErrorStrings.NoName;
      } else if (this.tmpCategory.Name.trim().length < 6) {
        this.CreateCategoryErrors.NoName = this.ErrorStrings.ShortName;
      } else if (this.tmpCategory.Name.trim().length > 50) {
        this.CreateCategoryErrors.NoName = this.ErrorStrings.LongName;
      } else if (this.duplicate) {
        this.CreateCategoryErrors.NoName = "Name already exists.";
        this.duplicate = false;
      }
      if (this.CreateCategoryErrors.NoName == "") {
        this.axios
          .put(Server.EQUIPMENT_CATEGORY_UPDATE_API_PATH, {
            newCategory: {
              id: this.tmpCategory.Id,
              name: this.tmpCategory.Name,
              description: this.tmpCategory.Description,
              status: this.isActive
            }
          })
          .then(async res => {
            this.editPopup = false;
            let obj = {
              title: "Update Category",
              message: "Successfully!!!",
              type: "success"
            };
            this.$refs.simplert.openSimplert(obj);
            this.getAllCategory();
            await Utils.sleep(2000);
            // this.$router.push("/category");
          })
          .catch(error => {
            console.log(error);
          });
      }
    },
    deleteCate(cate) {
      this.tmpCategory = cate;
      for (const item of this.allItems) {
        if (cate.Id == item.CategoryId) {
          this.deleteFlag = true;
          break;
        }
      }
      if (this.deleteFlag) {
        let obj = {
          title: "Delete A Category",
          message: "You can not delete the category that is being used.",
          type: "error"
        };
        this.$refs.simplert.openSimplert(obj);
      } else {
        this.deletePopup = true;
      }
      this.deleteFlag = false;
    },
    deleteThis() {
      if (this.tmpCategory) {
        this.axios
          .delete(
            `http://localhost:3000/api/EquipmentCategory/deleteCategory/${
              this.tmpCategory.Id
            }`
          )
          .then(async res => {
            this.tmpCategory = null;
            this.deletePopup = false;
            let obj = {
              title: "Delete A Category",
              message: "Successfully!!!",
              type: "success"
            };
            this.$refs.simplert.openSimplert(obj);
            this.getAllCategory();
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
    createCate() {
      for (const cate of this.allCategories) {
        if (this.newCategory.name.toUpperCase() == cate.Name.toUpperCase()) {
          this.duplicate = true;
          break;
        }
      }

      if (this.newCategory.name == "") {
        this.CreateCategoryErrors.NoName = this.ErrorStrings.NoName;
      } else if (this.newCategory.name.length < 6) {
        this.CreateCategoryErrors.NoName = this.ErrorStrings.ShortName;
      } else if (this.newCategory.name.length > 50) {
        this.CreateCategoryErrors.NoName = this.ErrorStrings.LongName;
      } else if (this.duplicate) {
        this.CreateCategoryErrors.NoName = "Name already exists.";
        this.duplicate = false;
      }
      if (this.CreateCategoryErrors.NoName == "") {
        this.axios
          .post(Server.EQUIPMENT_CATEGORY_CREATE_API_PATH, {
            newCategory: {
              name: this.newCategory.name.trim(),
              description: this.newCategory.description
            }
          })
          .then(async res => {
            // alert(this.selectedTeams.length);
            this.createPopup = false;
            let obj = {
              title: "Create Category",
              message: "Successfully!!!",
              type: "success"
            };
            this.newCategory.name = "";
            this.newCategory.description = "";
            this.$refs.simplert.openSimplert(obj);
            this.getAllCategory();
            await Utils.sleep(2000);
          })
          .catch(error => {
            console.log(error);
          });
      }
    }
  },
  watch: {
    "tmpCategory.Name": function() {
      if (this.tmpCategory && this.tmpCategory.Name.trim() != "") {
        this.CreateCategoryErrors.NoName = "";
      }
    },
    "newCategory.name": function() {
      if (this.newCategory.name.trim() != "") {
        this.CreateCategoryErrors.NoName = "";
      }
    },
    createPopup: function() {
      if (!this.createPopup) {
        this.CreateCategoryErrors.NoName = "";
        this.newCategory.name = "";
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
