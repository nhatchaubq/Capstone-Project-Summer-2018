var router = require("express").Router();
var TYPES = require("tedious").TYPES;

// router.get('/', (request, response) => {
//     request.sql("exec GetEquipments")
//         .into(response);
// });

router.get("/chau/:id", (req, res) => {
    req
        .sql("exec GetEquipmentDetailById @id")
        .param("id", req.params.id, TYPES.Int)
        .into(res);
});
/*Count Quality Equipment Item of one Equipment*/
// router.get('/:id', (req, res) => {
//     req.sql('exec CountQualityItem @id')
//         .param('id', req.params.id, TYPES.Int)
//         .into(res);
// });

/* Get all Item of an equipment by EquipmentID */
router.get("/:id", (req, res) => {
    req
        .sql(
            "SELECT ei.ID, ei.EquipmentID, ei.SerialNumber, ei.Price,CONVERT(date, ImportDate) as [ImportDate], " +
            "CONVERT(date, LastMaintainDate) as [LastMaintainDate], CONVERT(date, NextMaintainDate) as [NextMaintainDate], " +
            "ei.WarrantyDuration, ei.RuntimeDays, es.Name as Status, ei.Description " +
            "From EquipmentItem as ei " +
            "JOIN EquipmentStatus as es ON ei.StatusId = es.Id " +
            "Where ei.EquipmentID = @id ORDER BY es.Name ASC " +
            "for json path"
        )
        .param("id", req.params.id, TYPES.Int)
        .into(res);
});
/* GET AN ITEM of an Equipment */
router.get("/Item/:id", (request, response) => {
    request
        .sql(
            "select (json_query((select  ei.Id,ei.SerialNumber, ei.Price, ei.WarrantyDuration, ei.RuntimeDays,CONVERT(date, ImportDate) as [ImportDate], es.Name as Status,es.Id as StatusID, " +
            "CONVERT(date, LastMaintainDate) as [LastMaintainDate], CONVERT(date, NextMaintainDate) as NextMaintainDate, ei.Description, tile.Name as [Tile], tile.Id as [TileID] , floor.Name as [FLoor] , floor.Id as [FloorID], " +
            "block.Name as [Block], block.Id as [BlockID], loca.Name as [Location], loca.Id as [LocationID], loca.Address as [Address] ,(select wo.* " +
            "from WorkOrder as wo " +
            "where wo.StatusID < 5 and wo.Id in (select wod.WorkOrderID " +
            "from WorkOrderDetail as wod " +
            "where wod.EquipmentItemID = (select ei.Id as [EquipmentItemId] " +
            "from EquipmentItem as ei " +
            "where ei.Id = @id)) " +
            "for json path) as [WorkOrders] " +
            "from EquipmentItem as ei " +
            "JOIN EquipmentStatus as es on es.Id = ei.StatusId " +
            "JOIN Tile as tile on tile.Id = ei.TileID " +
            "JOIN Floor as floor on floor.Id = tile.FloorID " +
            "JOIN Block as block on block.Id = floor.BlockID " +
            "JOIN Location as loca on loca.Id = block.LocationID " +
            "where ei.Id = @id for json path, without_array_wrapper)) " +
            ") as [Item] " +
            "for json path, without_array_wrapper"
        )
        .param("id", request.params.id, TYPES.Int)
        .into(response);
});

/* GET AN ITEM of an Equipment with LOST STT */
router.get("/Itemloststt/:id", (request, response) => {
    request
        .sql(
            "select (json_query((select  ei.Id,ei.SerialNumber, ei.Price, ei.WarrantyDuration, ei.RuntimeDays,CONVERT(date, ImportDate) as [ImportDate], es.Name as Status,es.Id as StatusID, " +
            "CONVERT(date, LastMaintainDate) as [LastMaintainDate], CONVERT(date, NextMaintainDate) as NextMaintainDate, ei.Description, ei.TileID as [TileID], (select wo.* " +
            "from WorkOrder as wo " +
            "where wo.StatusID < 5 and wo.Id in (select wod.WorkOrderID " +
            "from WorkOrderDetail as wod " +
            "where wod.EquipmentItemID = (select ei.Id as [EquipmentItemId] " +
            "from EquipmentItem as ei " +
            "where ei.Id = @id)) " +
            "for json path) as [WorkOrders] " +
            "from EquipmentItem as ei " +
            "JOIN EquipmentStatus as es on es.Id = ei.StatusId " +
            "where ei.Id = @id for json path, without_array_wrapper)) " +
            ") as [Item] " +
            "for json path, without_array_wrapper"
        )
        .param("id", request.params.id, TYPES.Int)
        .into(response);
});

