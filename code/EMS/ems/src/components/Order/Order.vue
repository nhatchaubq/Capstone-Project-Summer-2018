<template>
    <div>        
        <div class="order-content">
            <!-- <div class="orders-view">                 -->
                <div class="">
                    <!-- <div style="width: 100%;">
                        Filter:
                    </div> -->
                    <div class="filter" style="width: 100%">
                        <!-- <div class="select">
                            <select v-model="selectedFilter">
                                <option disabled :value=null>Choose a filter</option>
                                <optgroup label="Status">
                                    <option :disabled="filterValues.includes(status)" :key="status.id" v-for="status in options.status" :value="status">{{ status.name }}</option>
                                </optgroup>
                                <optgroup label="Priorities">
                                    <option :disabled="filterValues.includes(priority)" :key="priority.id" v-for="priority in options.priorities" :value="priority">{{ priority.name }}</option>
                                </optgroup>
                            </select>
                        </div> -->
                        <div>
                            Priority:
                            <label class="checkbox" :key="priority.id" v-for="priority in options.priorities">
                                <input type="checkbox" v-on:change="addFilter(priority, $event)">
                                {{ priority.name }}
                            </label>
                        </div>
                        <div>
                            Status:
                            <label class="checkbox" :key="status.id" v-for="status in options.status">
                                <input type="checkbox" v-on:change="addFilter(status, $event)">
                                {{ status.name }}
                            </label>
                        </div>
                    </div>
                    <div style="width: 100%"></div>
                        <!-- <div class="filters-bar">
                            <span class="tag is-light" style="user-select: none; margin-right: .3rem; cursor: pointer;" :key="filter.id" v-on:click="removeFilter(filter)" v-for="filter in filterValues">
                                {{ filter.type == optionTypes.STATUS ? 'Status: ' : 'Priority: ' }} {{ filter.name }}
                                <i class="fa fa-times-circle"></i>
                            </span>
                        </div> -->
                    </div>
                    <div v-show="searchMode" style="display: flex; justify-content: flex-end; align-content: center;">
                        <span><a v-on:click="clearSearch()">Clear search result</a></span>  
                    </div>             
            <!-- </div>             -->
        </div>
        <div class="order-blocks">
            <div>
                <div class="emtpy-text" v-if="workOrders.length == 0">
                    There is no orders to display.
                </div>
                <div v-else>
                    <order-block :key="order.Id" :order="order" :class="isActive(order.Id)" v-for="order in workOrders" v-on:click.native="setSelectedOrder(order)"></order-block>
                </div>
            </div>
        </div>
        <div id="order-detail-view">
            <order-detail class="order-detail" :order="selectedOrder" :statusList="options.status"></order-detail>
        </div>
        <router-link to="/work_order/create">
            <button class="button btn-primary right-corner material-shadow-animate">Add Work Order</button>
        </router-link>
    </div>
</template>

<script>
// import Vue from 'vue';
import { sync, } from 'vuex-pathify';
import Server from '@/config/config.js';
import OrderBlock from './OrderBlock/OrderBlock';
import OrderDetail from './OrderDetailComponent/OrderDetail';

