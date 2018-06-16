var router = require('express').Router();
var TYPES = require('tedious').TYPES;

router.get('/:id', (request, response) => {
    request.sql("exec [dbo].GetAccountDetailByAccId @accId")
        .param('accId', request.params.id, TYPES.Int)
        .into(response);
});
module.exports = router;