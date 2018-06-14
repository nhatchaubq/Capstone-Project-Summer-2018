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
        .
});

module.exports = router;