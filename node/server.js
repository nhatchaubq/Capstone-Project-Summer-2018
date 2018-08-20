var app = require("express")();
const bodyParser = require("body-parser");
const tediousExpress = require("express4-tedious");
const cors = require("cors");
const fs = require("fs");

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

  password: "tien1005",

  port: "1433",
  options: {
    // instanceName : "SQLEXPRESS",
    encrypt: true,
    database: "EquipmentManageSystem",
    trustedConnection: true
  }
};

app.use(bodyParser.json());

app.use(function(request, respones, next) {
  request.sql = tediousExpress(connection);
  // respones.header('Access-Control-Allow-Origin', '*');
  // respones.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
  next();
});

var server = app.listen(3000, () => {
  console.log("listening on port 3000");
});

var io = require("socket.io")(server);
io.on("connection", function (socket) {
  socket.emit("WEB_CONFIG", require("./web_config/config.json"));
  socket.on("NEW_WORK_ORDER_CREATED", function (data) {
    socket.broadcast.emit("NEW_WORK_ORDER_CREATED", data);
  });
  socket.on("NEW_NOTIFICATION", function(data) {
    socket.broadcast.emit("NEW_NOTIFICATION", data);
  });
  socket.on("ORDER_STATUS_CHANGED", function(data) {
    socket.broadcast.emit("ORDER_STATUS_CHANGED", data);
  });
  socket.on("CLOSE_WORK_ORDER_DETAIL", function(data) {
    socket.broadcast.emit("ORDER_STATUS_CHANGED", data);
  });
  socket.on("CONFIGURATION_CHANGED", function(data) {
    fs.writeFile(
      "./web_config/config.json",
      JSON.stringify(data, null, 4),
      "utf8",
      function(err) {
        if (err) {
          return console.log(err);
        }
        socket.broadcast.emit("WEB_CONFIG", data);
        console.log("new config saved");
      }
    );
  });
});

// server.use(bodyParser.text());
app.use(bodyParser.json());
app.use("/api/login", require("./routes/login"));
app.use("/api/account", require("./routes/account"));
app.use("/api/account/id", require("./routes/accountDetail"));
app.use("/api/equipment", require("./routes/equipment"));
app.use("/api/EquipmentCategory", require("./routes/EquipmentCategory"));
app.use("/api/duration", require("./routes/duration"));
app.use("/api/equipmentItemHistory", require("./routes/equipmentItemHistory"));
app.use("/api/Vendor", require("./routes/vendor"));
app.use("/api/work_order", require("./routes/work_order"));
app.use("/api/location", require("./routes/location"));
app.use("/api/EquipmentStatus", require("./routes/EquipmentStatus"));
app.use("/api/role", require("./routes/accountRole"));
app.use("/api/AllAccExceptThatTeam", require("./routes/AllAccExceptThatTeam"));
app.use("/api/team", require("./routes/team"));
app.use("/api/equipmentItem", require("./routes/equipmentItem"));
app.use("/api/team_location", require("./routes/team_location"));
app.use("/api/team_account", require("./routes/team_account"));
app.use("/api/team/id", require("./routes/teamDetails"));
app.use("/api/dashboard", require("./routes/dashBoard"));
app.use(
  "/api/allaccwithout",
  require("./routes/AllAccWithoutMaintainerAndAdmin")
);
app.use("/api/changeYourPass", require("./routes/changeYourPass"));

app.use("/api/report", require("./routes/report"));
app.use("/api/block", require("./routes/block"));
app.use("/api/floor", require("./routes/floor"));
app.use("/api/tile", require("./routes/tile"));
app.use("/api/unit", require("./routes/unit"));
app.use("/api/maintenanceDuration", require("./routes/maintenanceDuration"));
app.use("/api/notification", require("./routes/notification"));
app.use("/api/map", require("./routes/map"));

// app.use('/api/account/edit/id', require('./routes/account'));
// app.use('/api/account', require('./routes/account'));
// app.use('/api/account/delete/id', require('./routes/'));

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error("Not Found: " + req.method + ":" + req.originalUrl);
  err.status = 404;
  next(err);
});
