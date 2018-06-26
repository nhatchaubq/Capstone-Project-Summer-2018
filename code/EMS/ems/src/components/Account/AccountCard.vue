<template>
<div>

   <div class="grid-wrapper" v-if="accounts">

    <div class="account-card material-box material-shadow-animate" style="border: none !important;" v-bind:key="account.id" v-for="account in accounts" v-on:click="gotoDetail(account.Id)">
        <div class="account-image-preview">
          <img :src="getAccountAvatar(account)" :alt="account.Username" style="width: 100%; height: 12rem;">
        </div>
        <div class="account-card-content" >
        <!-- <img src="{{equipment.thumbnail}}" alt="Crane"> -->
        <router-link :to="`/account/${account.Id}`"> 
          <h2><strong>{{account.Username}}</strong></h2>
        </router-link>
          <!-- <div><span>ID: </span>{{equipment.Id}}</div> -->
          <div><span>Full name: </span>{{account.Fullname ? account.Fullname : "N/A"}}</div>
          <div><span>Email: </span>{{account.Email ? account.Email : "N/A" }}</div>
          <div><span>Telephone number: </span>{{account.Phone ? account.Phone : "N/A"}}</div>
          <div><span>Role: </span>{{account.Role.Name}}  </div>
          <div><span>Status: </span>{{account.IsActive ? 'Active': 'Inactive'}}</div>
        
        <!-- <div><span>In department: </span>{{equipment.department}}</div> -->
      </div>

    </div>
  </div>

  </div>
</template>

<script>
export default {
  name: "account-card",
  props: {
    accounts: null
  },
  methods: {
    getAccountAvatar(acc) {
      return acc.AvatarImage
        ? acc.AvatarImage
        : "http://citizen.edisha.gov.in/Content/assets/stylesheet/img/placeholder-user.png";
    },
    gotoDetail(accountId) {
      this.$router.push(`/account/${accountId}`);
    }
  }
};
</script>

<style>
.grid-wrapper {
  display: grid;
  grid-template-columns: auto auto auto auto auto;
  grid-column-gap: 1rem;
  grid-row-gap: 2rem;
}
.account-card {
  /* border: 1px solid #bdbdbd; */
  /* height: 200px; */
  width: 100%;
  /* height: 15.5rem; */
  /* border-bottom: 1px solid #e0e0e0; */
  padding: 0 !important;
}

.account-card:hover {
  cursor: pointer;
}

.account-card-content {
  padding: 0.6rem;
}

.circle-progress {
  border: 10px solid #bdbdbd;
  border-top: 10px solid green;
  border-right: 10px solid green;
  border-radius: 50%;
  width: 200px;
  height: 200px;
}

.circle-progress p {
  text-align: center;
  position: relative;
  top: 65px;
}

.account-image-preview img {
  border-radius: 3px 3px 0 0;
}
</style>
