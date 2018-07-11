const router = require("express").Router();
const TYPES = require("tedious").TYPES;


router.get("/workorderbylocationId/:id", (request, response) => {
  request
    .sql(
      "select distinct wo.*, (select COUNT(*) " +
        " from WorkOrder as wo join TeamLocation as tl on tl.Id = wo.TeamLocationID " +
        " join WorkOrderDetail as wd on wo.Id = wd.WorkOrderID " +
        " where tl.LocationID = @locationId) as Quantity " +
        " from WorkOrder as wo join TeamLocation as tl on tl.Id = wo.TeamLocationID " +
        " join WorkOrderDetail as wd on wo.Id = wd.WorkOrderID " +
        " where tl.LocationID = @locationId " +
        " for json path"
    )
    .param("locationId", request.params.id, TYPES.Int)
    .into(response);
});



// router.get('/', (request, response) => {
//     request.sql("exec GetWorkOrders")
//         .into(response);
// });

// ChauBQN
// get work orders
router.get('/', (request, response) => {
    request.sql("select (select wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor], " +
            "        json_query((select * from [Location] where tl.LocationID = Id for json path, without_array_wrapper)) as [Location], " +
            "        t.Id as [Team.Id], t.[Name] as [Team.Name], " +
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
            "                                                    for json path) as [WorkOrderRecord] " +
            " from WorkOrder as wo join WorkOrderStatus as wos on wo.StatusID = wos.Id " +
            " join Account as acc on wo.RequestUserID = acc.Id " +
            " join [Priority] as p on wo.PriorityID = p.Id " +
            " join TeamLocation as tl on wo.TeamLocationID = tl.Id " +
            " join Team as t on tl.TeamID = t.Id " +
            " order by wo.CreateDate desc " +
            " for json path) as [WorkOrders] for json path, without_array_wrapper")
        .into(response);
});

// ChauBQN
// get equipments and equipment items to display on work order
router.get('/:id/equipments', (request, response) => {
    request.sql("select e.Id, e.[Name], e.[Image], u.[Name] as [Unit], (select ei2.*, wod2.ReturnDate as [DetailReturnDate], json_query((select lo.[Name] as [Location.Name], lo.[Address] as [Location.Address], " +
    "                                                                                                   bl.[Name] as [BlockName], fl.[Name] as [FloorName], ti.[Name] as [TileName] " +
    "                                                                                           from [Location] as lo join [Block] as bl on lo.Id = bl.LocationID " +
    "                                                                                                                   join [Floor] as fl on bl.Id = fl.BlockID " +
    "                                                                                                                   join Tile as ti on fl.Id = ti.FloorID " +
    "                                                                                           where ti.Id = ei2.TileID for json path, without_array_wrapper)) as [BlockFloorTile] "
                + "                                                     from WorkOrder as wo2 join WorkOrderDetail as wod2 on wo2.Id = wod2.WorkOrderID "
                + "                                                                         join EquipmentItem as ei2 on wod2.EquipmentItemID = ei2.Id "
                + "                                                     where wo2.Id = @workOrderId and ei2.EquipmentID = e.Id for json path) as [EquipmentItems] "
                + " from Equipment as e join [Unit] as u on e.UnitID = u.Id "
                + " where e.Id in (select distinct e.Id "
                + " from Equipment as e join EquipmentItem as ei on e.Id = ei.EquipmentID "
                + " where ei.id in (select wod.EquipmentItemID "
                + "         from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID "
                + "         where wo.Id = @workOrderId)) "
                + " for json path")
        .param('workOrderId', request.params.id, TYPES.Int)
        .into(response);
});

router.get("/status", (request, response) => {
    request.sql("select * from WorkOrderStatus for json path").into(response);
});

router.get("/priorities", (request, response) => {
    request.sql("select * from Priority for json path").into(response);
});

router.get("/search/:value", (req, res) => {
    req
        .sql("exec [dbo].SearchWorkOrder @searchValue")
        .param("searchValue", req.params.value, TYPES.NVarChar)
        .into(res);
});

router.get("/categories", (req, res) => {
    req.sql("select * from WorkOrderCategory for json path").into(res);
});