/* GET all Work Order of an Item */
router.get("/allworkorder/:id", (req, res) => {
    req
        .sql(
            "select wo.Id, wo.Name, acc.Fullname as [RequestUser], wos.Name as [Status] " +
            "from WorkOrder as wo " +
            "JOIN WorkOrderStatus as wos on wo.StatusID = wos.Id " +
            "JOIN Account as acc on acc.Id = wo.RequestUserID " +
            "where wo.Id IN " +
            "(select wod.WorkOrderID " +
            "from WorkOrderDetail as wod " +
            "where wod.EquipmentItemID = @id) " +
            "order by wo.CreateDate desc " +
            "for json path"
        )
        .param("id", req.params.id, TYPES.Int)
        .into(res);
});
/* GET STT of an Item */
router.get("/sttItem/:id", (request, response) => {
    request
        .sql(
            "Select es.Name, es.Id From EquipmentItem as ei JOIN EquipmentStatus as es on es.Id = ei.StatusID Where ei.ID = @id for json path, without_array_wrapper"
        )
        .param("id", request.params.id, TYPES.Int)
        .into(response);
});
/* GET CloseDate in last work order detail of an item  */
router.get("/closedate/:id", (req, res) => {
    req
        .sql(
            "select wod.ClosedDate " +
            "from WorkOrderDetail as wod " +
            "where wod.EquipmentItemID = @id " +
            "for json path"
        )
        .param("id", req.params.id, TYPES.Int)
        .into(res);
});

/* POST request, for insert */
router.post("/", (request, response) => {
    request
        .sql(
            "INSERT INTO EquipmentItem (EquipmentID, SerialNumber, WarrantyDuration, RuntimeDays, Price, ImportDate, StatusId, Description, TileID)" +
            " VALUES (@equipmentID, @serialNumber, @warrantyDuration, 0, @price, GETDATE(), @statusId, @description, @tileID)"
        )
        .param("equipmentID", request.body.equipmentID, TYPES.Int)
        .param("serialNumber", request.body.serialNumber, TYPES.NVarChar)
        .param("warrantyDuration", request.body.warrantyDuration, TYPES.Int)
        .param("price", request.body.price, TYPES.Float)
        //.param('importDate', request.body.importDate, TYPES.DateTime)
        .param("statusId", request.body.statusId, TYPES.Int)
        .param("description", request.body.description, TYPES.NVarChar)
        .param("tileID", request.body.tileID, TYPES.Int)
        .exec(response);
    console.log(request.body);
});

// router.get("/:id/getByLocationId", (request, response) => {
//   request
//     .sql(
//       "select eqti.*,eqt.Name,eqt.Image from [EquipmentItem] as eqti join [Position] as pos on eqti.PositionID = pos.Id " +
//         "join [Equipment] as eqt on eqti.EquipmentID = eqt.ID " +
//         "where pos.LocationID = @locationId for json path"
//     )
//     .param("locationId", request.params.id, TYPES.Int)
//     .into(response);
// });

