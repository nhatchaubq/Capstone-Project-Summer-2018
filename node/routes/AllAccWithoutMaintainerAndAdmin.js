var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/", (request, response) => {
  request
    .sql(
      "select acc.Id,acc.Username from [Account] as acc WHERE acc.RoleID = (SELECT r.Id FROM [role] as r WHERE r.Name = N'Staff') for json path"
    )
    .param("teamID", request.params.id, TYPES.Int)
    .into(response);
});




module.exports = router;