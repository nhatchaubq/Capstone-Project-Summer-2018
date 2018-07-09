const router = require("express").Router();
const TYPES = require("tedious").TYPES;



router.post("/createTeamAccount", (req, res) => {
    req
        .sql("insert into [TeamAccount](TeamID,AccountID,TeamRoleID) " +
            "values(@teamId,@accountId,2)"
        )
        .param("teamId", req.body.teamId, TYPES.Int)
        .param("accountId", req.body.accountId, TYPES.Int)
        .exec(res);
});

module.exports = router;