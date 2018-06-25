var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/", (request, response) => {
  request
    .sql(
      "Select * From [Location] as l order by l.[Name] desc " + "for json path"
    )
    .into(response);
});

router.delete("/deleteTeamWithoutWO/:id", (req, res) => {
  req
    .sql("exec DeleteTeamLocationWithoutWorkOrderByLocationId @locationId")
    .param("locationId", req.params.id, TYPES.Int)
    .exec(res);
});

router.put("/edit", (req, res) => {
  req
    .sql("exec EditLocation @locationId,@name,@address,@description")

    .param("locationId", req.body.newLocation.id, TYPES.Int)
    .param("name", req.body.newLocation.name, TYPES.NVarChar)
    .param("address", req.body.newLocation.address, TYPES.NVarChar)
    .param("description", req.body.newLocation.description, TYPES.NVarChar)
    .exec(res);
});

router.post("/create", (request, response) => {
  request
    .sql(
      "exec CreateLocation @name,@address,@description,@longtitude,@latitude"
    )
    .param("name", request.body.newLocation.name, TYPES.NVarChar)
    .param("address", request.body.newLocation.address, TYPES.NVarChar)
    .param("description", request.body.newLocation.description, TYPES.NVarChar)
    .param("longtitude", request.body.newLocation.longtitude, TYPES.Float)
    .param("latitude", request.body.newLocation.latitude, TYPES.Float)
    .into(response);
});
router.get("/editLocation/:id", (request, response) => {
  request
    .sql("exec Get1LocationById @locationId")
    .param("locationId", request.params.id, TYPES.Int)
    .into(response);
});

router.get("/:id/team", (req, res) => {
  req
    .sql("exec GetTeamFromLocationId @locationId")
    .param("locationId", req.params.id, TYPES.Int)
    .into(res);
});

module.exports = router;
