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
    .sql(
      "delete from TeamLocation where LocationID = @locationId and TeamID not in( " +
        "select distinct tl.TeamID " +
        "from TeamLocation as tl join WorkOrder as wo on tl.Id = wo.TeamLocationID " +
        "where tl.LocationID = @locationId)"
    )
    .param("locationId", req.params.id, TYPES.Int)
    .exec(res);
});

router.put("/updateLocation", (req, res) => {
  req
    .sql(
      "Update [Location] set Name = @name,Address = @address,Description = @description " +
        "where Id = @locationId"
    )

    .param("locationId", req.body.newLocation.id, TYPES.Int)
    .param("name", req.body.newLocation.name, TYPES.NVarChar)
    .param("address", req.body.newLocation.address, TYPES.NVarChar)
    .param("description", req.body.newLocation.description, TYPES.NVarChar)
    .exec(res);
});

router.put('/update_location_floor_plan/:locationId', (req, res) => {
  req.sql('update [Location] set [Image] = @imageUrl where Id = @locationId')
    .param('locationId', req.params.locationId, TYPES.Int)
    .param('imageUrl', req.body.imageUrl, TYPES.VarChar)
    .exec(res);
});

router.get("/floor_block_tile/:locationId", (req, res) => {
  req
    .sql("select lo.*, (select bl.*, (select fl.*, (select ti.* " +
      "      from Tile as ti " +
      "       where ti.FloorID = fl.Id " +
      "       for json path) as [Tiles] " +
      " from [Floor] as fl " +
      " where fl.BlockID = bl.Id " +
      " for json path) as [Floors] " +
      " from [Block] as bl " +
      " where bl.LocationID = @locationId " +
      " for json path) as [Blocks] " +
      " from [Location] as lo " +
      " where lo.Id = @locationId " +
      " for json path, without_array_wrapper")
    .param("locationId", req.params.locationId, TYPES.Int)
    .into(res);
});

router.get("/:id", (req, res) => {
  req
    .sql(
      "select * from [Location] where Id = @id for json path, without_array_wrapper"
    )
    .param("id", req.params.id, TYPES.Int)
    .into(res);
});

router.post("/create", (request, response) => {
  request
    .sql(
      "insert into [Location]([Name],[Address],[Description],Longitude,Latitude) " +
        "values(@name, @address, @description, @longtitude, @latitude) " +
        "select(select SCOPE_IDENTITY()) as [NewLocationId] for json path, without_array_wrapper"
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
    .sql(
      "select l.*,(select tl.Id as 'TeamLocationId',t.Id,t.Name " +
        "				from TeamLocation as tl join Location as l on tl.LocationID = l.Id " +
        "											join Team as t on t.Id = tl.TeamID " +
        "	where tl.LocationID = @locationId for json path) as 'Team', (select COUNT(wo.Id) " +
        "	from TeamLocation as tl join Location as l on tl.LocationID = l.Id " +
        "	join WorkOrder as wo on tl.Id = wo.TeamLocationID " +
        "	where tl.LocationID = @locationId) as 'WorkOrderQuantity', (select distinct tl.Id, tl.TeamID " +
        "	from TeamLocation as tl join WorkOrder as wo on tl.Id = wo.TeamLocationID " +
        "	where tl.LocationID = @locationId for json path) as 'TeamWithWorkOrdering' " +
        "	from[Location] as l " +
        "	where l.Id = @locationId for json path"
    )
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