// router.get("/getByEquipmentId/:id", (request, response) => {
//   request
//     .sql(
//       "select distinct e.*, (select ei.* " +
//         " from EquipmentItem as ei join Tile as t on ei.TileID = t.Id  " +
//         "                          join [Floor] as f on t.FloorID = f.Id " +
//         "                          join [Block] as b on f.BlockID = b.Id " +
//         " where b.LocationID = @locationId and ei.EquipmentId =  [LocationEquipment].Id for JSON path) as [EquipmentItems] " +
//         " from Equipment as e, (select eqt.Id as [Id] " +
//         "            from EquipmentItem as ei join Tile as t on ei.TileID = t.Id  " +
//         "                          join [Floor] as f on t.FloorID = f.Id " +
//         "                          join [Block] as b on f.BlockID = b.Id " +
//         "                                    join Equipment as eqt on eqt.Id = ei.EquipmentID " +
//         "            where b.LocationID = @locationId) as [LocationEquipment] " +
//         " where e.Id = [LocationEquipment].Id " +
//         " for json path"
//     )
//     .param("locationId", request.params.id, TYPES.Int)
//     .into(response);
// });

// router.get("/:id/getByLocationId", (request, response) => {
//     request
//         .sql(
//             "select eqti.*,eqt.Name,eqt.Image from [EquipmentItem] as eqti join [Position] as pos on eqti.PositionID = pos.Id " +
//             "join [Equipment] as eqt on eqti.EquipmentID = eqt.ID " +
//             "where pos.LocationID = @locationId for json path"
//         )
//         .param("locationId", request.params.id, TYPES.Int)
//         .into(response);
// });

// router.get("/getByEquipmentId/:id", (request, response) => {
//     request
//         .sql("select distinct e.*, (select ei.* " +
//             " from EquipmentItem as ei join Tile as t on ei.TileID = t.Id  " +
//             "                          join [Floor] as f on t.FloorID = f.Id " +
//             "                          join [Block] as b on f.BlockID = b.Id " +
//             " where b.LocationID = @locationId and ei.EquipmentId =  [LocationEquipment].Id for JSON path) as [EquipmentItems] " +
//             " from Equipment as e, (select eqt.Id as [Id] " +
//             "            from EquipmentItem as ei join Tile as t on ei.TileID = t.Id  " +
//             "                          join [Floor] as f on t.FloorID = f.Id " +
//             "                          join [Block] as b on f.BlockID = b.Id " +
//             "                                    join Equipment as eqt on eqt.Id = ei.EquipmentID " +
//             "            where b.LocationID = @locationId) as [LocationEquipment] " +
//             " where e.Id = [LocationEquipment].Id " +
//             " for json path")
//         .param("locationId", request.params.id, TYPES.Int)
//         .into(response);
// });

router.get("/oldstt/:id", (request, response) => {
    request
        .sql(
            "select StatusId from EquipmentItem where Id = @id for json path, without_array_wrapper"
        )
        .param("id", request.params.id, TYPES.Int)
        .into(response);
});

/*Update Item TileID to Null when stt = lost*/
router.put("/tileId/:id", (req, res) => {
    req
        .sql(
            "update EquipmentItem set TileID = NULL where EquipmentItem.Id = @id; "
        )
        .param("id", req.params.id, TYPES.Int)
        .exec(res);
});

router.put("/status/:id", (req, res) => {
    req
        .sql(
            "declare @currentItemStatusId int; " +
            "set @currentItemStatusId = (select StatusId from EquipmentItem where Id = @itemId); " +
            "update EquipmentItem set StatusId = @newStatusId where Id = @itemId; " +
            "insert into EquipmentItemHistory(EquipmentItemID, ByUserID, OldStatusID, NewStatusID, [Date], [Description]) " +
            "values(@itemId, @userId, @currentItemStatusId, @newStatusId, getdate(), @description)"
        )
        .param("itemId", req.params.id, TYPES.Int)
        .param("userId", req.body.userId, TYPES.Int)
        .param("newStatusId", req.body.newStatusId, TYPES.NVarChar)
        .param("description", req.body.description, TYPES.NVarChar)
        .exec(res);
});

