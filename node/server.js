var app = require('express')();
const bodyParser = require("body-parser");
const tediousExpress = require("express4-tedious");
const cors = require("cors");

// server.listen(80);
// io.on('connection', function (socket) {
//   socket.emit('news', { hello: 'world' });
//   socket.on('my other event', function (data) {
//     console.log(data);
//   });
// });

app.use(cors());

var connection = {
  server: "localhost",
  userName: "sa",

  password: "cCS94@bcnq836894",

  port: "1433",
  options: {
    // instanceName : "SQLEXPRESS",
    encrypt: true,
    database: "EquipmentManageSystem",
    trustedConnection: true
  }
};

app.use(bodyParser.json());

<<<<<<< HEAD
server.use(function (request, respones, next) {
=======
app.use(function (request, respones, next) {
>>>>>>> d9eeb6d73ce16e04428b482ed3a8957cce081f4a
  request.sql = tediousExpress(connection);
  // respones.header('Access-Control-Allow-Origin', '*');
  // respones.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
  next();
});

var server = app.listen(3000, () => {
  console.log("listening on port 3000");
});

var io = require('socket.io')(server);

// server.use(bodyParser.text());
app.use(bodyParser.json());
app.use("/api/login", require("./routes/login"));
app.use("/api/account", require("./routes/account"));
app.use("/api/account/id", require("./routes/accountDetail"));
app.use("/api/equipment", require("./routes/equipment"));
app.use("/api/EquipmentCategory", require("./routes/EquipmentCategory"));
app.use(
  "/api/equipmentItemHistory",
  require("./routes/equipmentItemHistory")
);
app.use("/api/Vendor", require("./routes/vendor"));
app.use("/api/work_order", require("./routes/work_order")(io));
app.use("/api/location", require("./routes/location"));
app.use("/api/EquipmentStatus", require("./routes/EquipmentStatus"));
app.use("/api/role", require("./routes/accountRole"));
app.use(
  "/api/AllAccExceptThatTeam",
  require("./routes/AllAccExceptThatTeam")
);
<<<<<<< HEAD
server.use("/api/team", require("./routes/team"));
server.use("/api/equipmentItem", require("./routes/equipmentItem"));
server.use("/api/team_location", require("./routes/team_location"));
server.use("/api/team_account", require("./routes/team_account"));
server.use("/api/team/id", require("./routes/teamDetails"));
server.use("/api/dashboard", require("./routes/dashBoard"));
server.use("/api/allaccwithout", require("./routes/AllAccWithoutMaintainerAndAdmin"));

=======
app.use("/api/team", require("./routes/team"));
app.use("/api/equipmentItem", require("./routes/equipmentItem"));
app.use("/api/team_location", require("./routes/team_location"));
app.use("/api/team_account", require("./routes/team_account"));
app.use("/api/team/id", require("./routes/teamDetails"));
app.use("/api/dashboard", require("./routes/dashBoard"));
>>>>>>> d9eeb6d73ce16e04428b482ed3a8957cce081f4a

app.use("/api/report", require("./routes/report"));
app.use("/api/block", require("./routes/block"));
app.use("/api/floor", require("./routes/floor"));
app.use("/api/tile", require("./routes/tile"));
app.use("/api/unit", require("./routes/unit"));

app.use("/api/notification", require("./routes/notification")(io));

// app.use('/api/account/edit/id', require('./routes/account'));
// app.use('/api/account', require('./routes/account'));
// app.use('/api/account/delete/id', require('./routes/'));

// catch 404 and forward to error handler
<<<<<<< HEAD
server.use(function (req, res, next) {
=======
app.use(function (req, res, next) {
>>>>>>> d9eeb6d73ce16e04428b482ed3a8957cce081f4a
  var err = new Error("Not Found: " + req.method + ":" + req.originalUrl);
  err.status = 404;
  next(err);
});
<<<<<<< HEAD

server.listen(3000, () => {
  console.log("listening on port 3000");
});
=======
>>>>>>> d9eeb6d73ce16e04428b482ed3a8957cce081f4a
