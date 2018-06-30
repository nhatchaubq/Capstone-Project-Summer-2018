var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/equipment", (req, res) => {
  req.sql("exec GetEquipmentForReport ").into(res);
});

router.get("/getEquipmentOverview", (req, res) => {
  req.sql("exec GetEquipmentOverviewForReport").into(res);
});

router.get("/getUsingEquipment", (req, res) => {
  req.sql("exec GetUsingEquipmentForReport").into(res);
});

router.get("/getStatusEquipment", (req, res) => {
  req.sql("exec GetEquipmentStatusForReport").into(res);
});

router.get("/getMaintenanceCalendar", (req, res) => {
  req.sql("exec GetMaintainCalendarEquipmentForReport").into(res);
});

module.exports = router;
