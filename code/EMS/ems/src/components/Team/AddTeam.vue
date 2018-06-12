<template>
       <div class="form">
         
         <form @submit.prevent="createTeam()">
            <div class="form-title">
                <div class="form-title-start">
                    Add New Team
                </div>
                <div></div>

            </div>
            <div>
                <div class="form-field">
                    <div class="form-field-title">
                    <strong>  Team's name <span style="color:red;">*</span></strong>
                    </div>
                    <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model="team.name" class="input " type="text" placeholder="Text input" >

                            <span class="icon is-small is-left">
                            <i class="fa fa-user"></i>
                            </span>
                            <!-- <span class="icon is-small is-right">
                            <i class="fa fa-check"></i>
                            </span> -->

                        </div>
                    </div>
                
            </div>
            
                        <div>
                <div class="form-field">
                    <div class="form-field-title">
                        Create date <strong><span style="color:red;">*</span></strong>
                    </div>
                    <div class="form-field-input">
                        <div class="control has-icons-left has-icons-right" style="padding:8px">
                        <input v-model="team.createdDate" class="input" type="date" placeholder="Text input" >
                            <span class="icon is-small is-left">
                            <i class="fa fa-calendar"></i>
                            </span>
                            <!-- <span class="icon is-small is-right">
                            <i class="fa fa-check"></i>
                            </span> -->
                            <!-- {{account.startdate}} -->
                        </div>
                    </div>
                    <!-- <h3>{{account.startdate}}</h3> -->
                </div>
                
            </div>
            

    
    

            
    
    <div class="form-title-end">
                    <router-link to='/team'>
                        <button id="btn-cancel" class="button" >Cancel</button>
                    </router-link>

                    <!-- <button id="btn-add" class="button" v-on:click="createAccount()">Create Account</button>
                    <button id="btn-add" class="button" v-on:click="createAccountTrueEnd()">Create Account true end</button> -->
                    <!-- <router-link to='/team/'>
                    <button id="btn-add" class="button">Create Team</button>
                    </router-link> -->
                    <button id="btn-add" class="button">Create Team</button>

                    <!-- <button id="btn-add" class="button">Create Account</button> -->
                </div>
            <div>&nbsp</div>
         </form>
        
    </div>
</template>

<script>
export default {
  data() {
    return {
      team: {
        name: "",
        createdDate: ""
      }
    };
  },
  methods: {
    createTeam() {
      this.axios
        .post("http://localhost:3000/api/team", {
          team: this.team
        })
        .then(res => {
          this.$router.push("/team");
        });
    }
  }
};
</script>

<style scoped>
.form {
  background-color: white;
  padding: 0 !important;
}
.form-title {
  display: grid;
  grid-template-columns: 25% 40% 35%;
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
  /* float: left; */
  /* align-content: center; */
  margin-left: 25rem;
}

#btn-cancel {
  background-color: #bdbdbd;
  color: white;
  margin-right: 0.6rem;
}

#btn-add {
  background-color: var(--primary-color);
  color: white;
}
#btn-add:hover {
  cursor: pointer;
  background-color: #009688;
  color: white;
}

.form-field {
  /* margin-bottom: 5px; */
  padding: 1rem 3rem;
}

.form-field-title {
  font-size: 13px;
}

#btn-change-pass {
  background-color: var(--primary-color);
  padding: 13px;
  color: white;
  border-radius: 5px;
  z-index: 1;
}

#btn-change-pass:hover {
  cursor: pointer;
  background-color: #009688;
  color: white;
}
</style>

