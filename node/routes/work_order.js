const router = require('express').Router();
const TYPES = require('tedious').TYPES;

// router.get('/', (request, response) => {
//     request.sql("exec GetWorkOrders")
//         .into(response);
// });

router.get('/', (request, response) => {
    request.sql("select (select wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor], "
                + "        json_query((select * from [Location] where tl.LocationID = Id for json path, without_array_wrapper)) as [Location], "
                + "        t.Id as [Team.Id], t.[Name] as [Team.Name], "
                + "       (json_query((select wod.*, json_query((select ei.*, e.Name as [Name], e.Image as [Image] "
                + "                                               from EquipmentItem as ei join Equipment as e on ei.EquipmentId = e.Id "
                + "                                               where ei.Id = wod.EquipmentItemId for json path, without_array_wrapper)) as [EquipmentItem] "
                + "                       from WorkOrderDetail as wod "
                + "                       where wod.WorkOrderID = wo.Id "
                + "            for json path))) as [WorkOrderDetails], (select wor.*, json_query((select [Name] "
                + "                                                                                from WorkOrderStatus "
                + "                                                                                where wor.OldStatusID = Id "
                + "                                                                                for json path, without_array_wrapper)) as [OldStatus], "
                + "                                                                        json_query((select [Name] "
                + "                                                                                    from WorkOrderStatus "
                + "                                                                                    where wor.NewStatusID = Id "
                + "                                                                                    for json path, without_array_wrapper)) as NewStatus, "
                + "                                                                            json_query((select acc.*, ro.[Name] as [Role] "
                + "                                                                                        from Account as acc join [Role] as ro on acc.RoleID = ro.Id "
                + "                                                                                        where acc.Id = wor.ModifiedByUserID "
                + "                                                                                        for json path, without_array_wrapper)) as [ModifiedUser] "
                + "                                                    from WorkOrderRecord as wor "
                + "                                                    where wor.WorkOrderID = wo.Id "
                + "                                                    order by wor.ModifiedByDateTime desc "
                + "                                                    for json path) as [WorkOrderRecord] "
                + " from WorkOrder as wo join WorkOrderStatus as wos on wo.StatusID = wos.Id "
                + " join Account as acc on wo.RequestUserID = acc.Id "
                + " join [Priority] as p on wo.PriorityID = p.Id "
                + " join TeamLocation as tl on wo.TeamLocationID = tl.Id "
                + " join Team as t on tl.TeamID = t.Id "
                + " order by wo.CreateDate desc "
                + " for json path) as [WorkOrders] for json path, without_array_wrapper")
        .into(response);
});

router.get('/:id/equipments', (request, response) => {
    request.sql('select e.Id, e.[Name], e.[Image], (select ei.* '
                + '         from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID '
                + '                                 join EquipmentItem as ei on wod.EquipmentItemID = ei.Id '
                + '             where wo.Id = @workOrderId and ei.EquipmentID = e.Id for json path) as [EquipmentItems] '
                + ' from Equipment as e '
                + ' where e.Id in (select distinct e.Id '
                + ' from Equipment as e join EquipmentItem as ei on e.Id = ei.EquipmentID '
                + ' where ei.id in (select wod.EquipmentItemID '
                + '         from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID '
                + '         where wo.Id = @workOrderId)) '
                + ' for json path')
        .param('workOrderId', request.params.id, TYPES.Int)
        .into(response);
});

router.get('/workorderbylocationId/:id',(request,response) => {
    request.sql("select distinct wo.*, (select COUNT(*) "
                + " from WorkOrder as wo join TeamLocation as tl on tl.Id = wo.TeamLocationID "
                + "     join WorkOrderDetail as wd on wo.Id = wd.WorkOrderID "
                + " where tl.LocationID = @locationId) as Quantity "
                + " from WorkOrder as wo join TeamLocation as tl on tl.Id = wo.TeamLocationID "
                + "     join WorkOrderDetail as wd on wo.Id = wd.WorkOrderID "
                + " where tl.LocationID = @locationId "
                + " for json path")
    .param('locationId', request.params.id, TYPES.Int)
    .into(response);
})

router.get('/status', (request, response) => {
    request.sql("select * from WorkOrderStatus for json path")
        .into(response);
});

router.get('/priorities', (request, response) => {
    request.sql("select * from Priority for json path")
        .into(response);
})

router.get('/search/:value', (req, res) => {
    req.sql("exec [dbo].SearchWorkOrder @searchValue")
        .param("searchValue", req.params.value, TYPES.NVarChar)
        .into(res);
});

router.get('/categories', (req, res) => {
    req.sql("select * from WorkOrderCategory for json path")
        .into(res);
});