export default {    
    components: {
        OrderDetail, OrderBlock,
    },    
    created() {
        // this.sortOrdersByDate(this.orders);
        // alert(this.$store.state.workOrderPage.orders.length);
        if (this.$store.state.workOrderPage.orders.length == 0) {
            this.axios.get(Server.WORKORDER_API_PATH)
                .then((response) => {
                    let data = response.data.WorkOrders;
                    this.$store.state.workOrderPage.orders = data;
                    this.workOrders = data;
                });
        } else {
            this.workOrders = this.$store.state.workOrderPage.orders;
        }
        this.axios.get(Server.WORKORDER_STATUS_API_PATH)
            .then((response) => {
                let data = response.data;
                data.forEach(element => {
                    let status = {
                        id: element.Id,
                        name: element.Name,
                        type: this.optionTypes.STATUS,
                    }
                    this.options.status.push(status);
                });
            });
        this.axios.get(Server.WORKORDER_PRIORITIES_API_PATH)
            .then((response) => {
                let data = response.data;
                data.forEach(element => {
                    let priority = {
                        id: element.Id,
                        name: element.Name,
                        type: this.optionTypes.PRIORITY,
                    }
                    this.options.priorities.push(priority);
                });
            });
    },
    data() {
        return {
            tempValues: null, // to hold the original orders when apply filters
            workOrders: [], // orders data to display in orderblocks <order-block></order-block>
            selectedOrder: null, // to provide order to OrderDetail component <order-detail></order-detail>
            // selectedFilter: null, // to hold the selected value when change in <select></select>
            searchMode: false,
            options: {
                priorities: [],
                status: [],
            },
            filterValues: [],
            filterOptionsValues: {
                priorities: [],
                status: [],
            },
            optionTypes: {
                STATUS: 0, PRIORITY: 1,
            }
        }
    },
    computed: {
        searchValues: sync('workOrderPage.searchValues'),    
    },
    methods: {
        setSelectedOrder(order) {
            if (this.selectedOrder == order) {
                this.selectedOrder = null;
            } else {
                this.selectedOrder = order;
            }
        },
        // when click on an orderblock, add 'is-active-block' class to it
        isActive(orderId) {
            if (this.selectedOrder != null && orderId === this.selectedOrder.Id) {
                return 'is-active-block';
            }
            return '';
        },
        removeFilter(filter) {
            // the lamda below will iterate the filterValues to find if any elements in it match the condition, then return the result array.
            // in this case it will find if any elements in filterValues match the filter we provided.
            // it is the same as we make a for loop then find the needed elements by using if, then return it as an array. all of those steps in one line of code if we use lamda.
            // this.filterValues = this.filterValues.filter(value => value.type != filter.type && value.id != filter.id);
            switch(filter.type) {
                case this.optionTypes.STATUS: {
                    this.filterOptionsValues.status = this.filterOptionsValues.status.filter(status => status.id != filter.id);
                    break;
                }
                case this.optionTypes.PRIORITY: {
                    this.filterOptionsValues.priorities = this.filterOptionsValues.priorities.filter(priority => priority.id != filter.id);
                    break;
                }
            }
            this.filterOrders();
            if (this.filterOptionsValues.status.length == 0 && this.filterOptionsValues.priorities.length == 0) {
                this.selectedFilter = null;
                this.workOrders = this.tempValues;
                this.tempValues = null;
            }
        },
        filterOrders() {
            if (!this.tempValues) {
                this.tempValues = this.workOrders;
            }
            this.workOrders = []; // reset orders before applying new filters
            this.selectedOrder = null;
            if (this.filterOptionsValues.status.length > 0) {
                this.filterOptionsValues.status.forEach(status => {
                    this.workOrders = this.workOrders.concat(this.tempValues.filter(order => order.WorkOrderStatus == status.name));
                });
            } else {
                this.workOrders = this.tempValues;
            }
            if (this.filterOptionsValues.priorities.length > 0) {
                var tempValues = [];
                this.filterOptionsValues.priorities.forEach(priority => {
                    tempValues = tempValues.concat(this.workOrders.filter(order => order.Priority == priority.name));
                });
                this.workOrders = tempValues;
            }
            this.workOrders = this.sortOrdersByDate(this.workOrders);
            this.selectedFilter = null;
            // for (var i = 0; i < this.filterValues.length; i++) {
            //     this.orders = this.sortOrdersByDate(this.orders);
            // }
        },
        sortOrdersByDate(orders) {
            return orders.sort((order1, order2) => {
                var date1 = parseInt(new Date(order1.CreateDate).getTime());
                var date2 = parseInt(new Date(order2.CreateDate).getTime());
                // alert(order1.Id + ' ' + order2.Id + ' ' + order2.PriorityId  + ' ' + order1.PriorityId);
                var result = date2 - date1;
                // return (result > 0) ? 1 : (result < 0) ? -1 : 0;
                return result;
            });
        },
        reset() {
            this.filterValues = [];
            this.filterOptionsValues.status = [];
            this.filterValues.priorities = [];
            this.selectedOrder = null;
        },
        clearSearch() {
            this.$store.state.searchValue = '';
            this.$store.state.workOrderPage.searchValues = [];
        },
        addFilter(filter, event) {
            if (event.target.checked) {
                if (!this.filterValues.includes(filter)) {                  
                    // this.filterValues.push(filter);
                    switch (filter.type) {
                        case this.optionTypes.STATUS: {
                            this.filterOptionsValues.status.push(filter);
                            break;
                        }
                        case this.optionTypes.PRIORITY: {
                            this.filterOptionsValues.priorities.push(filter);
                            break;
                        }
                    }
                    // tempValues is null means that no filters yet.                       
                    this.filterOrders();                    
                } 
                // else {
                //     filter = null;
                // }
            } else {
                this.removeFilter(filter);
            }
        }
    },
    watch: { // this 'watch' is used when we need to monitor changes of some variables, if they changes value then the function in this 'watch' will be triggered.
        // 'selectedFilter': function() {
        //     Vue.nextTick(() => {
        //         if (this.selectedFilter != null && !this.filterValues.includes(this.selectedFilter)) {                    
        //             this.filterValues.push(this.selectedFilter);
        //             switch (this.selectedFilter.type) {
        //                 case this.optionTypes.STATUS: {
        //                     this.filterOptionsValues.status.push(this.selectedFilter);
        //                     break;
        //                 }
        //                 case this.optionTypes.PRIORITY: {
        //                     this.filterOptionsValues.priorities.push(this.selectedFilter);
        //                     break;
        //                 }
        //             }
        //             // tempValues is null means that no filters yet.
        //             if (this.tempValues == null) {
        //                 this.tempValues = this.workOrders;
        //             }     
        //             this.filterOrders();                    
        //         } else {
        //             this.selectedFilter = null;
        //         }
        //     });
        // },
        'searchValues': function() {
            if (this.searchValues.length == 0) {
                this.workOrders = this.$store.state.workOrderPage.orders;
                this.searchMode = false;
            } else {
                this.workOrders = this.searchValues;
                this.searchMode = true;
            }
            this.reset();
        }      
    }
}
</script>

