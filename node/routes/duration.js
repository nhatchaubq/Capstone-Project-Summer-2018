var router = require("express").Router();
var TYPES = require("tedious").TYPES;
router.get("/", (request, response) => {
  request
    .sql(
      "SELECT * From [MaintenanceDuration] order by Months asc for json path"
    )
    .into(response);
});

router.post("/createDuration", (request, response) => {
  request
    .sql("INSERT INTO MaintenanceDuration (Months) VALUES (@month)")
    .param("month", request.body.newDuration.month, TYPES.Int)
    .exec(response);
});

router.put("/editDuration", (request, respone) => {
  request
    .sql(
      "Update [MaintenanceDuration] set Months = @month " +
        " where Id = @durationId"
    )
    .param("durationId", request.body.newDuration.id, TYPES.Int)
    .param("month", request.body.newDuration.month, TYPES.Int)
    .exec(respone);
});

router.delete("/deleteDuration/:id", (req, res) => {
  req
    .sql("delete from MaintenanceDuration where Id = @durationId")
    .param("durationId", req.params.id, TYPES.Int)
    .exec(res);
});

router.get("/getAllItems", (req, res) => {
  req
    .sql(
      "select distinct md.Id as 'DurationId',md.Months as 'Months'" +
        " from MaintenanceDuration as md join Equipment as e on md.Id = e.MaintenanceDurationID " +
        "							 join EquipmentItem as ei on ei.EquipmentID = e.Id " +
        " for json path "
    )
    .into(res);
});
module.exports = router;
