<template>
    <div class="headerbar">        
        <div class="">
            <div class="headerbar-title">
                {{ title }}
            </div>
        </div>
        <div class="">
            <div class="headerbar-end">
                <!-- search bar -->
                <div style="padding-top: .2rem; margin-right: 1rem;">
                    <div class="searchbar-wrapper" v-show="showSearchBar">
                        <form @submit.prevent="search()">
                            <i class="fa fa-search" v-on:click="search()" id="searchIcon"></i>
                            <input v-model.trim="searchText" type="text" class="searchbar" placeholder="Search"
                                v-on:input="() => {
                                    if (searchText != '') {
                                        makeTimeout(2);
                                    }
                                }"/>
                            <i v-if="searchText != ''" class="fa fa-times" id="clearSearchBtn" @click="searchText = ''"></i>
                        </form>
                    </div> <!-- search bar -->
                </div>
                <!-- start button -->
                <!-- <div style="padding-top: .2rem">
                    <div class="headerbar-button" style="margin-right: .3rem;" 
                        v-on:click="() => {
                            axios.post('http://localhost:3000/api/notification/accounts', {
                                notificationContent: 'Hello from <strong>the other side</strong>!!! Test notification.',
                                userRole: 'Equipment Staff',
                            })
                        }">
                        <i class="material-icons">star</i> -->
                    <!-- </div> 
                </div> -->
                <!-- noti button -->
                <div style="padding-right: .5rem; padding-top: .2rem; margin-right: 2.5rem">
                        <v-badge style="margin-top: .2rem;" color="red" v-popover:notificationPanel>
                            <span slot="badge" v-if="notifications.filter(noti => !noti.Status).length > 0">
                                {{ notifications.filter(noti => !noti.Status).length }}
                            </span>
                            <!-- <v-icon
                                large
                                color="grey"
                            >
                                mail
                            </v-icon> -->
                            <div class="headerbar-button" style="margin-right: -1.1rem; margin-top: -.4rem; padding-right: 0" v-on:click="() => {}">
                                <i class="material-icons">notifications</i>
                            </div> <!-- noti button -->
                        </v-badge>
                        <popover name="notificationPanel" style="margin-left: .5rem; margin-top: .1rem; padding: 0; min-width: 350px; max-width: 350px; border: 1px solid #e0e0e0">
                            <div class="row" style="padding: 5px; margin: 0; font-size: .85rem; font-weight: 500; color: #616161;">
                                <div class="col-6" style="margin: 0; padding: 0">Notifications</div>
                                <div class="col-6" style="width: 100%; text-align: right; margin: 0; padding: 0">
                                    <a v-on:click="() => {
                                        notifications.forEach(noti => {
                                            if (!noti.Status) {
                                                axios.put(`http://localhost:3000/api/notification/status/${noti.Id}`, {
                                                    userId: authUser.Id
                                                }).then((res) => {
                                                    if (res.status == 200) {
                                                        noti.Status = true;
                                                    }
                                                })
                                            }
                                        });
                                    }">Mark all as read</a>
                                </div>                                
                            </div>
                            <div v-if="notifications.length == 0">
                                <v-divider></v-divider>
                                <div style="display: flex; padding: 5px; font-size: .85rem; color: #757575;">
                                    There is no notification to display.
                                </div>
                            </div>
                            <div v-else>
                                <div style="max-height: 50vh; overflow-y: auto;">
                                    <div :key="'noti' + noti.Id" v-for="noti in notifications">
                                        <v-divider></v-divider>
                                        <div class="noti-tile" :class="{'unread': !noti.Status}" style="display: grid; grid-template-columns: 20% 70% 10%; padding-bottom: .5rem"
                                            v-on:click.stop="() => {
                                                if (noti.Metadata) {
                                                    let metadata = JSON.parse(noti.Metadata);
                                                    $router.push(`/${metadata.page}/${metadata.elementId}`);
                                                    axios.put(`http://localhost:3000/api/notification/status/${noti.Id}`, {
                                                            userId: authUser.Id
                                                        }).then((res) => {
                                                            if (res.status == 200) {
                                                               noti.Status = true;
                                                            }
                                                        })
                                                }
                                            }">
                                            <div style="display: flex; justify-content: center; align-items: center;">
                                                <div style="border-radius: 50%; background: #757575; width: 2.5rem; height: 2.5rem">
                                                    <div style="display: flex; justify-content: center; align-content: center; ">
                                                        <div style="padding-top: 13%">
                                                            <i style="font-size: 1.8rem; color: white" class="material-icons">assignment</i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div>
                                                <div style="display: flex; padding: .5rem 1rem 0 0;">
                                                    <span style="font-size: .9rem;" v-html="noti.Content"></span>
                                                </div>
                                                <div style="display: flex; padding: 0 1rem 0 0; font-size: .8rem; color: #757575;">
                                                    {{getStatusTimeString(noti)}}{{ noti.TimeString }}
                                                </div>
                                            </div>
                                            <div style="display: flex; justify-content: center; align-items: center; font-size: .5rem">
                                                <i  class="fa mark-as-read-dot" style="z-index: 99"
                                                    :class="{'fa-circle': !noti.Status, 'fa-circle-o': noti.Status}"
                                                    v-on:click.stop="() => {
                                                        axios.put(`http://localhost:3000/api/notification/status/${noti.Id}`, {
                                                            userId: authUser.Id
                                                        }).then((res) => {
                                                            if (res.status == 200) {
                                                                noti.Status = !noti.Status;
                                                            }
                                                        })
                                                    }"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <v-divider></v-divider>
                                <div style="display: flex; padding: 5px; font-size: .85rem; color: #757575; align-items: center; justify-content: center;">
                                    <a><strong style="color: var(--primary-color) !important">View all notifications</strong></a>
                                </div>
                            </div>
                        </popover>
                </div>
                <!-- avatar -->
                <div style="padding-left: 1rem; padding-right: .6rem; padding-top: .2rem">
                    <router-link :to="`/account/${authUser.Id}`">
                        <div class="circle-avatar-container">
                            <img class="circle-avatar" v-bind:src="getUserAvatar()"/>
                        </div>
                    </router-link>
                </div> <!-- avatar -->
                <!-- account username & logout -->
                <div>
                    <div style="display: grid; grid-template-rows: auto auto">
                        <div>
                            <router-link :to="`/account/${authUser.Id}`">
                                <a style="font-size: 1rem; color: var(--primary-color) !important">
                                    {{ authUser.Username }}
                                </a>
                            </router-link>
                        </div>
                        <div style="text-align: left; width: 100%">
                            <a style="color: var(--dark-background-color) !important; font-size: 0.8rem; position: relative; top: -.4rem" v-on:click="logout()">Logout</a>
                        </div>
                    </div>
                </div> <!-- account username & logout -->
            </div>
        </div>
    </div>
