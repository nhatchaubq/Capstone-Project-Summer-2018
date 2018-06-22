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

/* PUT request, for update */
// router.put('/:id/:leaderID', function (request, response) {
//     request.sql("exec [dbo].[ChangeLeaderToMember&MeToLiByAccountID(21/06)] @id")
//         .param('id', request.params.TeamID, TYPES.Int)
//         .param('leaderID', request.params.LeaderID, TYPES.Int)
//         .param('memberID', request.body.MemberID, TYPES.NVarChar)
//         .into(response);
// });

/* PUT request, for update */
router.put('/:id/:accountID', (request, response) => {
    // request.sql('update [TeamAccount] set TeamRoleID = 1 where TeamID = @id and AccountID = @accountID')
    request.sql('update [TeamAccount] set TeamRoleID = 2  where AccountID =(select AccountID from TeamAccount where TeamAccount.TeamRoleID =1 and TeamAccount.TeamID = @id) and TeamAccount.TeamID =@id; update [TeamAccount] set TeamRoleID = 1  where AccountID = @memberID and TeamID =@id')
        .param('id', request.params.id, TYPES.Int)
        .param('memberID', request.params.accountID, TYPES.Int)
        .exec(response);
});

module.exports = router;