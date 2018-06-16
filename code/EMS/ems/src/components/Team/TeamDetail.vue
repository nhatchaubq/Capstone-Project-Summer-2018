<template>
    <div class="grid-wrapper">
<div class="material-box">
<h2>{{this.$route.params.id}}</h2>
<h2 style="text-transform: uppercase;font-size: 30px; color: #3960A4">Team name{{team.Name}}</h2>
<h2 style=" border-bottom: 1px solid #e0e0e0;"></h2>
<h2>Team ID: {{team.Id}}</h2>
<h2>Create date: {{team.CreatedDate}}</h2>


</div>


    </div>
    
</template>

<script>
export default {
  created() {
    let URL = `http://localhost:3000/api/team/id/${this.$route.params.id}`;
    this.axios.get(URL).then(response => {
      let data = response.data;
      this.team = data;
    });
  },
  data() {
    return {
      team: null
    };
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
</style>
