<template>
    <div>        
        <div class="order-content">
            <div class="orders-view">
                <div class="order-navigator-buttons">
                    <button class="is-active">All</button>
                    <button class="">Open</button>
                    <button class="">Upcoming</button>
                    <button class="">Checked</button>
                    <button class="">Overdue</button>
                </div>
                <div class="order-blocks">
                    <order-block v-bind:key="order.id" v-bind:order="order" v-bind:class="isActive(order.id)" v-for="order in orders" v-on:click.native="setSelectedOrder(order)"></order-block>
                </div>
            </div>
            <div id="order-detail-view">
                <order-detail class="order-detail" v-bind:order="selectedOrder"></order-detail>
            </div>
        </div>
        <router-link to="/work_order/create" tag="button" id="btn-add-work-order">Add Work Order</router-link>
    </div>
</template>

<script>
import data from '@/models/work_orders.js';
import OrderBlock from './OrderBlock/OrderBlock';
import OrderDetail from './OrderDetailComponent/OrderDetail';

export default {    
    components: {
        OrderDetail, OrderBlock
    },
    data() {
        return {
            orders: data,
            selectedOrder: null,
        }
    },
    methods: {
        setSelectedOrder(order) {
            this.selectedOrder = order;
        },
        isActive(orderId) {
            if (this.selectedOrder != null && orderId === this.selectedOrder.id) {
                return 'is-active-block';
            }
            return '';
        }
    }
}
</script>

<style scoped>
    .order-navigator-buttons {
        display: flex;
        justify-content: center;
        align-content: center;
        margin-bottom: 20px;
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
        background-color: var(--primary-color);
        padding: 13px;
        color: white;
        border-radius: 10px;
        box-shadow: 4px 4px 5px #bdbdbd;
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
        height: 100%;          
        padding-right: .5rem;
        width: 30rem;
        overflow-y: scroll;
    }

    .is-active-block {
        background-color: #eeeeee;
        border: 1px solid #e0e0e0;
        box-shadow: 1px 1px 1px #bdbdbd;        
    }
    
    .order-detail {
        position: fixed;    
        left: 48rem;    
        overflow-y: scroll;
        height: 100%; 
        width: 30rem;    
        z-index: 2;
    }
</style>