</template>

<script>
import { sync } from "vuex-pathify";
import menu from "@/models/menu.js";
import Server from "@/config/config.js";
import moment from "moment";

export default {
  name: "header-bar",
  data() {
    return {
      showMenu: false,
      searchText: "",
      searchFunction: null
    };
  },
  computed: {
    title: sync("title"),
    showSearchBar: sync("showSearchBar"),
    authUser() {
      return JSON.parse(window.localStorage.getItem("user"));
    },
    notifications: sync("notifications")
  },
  methods: {
    makeTimeout(seconds) {
      if (this.searchFunction) {
        clearTimeout(this.searchFunction);
      }
      this.searchFunction = setTimeout(() => this.search(), seconds * 1000);
    },
    search() {
      if (this.searchText != "") {
        if (this.searchFunction) {
          clearTimeout(this.searchFunction);
          this.searchFunction = null;
        }
        let searchApi;
        switch (this.title) {
          case menu.WorkOrder: {
            searchApi = `${Server.WORKORDER_SEARCH_API_PATH}/${
              this.searchText
            }`;
            this.axios
              .get(searchApi)
              .then(res => {
                if (res.status == 200) {
                  this.$store.state.workOrderPage.searchValues = res.data;
                  this.searchFunction = null;
                }
              })
              .catch(error => {
                console.log(error);
                this.$router.push("/500");
              });
            break;
          }
          case menu.Location: {
            searchApi = `${Server.LOCATION_SEARCH_API_PATH}/${this.searchText}`;
            this.axios
              .get(searchApi)
              .then(res => {
                if (res.status == 200) {
                  this.$store.state.locationPage.searchValues = res.data;
                  this.searchFunction = null;
                }
              })
              .catch(error => {
                console.log(error);
                this.$router.push("/500");
              });
            break;
          }
        }
      }
    },
    getUserAvatar() {
      if (this.authUser.AvatarImage) {
        return this.authUser.AvatarImage;
      } else {
        return require("@/assets/avatar-user.png");
      }
    },
    logout() {
      this.$store.state.isLoggedIn = false;
      window.localStorage.removeItem("user");
      this.$router.push("/");
    },
    showAlert(msg) {
      alert(msg);
    },
    getStatusTimeString(notiObj) {
      setInterval(() => {
        const milis =
          moment().valueOf() - moment(notiObj.CreatedDate).valueOf();
        const duration = moment.duration(milis);
        const days = duration.days();
        // alert(`asDays ${days}`)
        if (days == 0) {
          const hours = duration.hours();
          if (hours == 0) {
            const minutes = duration.minutes();
            if (minutes > 0) {
              notiObj.TimeString = `About ${minutes} ${
                minutes > 1 ? "minutes" : "minute"
              } ago`;
            } else if (minutes == 0) {
              notiObj.TimeString = `Just now`;
            }
          } else {
            notiObj.TimeString = `About ${hours} ${
              hours > 1 ? "hours" : "hour"
            } ago`;
          }
        } else if (days == 1) {
          notiObj.TimeString = `Yesterday at ${moment(
            notiObj.CreatedDate
          ).format("hh:mm a")}`;
        } else {
          notiObj.TimeString = `${moment(notiObj.CreatedDate).format("LLL")}`;
        }
      }, 1000);
    }
  },
  watch: {
    title: function() {
      switch (this.title) {
        case menu.WorkOrder: {
          this.searchText = this.$store.state.workOrderPage.searchText;
          break;
        }
        case menu.Equipment: {
          this.searchText = this.$store.state.equipmentPage.searchText;
          break;
        }
        case menu.Location: {
          this.searchText = this.$store.state.locationPage.searchText;
          break;
        }
        case menu.Vendors: {
          this.searchText = this.$store.state.vendorPage.searchText;
          break;
        }
        case menu.Accounts: {
          this.searchText = this.$store.state.accountPage.searchText;
          break;
        }
        case menu.Teams: {
          this.searchText = this.$store.state.teamPage.searchText;
          break;
        }
        default: {
          this.searchText = "";
          break;
        }
      }
    },
    searchText: function() {
      switch (this.title) {
        case menu.WorkOrder: {
          this.$store.state.workOrderPage.searchText = this.searchText;
          if (this.searchText == "") {
            this.$store.state.workOrderPage.searchValues = [];
          }
          break;
        }
        case menu.Equipment: {
          this.$store.state.equipmentPage.searchText = this.searchText;
          break;
        }
        case menu.Location: {
          this.$store.state.locationPage.searchText = this.searchText;
          if (this.searchText == "") {
            this.$store.state.locationPage.searchValues = [];
          }
          break;
        }
        case menu.Vendors: {
          this.$store.state.vendorPage.searchText = this.searchText;
          break;
        }
        case menu.Accounts: {
          this.$store.state.accountPage.searchText = this.searchText;
          break;
        }
        case menu.Teams: {
          this.$store.state.teamPage.searchText = this.searchText;
          break;
        }
      }
    },
    "$store.state.workOrderPage.searchText": function() {
      this.searchText = this.$store.state.workOrderPage.searchText;
    },
    "$store.state.locationPage.searchText": function() {
      this.searchText = this.$store.state.locationPage.searchText;
    }
  }
};
</script>

