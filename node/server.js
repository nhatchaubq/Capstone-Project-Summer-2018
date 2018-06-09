const express = require('express');
const bodyParser = require('body-parser');
const tediousExpress = require('express4-tedious');
const cors = require('cors');

var server = express();
server.use(cors());

var connection = {
    server: "localhost",
    userName: "sa",
    password: "123456",
    port: "1433",
    options: {
        // instanceName : "SQLEXPRESS",
        encrypt: true,
        database: "EquipmentManageSystem"
    }
};

server.use(function (request, respones, next) {
    request.sql = tediousExpress(connection);
    respones.header('Access-Control-Allow-Origin', '*');
    respones.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
    next();
});

// server.use(bodyParser.text());
server.use(bodyParser.json());
server.use('/api/login', require('./routes/login'));
server.use('/api/account', require('./routes/account'));
server.use('/api/equipment', require('./routes/equipment'));
server.use('/api/work_order', require('./routes/work_order'));
server.use('/api/location',require('./routes/location'));

// catch 404 and forward to error handler
server.use(function (req, res, next) {
    var err = new Error('Not Found: ' + req.method + ":" + req.originalUrl);
    err.status = 404;
    next(err);
});

server.listen(3000, () => {
    console.log('listening on port 3000');
});