/* ChauBQN */
// get equipment items for displaying in create work order
router.get('/get_equipment_detail/:id', (req, res) => {
    req.sql("select ei.*, es.[Name] as [Status], " +
            " json_query((select wo.*, acc.[Username] as [RequestUsername], wos.[Name] as [Status], pri.[Name] as [Priority], pri.TagHexColor as [PriorityTagColor], " +
            "                             json_query((select wod.* " +
            "                                         from WorkOrderDetail as wod " +
            "                                         where wod.EquipmentItemID = ei.Id and wod.WorkOrderID = wo.Id " +
            "                                         for json path, without_array_wrapper)) as [Detail] " +
            "             from WorkOrder as wo join Account as acc on wo.RequestUserID = acc.Id  " +
            "                                 join WorkOrderStatus as wos on wo.StatusID = wos.Id " +
            "                                 join [Priority] as pri on wo.PriorityID = pri.Id, (select Id  " +
            "                                                                                    from WorkOrderStatus " +
            "                                                                                    where [Name] != N'Cancelled' and [Name] != N'Closed' and [Name] != N'Rejected') as [status],  " +
            "                                                                                            (select wod.* " +
            "                                                                                            from WorkOrderDetail as wod " +
            "                                                                                            where wod.EquipmentItemID = ei.Id) as [workorderdetail] " +
            "            where wo.StatusId = [status].Id and wo.Id = [workorderdetail].WorkOrderID " +
            "            order by wo.StatusID desc, wo.PriorityID desc " +
            "            for json path)) as [WorkOrders] " +
            " from EquipmentItem as ei " +
            "        join Equipment as e on ei.EquipmentID = e.Id " +
            "        join EquipmentStatus as es on ei.StatusId = es.Id " +
            " where ei.EquipmentID = @equipmentId " +
            " order by (select count(wo.Id) " +
            "    from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID " +
            "    where wod.EquipmentItemID = ei.Id and wo.StatusID in (select Id " +
            "                                                        from WorkOrderStatus " +
            "                                                        where [Name] != N'Cancelled' and [Name] != N'Closed' and [Name] != N'Rejected')) asc, ei.RuntimeDays asc, ei.LastMaintainDate desc, ei.NextMaintainDate desc " +
            " for json path")
        .param('equipmentId', req.params.id, TYPES.Int)
        .into(res);
});

// router.get('/create/get_date_between/:equipmentId/:startDate/:dueDate', (req, res) => {
//     req.sql('exec [dbo].[GetWorkOrderHasEquipmentBetweenStartDateAndDueDate] @equipmentId, @startDate, @dueDate')
//     .param('equipmentId', req.params.equipmentId, TYPES.Int)
//     .param('startDate', req.params.startDate, TYPES.NVarChar)
//     .param('dueDate', req.params.dueDate, TYPES.NVarChar)
//     .into(res);
// });

/* ChauBQN */
/* create new work order and insert new record to WorkOrderRecord */
router.post('/', (req, res) => {
    req.sql("declare @newWorkOrderId int; " +
            " insert into [WorkOrder]([Name], RequestUserID, CreateDate, [Description], PriorityID, StatusID, CategoryID, TeamLocationID) " +
            "     values(@name, @requestUserId, @createDate, @description, @priorityId, @statusId, @categoryId, @teamLocationId); " +
            " set @newWorkOrderId = (select SCOPE_IDENTITY()); " +
            " select(@newWorkOrderId) as [NewWorkOrderId] for json path, without_array_wrapper; " +
            " insert into WorkOrderRecord(WorkOrderID, ModifiedByUserID, ModifiedByDateTime, OldStatusID, NewStatusID, [Description]) " +
            "       values(@newWorkOrderId, @requestUserId, @createDate, null, @statusId, @description);")
        .param('name', req.body.name, TYPES.NVarChar)
        .param('requestUserId', req.body.requestUserId, TYPES.Int)
        .param('createDate', req.body.createDate, TYPES.NVarChar)
        .param('description', req.body.description, TYPES.NVarChar)
        .param('priorityId', req.body.priorityId, TYPES.Int)
        .param('statusId', req.body.statusId, TYPES.Int)
        .param('categoryId', req.body.categoryId, TYPES.Int)
        .param('teamLocationId', req.body.teamLocationId, TYPES.Int)
        .into(res);
});

