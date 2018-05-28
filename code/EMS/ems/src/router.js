import Vue from 'vue'
import Router from 'vue-router'

import LoginComponent from './components/Login/Login.vue'
import DashboardComponent from './components/Dashboard/Dashboard.vue';
import EquipmentComponent from './components/Equipment/Equipment.vue';
import OrderComponent from './components/Order/Order.vue';
import CalendarComponent from './components/Calendar/Calendar.vue';
import ReportComponent from './components/Report/Report.vue';
import TeamComponent from './components/Team/Team.vue';
import LocationComponent from './components/Location/Location.vue';
Vue.use(Router)

export default new Router({
    mode: 'history',
    routes: [
        {
            path: '/',
            component: DashboardComponent,
        },
        {
            path: '/login',
            component: LoginComponent,
        },
        {
            path: '/equipment',
            component: EquipmentComponent,
        },
        {
            path: '/work_order',
            component: OrderComponent,
        },
        {
            path: '/calendar',
            component: CalendarComponent,
        },
        {
            path: '/report',
            component: ReportComponent,
        },
        {
            path: '/team',
            component: TeamComponent,
        },
        {
            path: '/location',
            component: LocationComponent,
        }
    ]
});