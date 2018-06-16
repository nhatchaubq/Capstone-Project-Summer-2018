const router = require('express').Router();
const TYPES = require('tedious').TYPES;

router.get('/', (request, response) => {
    request.sql("exec GetWorkOrders")
        .into(response);
});

router.get('/:id/equipments', (request, response) => {
    request.sql('exec GetEquipmentInfoOfWorkOrderById @workOrderId')
        .param('workOrderId', request.params.id, TYPES.Int)
        .into(response);
});

router.get('/workorderbylocationId/:id',(request,response) => {
    request.sql("exec GetWorkOrderByLocationId @locationId")
    .param('locationId',request.params.id, TYPES.Int)
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

router.post('/', (req, res) => {
    req.sql("exec [dbo].CreateWorkOrder @name, @requestUserId, @createDate, "
    + "@description, @priorityId, @statusId, @categoryId, @teamLocationId")
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
    req.sql('exec [dbo].[CreateWorkOrderDetail] @workOrderId, @equipmentItemId, @startDate, @dueDate, @maintainceCost, @description')
        .param('workOrderId', req.body.workOrderId, TYPES.Int)
        .param('equipmentItemId', req.body.equipmentItemId, TYPES.Int)
        .param('startDate', req.body.startDate, TYPES.NVarChar)
        .param('dueDate', req.body.dueDate, TYPES.NVarChar)
        .param('maintainceCost', req.body.maintainceCost, TYPES.Float)
        .param('description', req.body.description, TYPES.NVarChar)
        .exec(res);
});

module.exports = router;