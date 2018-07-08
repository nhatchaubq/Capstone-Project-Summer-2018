var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/equipment", (req, res) => {
  req.sql("exec GetEquipmentForReport ").into(res);
});

router.get("/getCategory", (req, res) => {
  req
    .sql("select * from [EquipmentCategory] order by [Name] for json path")
    .into(res);
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

router.get("/getAvailableEquipment", (req, res) => {
  req.sql("exec GetAvailableEquipmentForReport").into(res);
});

router.get("/getMaintenanceCalendar", (req, res) => {
  req.sql("exec GetMaintainCalendarEquipmentForReport").into(res);
});

router.get("/getWorkorderOverview", (req, res) => {
  req.sql("exec GetWorkOrderOverviewForReport ").into(res);
});

router.get("/getLateWorkorder", (req, res) => {
  req.sql("exec [GetLateWorkorderForReport]").into(res);
});

router.get("/getClosedWorkorder", (req, res) => {
  req.sql("exec GetClosedWorkorderForReport").into(res);
});

module.exports = router;
