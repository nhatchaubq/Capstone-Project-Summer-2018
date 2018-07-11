<template>
     <div class="form">
         
         <form @submit.prevent="createEquimentCategory()">
            <div class="form-title">
                <div class="form-title-start">
                    Add New Equipment Category
                </div>
            </div>
            <div class="form-field">
                <div class="form-field-title">
                <strong>  Category Name <span style="color:red;">*</span></strong>
                </div>
                <div class="control has-icons-left has-icons-right" style="padding:8px">
                    <input v-model="EquipmentCate.Name" class="input " type="text" placeholder="Text input" >

                        <span class="icon is-small is-left">
                        <i class="fa fa-list"></i>
                        </span>

                </div>
            </div>
            <div class="form-field" >
                <div class="form-field-title">
                     <strong>Description</strong>
                </div>   
                    <textarea v-model="EquipmentCate.Description" class="control has-icons-left" id="text-descrip" rows="4"  >
                    </textarea>
                <!-- <h3>{{account.startdate}}</h3> -->
            </div>
            <div class="form-title-end" style="margin-bottom:2rem">
                <router-link to='/equipment'>
                    <button id="btn-cancel" class="button" >Cancel</button>
                </router-link>
                <button id="btn-add" class="button">Create Equipment Category</button>
            </div>


            



         </form>
    </div>
</template>

<script>
export default {
  data() {
    return {
      EquipmentCate: {
        Name: "",
        Description: ""
      }
    };
  },
  methods: {
    createEquimentCategory() {
      this.axios
        .post("http://localhost:3000/api/EquipmentCategory", {
          EquipmentCate: this.EquipmentCate
        })
        .then(res => {
          this.$router.push("/equipment");
        });
    }
  }
};
</script>

<style>
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
#text-descrip {
  border: 0.5px solid lightgray;
  border-radius: 5px;
  padding: 0.3rem;
  width: 100%;
}
#text-descrip:hover {
  border: 1px solid grey;
}
</style>
