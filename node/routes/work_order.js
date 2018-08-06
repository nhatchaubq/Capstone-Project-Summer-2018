const router = require("express").Router();
const TYPES = require("tedious").TYPES;

router.get("/workorderbylocationId/:id", (request, response) => {
    request
        .sql(
            " select distinct wo.*,t.Name as 'Team' ,ws.Name as 'Status',wc.Name as 'Category',(select distinct e.Id,e.Name,e.Image,wd.WorkOrderID,wd.ClosedDate,(select wd.*,ei.SerialNumber,ei.EquipmentID " +
            " from WorkOrderDetail as wd join EquipmentItem as ei on wd.EquipmentItemID = ei.Id								 " +
            " 	where wd.WorkOrderID = wo.Id and ei.EquipmentID = e.Id for json path) as 'EquipmentItems' " +
            "   from WorkOrderDetail as wd join EquipmentItem as ei on wd.EquipmentItemID = ei.Id " +
            "   join Equipment as e on e.Id = ei.EquipmentID " +
            "   where wd.WorkOrderID = wo.Id  for json path) as 'WorkorderDetail' " +
            "   from WorkOrder as wo join TeamLocation as tl on tl.Id = wo.TeamLocationID " +
            " join Team as t on t.Id = tl.TeamId " +
            " join WorkOrderDetail as wd on wo.Id = wd.WorkOrderID " +
            " join WorkOrderStatus as ws on ws.Id = wo.StatusID " +
            " for json path"
            // "exec [GetWorkOrderByLocationId] @locationId"
        ).param("locationId", request.params.id, TYPES.Int)
        .into(response);
});
// ChauBQN
// Get work order info to edit
router.get('/id/:orderId', (request, response) => {
    request.sql("select wo.*, json_query((select lo.Id as [Id] " +
            "                               from [Location] as lo join TeamLocation as tl on lo.Id = tl.LocationID " +
            "                               where tl.Id = wo.TeamLocationID " +
            "                               for json path, without_array_wrapper)) as [Location], " +
            "                         json_query((select t.Id as [Id] " +
            "                                     from [Team] as t join TeamLocation as tl on t.Id = tl.TeamID " +
            "                                     where tl.Id = wo.TeamLocationID " +
            "                                     for json path, without_array_wrapper)) as [Team], " +
            "                             json_query((select e.Id as [Id],  " +
            "                                                                     json_query((select ei.Id as [Id] " +
            "                                                                                 from EquipmentItem as ei join WorkOrderDetail as wod on ei.Id = wod.EquipmentItemID " +
            "                                                                                 where wod.WorkOrderID = @orderId and ei.EquipmentID = e.Id " +
            "                                                                                 for json path)) as [EquipmentItems], " +
            "                                                                         json_query((select ei.*, es.[Name] as [Status], " +
            "                                                                                       json_query((select * " +
            "                                                                                             from [Location] " +
            "                                                                                             where Id = ei.WarehouseID " +
            "                                                                                             for json path, without_array_wrapper)) as Warehouse, " +
            "                                                                                                 json_query((select wo3.*, acc.[Username] as [RequestUsername], wos.[Name] as [Status], pri.[Name] as [Priority], pri.TagHexColor as [PriorityTagColor], " +
            "                                                                                                                     json_query((select wod.* " +
            "                                                                                                                                 from WorkOrderDetail as wod " +
            "                                                                                                                                 where wod.EquipmentItemID = ei.Id and wod.WorkOrderID = wo3.Id " +
            "                                                                                                                                 for json path, without_array_wrapper)) as [Detail] " +
            "                                                                                                             from WorkOrder as wo3 join Account as acc on wo3.RequestUserID = acc.Id  " +
            "                                                                                                                     join WorkOrderStatus as wos on wo3.StatusID = wos.Id " +
            "                                                                                                                     join [Priority] as pri on wo3.PriorityID = pri.Id, (select Id  " +
            "                                                                                                                                                                        from WorkOrderStatus " +
            "                                                                                                                                                                        where [Name] != N'Cancelled' and [Name] != N'Closed') as [status],  " +
            "                                                                                                                                                                                 (select wod.* " +
            "                                                                                                                                                                                  from WorkOrderDetail as wod " +
            "                                                                                                                                                                                  where wod.EquipmentItemID = ei.Id and wod.ClosedDate is NULL) as [workorderdetail] " +
            "                                                                                                             where wo3.StatusId = [status].Id and wo3.Id = [workorderdetail].WorkOrderID " +
            "                                                                                                             order by wo3.StatusID desc, wo3.PriorityID desc " +
            "                                                                                                             for json path)) as [WorkOrders], " +
            "                                                                                                                       json_query((select lo.* " +
            "                                                                                                                                   from [Tile] as ti join [Floor] as fl on ti.FloorID = fl.Id " +
            "                                                                                                                                               join [Block] as bl on bl.Id = fl.BlockID " +
            "                                                                                                                                               join [Location] as lo on bl.LocationID = lo.Id " +
            "                                                                                                                                   where ti.Id = ei.TileID " +
            "                                                                                                                                   for json path, without_array_wrapper)) as [Location] " +
            "                                                                                     from EquipmentItem as ei "
            //   + "                                                                                             join Equipment as e4 on ei.EquipmentID = e4.Id "
            +
            "                                                                                             join EquipmentStatus as es on ei.StatusId = es.Id " +
            "                                                                                     where ei.EquipmentID = e.Id "
            //   + "                                                                                     order by (select count(wo4.Id) "
            //   + "                                                                                               from WorkOrder as wo4 join WorkOrderDetail as wod on wo4.Id = wod.WorkOrderID "
            //   + "                                                                                               where wod.EquipmentItemID = ei.Id and wo.StatusID in (select Id "
            //   + "                                                                                                                                                     from WorkOrderStatus "
            //   + "                                                                                                                                                     where [Name] != N'Cancelled' and [Name] != N'Closed')) asc, ei.RuntimeDays asc, ei.LastMaintainDate desc, ei.NextMaintainDate desc "
            +
            "                                                                                     for json path)) as [Table] " +
            "                                         from Equipment as e " +
            "                                         where e.Id in (select distinct e.Id " +
            "                                                        from Equipment as e join EquipmentItem as ei on e.Id = ei.EquipmentID " +
            "                                                        where ei.id in (select wod.EquipmentItemID " +
            "                                                                        from WorkOrder as wo5 join WorkOrderDetail as wod on wo5.Id = wod.WorkOrderID " +
            "                                                                        where wo5.Id = @orderId)) " +
            "                                         for json path)) as [Equipments] " +
            " from WorkOrder as wo " +
            " where Id = @orderId " +
            " for json path, without_array_wrapper")
        .param("orderId", request.params.orderId, TYPES.Int)
        .into(response);
});

