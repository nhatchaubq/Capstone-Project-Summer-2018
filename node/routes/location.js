var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/", (request, response) => {
  request
    .sql(
      "Select * From [Location] as l order by IsActive desc,Name asc " +
        "for json path"
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
      "Update [Location] set Name = @name,Address = @address,Description = @description,IsActive = @isActive " +
        "where Id = @locationId"
    )

    .param("locationId", req.body.newLocation.id, TYPES.Int)
    .param("name", req.body.newLocation.name, TYPES.NVarChar)
    .param("address", req.body.newLocation.address, TYPES.NVarChar)
    .param("description", req.body.newLocation.description, TYPES.NVarChar)
    .param("isActive", req.body.newLocation.isActive, TYPES.Bit)
    .exec(res);
});

router.put("/update_location_floor_plan/:locationId", (req, res) => {
  req
    .sql("update [Location] set [Image] = @imageUrl where Id = @locationId")
    .param("locationId", req.params.locationId, TYPES.Int)
    .param("imageUrl", req.body.imageUrl, TYPES.VarChar)
    .exec(res);
});

// ChauBQN
// Get block floor tile of a location
router.get("/floor_block_tile", (req, res) => {
  req
    .sql(
      "select lo.*, (select bl.*, (select fl.*, (select ti.* " +
        "                                             from Tile as ti " +
        "                                             where ti.FloorID = fl.Id " +
        "                                             for json path) as [Tiles] " +
        "                               from [Floor] as fl " +
        "                               where fl.BlockID = bl.Id " +
        "                               for json path) as [Floors] " +
        "                 from [Block] as bl " +
        "                 where bl.LocationID = lo.Id " +
        "                 for json path) as [Blocks] " +
        " from [Location] as lo " +
        " where lo.IsActive = 1 " +
        " for json path"
    )
    .into(res);
});

// ChauBQN
// Get block floor tile of a location
router.get("/floor_block_tile/:locationId", (req, res) => {
  req
    .sql(
      "select lo.*, (select bl.*, (select fl.*, (select ti.* " +
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
        " where lo.Id = @locationId and lo.IsActive = 1 " +
        " for json path, without_array_wrapper"
    )
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
      "insert into [Location]([Name],[Address],[Description],Longitude,Latitude,IsActive) " +
        "values(@name, @address, @description, @longtitude, @latitude,@isActive) " +
        "select(select SCOPE_IDENTITY()) as [NewLocationId] for json path, without_array_wrapper"
    )
    .param("name", request.body.newLocation.name, TYPES.NVarChar)
    .param("address", request.body.newLocation.address, TYPES.NVarChar)
    .param("description", request.body.newLocation.description, TYPES.NVarChar)
    .param("longtitude", request.body.newLocation.longtitude, TYPES.Float)
    .param("latitude", request.body.newLocation.latitude, TYPES.Float)
    .param("isActive", request.body.newLocation.isActive, TYPES.Bit)
    .into(response);
});

router.get("/editLocation/:id", (request, response) => {
  request
    .sql(
      "select l.*,(select tl.Id as 'TeamLocationId',t.Id,t.Name " +
        " from TeamLocation as tl join Location as l on tl.LocationID = l.Id " +
        " join Team as t on t.Id = tl.TeamID " +
        " where tl.LocationID = @locationId for json path) as 'Team', (select distinct tl.Id, tl.TeamID " +
        " from TeamLocation as tl join WorkOrder as wo on tl.Id = wo.TeamLocationID " +
        " join WorkOrderStatus as ws on ws.Id = wo.StatusID " +
        " where tl.LocationID = @locationId and ws.Name != 'Closed' and ws.Name != 'Cancelled'  for json path) as 'TeamWithWorkOrdering', " +
        " (select ei.Id " +
        "   from EquipmentItem as ei join Tile as t on ei.TileID = t.Id " +
        "   join[Floor] as f on f.Id = t.FloorID " +
        "   join[Block] as b on f.BlockID = b.Id " +
        "   where b.LocationID = @locationId	for json path) as 'Items' " +
        "   from[Location] as l " +
        " where l.Id = @locationId for json path"
    )
    // "exec Get1LocationById @locationId"
    .param("locationId", request.params.id, TYPES.Int)
    .into(response);
});

// ChauBQN
// get team of location for create work order
router.get("/:id/team/:userId", (req, res) => {
  req
    .sql(
      "select (json_query((select * from Team where Id = tl.TeamID for json path, without_array_wrapper))) as [Team] " +
        " from TeamLocation as tl join Team as t on tl.TeamID = t.Id join TeamAccount as ta on t.Id = ta.TeamID " +
        " where tl.LocationID = @locationId and ta.TeamRoleID = (select Id from TeamRoles where TeamRole = N'Leader') and ta.AccountID = @userId " +
        " for json path"
    )
    .param("locationId", req.params.id, TYPES.Int)
    .param("userId", req.params.userId, TYPES.Int)
    .into(res);
});

module.exports = router;
