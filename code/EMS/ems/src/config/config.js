const SERVER_DEFAULT = "http://localhost:3000/api";

// login api section - start
const LOGIN_API_PATH = SERVER_DEFAULT + "/login";
// login api section - end

// account api section - start
const ACCOUNT_API_PATH = SERVER_DEFAULT + "/account";
const CREATE_ACCOUNT_API_PATH = ACCOUNT_API_PATH + "/create";
const VIEW_ACCOUNT_DETAIL_API_PATH = ACCOUNT_API_PATH + "/1";
// user api section - end

// equipment api section - start
const EQUIPMENT_API_PATH = SERVER_DEFAULT + "/equipment";

// equipment api section - end

// equipmentitem api section - start
const EQUIPMENTITEM_API_PATH = SERVER_DEFAULT + "/equipmentItem";
const EQUIPMENTITEM_BY_ID_LOCATION_API_PATH = SERVER_DEFAULT + "/equipmentItem";
// equipmentitem api section - end

// work order api section - start
const WORKORDER_API_PATH = SERVER_DEFAULT + "/work_order";
const WORKORDER_DETAIL_API_PATH = WORKORDER_API_PATH + "/detail";
const WORKORDER_SEARCH_API_PATH = WORKORDER_API_PATH + "/search";
const WORKORDER_STATUS_API_PATH = WORKORDER_API_PATH + "/status";
const WORKORDER_CATEGORIES_API_PATH = WORKORDER_API_PATH + "/categories";
const WORKORDER_PRIORITIES_API_PATH = WORKORDER_API_PATH + "/priorities";
const WORKODER_BY_ID_LOCATION_API_PATH =
  WORKORDER_API_PATH + "/workorderbylocationId";
// work order api section - end

//location api section - start
const LOCATION_API_PATH = SERVER_DEFAULT + "/location";
const LOCATION_SEARCH_API_PATH = LOCATION_API_PATH + "/search";
const LOCATION_CREATE_API_PATH = LOCATION_API_PATH + "/create";
const LOCATION_UPDATE_API_PATH = LOCATION_API_PATH + "/editLocation";
const LOCATION_BLOCK_FLOOR_TILE_API_PATH =
  LOCATION_API_PATH + "/floor_block_tile";
const LOCATION_EDIT_API_PATH = LOCATION_API_PATH + "/updateLocation";
const LOCATION_DELETE_TEAM_WITHOUT_WORDODER =
  LOCATION_API_PATH + "/deleteTeamWithoutWO";
//location api section - end

//team_location api section - start
const TEAM_LOCATION_API_PATH = SERVER_DEFAULT + "/team_location";
const TEAM_LOCATION_CREATE_API_PATH =
  TEAM_LOCATION_API_PATH + "/createTeamLocation";
//team_location api section - end

//team api section - start
const TEAM_API_PATH = SERVER_DEFAULT + "/team";
const TEAM_BY_LOCATION_ID_API_PATH = TEAM_API_PATH + "/getTeamByLocation";
const TEAM_ACCOUNT_CREATE_API_PATH = SERVER_DEFAULT + "/team_account/createTeamAccount";
//team api section - end

// vendor api section -start
const VENDOR_API_PATH = SERVER_DEFAULT + "/vendor";

// vendor api section -end

// dashBoard
const DASHBOARD_API_PATH = SERVER_DEFAULT + "/dashboard";
// /dashBoard

//api report -start
const REPORT_API_PATH = SERVER_DEFAULT + "/report";
const REPORT_EQUIPMENT_API_PATH = REPORT_API_PATH + "/getEquipmentOverview";
const REPORT_USING_EQUIPMENT_API_PATH = REPORT_API_PATH + "/getUsingEquipment";
const REPORT_STATUS_EQUIPMENT_API_PATH =
  REPORT_API_PATH + "/getStatusEquipment";
const REPORT_MAINTENANCE_CALENDAR_EQUIPMENT_API_PATH =
  REPORT_API_PATH + "/getMaintenanceCalendar";
const REPORT_AVAILABLE_EQUIPMENT_API_PATH =
  REPORT_API_PATH + "/getAvailableEquipment";

const REPORT_WORKORDER_API_PATH = REPORT_API_PATH + "/getWorkorderOverview";
const REPORT_LATE_WORKORDER_API_PATH = REPORT_API_PATH + "/getLateWorkorder";
const REPORT_RETURNED_WORKORDER_API_PATH =
  REPORT_API_PATH + "/getClosedWorkorder";
//api report -end

// api notification - start
const NOTIFICATION_API_PATH = SERVER_DEFAULT + '/notification';
// api notification - end

export default {
  SERVER_DEFAULT,

  LOGIN_API_PATH,
  ACCOUNT_API_PATH,
  CREATE_ACCOUNT_API_PATH,
  EQUIPMENT_API_PATH,
  REPORT_API_PATH,

  EQUIPMENTITEM_API_PATH,
  EQUIPMENTITEM_BY_ID_LOCATION_API_PATH,

  WORKORDER_API_PATH,
  WORKORDER_DETAIL_API_PATH,
  WORKORDER_SEARCH_API_PATH,
  WORKORDER_STATUS_API_PATH,
  WORKORDER_PRIORITIES_API_PATH,
  WORKORDER_CATEGORIES_API_PATH,
  WORKODER_BY_ID_LOCATION_API_PATH,

  LOCATION_API_PATH,
  LOCATION_CREATE_API_PATH,
  TEAM_API_PATH,
  VIEW_ACCOUNT_DETAIL_API_PATH,
  LOCATION_BLOCK_FLOOR_TILE_API_PATH,
  LOCATION_SEARCH_API_PATH,

  TEAM_LOCATION_API_PATH,
  TEAM_BY_LOCATION_ID_API_PATH,
  LOCATION_UPDATE_API_PATH,
  TEAM_LOCATION_CREATE_API_PATH,
  LOCATION_EDIT_API_PATH,
  LOCATION_DELETE_TEAM_WITHOUT_WORDODER,

  TEAM_ACCOUNT_CREATE_API_PATH,

  VENDOR_API_PATH,

  DASHBOARD_API_PATH,
  REPORT_EQUIPMENT_API_PATH,
  REPORT_USING_EQUIPMENT_API_PATH,
  REPORT_STATUS_EQUIPMENT_API_PATH,
  REPORT_MAINTENANCE_CALENDAR_EQUIPMENT_API_PATH,
  REPORT_AVAILABLE_EQUIPMENT_API_PATH,

  REPORT_WORKORDER_API_PATH,
  REPORT_LATE_WORKORDER_API_PATH,
  REPORT_RETURNED_WORKORDER_API_PATH,

  NOTIFICATION_API_PATH
};