// ChauBQN
// get work orders
router.get("/", (request, response) => {
    request
        .sql(
            "select (select wo.*, woc.[Name] as [Category], wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor], " +
            "       (json_query((select wod.*, json_query((select ei.*, e.Name as [Name], e.Image as [Image] " +
            "                                               from EquipmentItem as ei join Equipment as e on ei.EquipmentId = e.Id " +
            "                                               where ei.Id = wod.EquipmentItemId for json path, without_array_wrapper)) as [EquipmentItem] " +
            "                       from WorkOrderDetail as wod " +
            "                       where wod.WorkOrderID = wo.Id " +
            "            for json path))) as [WorkOrderDetails], (select wor.*, json_query((select [Name] " +
            "                                                                                from WorkOrderStatus " +
            "                                                                                where wor.OldStatusID = Id " +
            "                                                                                for json path, without_array_wrapper)) as [OldStatus], " +
            "                                                                        json_query((select [Name] " +
            "                                                                                    from WorkOrderStatus " +
            "                                                                                    where wor.NewStatusID = Id " +
            "                                                                                    for json path, without_array_wrapper)) as NewStatus, " +
            "                                                                            json_query((select acc.*, ro.[Name] as [Role] " +
            "                                                                                        from Account as acc join [Role] as ro on acc.RoleID = ro.Id " +
            "                                                                                        where acc.Id = wor.ModifiedByUserID " +
            "                                                                                        for json path, without_array_wrapper)) as [ModifiedUser] " +
            "                                                    from WorkOrderRecord as wor " +
            "                                                    where wor.WorkOrderID = wo.Id " +
            "                                                    order by wor.ModifiedByDateTime desc " +
            "                                                    for json path) as [WorkOrderRecord], json_query((select tl.*, json_query((select * from [Location] where tl.LocationID = Id for json path, without_array_wrapper)) as [Location], t.Id as [Team.Id], t.[Name] as [Team.Name] " +
            "                                                                                                     from TeamLocation as tl " +
            "                                                                                                               join Team as t on tl.TeamID = t.Id " +
            "                                                                                                     where wo.TeamLocationID = tl.Id " +
            "                                                                                                     for json path, without_array_wrapper)) as [TeamLocation]  " +
            " from WorkOrder as wo join WorkOrderStatus as wos on wo.StatusID = wos.Id " +
            " join Account as acc on wo.RequestUserID = acc.Id " +
            " join [Priority] as p on wo.PriorityID = p.Id " +
            " join [WorkOrderCategory] as woc on wo.CategoryID = woc.Id " +
            " order by wo.CreateDate desc " +
            " for json path) as [WorkOrders] for json path, without_array_wrapper"
        )
        .fail(function (exception, response) {
            response.statusCode = 500;
            response.write(exception.message);
            response.end();
        })
        .into(response);
});