/* ChauBQN */
router.post('/detail', (req, res) => {
    req.sql('insert into WorkOrderDetail(EquipmentItemID, WorkOrderID, ExpectingStartDate, ExpectingDueDate, MaintainceCost, [Description]) ' +
            'values(@equipmentItemId, @workOrderId, @startDate, @dueDate, @maintainceCost, @description);')
        .param('workOrderId', req.body.workOrderId, TYPES.Int)
        .param('equipmentItemId', req.body.equipmentItemId, TYPES.Int)
        .param('startDate', req.body.startDate, TYPES.NVarChar)
        .param('dueDate', req.body.dueDate, TYPES.NVarChar)
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
    req.sql("declare @workOrderId int; "
        + "  declare @currentItemStatusId int; "
        + "  declare @newStatusId int; "
    
        + "  set @workOrderId = (select WorkOrderId from WorkOrderDetail where Id = @workOrderDetailId); "
        + "  set @currentItemStatusId = (select StatusId from EquipmentItem where Id = @itemId); "
        + "  set @newStatusId = (select Id from EquipmentStatus where [Name] = @newItemStatus); "
   
        + "  insert into WorkOrderDetailReturn(WorkOrderDetailId, ByUserId, [DateTime], NewItemStatusId) values(@workOrderDetailId, @userId, getdate(), @newStatusId); "
        + "  update WorkOrderDetail set ReturnDate = getdate() where Id = @workOrderDetailId; "
  
        + "  declare @totalOrderDetail int; "
        + "  declare @totalOrderDetailReturned int; "
        
        + "  set @totalOrderDetail = (select count(*) from WorkOrderDetail where WorkOrderID = @workOrderId); "
        + "  set @totalOrderDetailReturned = (select count(*)  "
        + "                                   from WorkOrderDetail as wod  "
        + "                                             join WorkOrderDetailReturn as wodr on wod.Id = wodr.WorkOrderDetailId  "
        + "                                   where wod.WorkOrderID = @workOrderId) "
        + "  if @totalOrderDetail = @totalOrderDetailReturned "
        + "  begin "
        + "     declare @oldWorkOrderStatusId int; "
        + "     declare @newWorkOrderStatusId int; "
        + "     set @oldWorkOrderStatusId = (select StatusID from WorkOrder where Id = @workOrderId); "
        + "     set @newWorkOrderStatusId = (select Id from WorkOrderStatus where [Name] = N'Closed'); "
        
        + "     update WorkOrderDetail set ReturnedDate = getdate() where Id = @workOrderDetailId "
        
        + "     update [WorkOrder] set StatusID = @newWorkOrderStatusId, ClosedDate = getdate() where Id = @workOrderId; "
        
        + "     insert into [WorkOrderRecord](WorkOrderID, ModifiedByUserID, ModifiedByDateTime, OldStatusID, NewStatusID, [Description]) "
        + "         values(@workOrderId, @userId, getdate(), @oldWorkOrderStatusId, @newWorkOrderStatusId, @description); "
        + " end "
        
        + "  update EquipmentItem set StatusId = @newStatusId where Id = @itemId; "
        + "  insert into EquipmentItemHistory(EquipmentItemID, ByUserID, OldStatusID, NewStatusID, [Date], [Description]) "
        + "     values(@itemId, @userId, @currentItemStatusId, @newStatusId, getdate(), @description)")
        .param('workOrderDetailId', req.params.workOrderDetailId, TYPES.Int)
        .param('userId', req.body.userId, TYPES.Int)
        .param('itemId', req.body.itemId, TYPES.Int)
        .param('newItemStatus', req.body.newItemStatus, TYPES.NVarChar)
        .param('currentDate', req.body.currentDate, TYPES.NVarChar)
        .param('description', req.body.description, TYPES.NVarChar)
        .exec(res);
});

// ChauBQN
// update status of work order
router.put('/status/:orderId', (req, res) => {
    req.sql("declare @currentDate datetime; " +
            " declare @oldWorkOrderStatusId int; " +
            " declare @newWorkOrderStatusId int; " +
            " set @oldWorkOrderStatusId = (select StatusID from WorkOrder where Id = @workOrderId); " +
            " set @newWorkOrderStatusId = (select Id from WorkOrderStatus where [Name] = @newWorkOrderStatusName); " +
            " set @currentDate = getdate(); " +
            " update [WorkOrder] set StatusID = @newWorkOrderStatusId where Id = @workOrderId; " +
            " if @newWorkOrderStatusName = n'In Progress' " +
            " begin " +
            "   update WorkOrderDetail set StartDate = @currentDate " +
            " end " +
            " insert into [WorkOrderRecord](WorkOrderID, ModifiedByUserID, ModifiedByDateTime, OldStatusID, NewStatusID, [Description]) " +
            " values(@workOrderId, @userId, @currentDate, @oldWorkOrderStatusId, @newWorkOrderStatusId, @description);")
        .param('workOrderId', req.params.orderId, TYPES.Int)
        .param('userId', req.body.userId, TYPES.Int)
        .param('newWorkOrderStatusName', req.body.newStatusName, TYPES.NVarChar)
        .param('description', req.body.description, TYPES.NVarChar)
        .exec(res);
});
module.exports = router;