<style scoped>
.headerbar {
  display: grid;
  grid-template-columns: auto auto;
  /* height: 4rem; */
  /* background-color: var(--light-background); */
  /* background-color: #b0bec5; */
  background-color: #eeeeee;
  z-index: 2;
  width: 100%;
  padding: 0rem 2rem;
  /* border-bottom: 2px solid var(--dark-background); */
}

.headerbar-title {
  /* padding-top: 0.6rem;
        padding-left: 2rem; */
  font-size: 1.6rem;
  color: var(--dark-background);
  height: 100%;
  padding-top: 0.5rem;
  /* width: 30rem; */
  /* font-weight: bold; */
}

.headerbar-end {
  display: flex;
  justify-content: flex-end;
  padding-top: 0.4rem;
  /* padding: .9rem 1.3rem .9rem 0; */
  /* display: grid;
        grid-template-columns: 70% 15% 15%; */
  /* grid-column-gap: 10px; */
  /* padding-right: 1rem; */
  /* display: flex; */
}

.searchbar-wrapper {
  margin-top: -0.1rem;
  width: 100%;
  margin-right: 2rem;
  transition: all 0.25s ease-in-out;
}

.searchbar {
  /* border: none !important; */
  /* display: flex; */
  margin-left: -40px;
  margin-right: -40px;
  /* border: 1px solid #bdbdbd; */
  background-color: var(--light-background);
  /* border: 1px solid var(--light-background); */
  border: 1px solid #e0e0e0;
  border-radius: 5px;
  padding: 5px 40px 5px 40px;
  box-shadow: 1px 1px 2px #bdbdbd;
  transition: all 0.25s ease-in;
  font-style: italic;
  width: 100%;
}