// ChauBQN
// get equipments and equipment items to display on work order
router.get("/:id/equipments", (request, response) => {
    request
        .sql(
            "select e.Id, e.[Name], e.[Image], u.[Name] as [Unit], (select ei2.*, es.[Name] as [Status], md.[Months] as [MaintenanceDurationInMonths], json_query((select lo.[Name] as [Location.Name], lo.[Address] as [Location.Address], " +
            "                                                                                                                                           bl.[Name] as [BlockName], fl.[Name] as [FloorName], ti.[Name] as [TileName] " +
            "                                                                                                                                   from [Location] as lo join [Block] as bl on lo.Id = bl.LocationID " +
            "                                                                                                                                               join [Floor] as fl on bl.Id = fl.BlockID " +
            "                                                                                                                                               join Tile as ti on fl.Id = ti.FloorID " +
            "                                                                                                                                   where ti.Id = ei2.TileID for json path, without_array_wrapper)) as [BlockFloorTile], " +
            "                                                                                                                                           json_query((select wodr.*, es.[Name] as [ReturnedStatusName] " +
            "                                                                                                                                                       from WorkOrderDetailReturn as wodr " +
            "                                                                                                                                                               join EquipmentStatus as es on wodr.ReturnedStatusId = es.Id " +
            "                                                                                                                                                       where wodr.WorkOrderDetailId = wod2.Id " +
            "                                                                                                                                                       for json path, without_array_wrapper)) as [DetailReturn] " +
            "                                                     from WorkOrder as wo2 join WorkOrderDetail as wod2 on wo2.Id = wod2.WorkOrderID " +
            "                                                                         join EquipmentItem as ei2 on wod2.EquipmentItemID = ei2.Id " +
            "                                                                         join EquipmentStatus as es on ei2.StatusID = es.Id " +
            "                                                     where wo2.Id = @workOrderId and ei2.EquipmentID = e.Id for json path) as [EquipmentItems] " +
            " from Equipment as e join [Unit] as u on e.UnitID = u.Id " +
            "       join [MaintenanceDuration] as md on e.MaintenanceDurationID = md.Id " +
            " where e.Id in (select distinct e.Id " +
            "                 from Equipment as e join EquipmentItem as ei on e.Id = ei.EquipmentID " +
            "                 where ei.id in (select wod.EquipmentItemID " +
            "                                 from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID " +
            "                                 where wo.Id = @workOrderId)) " +
            " for json path"
        )
        .param("workOrderId", request.params.id, TYPES.Int)
        .into(response);
});

//   router.get("/status", (request, response) => {
//     request.sql("select * from WorkOrderStatus for json path").into(response);
//   });

router.get("/status", (request, response) => {
    request.sql("select * from WorkOrderStatus for json path").into(response);
});

router.get("/priorities", (request, response) => {
    request.sql("select * from Priority for json path").into(response);
});

// router.get("/search/:value", (req, res) => {
//     req
//         .sql("exec [dbo].SearchWorkOrder @searchValue")
//         .param("searchValue", req.params.value, TYPES.NVarChar)
//         .into(res);
// });


router.get("/categories", (req, res) => {
    req.sql("select * from WorkOrderCategory for json path").into(res);
});

