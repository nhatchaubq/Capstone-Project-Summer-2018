<template>
    <div class="form">
        worked!
    </div>
</template>

<script>
export default {
  data() {
    return {
      vendor: {
        businessName: "",
        businessAddress: "",
        website: "",
        ContactName: "",
        ContactEmail: "",
        Description: ""
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
</style>
