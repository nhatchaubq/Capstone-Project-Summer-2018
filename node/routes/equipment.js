var router = require("express").Router();
var TYPES = require("tedious").TYPES;

// router.get("/", (request, response) => {
//   request.sql("exec GetEquipments").into(response);
// });
/*Get ALL EQT*/
router.get("/", (request, response) => {
  request
    .sql(
      "SELECT e.Id as 'Equipment.Id', e.Name as 'Equipment.Name', " +
      "e.Image  as 'Equipment.Image', e.MadeIn as 'Equipment.MadeIn', " +
      "e.Description as 'Equipment.Description', e.VendorID as 'Equipment.VendorId', " +
      "v.BusinessName as 'Equipment.Vendor.Name', e.CategoryID as 'Equipment.CategoryId', e.Status as 'Equipment.Status', " +
      "u.[Name] as [Equipment.Unit.Name], e.UnitID as 'Equipment.UnitId', " +
      "md.[Months] as [Equipment.MaintenanceDuration.Month], e.MaintenanceDurationID as 'Equipment.MaintenanceDurationId', " +
      "ec.Name as 'Equipment.Category.Name', (select count(Id)  from EquipmentItem where EquipmentID = e.Id) as [Equipment.Quantity], " +
      "(select count(Id) from EquipmentItem as ei where EquipmentID = e.Id and ei.StatusId = (select Id from EquipmentStatus where [Name] = N'Available')) as [Equipment.AvailableQuantity], " +
      "(select count(Id) from EquipmentItem as ei where EquipmentID = e.Id and ei.StatusId = (select Id from EquipmentStatus where [Name] = N'Working Approved')) as [Equipment.WorkingApprovedQuantity] " +
      "FROM [Equipment] as e " +
      "JOIN [Vendor] as v ON e.VendorID = v.Id " +
      "JOIN [EquipmentCategory] as ec ON e.CategoryID = ec.Id " +
      "JOIN [Unit] as u on e.UnitID = u.Id " +
      "JOIN [MaintenanceDuration] as md on e.MaintenanceDurationID = md.Id " +
      "Order by e.Status desc,e.Name asc " +
      "for json path"
    )
    .into(response);
});
/*GET an Eqt by ID*/
router.get("/:id", (request, response) => {
  request
    .sql(
      "SELECT e.Id as 'Equipment.Id', e.Name as 'Equipment.Name', " +
      "e.Image  as 'Equipment.Image', e.MadeIn as 'Equipment.MadeIn', " +
      "e.Description as 'Equipment.Description', e.VendorID as 'Equipment.VendorId', e.Status as 'Equipment.Status', " +
      "v.BusinessName as 'Equipment.Vendor.Name', e.CategoryID as 'Equipment.CategoryId',  " +
      "ec.Name as 'Equipment.Category.Name', e.UnitID as 'Equipment.UnitID', unit.Name as 'Equipment.Unit.Name',e.MaintenanceDurationID as 'Equipment.MaintenanceDurationID', duration.Months as 'Equipment.MaintenanceDuration.Months' , (select count(Id)  from EquipmentItem where EquipmentID = e.Id) as [Equipment.Quantity], " +
      "(select count(Id) from EquipmentItem as ei where EquipmentID = e.Id and ei.StatusId = 1) as [Equipment.AvailableQuantity], " +
      "(select count(Id) from EquipmentItem as ei where EquipmentID = e.Id and ei.StatusId = 2) as [Equipment.NotAvailableQuantity], " +
      "(select * from EquipmentItem where EquipmentID = e.Id for json path) as [Equipment.EquipmentItems] " +
      "FROM [Equipment] as e " +
      "JOIN [Vendor] as v ON e.VendorID = v.Id " +
      "JOIN [EquipmentCategory] as ec ON e.CategoryID = ec.Id " +
      "JOIN [Unit] as unit ON e.UnitID = unit.Id " +
      "JOIN [MaintenanceDuration] as duration ON e.MaintenanceDurationID = duration.Id " +
      "where e.Id = @id " +
      "for json path"
    )
    .param("id", request.params.id, TYPES.Int)
    .into(response);
});