<style scoped>
    /* .filter {
        display: grid;
        grid-template-columns: 18% auto;
        grid-template-rows: auto auto;
        margin-bottom: 1rem;   
    } */
    
    .filter {
        display: grid;
        /* grid-template-columns: 18% auto; */
        grid-template-rows: auto auto;
        margin-bottom: 1rem;
        user-select: none;
        grid-row-gap: .5rem;
    }

    .filter label {
        margin-right: .5rem;
    }

    .tag i {
        color: #757575;
        margin-left: .3rem;
        font-size: 1rem;
        transition: all .1s ease-in-out;
        display: none;
    }

    .tag:hover i {
        display: block;
    }

    .tag i:hover {
        color: #9e9e9e;        
    }

    .tag i:active {
        color: #616161;        
    }

    .filters-bar {
        width: 100%;
        padding-top: .7rem;
    }
    
    .order-navigator-buttons > button {
        width: 7rem;
        margin: 0 1rem 0 1rem;
        padding: 0.5rem 0 0.5rem 0;
        /* background-color: aqua; */
        font-size: 1.2rem;
    }

    .is-active {
        border-bottom: 1px solid black;
        font-weight: bold;        
    }

    .order-content {
        margin-top: 1rem;
        display: grid;
        grid-template-columns: 50% 50%;    

    }   

    .orders-view {        
        width: 30rem !important;
        /* z-index: 2; */
    }

    .order-blocks {
        position: fixed;   
        height: 75%;          
        padding-right: .5rem;
        width: 40%;
        overflow-y: auto;
    }

    .is-active-block {
        background-color: #e0e0e0 !important;
        border: 1px solid #e0e0e0 !important;
        box-shadow: 1px 1px 1px #bdbdbd !important;        
    }
    
    .order-detail {
        position: fixed;    
        left: 59%;    
        height: 75%; 
        overflow-y: auto;
        width: 39%;    
        z-index: 2;
    }    

    .right-corner {
    position: fixed;
    right: 3rem;
    bottom: 2rem;
    }
</style>
