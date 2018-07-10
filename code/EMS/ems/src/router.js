import Vue from "vue";
import Router from "vue-router";

import DashboardComponent from "./components/Dashboard/Dashboard.vue";
import EquipmentComponent from "./components/Equipment/Equipment.vue";
import OrderComponent from "./components/Order/Order.vue";
import CreateOrderComponent from "./components/Order/CreateOrder/CreateOrder.vue";
import CalendarComponent from "./components/Calendar/Calendar.vue";
import ReportComponent from "./components/Report/Report.vue";
import TeamComponent from "./components/Team/Team.vue";
import AddTeamComponent from "./components/Team/AddTeam.vue";
import TeamDetailComponent from "./components/Team/TeamDetail.vue";
import LocationComponent from "./components/Location/Location.vue";

import EquipmentDetailComponent from "./components/Equipment/EquipmentDetail.vue";
import AddEquipmentComponent from "./components/Equipment/AddEquipment.vue";
import AccountComponent from "./components/Account/Account.vue";
import AddAccountComponent from "./components/Account/AddAccount.vue";
import AccountDetailComponent from "./components/Account/AccountDetail.vue";
import DepartmentComponent from "./components/Department/Department.vue";
import ProjectComponent from "./components/Project/Project.vue";
import CreateLocation from "./components/Location/CreateLocation.vue";
import VendorComponent from "./components/Vendor/Vendor.vue";
import VendorDetailComponent from "./components/Vendor/VendorDetail.vue";
import AddVendorComponent from "./components/Vendor/AddVendor.vue";
import AddVendor1Component from "./components/Vendor/AddVendor1.vue";
import EditLocation from "./components/Location/EditLocation.vue";

// chaubqn - start
import TestComponent from "./components/TestSite/Test.vue";
import LocationMapViewComponent from "./components/Location/MapView.vue";
import AddBlockFloorTileComponent from "./components/Location/AddBlockFloorTile.vue";
// chaubqn - end

// hau - start
import EquipmentOverviewReportComponent from "./components/Report/Equipment/EquipmentOverviewReport.vue";
import EquipmentStatusReportComponent from "./components/Report/Equipment/EquipmentStatusReport.vue";
import EquipmentUsingReportComponent from "./components/Report/Equipment/EquipmentUsingReport.vue";
import EquipmentMaintenanceCalendarReportComponent from "./components/Report/Equipment/EquipmentMaintenanceCalendarReport.vue";
import AvailableEquipmentReportComponent from "./components/Report/Equipment/AvailableEquipmentReport.vue";

import WorkorderOverviewReportComponent from "./components/Report/Workorder/WorkOrderOverviewReport.vue";
import LateWorkorderReportComponent from "./components/Report/Workorder/LateWorkorderReport.vue";
import ReturnedWorkorderReportComponent from "./components/Report/Workorder/ClosedWorkorderReport.vue";

// hau - end

Vue.use(Router);
//Dien -test- start
import DienComponent from "./components/chartTest/test1.vue";
//Dien -test- end


//Dien addEquipmentCategory-start
import AddEquipmentCategoryComponent from "./components/Equipment/AddEquipmentCategory.vue"
//Dien addEquipmentCategory-end

Vue.use(Router);

import store from "./store";
import menu from "./models/menu";

