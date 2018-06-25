var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/", (request, response) => {
  request
    .sql(
      "Select * From [Location] as l order by l.[Name] desc " + "for json path"
    )
    .into(response);
});

router.get('/floor_block_tile/:locationId', (req, res) => {
  req.sql('exec [dbo].GetLocationBlockFloorTile @locationId')
    .param('locationId', req.params.locationId, TYPES.Int)
    .into(res);
});

router.get('/:id', (req, res) => {
  req.sql('select * from [Location] where Id = @id for json path, without_array_wrapper')
    .param('id', req.params.id, TYPES.Int)
    .into(res);
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
    .sql("exec EditLocationById @locationId")
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