router.get('/get_equipment_detail/:id', (req, res) => {
    req.sql("select ei.*, es.[Name] as [Status], "
            + " -- select all work orders the equipment item are currently in "
            + " -- the order status must not be 'Cancelled', 'Closed' and 'Rejected' because those statuses do not effect the status of the equipment item "
            + " -- if the item has not in any work orders at the time, the [WorkOrders] will be NULL in the returned result; "
            + " json_query((select wo.*, acc.[Username] as [RequestUsername], wos.[Name] as [Status], pri.[Name] as [Priority], pri.TagHexColor as [PriorityTagColor], "
            + "                             json_query((select wod.* "
            + "                                         from WorkOrderDetail as wod "
            + "                                         where wod.EquipmentItemID = ei.Id and wod.WorkOrderID = wo.Id "
            + "                                         for json path, without_array_wrapper)) as [Detail] "
            + "             from WorkOrder as wo join Account as acc on wo.RequestUserID = acc.Id  "
            + "                                 join WorkOrderStatus as wos on wo.StatusID = wos.Id "
            + "                                 join [Priority] as pri on wo.PriorityID = pri.Id, (select Id  "
            + "                                                                                    from WorkOrderStatus "
            + "                                                                                    where [Name] != N'Cancelled' and [Name] != N'Closed' and [Name] != N'Rejected') as [status],  "
            + "                                                                                            (select wod.* "
            + "                                                                                            from WorkOrderDetail as wod "
            + "                                                                                            where wod.EquipmentItemID = ei.Id) as [workorderdetail] "
            + "            where wo.StatusId = [status].Id and wo.Id = [workorderdetail].WorkOrderID "
            + "            order by wo.StatusID desc, wo.PriorityID desc "
            + "            for json path)) as [WorkOrders] "
            + "from EquipmentItem as ei "
            + "        join Equipment as e on ei.EquipmentID = e.Id "
            + "        join EquipmentStatus as es on ei.StatusId = es.Id "
            + "where ei.EquipmentID = @equipmentId "
            + "-- if an equipment item has not in any work order at the time, it must have more priority than others "
            + "-- then we consider the runtime days, the less runtime days, the less the equipment item works in the construction site, so it must be choosen "
            + "-- then we consider the last maintaince date, the farther the last maintaince, the more of chance the next maintaince happens, so we should choose the item that has last maintaince close from the current time "
            + "-- last, from the time someone wants to create an work order, it's ideally to pick the item has next maintaince farther from the current time "
            + "order by (select count(wo.Id) "
            + "    from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID "
            + "    where wod.EquipmentItemID = ei.Id and wo.StatusID in (select Id "
            + "                                                        from WorkOrderStatus "
            + "                                                        where [Name] != N'Cancelled' and [Name] != N'Closed' and [Name] != N'Rejected')) asc, ei.RuntimeDays asc, ei.LastMaintainDate desc, ei.NextMaintainDate desc "
            + " for json path")
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

router.post('/', (req, res) => {
    req.sql("declare @newWorkOrderId int; "
            + " insert into [WorkOrder]([Name], RequestUserID, CreateDate, [Description], PriorityID, StatusID, CategoryID, TeamLocationID) "
            + "     values(@name, @requestUserId, @createDate, @description, @priorityId, @statusId, @categoryId, @teamLocationId); "
            + " set @newWorkOrderId = (select SCOPE_IDENTITY()); "
            + " select(@newWorkOrderId) as [NewWorkOrderId] for json path, without_array_wrapper; "
            + " insert into WorkOrderRecord(WorkOrderID, ModifiedByUserID, ModifiedByDateTime, OldStatusID, NewStatusID, [Description]) "
            + " values(@newWorkOrderId, @requestUserId, @createDate, null, @statusId, @description);")
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

router.post('/detail', (req, res) => {
    req.sql('insert into WorkOrderDetail(EquipmentItemID, WorkOrderID, StartDate, FinishedDate, MaintainceCost, [Description]) '
            + 'values(@equipmentItemId, @workOrderId, @startDate, @dueDate, @maintainceCost, @description);')
        .param('workOrderId', req.body.workOrderId, TYPES.Int)
        .param('equipmentItemId', req.body.equipmentItemId, TYPES.Int)
        .param('startDate', req.body.startDate, TYPES.NVarChar)
        .param('dueDate', req.body.dueDate, TYPES.NVarChar)
        .param('maintainceCost', req.body.maintainceCost, TYPES.Float)
        .param('description', req.body.description, TYPES.NVarChar)
        .exec(res);
});

router.put('/status/:orderId', (req, res) => {
    req.sql('declare @currentDate datetime; '
	        + ' declare @oldWorkOrderStatusId int; '
            + ' declare @newWorkOrderStatusId int; '
            + ' set @oldWorkOrderStatusId = (select StatusID from WorkOrder where Id = @workOrderId); '
            + ' set @newWorkOrderStatusId = (select Id from WorkOrderStatus where [Name] = @newWorkOrderStatusName); '
            + ' set @currentDate = getdate(); '
            + ' update [WorkOrder] set StatusID = @newWorkOrderStatusId where Id = @workOrderId; '
	        + ' insert into [WorkOrderRecord](WorkOrderID, ModifiedByUserID, ModifiedByDateTime, OldStatusID, NewStatusID, [Description]) '
            + ' values(@workOrderId, @userId, @currentDate, @oldWorkOrderStatusId, @newWorkOrderStatusId, @description);')
        .param('workOrderId', req.params.orderId, TYPES.Int)
        .param('userId', req.body.userId, TYPES.Int)
        .param('newStatusName', req.body.newStatusName, TYPES.NVarChar)
        .param('description', req.body.description, TYPES.NVarChar)
        .exec(res);
});

module.exports = router;