let router = new Router({
  mode: "history",
  routes: [{
      path: "/",
      component: DashboardComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.Dashboard);
        next();
      },
      meta: {
        showSearchBar: false
      }
    },
    {
      path: "/login",
      name: "login"
      // component: LoginComponent,
    },
    {
      path: "/equipment",
      component: EquipmentComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.Equipment);
        next();
      },
      meta: {
        showSearchBar: true
      }
    },
    {
      path: "/equipment/create",
      component: AddEquipmentComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.Equipment);
        next();
      },
      meta: {
        showSearchBar: false
      }
    },
    {
      path: "/equipment/:id",
      component: EquipmentDetailComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.EquipmentDetail);
        next();
      }
    },
    {
      path: "/work_order",
      component: OrderComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.WorkOrder);
        next();
      },
      meta: {
        showSearchBar: true
      }
    },
    {
      name: "create_work_order",
      path: "/work_order/create",
      component: CreateOrderComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.WorkOrder);
        next();
      },
      meta: {
        showSearchBar: false
      }
    },
    {
      path: "/calendar",
      component: CalendarComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.Calendar);
        next();
      },
      meta: {
        showSearchBar: false
      }
    },
    {
      path: "/report",
      component: ReportComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.Report);
        next();
      },
      meta: {
        showSearchBar: false
      }
    },
    {
      path: "/team",
      component: TeamComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.Teams);
        next();
      },
      meta: {
        showSearchBar: true
      }
    },
    {
      path: "/team/add",
      component: AddTeamComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.Teams);
        next();
      }
    },
    {
      path: "/team/:id",
      component: TeamDetailComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.TeamDetails);
        next();
      }
    },
    {
      path: "/account",
      component: AccountComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.Accounts);
        next();
      }
    },
    {
      path: "/account/add",
      component: AddAccountComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.Accounts);
        next();
      }
    },
    {
      path: "/account/:id",
      component: AccountDetailComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.AccountDetails);
        next();
      }
    },
    {
      path: "/department",
      component: DepartmentComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.Department);
        next();
      }
    },
    {
      path: "/location",
      component: LocationComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.Location);
        next();
      },
      meta: {
        showSearchBar: true
      }
    },
    {
      path: "/project",
      component: ProjectComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.Project);
        next();
      },
      meta: {
        showSearchBar: true
      }
    },
    {
      path: "/vendor",
      component: VendorComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.Vendors);
        next();
      },
      meta: {
        showSearchBar: true
      }
    },
    {
      path: "/vendor/:id",
      component: VendorDetailComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.Vendors);
        next();
      },
      meta: {
        showSearchBar: true
      }
    },
    {
      path: "/vendor/add",
      component: AddVendorComponent,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.Vendors);
        next();
      }
    },
    {
      path: "/vendor1/add",
      component: AddVendor1Component,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.Vendors);
        next();
      }
    },
    {
      path: "/location/create-location",
      component: CreateLocation,

      beforeEnter: (to, from, next) => {
        store.set("title", menu.Location);

        next();
      },
      meta: {
        showSearchBar: true
      }
    },
    {
      path: "/location/edit-location/:id",
      component: EditLocation,
      beforeEnter: (to, from, next) => {
        store.set("title", menu.Location);
        next();
      },
      meta: {
        showSearchBar: true
      }
    },
    // chaubqn - start
    {
      path: "/test",
      component: TestComponent,

      beforeEnter: (to, from, next) => {
        store.set("title", "Test area");
        next();
      },
      meta: {
        showSearchBar: false
      }
    },
    {
      path: "/location/mapview/:locationId",
      component: LocationMapViewComponent,

      beforeEnter: (to, from, next) => {
        store.set("title", menu.Location);
        next();
      },
      meta: {
        showSearchBar: true
      }
    },
    {
      path: "/location/:locationId/add_block_floor_tile",
      component: AddBlockFloorTileComponent,

      beforeEnter: (to, from, next) => {
        store.set("title", menu.Location);
        next();
      },
      meta: {
        showSearchBar: false
      }
    },
    // chaubqn - end
    // hau - start
    {
      path: "/report/equipment/equipment_overview",
      component: EquipmentOverviewReportComponent,

      beforeEnter: (to, from, next) => {
        store.set("title", "Equipment Report");
        next();
      },
      meta: {
        showSearchBar: false
      }
    },
    {
      path: "/report/equipment/equipment_status",
      component: EquipmentStatusReportComponent,

      beforeEnter: (to, from, next) => {
        store.set("title", "Equipment Report");
        next();
      },
      meta: {
        showSearchBar: false
      }
    },
    {
      path: "/report/equipment/equipment_using",
      component: EquipmentUsingReportComponent,

      beforeEnter: (to, from, next) => {
        store.set("title", "Equipment Report");
        next();
      },
      meta: {
        showSearchBar: false
      }
    },
    {
      path: "/report/equipment/equipment_maintenance_calendar",
      component: EquipmentMaintenanceCalendarReportComponent,

      beforeEnter: (to, from, next) => {
        store.set("title", "Equipment Report");
        next();
      },
      meta: {
        showSearchBar: false
      }
    },
    {
      path: "/report/equipment/equipment_available",
      component: AvailableEquipmentReportComponent,

      beforeEnter: (to, from, next) => {
        store.set("title", "Equipment Report");
        next();
      },
      meta: {
        showSearchBar: false
      }
    },
    {
      path: "/report/workorder/workorder_overview",
      component: WorkorderOverviewReportComponent,

      beforeEnter: (to, from, next) => {
        store.set("title", "Work Order Report");
        next();
      },
      meta: {
        showSearchBar: false
      }
    },
    {
      path: "/report/workorder/late_workorder",
      component: LateWorkorderReportComponent,

      beforeEnter: (to, from, next) => {
        store.set("title", "Work Order Report");
        next();
      },
      meta: {
        showSearchBar: false
      }
    },
    {
      path: "/report/workorder/returned_workorder",
      component: ReturnedWorkorderReportComponent,

      beforeEnter: (to, from, next) => {
        store.set("title", "Work Order Report");
        next();
      },
      meta: {
        showSearchBar: false
      }
    },

    // hau - end

    // Dien -test -start
    {
      path: "/1",
      component: DienComponent,

      beforeEnter: (to, from, next) => {
        store.set("title", menu.Test);
        next();
      },
      meta: {
        showSearchBar: false
      }
    },
    // Dien -test -end
    //Dien addEquipmentCategory-start
    {
      path: "/addec",
      component: AddEquipmentCategoryComponent,

      beforeEnter: (to, from, next) => {
        store.set("title", menu.Equipment);
        next();
      },
      meta: {
        showSearchBar: false
      }
    }

    //Dien addEquipmentCategory-end
  ]
});

export default router;