router.put("/:eid", (req, res) => {
    req
        .sql(
            "Update EquipmentItem " +
            "SET WarrantyDuration = @warrantyDuration, RuntimeDays = @runtimeDays, Price = @price, ImportDate = @importdate, " +
            "LastMaintainDate = @lastmaintaindate, NextMaintainDate =@nextmaintaindate, Description = @description " +
            "WHERE Id = @id"
        )
        .param("warrantyDuration", req.body.warrantyDuration, TYPES.Int)
        .param("runtimeDays", req.body.runtimeDays, TYPES.Int)
        .param("price", req.body.price, TYPES.Float)
        .param("importdate", req.body.importdate, TYPES.NVarChar)
        .param("lastmaintaindate", req.body.lastmaintaindate, TYPES.NVarChar)
        .param("nextmaintaindate", req.body.nextmaintaindate, TYPES.NVarChar)
        // .param("statusId", req.body.statusId, TYPES.Int)
        .param("description", req.body.description, TYPES.NVarChar)
        .param("tileID", req.body.tileID, TYPES.Int)
        .param("id", req.params.eid, TYPES.Int)
        .exec(res);
});

/* GET AN ITEM of an Equipment */

router.get("/Item/:id", (request, response) => {
    request
        .sql("exec GetAnItem @id")
        .param("id", request.params.id, TYPES.Int)
        .into(response);
});
/* POST request, for insert */
router.post("/", (request, response) => {
    request
        .sql(
            "INSERT INTO EquipmentItem (EquipmentID, SerialNumber, WarrantyDuration, RuntimeDays, Price, ImportDate, StatusId, Description, TileID)" +
            " VALUES (@equipmentID, @serialNumber, @warrantyDuration, 0, @price, GETDATE(), @statusId, @description, @tileID)"
        )
        .param("equipmentID", request.body.equipmentID, TYPES.Int)
        .param("serialNumber", request.body.serialNumber, TYPES.NVarChar)
        .param("warrantyDuration", request.body.warrantyDuration, TYPES.Int)
        .param("price", request.body.price, TYPES.Float)
        //.param('importDate', request.body.importDate, TYPES.DateTime)
        .param("statusId", request.body.statusId, TYPES.Int)
        .param("description", request.body.description, TYPES.NVarChar)
        .param("tileID", request.body.tileID, TYPES.Int)
        .exec(response);
});

router.get("/:id/getByLocationId", (request, response) => {
    request
        .sql(
            "select eqti.*,eqt.Name,eqt.Image from [EquipmentItem] as eqti join [Position] as pos on eqti.PositionID = pos.Id " +
            "join [Equipment] as eqt on eqti.EquipmentID = eqt.ID " +
            "where pos.LocationID = @locationId for json path"
        )
        .param("locationId", request.params.id, TYPES.Int)
        .into(response);
});

router.get("/getByEquipmentId/:id", (request, response) => {
    request
        .sql(
            "select distinct e.*, (select ei.* " +
            "                   from EquipmentItem as ei join Tile as t on ei.TileID = t.Id  " +
            " 						                    join[Floor] as f on t.FloorID = f.Id " +
            " 							                join[Block] as b on f.BlockID = b.Id " +
            " 	                where b.LocationID = @locationId and ei.EquipmentId = [LocationEquipment].Id for JSON path) as[EquipmentItems] " +
            " from Equipment as e, (select eqt.Id as [Id] " +
            "                       from EquipmentItem as ei join Tile as t on ei.TileID = t.Id " +
            "                                               join[Floor] as f on t.FloorID = f.Id " +
            "                                               join[Block] as b on f.BlockID = b.Id " +
            "                                               join Equipment as eqt on eqt.Id = ei.EquipmentID " +
            "                       where b.LocationID = @locationId) as [LocationEquipment] " +
            " where e.Id = [LocationEquipment].Id " +
            " for json path "
            // "exec [GetEquipmentItemByEquipmentIdAndLocationId] @locationId"
        )
        .param("locationId", request.params.id, TYPES.Int)
        .into(response);
});

// chau - update pos of equipment item
router.put("/position/tile/:itemId", (req, res) => {
    req
        .sql("update EquipmentItem set TileID = @tileId where Id = @itemId ")
        .param("itemId", req.params.itemId, TYPES.Int)
        .param("tileId", req.body.tileId, TYPES.Int)
        .exec(res);
});

module.exports = router;