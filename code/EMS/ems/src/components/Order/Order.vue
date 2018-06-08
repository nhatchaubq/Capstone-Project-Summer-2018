<template>
    <div>        
        <div class="order-content">
            <div class="orders-view">                
                <div class="filter">
                    <div style="width: 100%; position: relative; top: .4rem; margin-right: 1rem;">
                        Add filter:
                    </div>
                    <div style="width: 100%">
                        <div class="select">
                            <select v-model="selectedFilter">
                                <option disabled :value=null>Choose a filter</option>
                                <optgroup label="Status">
                                    <option :disabled="filterValues.includes(status)" :key="status.id" v-for="status in options.status" :value="status">{{ status.name }}</option>
                                </optgroup>
                                <optgroup label="Priorities">
                                    <option :disabled="filterValues.includes(priority)" :key="priority.id" v-for="priority in options.priorities" :value="priority">{{ priority.name }}</option>
                                </optgroup>
                            </select>
                        </div>
                    </div>
                    <div style="width: 100%"></div>
                    <div class="filters-bar">
                        <span class="tag is-light" style="user-select: none; margin-right: .3rem; cursor: pointer;" v-bind:key="filter.id" v-on:click="removeFilter(filter)" v-for="filter in filterValues">
                            {{ filter.name }}
                            <i class="fa fa-times-circle"></i>
                        </span>
                    </div>
                </div>
                <div class="order-blocks">
                    <div>
                        <div class="emtpy-text" v-if="workOrders.length == 0">
                            There is no orders to display.
                        </div>
                        <div v-else>
                            <order-block v-bind:key="order.Id" v-bind:order="order" v-bind:class="isActive(order.Id)" v-for="order in workOrders" v-on:click.native="setSelectedOrder(order)"></order-block>
                        </div>
                    </div>
                </div>
            </div>
            <div id="order-detail-view">
                <order-detail class="order-detail" v-bind:order="selectedOrder"></order-detail>
            </div>
        </div>
        <router-link to="/work_order/create" tag="button" id="btn-add-work-order" class="button is-primary material-shadow-animate">Add Work Order</router-link>
    </div>
</template>

<script>
import Vue from 'vue';
import Server from '@/config/config.js';
import OrderBlock from './OrderBlock/OrderBlock';
import OrderDetail from './OrderDetailComponent/OrderDetail';

export default {    
    components: {
        OrderDetail, OrderBlock,
    },    
    created() {
        // this.sortOrdersByDate(this.orders);
        this.axios.get(Server.WORKORDER_API_PATH)
            .then((response) => {
                let data = response.data.WorkOrders;
                data.forEach(workOrder => {
                    this.workOrders.push(workOrder);
                });
            }).catch((error) => {
                console.log(error);
            });
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
            })
            .catch((error) => {
                console.log(error);
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
            })
            .catch((error) => {
                console.log(error);
            });
    },
    data() {
        return {
            tempValues: null, // to hold the original orders when apply filters
            workOrders: [], // orders data to display in orderblocks <order-block></order-block>
            selectedOrder: null, // to provide order to OrderDetail component <order-detail></order-detail>
            selectedFilter: null, // to hold the selected value when change in <select></select>
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
    methods: {
        setSelectedOrder(order) {
            this.selectedOrder = order;
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
            this.filterValues = this.filterValues.filter(value => value != filter);
            switch(filter.type) {
                case this.optionTypes.STATUS: {
                    this.filterOptionsValues.status.pop(filter);
                    break;
                }
                case this.optionTypes.PRIORITY: {
                    this.filterOptionsValues.priorities.pop(filter);
                    break;
                }
            }
            this.filterOrders();
            if (this.filterValues.length === 0) {
                this.selectedFilter = null;
                this.workOrders = this.tempValues;
            }
        },
        filterOrders() {
            this.workOrders = []; // reset orders before applying new filters
            this.selectedOrder = null;

            this.filterOptionsValues.status.forEach(status => {
                this.workOrders = this.workOrders.concat(this.tempValues.filter(order => order.WorkOrderStatus == status.name));
            });
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
                return (result > 0) ? 1 : (result < 0) ? -1 : (order2.PriorityID - order1.PriorityID);
            });
        }
    },
    watch: { // this 'watch' is used when we need to monitor changes of some variables, if they changes value then the function in this 'watch' will be triggered.
        'selectedFilter': function() {
            Vue.nextTick(() => {
                if (this.selectedFilter != null && !this.filterValues.includes(this.selectedFilter)) {                    
                    this.filterValues.push(this.selectedFilter);
                    switch (this.selectedFilter.type) {
                        case this.optionTypes.STATUS: {
                            this.filterOptionsValues.status.push(this.selectedFilter);
                            break;
                        }
                        case this.optionTypes.PRIORITY: {
                            this.filterOptionsValues.priorities.push(this.selectedFilter);
                            break;
                        }
                    }
                    // console.log(this.filterOptionsValues);
                    // this.selectedFilter = null;
                    // tempValues is null means that no filters yet.
                    if (this.tempValues == null) {
                        this.tempValues = this.workOrders;
                    }     
                    this.filterOrders();                    
                } else {
                    this.selectedFilter = null;
                }
            });
        }
    }
}
</script>

<style scoped>
    .filter {
        display: grid;
        grid-template-columns: 18% auto;
        grid-template-rows: auto auto;
        margin-bottom: 1rem;   
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

    #btn-add-work-order {
        position: fixed;
        right: 3rem;
        bottom: 2rem;
        /* background-color: var(--primary-color);
        padding: 13px;
        color: white;
        border-radius: 10px; */
        z-index: 99;
    }

    #btn-add-work-order:hover {
        cursor: pointer;
    }

    .order-content {

        /* margin-top: 3rem; */
        /* display: grid;
        grid-template-columns: 50% 50%; */

        

    }   

    .orders-view {        
        width: 30rem !important;
        /* z-index: 2; */
    }

    .order-blocks {
        position: fixed;   
        height: 80%;          
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
        /* height: 100%;  */
        overflow-y: auto;
        width: 39%;    
        z-index: 2;
    }
</style>