router.get("/search/:value", (req, res) => {
  req
    .sql("  SELECT distinct e.Id, e.Name as [EquipmentName] " +
      " FROM Equipment as e  " +
      "JOIN [Vendor] as v ON e.VendorID = v.Id " +
      "JOIN [EquipmentCategory] as ec ON e.CategoryID = ec.Id " +
      "JOIN [Unit] as u on e.UnitID = u.Id " +
      "JOIN [MaintenanceDuration] as md on e.MaintenanceDurationID = md.Id " +
      " WHERE e.[Name] like N'%' + @searchText + '%' or v.[BusinessName] like N'%' + @searchText + '%' or e.[MadeIn] like N'%' + @searchText + '%' " +
      "     or convert(nvarchar(max), e.Id) = @searchText or ec.[Name] like N'%' + @searchText + '%' " +
      " order by e.Name desc" +
      " for json path")
    .param("searchText", req.params.value, TYPES.NVarChar)
    .into(res);
});
router.get("/searchLeaderEquipment/:value", (req, res) => {
  req
    .sql(" select distinct wo.*,t.Name as 'Team' ,ws.Name as 'Status',wc.Name as 'Category', loca.Name as [Location], loca.Id as [LocationID],(select distinct e.Id,e.Name,e.Image,wd.WorkOrderID,wd.ClosedDate , ei.SerialNumber as [SerialNumber], " +
      "   ei.Id as [EquipmentItemID], ei.TileID as [TileID], tile.Name as [Tile], floor.Id as [FloorID], floor.Name as [Floor] ,block.Id as [BlockID], block.Name as [Block], l.Id as [LocationID], l.Name as [Location] " +
      "   from WorkOrderDetail as wd join EquipmentItem as ei on wd.EquipmentItemID = ei.Id " +
      "   join Equipment as e on e.Id = ei.EquipmentID " +
      "   join Tile as tile on tile.Id = ei.TileID " +
      "   join Floor as floor on floor.Id = tile.FloorID " +
      "   join Block as block on block.Id = floor.BlockID " +
      "   join Location as l on l.Id = block.LocationID " +
      "   where wd.WorkOrderID = wo.Id and (wd.ClosedDate is null) for json path) as 'WorkorderDetail' " +
      " from WorkOrder as wo join TeamLocation as tl on tl.Id = wo.TeamLocationID " +
      " join Team as t on t.Id = tl.TeamId " +
      " join Location as loca on loca.Id = tl.LocationID " +
      " join WorkOrderDetail as wd on wo.Id = wd.WorkOrderID " +
      " join EquipmentItem as ei on wd.EquipmentItemID = ei.Id " +
      "   join Equipment as e on e.Id = ei.EquipmentID " +
      " join WorkOrderStatus as ws on ws.Id = wo.StatusID " +
      " join Account as acc on acc.Id = wo.RequestUserID " +
      " join WorkOrderCategory as wc on wc.Id = wo.CategoryID						  " +
      " where (ws.Name = 'In Progress') AND  " +
      "       e.[Name] like N'%' + @searchText + '%' or ws.[Name] like N'%' + @searchText + '%' or loca.[Name] like N'%' + @searchText + '%' " +
      "       or convert(nvarchar(max), e.Id) = @searchText or ei.[SerialNumber] like N'%' + @searchText + '%' " +
      " order by wo.CreateDate asc  " +
      "  for json path ")
    .param("searchText", req.params.value, TYPES.NVarChar)
    .into(res);
});
// /*Get Equipment BY ID*/
// router.get("/:id", (request, response) => {
//   request
//     .sql("exec GetEquipmentByID @id")
//     .param("id", request.params.id, TYPES.Int)
//     .into(response);
// });

/* GET request, get EquipmentByName */
router.get("/byName/:equipmentName", function (request, response) {
  request
    .sql(
      "SELECT * from Equipment where Name = @equipmentName for json path, without_array_wrapper"
    )
    .param("equipmentName", request.params.equipmentName, TYPES.NVarChar)
    .into(response);
});

