const express = require("express");
const bodyParser = require("body-parser");
const tediousExpress = require("express4-tedious");
const cors = require("cors");

var server = express();
server.use(cors());

var connection = {
  server: "localhost",
  userName: "sa",
  password: "tien1005",
  port: "1433",
  options: {
    // instanceName : "SQLEXPRESS",
    encrypt: true,
    database: "EquipmentManageSystem",
    trustedConnection: true
  }
};

server.use(bodyParser.json());

server.use(function (request, respones, next) {
  request.sql = tediousExpress(connection);
  // respones.header('Access-Control-Allow-Origin', '*');
  // respones.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
  next();
});

// server.use(bodyParser.text());
server.use(bodyParser.json());
server.use("/api/login", require("./routes/login"));
server.use("/api/account", require("./routes/account"));
server.use("/api/account/id", require("./routes/accountDetail"));
server.use("/api/equipment", require("./routes/equipment"));
server.use("/api/EquipmentCategory", require("./routes/EquipmentCategory"));
server.use(
  "/api/equipmentItemHistory",
  require("./routes/equipmentItemHistory")
);
server.use("/api/Vendor", require("./routes/vendor"));
server.use("/api/work_order", require("./routes/work_order"));
server.use("/api/location", require("./routes/location"));
server.use("/api/EquipmentStatus", require("./routes/EquipmentStatus"));
server.use("/api/role", require("./routes/accountRole"));
server.use(
  "/api/AllAccExceptThatTeam",
  require("./routes/AllAccExceptThatTeam")
);
server.use("/api/team", require("./routes/team"));
server.use("/api/equipmentItem", require("./routes/equipmentItem"));
server.use("/api/team_location", require("./routes/team_location"));
server.use("/api/team_account", require("./routes/team_account"));
server.use("/api/team/id", require("./routes/teamDetails"));
server.use("/api/dashboard", require("./routes/dashBoard"));

server.use("/api/report", require("./routes/report"));
server.use("/api/block", require("./routes/block"));
server.use("/api/floor", require("./routes/floor"));
server.use("/api/tile", require("./routes/tile"));
server.use("/api/unit", require("./routes/unit"));

// server.use('/api/account/edit/id', require('./routes/account'));
// server.use('/api/account', require('./routes/account'));
// server.use('/api/account/delete/id', require('./routes/'));

// catch 404 and forward to error handler
server.use(function (req, res, next) {
  var err = new Error("Not Found: " + req.method + ":" + req.originalUrl);
  err.status = 404;
  next(err);
});

server.listen(3000, () => {
  console.log("listening on port 3000");
});