/* ChauBQN */
// get equipment items for displaying in create work order
router.get('/get_equipment_detail/:id', (req, res) => {
    req.sql("select ei.*, es.[Name] as [Status], " +
            " json_query((select * " +
            "       from [Location] " +
            "       where Id = ei.WarehouseID " +
            "       for json path, without_array_wrapper)) as Warehouse, " +
            " json_query((select wo.*, acc.[Username] as [RequestUsername], wos.[Name] as [Status], pri.[Name] as [Priority], pri.TagHexColor as [PriorityTagColor] " +
            "             from WorkOrder as wo join Account as acc on wo.RequestUserID = acc.Id  " +
            "                                 join WorkOrderStatus as wos on wo.StatusID = wos.Id " +
            "                                 join [Priority] as pri on wo.PriorityID = pri.Id, (select Id  " +
            "                                                                                    from WorkOrderStatus " +
            "                                                                                    where [Name] != N'Cancelled' and [Name] != N'Closed' and [Name] != N'Rejected') as [status],  " +
            "                                                                                            (select wod.* " +
            "                                                                                            from WorkOrderDetail as wod " +
            "                                                                                            where wod.EquipmentItemID = ei.Id and wod.ClosedDate is NULL) as [workorderdetail] " +
            "            where wo.StatusID = [status].Id and wo.Id = [workorderdetail].WorkOrderID " +
            "            order by wo.StatusID desc, wo.PriorityID desc " +
            "            for json path)) as [WorkOrders], " +
            "               json_query((select lo.* " +
            "                           from [Tile] as ti join [Floor] as fl on ti.FloorID = fl.Id " +
            "                                       join [Block] as bl on bl.Id = fl.BlockID " +
            "                                       join [Location] as lo on bl.LocationID = lo.Id " +
            "                           where ti.Id = ei.TileID " +
            "                           for json path, without_array_wrapper)) as [Location] " +
            " from EquipmentItem as ei " +
            // "        join Equipment as e on ei.EquipmentID = e.Id " +
            "        join EquipmentStatus as es on ei.StatusId = es.Id " +
            " where ei.EquipmentID = @equipmentId and ei.StatusID in (select Id from EquipmentStatus where [Name] != N'Damaged' and [Name] != N'Lost' and [Name] != N'Archived') " +
            // " order by (select count(wo.Id) " +
            // "           from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID " +
            // "           where wod.EquipmentItemID = ei.Id and wo.StatusID in (select Id " +
            // "                                                                 from WorkOrderStatus " +
            // "                                                                 where [Name] != N'Cancelled' and [Name] != N'Closed' and [Name] != N'Rejected')) asc, ei.RuntimeDays asc, ei.LastMaintainDate desc, ei.NextMaintainDate desc " +
            " for json path")
        .param('equipmentId', req.params.id, TYPES.Int)
        .into(res);
});

/* ChauBQN */
/* create new work order and insert new record to WorkOrderRecord */
router.post('/', (req, res) => {
    req.sql(" declare @newWorkOrderId int; " +
            " declare @categoryId int; " +
            " declare @createDate datetime; " +
            " declare @statusId int; " +
            " set @createDate = getdate(); " +
            " set @statusId = (select Id from WorkOrderStatus where [Name] = N'Requested'); " +
            " set @categoryId = (select Id from WorkOrderCategory where [Name] = @categoryName); " +
            " insert into [WorkOrder]([Name], RequestUserID, CreateDate, ExpectingStartDate, ExpectingCloseDate, [Description], PriorityID, StatusID, CategoryID, TeamLocationID) " +
            "     values(@name, @requestUserId, @createDate, @expectingStartDate, @expectingCloseDate, @description, @priorityId, @statusId, @categoryId, @teamLocationId); " +
            " set @newWorkOrderId = (select SCOPE_IDENTITY()); " +
            " select(@newWorkOrderId) as [NewWorkOrderId] for json path, without_array_wrapper; " +
            " insert into WorkOrderRecord(WorkOrderID, ModifiedByUserID, ModifiedByDateTime, OldStatusID, NewStatusID, [Description]) " +
            "       values(@newWorkOrderId, @requestUserId, @createDate, null, @statusId, @description);")
        .param('name', req.body.name, TYPES.NVarChar)
        .param('requestUserId', req.body.requestUserId, TYPES.Int)
        .param('description', req.body.description, TYPES.NVarChar)
        .param('priorityId', req.body.priorityId, TYPES.Int)
        .param('categoryName', req.body.categoryName, TYPES.NVarChar)
        .param('teamLocationId', req.body.teamLocationId, TYPES.Int)
        .param('expectingStartDate', req.body.expectingStartDate, TYPES.NVarChar)
        .param('expectingCloseDate', req.body.expectingCloseDate, TYPES.NVarChar)
        // .done((data) => {
        //     io.sockets.emit('NEW_WORK_ORDER_CREATED', {message: 'Created Work Order'});
        //     res.end();
        // })
        .fail(function (exception, response) {
            response.statusCode = 500;
            response.write(exception.message);
            response.end();
        })
        .into(res);
});

