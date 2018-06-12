<template>
    <div class="headerbar">
        <div class="">
            <div class="headerbar-title">
                {{ title }}
            </div>
        </div>
        <div class=""></div>
        <div class="">
            <div class="headerbar-end">
                <div class="searchbar-wrapper" v-show="showSearchBar">
                    <form @submit.prevent="search()">
                        <i class="fa fa-search" v-on:click="search()" id="searchIcon"></i>
                        <input v-model="searchValue" type="text" class="searchbar" placeholder="Search"/>
                    </form>
                </div>
                <div>
                    <div class="headerbar-button">
                        <i class="material-icons">star</i>
                    </div>
                </div>
                <div>
                    <div class="headerbar-button">
                        <i class="material-icons">notifications</i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { sync, } from 'vuex-pathify';
import menu from '@/models/menu.js';
import Server from '@/config/config.js';

export default {
    name: 'header-bar',
    data() {
        return {
            
        }
    },
    computed: {
        title: sync('title'),
        searchValue: sync('searchValue'),
        showSearchBar: sync('showSearchBar'),
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
        }
    }
}
</script>

<style scoped>
    .headerbar {
        display: grid;
        grid-template-columns: auto 50% auto;
        height: 4rem;
        /* background-color: var(--light-background); */
        /* background-color: #b0bec5; */
        background-color: #eeeeee;
        z-index: 2;
        width: 100%;
        /* border-bottom: 2px solid var(--dark-background); */
    }

    .headerbar-title {
        padding-top: 0.6rem;
        padding-left: 2rem;
        font-size: 2rem;
        color: var(--dark-background);
        height: 100%;
        /* width: 30rem; */
        /* font-weight: bold; */
    }
    
    .headerbar-end {
        display: flex;
        justify-content: flex-end;
        padding: .9rem 1.3rem .9rem 0;
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
        width: 35px;
        height: 35px;
        border-radius: 50%;
        box-shadow: 0px 0px 0px #e0e0e0;
        transition: all .25s ease-in;
        margin-right: 10px;
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
        color: white;    }
</style>
