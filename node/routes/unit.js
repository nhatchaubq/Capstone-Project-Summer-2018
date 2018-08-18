var router = require("express").Router();
var TYPES = require("tedious").TYPES;
router.get("/", (request, response) => {
  request
    .sql("SELECT * From [Unit] order by Name asc for json path")
    .into(response);
});

router.post("/", (request, response) => {
  request
    .sql("INSERT INTO Unit (Name) VALUES (@name)")
    .param("name", request.body.name, TYPES.NVarChar)
    .exec(response);
});

router.post("/createUnit", (request, response) => {
  request
    .sql("INSERT INTO Unit (Name) VALUES (@name)")
    .param("name", request.body.newUnit.name, TYPES.NVarChar)
    .exec(response);
});

router.put("/editUnit", (request, respone) => {
  request
    .sql("Update [Unit] set Name = @name " + " where Id = @unitId")
    .param("unitId", request.body.newUnit.id, TYPES.Int)
    .param("name", request.body.newUnit.name, TYPES.NVarChar)
    .exec(respone);
});

router.delete("/deleteUnit/:id", (req, res) => {
  req
    .sql("delete from Unit where Id = @unitId")
    .param("unitId", req.params.id, TYPES.Int)
    .exec(res);
});

router.get("/getAllItems", (req, res) => {
  req
    .sql(
      "select distinct u.Id as 'UnitId',u.Name as 'UnitName'" +
        " from Unit as u join Equipment as e on u.Id = e.UnitID " +
        "							 join EquipmentItem as ei on ei.EquipmentID = e.Id " +
        " for json path "
    )
    .into(res);
});
module.exports = router;
