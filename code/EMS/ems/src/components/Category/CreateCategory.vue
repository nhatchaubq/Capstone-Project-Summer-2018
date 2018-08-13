<template>
    <div class="form">
        <div class="form-title">                
          <div class="form-title-start">
            Add New Category
          </div>
          <div class="form-title-end">                              
                <button id="" class="button" style="margin-right: .6rem"  v-on:click="$router.push('/category')">Cancel</button>
                <simplert :useRadius="true" :icon="true" ref="simplert"></simplert>
                <button id="" class="button is-primary"  v-on:click="createCategory()">Create New Category</button>
          </div>  
        </div>
        <div class="form-content" >   
            <div class="form-field" style="padding-top:1.5rem">
                <div class="form-field-title">
                    <strong>Name <span style="color:red;">*</span></strong>  <span v-if="CreateCategoryErrors.NoName != ''"><span class="error-text">  {{ CreateCategoryErrors.NoName }}</span></span>
                </div>
                <div class="form-field-input">
                    <input v-model="newCategory.name" type="text" class="input">
                </div>
            </div>            
            <div class="form-field">
                <div class="form-field-title">
                   <strong>Description</strong>
                </div>
                <div class="form-field-input">
                    <!-- <input type="text" class="input" > -->
                    <textarea id="text-descrip" v-model="newCategory.description"  cols="80" rows="10"></textarea>
                </div>
            </div>                       
        </div>    
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
  data() {
    return {
      newCategory: {
        name: "",
        description: ""
      },
      CreateCategoryErrors: {
        NoName: ""
      },
      ErrorStrings: {
        NoName: "Please enter name of category!",
        ShortName: "Use 6 characters or more for category's name",
        LongName: "Use 50 characters or fewer for category's name"
      },
      form: {
        Name: ""
      }
    };
  },
  created() {
    // this.axios
    //   .get(Server.TEAM_API_PATH + "/getAllTeam")
    //   .then(response => {
    //     let data = response.data;
    //     data.forEach(team => {
    //       this.teams.push(team);
    //     });
    //   })
    //   .catch(error => {
    //     console.log(error);
    //   });
  },
  methods: {
    createCategory() {
      if (this.newCategory.name.trim() == "") {
        this.CreateCategoryErrors.NoName = this.ErrorStrings.NoName;
      } else if (this.newCategory.name.trim().length < 6) {
        this.CreateCategoryErrors.NoName = this.ErrorStrings.ShortName;
      } else if (this.newCategory.name.trim().length > 50) {
        this.CreateCategoryErrors.NoName = this.ErrorStrings.LongName;
      }
      if (this.CreateCategoryErrors.NoName == '') {
        this.axios
          .post(Server.EQUIPMENT_CATEGORY_CREATE_API_PATH, {
            newCategory: {
              name: this.newCategory.name.trim(),
              description: this.newCategory.description.trim()
            }
          })
          .then(async res => {
            // alert(this.selectedTeams.length);
            let obj = {
              title: "Create Category",
              message: "Successfully!!!",
              type: "success"
            };
            this.$refs.simplert.openSimplert(obj);
            await Utils.sleep(1500);
            this.$router.push("/category");
          })
          .catch(error => {
            console.log(error);
          });
      }
    }
  },
  watch: {
    "newCategory.name": function() {
      if (this.newCategory.name.trim() != "") {
        this.CreateCategoryErrors.NoName = "";
      }
    }
  }
};
</script>

<style scoped>
/* #clear-btn {
  border-left: 0.5px solid lightgray;
  border-radius: 3px;
  position: relative;
  left: 70.05rem;
  bottom: 2.25rem;
  height: 2.4rem;
  padding-top: 0.25rem;

  color: red;
} */

.form {
  background-color: white;
  padding: 0 !important;
  grid-template-columns: 20% 20% 60%;
}
.form-content {
  font-size: 0.9rem;
  position: fixed;
  max-height: 82.5%;
  width: 82%;
  overflow-y: auto;

  /* display: flex;
        flex-direction: column;  */
}

.form-field {
  /* margin-bottom: 5px; */
  width: 100%;
  padding: 1rem 2rem;
}

.form-title {
  display: grid;
  grid-template-columns: 65% 35%;
  border-bottom: 1px solid #e0e0e0;
  padding: 1rem 2rem;
}
.form-title-start {
  position: relative;
  top: 10px;
  font-weight: bold;
  font-size: 20px;
  color: #616161;
}
.form-title-end {
  width: 100%;
  display: flex;
  justify-content: flex-end;
  /* align-content: center; */
}
.form-input {
  padding-left: 50px;
  padding-right: 50px;
}
.form-field {
  margin-bottom: 1.5rem;
}

.form-field-title {
  font-size: 15px;
}
/* .form-button {
  display: grid;
  grid-template-columns: 50% 50%;
  padding-top: 8rem;
} */
/* .form-button div button {
  height: 60px;
  width: 200px;
  border-radius: 5px;
} */
/* #btn-create {
  background-color: var(--primary-color);
  color: white;
  font-size: 22px;
  font-weight: bold;
}
#btn-cancel {
  background-color: chocolate;
  color: white;
  font-size: 22px;
  font-weight: bold;
} */
#text-descrip {
  border: 0.5px solid lightgray;
  border-radius: 5px;
  padding: 0.3rem;
}
#text-descrip:hover {
  border: 1px solid grey;
}
.lb-team {
  border: 0.5px solid;
  border-radius: 5px;
  padding: 3px;
}

.delete {
  position: relative;
  top: 0.2rem;
  font-size: 20px;
}
</style>