.searchbar-wrapper i {
  position: relative;
  padding: 10px;
  color: #9e9e9e;
  /* z-index: 1; */
  /* transition: all 0.25s ease-in-out; */
}

.searchbar:hover,
.searchbar-wrapper input:focus {
  /* border: 1px solid #eeeeee; */
  box-shadow: 4px 4px 8px #bdbdbd;
}

#searchIcon:hover {
  cursor: pointer;
}

#clearSearchBtn {
  cursor: pointer;
  transition: all 0.2s ease-in-out;
}
#clearSearchBtn:hover {
  color: #bdbdbd;
}
#clearSearchBtn:active {
  color: #757575;
}

.headerbar-button {
  /* margin-top: 0.7rem; */
  user-select: none;
  color: #424242;
  border: 1px solid black;
  /* background-color: #e0e0e0; */
  text-align: center;
  width: 2.25rem;
  height: 2.2rem;
  border-radius: 50%;
  box-shadow: 0px 0px 0px #e0e0e0;
  transition: all 0.25s ease-in;
}

.headerbar-button i {
  position: relative;
  top: 5px;
  transition: all 0.25s ease-in;
}

.headerbar-button:hover {
  border: 1px solid var(--primary-color);
  background-color: var(--primary-color);
  box-shadow: 3px 3px 5px #bdbdbd;
  cursor: pointer;
}

.headerbar-button:hover i {
  color: white;
}
.circle-avatar-container {
  /* position: fixed;
        left: 5rem;
        bottom: 0.8rem; */
  border-radius: 50%;
  border: 1px solid var(--shadow);
  width: 2.25rem;
  height: 2.2rem;
}
.circle-avatar-container:hover {
  cursor: pointer;
}

.circle-avatar {
  /* position: relative; */
  border-radius: 50%;
  /* left: 5rem;
            bottom: .8rem; */
  width: 100%;
  height: 100%;
}

.noti-tile {
  user-select: none;
  cursor: pointer;
  background: #f5f5f5;
  z-index: 5;
}

.noti-tile:hover {
  background: #fafafa;
}

.noti-tile:hover .mark-as-read-dot {
  opacity: 100;
}

.noti-tile:active {
  background: #e0e0e0;
}

.noti-tile.unread {
  user-select: none;
  cursor: pointer;
  background: #e0f7fa;
}

.noti-tile.unread:hover {
  background: #e9fbfd;
}

.noti-tile.unread:active {
  background: #aceaf3;
}

.mark-as-read-dot {
  opacity: 0;
  color: #bdbdbd;
  z-index: 99;
  transition: all 0.17s ease-in-out;
}

.mark-as-read-dot:hover {
  color: #e0e0e0;
}

.mark-as-read-dot:active {
  color: #9e9e9e;
}
</style>
