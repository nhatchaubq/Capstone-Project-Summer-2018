var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/:id", (request, response) => {
  request
    .sql(
      "(select acc.Id,acc.Fullname from [Account] as acc)  except (select acc.Id,acc.Fullname from [Account] as acc  join [TeamAccount] as ta ON acc.Id = ta.AccountID where TeamID = @teamID) for json path"
    )
    .param("teamID", request.params.id, TYPES.Int)
    .into(response);
});
router.post("/:id", (request, response) => {
  request
    .sql(
      "INSERT INTO [TeamAccount] (TeamID, AccountID, TeamRoleID) VALUES (@teamID, @accountID, 2)"
    )
    .param("teamID", request.params.id, TYPES.Int)
    .param("accountID", request.body.accountID, TYPES.Int)
    .exec(response);
});
module.exports = router;