// chaubqn
router.get('/getItemsByStatus/:status', function(req, res) {
  req.sql(" select e.*, json_query((select ei.*, json_query((select [tile].[Name] as [Tile], [floor].[Name] as [Floor], [block].[Name] as [Block], [location].[Name] as [Location.Name], [location].[Address] as [Location.Address] "
        + "                                                 from Tile as tile "
        + "                                                       join [Floor] as [floor] on tile.FloorID = [floor].Id "
        + "                                                       join [Block] as [block] on [floor].BlockID = [block].Id "
        + "                                                       join [Location] as [location] on [block].LocationID = [location].Id "
        + "                                                 where ei.TileID = tile.Id for json path, without_array_wrapper)) as [Position], "
        + "                                 json_query((select lo.[Name] as [Name], lo.[Address] as [Address] "
        + "                                             from [Location] as lo join EquipmentItem as ei2 on lo.Id = ei2.WarehouseID "
        + "                                             where ei2.Id = ei.Id "
        + "                                             for json path, without_array_wrapper)) as [Warehouse] "
        + "                         from EquipmentItem as ei  "
        + "                         where ei.EquipmentID = e.Id and ei.StatusId = (select Id from EquipmentStatus where [Name] = @status) "
        + "                         for json path)) as [EquipmentItems] "
        + " from Equipment as e "
        + " where e.Status = 1 "
        + " for json path")
        .param('status', req.params.status, TYPES.NVarChar)
        .into(res);
});

/* GET request, get EquipmentByName and vendorName */
router.get("/:equipmentId/:vendorId", function (request, response) {
  request
    .sql(
      "SELECT count(e.Id) as [Quantity] " +
      "FROM [Equipment] as e " +
      "JOIN [Vendor] as v ON e.VendorID = v.Id " +
      "where e.Id = @equipmentId and v.Id = @vendorId for json path, without_array_wrapper"
    )
    .param("equipmentId", request.params.equipmentId, TYPES.Int)
    .param("vendorId", request.params.vendorId, TYPES.Int)
    .into(response);
});
/* POST request, for insert */
router.post("/", (request, response) => {
  request
    .sql(
      "INSERT INTO Equipment (Name, VendorID, Image, MadeIn, Description, CategoryID, UnitID, MaintenanceDurationID, Status)" +
      " VALUES (@name, @vendorID, @image, @madein, @description, @categoryID, @unitID, @maintenanceDurationID, 'True')"
    )
    .param("name", request.body.name, TYPES.NVarChar)
    .param("vendorID", request.body.vendorID, TYPES.Int)
    .param("image", request.body.image, TYPES.NVarChar)
    .param("madein", request.body.madein, TYPES.NVarChar)
    .param("description", request.body.description, TYPES.NVarChar)
    .param("categoryID", request.body.categoryID, TYPES.Int)
    .param("unitID", request.body.unitID, TYPES.Int)
    .param("maintenanceDurationID", request.body.maintenanceDurationID, TYPES.Int)
    .exec(response);
});

/* PUT request, for update an Equipment */
router.put("/:id", function (request, response) {
  request
    .sql(
      "UPDATE [Equipment] set Name = @name, VendorID = @vendorid, Image=@image, MadeIn=@madein, Description=@description, CategoryID=@categoryid, UnitID=@unitid, MaintenanceDurationID=@maintenanceDurationid, Status = @status where Id = @id"
    )
    .param("id", request.params.id, TYPES.Int)
    .param("name", request.body.name, TYPES.NVarChar)
    .param("vendorid", request.body.vendorid, TYPES.Int)
    .param("image", request.body.image, TYPES.NVarChar)
    .param("madein", request.body.madein, TYPES.NVarChar)
    .param("categoryid", request.body.categoryid, TYPES.Int)
    .param("description", request.body.description, TYPES.NVarChar)
    .param("unitid", request.body.unitid, TYPES.Int)
    .param("maintenanceDurationid", request.body.maintenanceDurationid, TYPES.Int)
    .param("status", request.body.status, TYPES.Bit)

    .exec(response);
});

module.exports = router;