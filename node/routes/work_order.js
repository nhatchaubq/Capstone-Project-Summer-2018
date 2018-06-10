const router = require('express').Router();
const TYPES = require('tedious').TYPES;

router.get('/', (request, response) => {
    request.sql("exec GetWorkOrders")
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

module.exports = router;