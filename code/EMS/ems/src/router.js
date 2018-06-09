import Vue from "vue";
import Router from "vue-router";

import DashboardComponent from "./components/Dashboard/Dashboard.vue";
import EquipmentComponent from "./components/Equipment/Equipment.vue";
import OrderComponent from "./components/Order/Order.vue";
import CreateOrderComponent from "./components/Order/CreateOrder/CreateOrder.vue";
import CalendarComponent from "./components/Calendar/Calendar.vue";
import ReportComponent from "./components/Report/Report.vue";
import TeamComponent from "./components/Team/Team.vue";
import LocationComponent from "./components/Location/Location.vue";
import EquipmentDetailsComponent from './components/Equipment/EquipmentDetails.vue';
import AddEquipmentComponent from './components/Equipment/AddEquipment.vue';
import AccountComponent from'./components/Account/Account.vue';
import AddAccountComponent from './components/Account/AddAccount.vue';
import DepartmentComponent from './components/Department/Department.vue';
import ProjectComponent from './components/Project/Project.vue'
Vue.use(Router)

import store from './store';

let router = new Router({
    mode: 'history',
    routes: [
        {
            path: '/',
            component: DashboardComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Dashboard');
                next();
            },
            meta: {
                showSearchBar: false,
            }
        },
        // {
        //     path: '/login',
        //     name: 'login',
        //     component: LoginComponent,
        // },
        {
            path: '/equipment',
            component: EquipmentComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Equipment');
                next();
            },
            meta: {
                showSearchBar: true,
            }
        },
        {
            path: '/equipment/create',
            component: AddEquipmentComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Equipment');
                next();
            },
            meta: {
                showSearchBar: false,
            }
        },
        {
            path: '/equipment/:id',
            component: EquipmentDetailsComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Equipment details');
                next();
            }
        },
        {
            path: '/work_order',
            component: OrderComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Work Order');
                next();
            },
            meta: {
                showSearchBar: true,
            }
        },
        {
            path: '/work_order/create',
            component: CreateOrderComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Work Order');
                next();
            },
            meta: {
                showSearchBar: false,
            }
        },
        {
            path: '/calendar',
            component: CalendarComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Calendar');
                next();
            },
            meta: {
                showSearchBar: false,
            }
        },
        {
            path: '/report',
            component: ReportComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Report');
                next();
            },
            meta: {
                showSearchBar: false,
            }
        },
        {
            path: '/team',
            component: TeamComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Teams ');
                next();
            },
            meta: {
                showSearchBar: true,
            }
        },
        {
            path: '/account',
            component: AccountComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Account');
                next();
            }
        },
        {
            path: '/account/add',
            component: AddAccountComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Account');
                next();
            }
        },
        {
            path: '/department',
            component: DepartmentComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Department');
                next();
            }
        },
        {
            path: '/location',
            component: LocationComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Location');
                next();
            },
            meta: {
                showSearchBar: true,
            }
        },
        {
            path: '/project',
            component: ProjectComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Project');
                next();
            },
            meta: {
                showSearchBar: true,
            }
        },
        {
            path: '/vendors',
            component: LocationComponent,
            beforeEnter: (to, from, next) => {
                store.set('title', 'Vendors');
                next();
            },
            meta: {
                showSearchBar: true,
            }
        }
    ]
});

export default router;
