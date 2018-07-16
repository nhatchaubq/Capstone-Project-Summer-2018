var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/", (request, response) => {
  request
    .sql(
      "select acc.Id,acc.Fullname from [Account] as acc WHERE acc.RoleID NOT IN (SELECT r.Id FROM [role] as r WHERE r.Name = N'Admin' OR r.Name = N'Maintainer' OR r.Name = N'Manager') for json path"
    )
    .param("teamID", request.params.id, TYPES.Int)
    .into(response);
});




module.exports = router;