/* ChauBQN */
router.post('/detail', (req, res) => {
    req.sql('insert into WorkOrderDetail(EquipmentItemID, WorkOrderID, MaintainceCost, [Description]) ' +
            '   values(@equipmentItemId, @workOrderId, @maintainceCost, @description);')
        .param('workOrderId', req.body.workOrderId, TYPES.Int)
        .param('equipmentItemId', req.body.equipmentItemId, TYPES.Int)
        .param('maintainceCost', req.body.maintainceCost, TYPES.Float)
        .param('description', req.body.description, TYPES.NVarChar)
        .exec(res);
});

/* ChauBQN */
/* close a work order detail */
/* first insert new record to WorkOrderDetailReturn, and update ReturnDate of WorkOrderDetail */
/* and if all the work order detail has been returned, 
    the query will update the work order status to 'Closed' and insert new record to WorkOrderRecord */
/* last, update Status of EquipmentItem and insert new record to EquipmentItemHistory */
router.post('/close_detail/:workOrderDetailId', (req, res) => {
    req.sql("declare @workOrderId int; " +
            "  declare @currentItemStatusId int; " +
            "  declare @newStatusId int; " +
            "  set @workOrderId = (select WorkOrderId from WorkOrderDetail where Id = @workOrderDetailId); " +
            "  set @currentItemStatusId = (select StatusId from EquipmentItem where Id = @itemId); " +
            "  set @newStatusId = (select Id from EquipmentStatus where [Name] = @newItemStatus); " +
            "  insert into WorkOrderDetailReturn(WorkOrderDetailId, ByUserId, [DateTime], ReturnedStatusId) values(@workOrderDetailId, @userId, getdate(), @newStatusId); " +
            "  update WorkOrderDetail set ClosedDate = getdate(), MaintainceCost = @cost where Id = @workOrderDetailId; " +
            "  declare @currentRuntimeDays int; " +
            "  declare @orderStartDate datetime; " +
            "  set @orderStartDate = (select StartDate from WorkOrder where Id = @workOrderId); " +
            "  set @currentRuntimeDays = (select RuntimeDays from EquipmentItem where Id = @itemId); " +
            "  update EquipmentItem set RuntimeDays = (DATEDIFF(day, @orderStartDate, getdate()) + @currentRuntimeDays) where Id = @itemId; " +
            "  declare @totalOrderDetail int; " +
            "  declare @totalOrderDetailReturned int; " +
            "  set @totalOrderDetail = (select count(*) from WorkOrderDetail where WorkOrderID = @workOrderId); " +
            "  set @totalOrderDetailReturned = (select count(*)  " +
            "                                   from WorkOrderDetail as wod  " +
            "                                             join WorkOrderDetailReturn as wodr on wod.Id = wodr.WorkOrderDetailId  " +
            "                                   where wod.WorkOrderID = @workOrderId) " +
            "  update EquipmentItem set StatusId = @newStatusId where Id = @itemId; " +
            "  insert into EquipmentItemHistory(EquipmentItemID, ByUserID, OldStatusID, NewStatusID, [Date], [Description]) " +
            "     values(@itemId, @userId, @currentItemStatusId, @newStatusId, getdate(), @description) " +
            "  if @totalOrderDetail = @totalOrderDetailReturned " +
            "  begin " +
            "     declare @oldWorkOrderStatusId int; " +
            "     declare @newWorkOrderStatusId int; " +
            "     set @oldWorkOrderStatusId = (select StatusID from WorkOrder where Id = @workOrderId); " +
            "     set @newWorkOrderStatusId = (select Id from WorkOrderStatus where [Name] = N'Closed'); " +
            "     update WorkOrderDetail set ClosedDate = getdate() where Id = @workOrderDetailId " +
            "     update [WorkOrder] set StatusID = @newWorkOrderStatusId, ClosedDate = getdate() where Id = @workOrderId; " +
            "     insert into [WorkOrderRecord](WorkOrderID, ModifiedByUserID, ModifiedByDateTime, OldStatusID, NewStatusID, [Description]) " +
            "         values(@workOrderId, @userId, getdate(), @oldWorkOrderStatusId, @newWorkOrderStatusId, @description); "
            // + "     select * from WorkOrder where Id = @workOrderId; "
            +
            " end ")
        .param('workOrderDetailId', req.params.workOrderDetailId, TYPES.Int)
        .param('userId', req.body.userId, TYPES.Int)
        .param('itemId', req.body.itemId, TYPES.Int)
        .param('newItemStatus', req.body.newItemStatus, TYPES.NVarChar)
        .param('description', req.body.description, TYPES.NVarChar)
        .param('cost', req.body.cost, TYPES.Int)
        // .done((fn) => {
        //     io.sockets.emit('ORDER_STATUS_CHANGED', {});
        //     res.end();
        // })
        .into(res);
});

