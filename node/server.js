var app = require("express")();
const bodyParser = require("body-parser");
const tediousExpress = require("express4-tedious");
const cors = require("cors");
const fs = require("fs");
//tien
var request = require('request');
const format = require('node.date-time');
const moment = require("moment");
const cron = require("node-cron");
const express = require("express");
let nodemailer = require("nodemailer");
let overdueWWO = [];
let nearExpectWO = [];
var account = [];
var emails = [];
var user = {
  username: "",
  email: "",
  fullname: ""
}
// server.listen(80);
// io.on('connection', function (socket) {
//   socket.emit('news', { hello: 'world' });
//   socket.on('my other event', function (data) {
//     console.log(data);
//   });
// });
let transporter = nodemailer.createTransport({
  service: 'Gmail',
  port: 587,
  secure: false, // true for 465, false for other ports
  auth: {
    user: 'tiennt1005@gmail.com', // generated ethereal user
    pass: 'tien1005' // generated ethereal password
  },
  tls: {
    rejectUnauthorized: false
  }
});

cron.schedule("30 19 * * *", function () {
  console.log("---------------------");
  console.log("Running Cron Job");
  for (var i = 0; i < account.length; i++) {
    var textWO = "";
    var content =
      " <p>Dear Mr/Mrs " + account[i] + "</p>" +
      " <p>Anh/chị có một số workorder mượn đồ của cty đã quá hạn trả. Anh/chị vui lòng trả về cho cty nhanh chóng. Xin cảm ơn anh/chị.</p> " +
      " <p>Các work order gồm: </p> " +
      " <div style='padding-left: 20px; font-size:16px'> ";
    for (var j = 0; j < overdueWWO.length; j++) {
      if (overdueWWO[j].RequestUsername == account[i]) {

        textWO = textWO + overdueWWO[j].Name + "\n";
        content = content.concat("<p style='color:red;'>" + overdueWWO[j].Name + "</p>");
      }
    }
    content = content.concat("</div>");
    if (textWO != "") {
      let mailOptions = {
        from: "tiennt1005@gmail.com",
        to: emails[i],
        subject: `WorkOrder trễ hạn`,
        text: '',
        html: content
      };
      transporter.sendMail(mailOptions, function (error, info) {
        if (error) {
          throw error;
        } else {
          console.log("Email successfully sent!");
        }
      });
    }
  }
  for (var i = 0; i < account.length; i++) {
    var textWO = "";
    var content =
      " <p>Dear Mr/Mrs " + account[i] + "</p>" +
      " <p>Anh/chị có một số workorder mượn đồ của cty đã gần tới hạn trả. Anh/chị vui lòng thu xếp trả về cty nhanh chóng. Xin cảm ơn anh/chị.</p> " +
      " <p>Các work order gồm: </p> " +
      " <div style='padding-left: 20px; font-size:16px'> ";
    for (var j = 0; j < nearExpectWO.length; j++) {
      if (nearExpectWO[j].RequestUsername == account[i]) {

        textWO = textWO + nearExpectWO[j].Name + "\n";
        content = content.concat("<p style='color:red;'>" + nearExpectWO[j].Name + "</p>");
      }
    }
    content = content.concat("</div>");

    if (textWO != "") {
      let mailOptions = {
        from: "tiennt1005@gmail.com",
        to: emails[i],
        subject: `WorkOrder tới hạn`,
        text: '',
        html: content
      };
      transporter.sendMail(mailOptions, function (error, info) {
        if (error) {
          throw error;
        } else {
          console.log("Email successfully sent!");
        }
      });
    }
  }
});
app.use(cors());

var connection = {
  server: "localhost",
  userName: "sa",
  password: "123456",
  connectionTimeout: 300000,
  requestTimeout: 300000,
  pool: {
    idleTimeoutMillis: 300000,
    max: 100
  },

  port: "1433",
  options: {
    // instanceName : "SQLEXPRESS",
    encrypt: true,
    database: "EquipmentManageSystem",
    trustedConnection: true,
    requestTimeout: 700000
  },
};

app.use(bodyParser.json());

app.use(function (request, respones, next) {
  request.sql = tediousExpress(connection);
  // respones.header('Access-Control-Allow-Origin', '*');
  // respones.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
  next();
});

var server = app.listen(3000, () => {
  console.log("listening on port 3000");
});

var io = require("socket.io")(server);
var options = {
  url: 'http://localhost:3000/api/work_order',
  headers: {
    'User-Agent': 'request'
  }
};

function callback(error, response, body) {
  var today = moment().format();
  if (!error && response.statusCode == 200) {
    var info = JSON.parse(body);
    var WOArray = info.WorkOrders;
    var duplicate = 0;
    for (var i = 0; i < WOArray.length; i++) {
      duplicate = 0;
      var expect_date = moment(WOArray[i].ExpectingCloseDate, 'YYYY-MM-DD HH:mm:ss');
      var duration = moment(expect_date).diff(today, 'days');
      if (WOArray[i].WorkOrderStatus == 'In Progress' && today > WOArray[i].ExpectingCloseDate) {
        overdueWWO.push(WOArray[i]);
      }
      if (WOArray[i].WorkOrderStatus == 'In Progress' && duration < 3 && duration >= 0) {
        nearExpectWO.push(WOArray[i]);
      }
      for (var j = 0; j < account.length; j++) {
        if (account[j] == WOArray[i].RequestUsername) {
          duplicate = duplicate + 1;
        }
      }
      if (duplicate == 0) {
        account.push(WOArray[i].RequestUsername);
        emails.push(WOArray[i].RequestUserEmail);
      }
    }
    // console.log(account)
  }
}
request(options, callback);

io.on("connection", function (socket) {
  socket.emit("WEB_CONFIG", require("./web_config/config.json"));
  socket.on("NEW_WORK_ORDER_CREATED", function (data) {

    socket.broadcast.emit("NEW_WORK_ORDER_CREATED", data);
  });
  socket.on("NEW_NOTIFICATION", function (data) {
    socket.broadcast.emit("NEW_NOTIFICATION", data);
  });
  socket.on("ORDER_STATUS_CHANGED", function (data) {
    socket.broadcast.emit("ORDER_STATUS_CHANGED", data);
  });
  socket.on("CLOSE_WORK_ORDER_DETAIL", function (data) {
    socket.broadcast.emit("ORDER_STATUS_CHANGED", data);
  });

  socket.on("CONFIGURATION_CHANGED", function (data) {

    fs.writeFile(
      "./web_config/config.json",
      JSON.stringify(data, null, 4),
      "utf8",

      function (err) {

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
app.use(function (req, res, next) {
  var err = new Error("Not Found: " + req.method + ":" + req.originalUrl);
  err.status = 404;
  next(err);
});