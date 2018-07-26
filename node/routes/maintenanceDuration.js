var router = require('express').Router();
var TYPES = require('tedious').TYPES;
router.get('/', (request, response) => {
    request.sql("SELECT * From [MaintenanceDuration] for json path")
        .into(response);
});

router.post('/', (request, response) => {
    request.sql("INSERT INTO MaintenanceDuration (Months) VALUES (@month)")
        .param('month', request.body.month, TYPES.Int)
        .exec(response);
});
module.exports = router;