// ChauBQN
// update status of work order
router.put("/status/:orderId", (req, res) => {
    req
        .sql(
            "declare @currentDate datetime; " +
            " declare @oldWorkOrderStatusId int; " +
            " declare @newWorkOrderStatusId int; " +
            " set @oldWorkOrderStatusId = (select StatusID from WorkOrder where Id = @workOrderId); " +
            " set @newWorkOrderStatusId = (select Id from WorkOrderStatus where [Name] = @newWorkOrderStatusName); " +
            " set @currentDate = getdate(); " +
            " update [WorkOrder] set StatusID = @newWorkOrderStatusId where Id = @workOrderId; " +
            " if @newWorkOrderStatusName = N'In Progress' " +
            " begin " +
            "   update WorkOrder set StartDate = @currentDate where Id = @workOrderId; " +
            " end " +
            " insert into [WorkOrderRecord](WorkOrderID, ModifiedByUserID, ModifiedByDateTime, OldStatusID, NewStatusID, [Description]) " +
            "   values(@workOrderId, @userId, @currentDate, @oldWorkOrderStatusId, @newWorkOrderStatusId, @description);"
        )
        .param("workOrderId", req.params.orderId, TYPES.Int)
        .param("userId", req.body.userId, TYPES.Int)
        .param("newWorkOrderStatusName", req.body.newStatusName, TYPES.NVarChar)
        .param("description", req.body.description, TYPES.NVarChar)
        //   .done((fn) => {
        //       io.sockets.emit('ORDER_STATUS_CHANGED', {noNeedToRefreshWorkOrderUserId: req.body.noNeedToRefreshWorkOrderUserId});
        //       res.end();
        //   })
        .exec(res);
});

// ChauBQN
// update work order
router.put('/:workOrderId', (req, res) => {
    req.sql('update WorkOrder set TeamLocationID = @teamLocationId, ExpectingStartDate = @expectingStartDate, ExpectingCloseDate = @expectingCloseDate where Id = @workOrderId')
        .param('workOrderId', req.params.workOrderId, TYPES.Int)
        .param('teamLocationId', req.body.teamLocationId, TYPES.Int)
        .param('expectingStartDate', req.body.expectingStartDate, TYPES.NVarChar)
        .param('expectingCloseDate', req.body.expectingCloseDate, TYPES.NVarChar)
        // .done((data) => {
        //     io.sockets.emit('NEW_WORK_ORDER_CREATED', {message: 'Created Work Order'});
        //     res.end();
        // })
        .exec(res);
});

// ChauBQN
// delete work order detail
router.delete('/detail/:workOrderId', (req, res) => {
    req.sql('delete from WorkOrderDetail where WorkOrderId = @workOrderId')
        .param('workOrderId', req.params.workOrderId, TYPES.Int)
        .exec(res);
})

module.exports = router;