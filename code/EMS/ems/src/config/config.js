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
const LOCATION_CREATE_API_PATH = LOCATION_API_PATH + "/create";
const LOCATION_UPDATE_API_PATH = LOCATION_API_PATH + "/editLocation";
//location api section - end

//team_location api section - start
const TEAM_LOCATION_API_PATH = SERVER_DEFAULT + "/team_location";
const TEAM_LOCATION_CREATE_API_PATH =
  TEAM_LOCATION_API_PATH + "/createTeamLocation";
//team_location api section - end

//team api section - start
const TEAM_API_PATH = SERVER_DEFAULT + "/team";
const TEAM_BY_LOCATION_ID_API_PATH = TEAM_API_PATH + "/getTeamByLocation";
//team api section - end

// vendor api section -start
const VENDOR_API_PATH = SERVER_DEFAULT + "/vendor/1";


// vendor api section -end

export default {
  LOGIN_API_PATH,
  ACCOUNT_API_PATH,
  CREATE_ACCOUNT_API_PATH,
  EQUIPMENT_API_PATH,

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

  TEAM_LOCATION_API_PATH,
  TEAM_BY_LOCATION_ID_API_PATH,
  LOCATION_UPDATE_API_PATH,
  TEAM_LOCATION_CREATE_API_PATH,

  VENDOR_API_PATH
};