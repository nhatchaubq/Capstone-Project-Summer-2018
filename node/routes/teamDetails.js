var router = require('express').Router();
var TYPES = require('tedious').TYPES;

router.get('/:id', (request, response) => {
    request.sql("exec [dbo].GetTeamDetailsByTeamId @teamId")
        .param('teamId', request.params.id, TYPES.Int)
        .into(response);
});
router.get("/getMembersInTeam/:id", (request, response) => {
    request
        .sql("exec [dbo].[GetAllMemberInteam] @id")
        .param('id', request.params.id, TYPES.Int)
        .into(response);
});

/* DELETE request, for delete */
router.delete("/:id/:accountId", (request, response) => {
    request
        .sql("delete from [TeamAccount] where AccountID= @accountId and TeamID = @id")
        .param("id", request.params.id, TYPES.Int)
        .param("accountId", request.params.accountId, TYPES.Int)
        .exec(response);
});
module.exports = router;