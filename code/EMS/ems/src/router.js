import Vue from 'vue'
import Router from 'vue-router'

import LoginComponent from './components/Login/Login.vue'
import DashboardComponent from './components/Dashboard/Dashboard.vue';
import EquipmentComponent from './components/Equipment/Equipment.vue';
import OrderComponent from './components/Order/Order.vue';
import CreateOrderComponent from './components/Order/CreateOrder/CreateOrder.vue'
import CalendarComponent from './components/Calendar/Calendar.vue';
import ReportComponent from './components/Report/Report.vue';
import TeamComponent from './components/Team/Team.vue';
import LocationComponent from './components/Location/Location.vue';
Vue.use(Router)

import store from './store';

export default new Router({
    mode: 'history',
    routes: [
        {
            path: '/',
            component: DashboardComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Dashboard');
                next();
            }
        },
        {
            path: '/login',
            component: LoginComponent,
        },
        {
            path: '/equipment',
            component: EquipmentComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Equipment');
                next();
            }
        },
        {
            path: '/work_order',
            component: OrderComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Work Order');
                next();
            }
        },
        {
            path: '/work_order/create',
            component: CreateOrderComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Work Order');
                next();
            }
        },
        {
            path: '/calendar',
            component: CalendarComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Calendar');
                next();
            }
        },
        {
            path: '/report',
            component: ReportComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Report');
                next();
            }
        },
        {
            path: '/teams',
            component: TeamComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Teams & People');
                next();
            }
        },
        {
            path: '/location',
            component: LocationComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Location');
                next();
            }
        },
        {
            path: '/vendors',
            component: LocationComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Vendors');
                next();
            }
        }
    ]
});