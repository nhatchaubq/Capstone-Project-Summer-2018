<template>
  <nav class="navbar">
    <div class="navbar-brand">
      <router-link to="/" class="navbar-item">EMS</router-link>
    </div>
    <div class="navbar-menu">
      <div class="navbar-start">
        <router-link to="/" class="navbar-item">Home</router-link>
        <div class="navbar-item has-dropdown is-hoverable">
          <a class="navbar-link" href="#">Equipment</a>
          <div class="navbar-dropdown">
            <a class="navbar-item">Hammer</a>
            <a class="navbar-item">Saw</a>
            <a class="navbar-item">Screw</a>
            <hr class="navbar-divider"/>
            <a class="navbar-item">Somthing elses</a>
          </div>
        </div>
        <a class="navbar-item">Work Plan</a>
      </div>
      <div class="navbar-end">
        <div class="navbar-item">
          <div class="field is-group">
            <router-link tag="button" to="/login" class="button is-white is-rounded">Login</router-link>
            <router-link tag="button" to="/register" class="button is-primary is-outlined is-rounded">Register</router-link>     
          </div>
        </div>
      </div>
    </div>
  </nav>
</template>

<script>
export default {
  name: 'app-nav',
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .navbar-item, .navbar-link {
    color:#4a4a4a !important;
    text-decoration: none !important;
  }
</style>
