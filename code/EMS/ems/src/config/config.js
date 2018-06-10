const SERVER_DEFAULT = "http://localhost:3000/api";

// login api section - start
const LOGIN_API_PATH = SERVER_DEFAULT + "/login";
// login api section - end

// account api section - start
const ACCOUNT_API_PATH = SERVER_DEFAULT + "/account";
const CREATE_ACCOUNT_API_PATH = ACCOUNT_API_PATH + "/create";
// user api section - end

// equipment api section - start
const EQUIPMENT_API_PATH = SERVER_DEFAULT + "/equipment";
// equipment api section - end

// work order api section - start
const WORKORDER_API_PATH = SERVER_DEFAULT + "/work_order";
const WORKORDER_SEARCH_API_PATH = WORKORDER_API_PATH + '/search';
const WORKORDER_STATUS_API_PATH = WORKORDER_API_PATH + '/status';
const WORKORDER_PRIORITIES_API_PATH = WORKORDER_API_PATH + '/priorities';
// work order api section - end

export default {
  LOGIN_API_PATH,
  ACCOUNT_API_PATH,
  CREATE_ACCOUNT_API_PATH,
  EQUIPMENT_API_PATH,
  WORKORDER_API_PATH,
  WORKORDER_SEARCH_API_PATH,
  WORKORDER_STATUS_API_PATH,
  WORKORDER_PRIORITIES_API_PATH
};
