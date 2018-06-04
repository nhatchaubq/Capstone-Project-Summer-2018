const SERVER_DEFAULT = 'http://localhost:3000/api';

// login api section - start
const LOGIN_API_PATH = SERVER_DEFAULT + '/login';
// login api section - end

// user api section - start
const USER_API_PATH = SERVER_DEFAULT + '/user'
const CREATE_USER_API_PATH = USER_API_PATH + '/create';
// user api section - end

// equipment api section - start
const EQUIPMENT_API_PATH = SERVER_DEFAULT + '/equipment';
// equipment api section - end

export default {
    LOGIN_API_PATH,
    USER_API_PATH,
    CREATE_USER_API_PATH,
    EQUIPMENT_API_PATH
}
