var router = require('express').Router();
var TYPES = require('tedious').TYPES;

router.get('/:id', (request, response) => {
    request.sql("exec [dbo].GetTeamDetailsByTeamId @teamId")
        .param('teamId', request.params.id, TYPES.Int)
        .into(response);
});
module.exports = router;