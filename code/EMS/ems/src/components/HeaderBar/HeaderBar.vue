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
                <div style="padding-top: .2rem">
                    <div class="searchbar-wrapper" v-show="showSearchBar">
                        <form @submit.prevent="search()">
                            <i class="fa fa-search" v-on:click="search()" id="searchIcon"></i>
                            <input v-model="searchValue" type="text" class="searchbar" placeholder="Search"/>
                        </form>
                    </div> <!-- search bar -->

                </div>
                <!-- start button -->
                <div style="padding-top: .2rem">
                    <div class="headerbar-button" style="margin-right: .3rem;" 
                        v-on:click="() => {
                            axios.post('http://localhost:3000/api/notification/accounts', {
                                notificationContent: 'Hello from the other side!!! Test notification.',
                                userRole: 'Equipment Staff',
                            })
                        }">
                        <i class="material-icons">star</i>
                    </div> <!-- start button -->
                </div>
                <!-- noti button -->
                <div style="padding-right: .5rem; padding-top: .2rem">
                    <v-menu style="padding: 0" v-model="showMenu" :close-on-content-click="false" offset-y :min-width="350">
                        <v-badge style="margin-top: .2rem; margin-right: 1.2rem" slot="activator" color="red">
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
                        <v-card style="padding: 0;">
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
                                <div :key="'noti' + noti.Id" v-for="noti in notifications">
                                    <v-divider></v-divider>
                                    <div class="noti-tile" :class="{'unread': !noti.Status}" style="display: grid; grid-template-columns: 20% 80%;">
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
                                                {{ getStatusTimeString(noti.CreatedDate) }}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <v-divider></v-divider>
                                <div style="display: flex; padding: 5px; font-size: .85rem; color: #757575; align-items: center; justify-content: center;">
                                    <a><strong style="color: var(--primary-color) !important">View all notifications</strong></a>
                                </div>
                            </div>
                        </v-card>
                    </v-menu>
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
import { sync, } from 'vuex-pathify';
import menu from '@/models/menu.js';
import Server from '@/config/config.js';
import moment from 'moment';

export default {
    name: 'header-bar',
    data() {
        return {
            showMenu: false,
        }
    },
    computed: {
        title: sync('title'),
        searchValue: sync('searchValue'),
        showSearchBar: sync('showSearchBar'),
        authUser() {
            return JSON.parse(window.localStorage.getItem("user"));
        },
        notifications: sync('notifications'),
    },
    methods: {
        search() {
            switch(this.title) {
                case menu.WorkOrder: {
                    let url = `${Server.WORKORDER_SEARCH_API_PATH}/${this.searchValue}`;
                    this.axios.get(url)
                        .then((res) => {
                            let result = res.data.WorkOrders;
                            this.$store.state.workOrderPage.searchValues = result;
                        });
                    break;
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
        getStatusTimeString(value) {
            const milis = moment().valueOf() - moment(value).valueOf();
            const duration = moment.duration(milis);
            const hours = duration.hours();
            if (hours > 0 && hours <= 5) {
                return `From ${hours} ${hours > 1 ? 'hours' : 'hour'} ago`
            } else if (hours == 0) {
                const minutes = duration.minutes();
                return `From ${minutes} ${minutes > 1 ? 'minutes' : 'minute'} ago`;
            } else {
                return `${moment(value).format('LLL')}`;
            }            
        }
    }
}
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
        padding-top: .5rem
        /* width: 30rem; */
        /* font-weight: bold; */
    }
    
    .headerbar-end {
        display: flex;
        justify-content: flex-end;
        padding-top: .4rem;
        /* padding: .9rem 1.3rem .9rem 0; */
        /* display: grid;
        grid-template-columns: 70% 15% 15%; */
        /* grid-column-gap: 10px; */
        /* padding-right: 1rem; */
        /* display: flex; */
    }

    .searchbar-wrapper {
        /* margin-top: 0.7rem; */
        margin-right: 20px;
    }

    .searchbar {
        /* border: none !important; */
        /* display: flex; */
        margin-left: -40px;
        /* border: 1px solid #bdbdbd; */
        background-color: var(--light-background);
        /* border: 1px solid var(--light-background); */
        border: 1px solid #e0e0e0;
        border-radius: 5px;
        padding: 5px 10px 5px 40px;
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

    .searchbar:hover, .searchbar-wrapper input:focus {
        /* border: 1px solid #eeeeee; */
        box-shadow: 4px 4px 8px #bdbdbd;  
    }

    #searchIcon:hover {
        cursor: pointer;
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
        transition: all .25s ease-in;
    }

    .headerbar-button i {
        position: relative;
        top: 5px;
        transition: all .25s ease-in;        
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
    }

    .noti-tile:hover {
        background: #fafafa;
    }

    .noti-tile:active {
        background: #e0e0e0;
    }

    .noti-tile.unread {
        user-select: none;
        cursor: pointer;
        background: #E0F7FA;
    }

    .noti-tile.unread:hover {
        background: #E9FBFD;
    }

    .noti-tile.unread:active {
        background: #ACEAF3;
    }

</style>
