var router = require("express").Router();
var TYPES = require("tedious").TYPES;

/* GET request, for select */
router.get("/", function(request, response) {
  request
    .sql(
      "SELECT team.Id as 'Team.Id', team.Name as 'Team.Name', team.CreatedDate as 'Team.CreatedDate' " +
        "FROM [Team] " +  
        "ORDER BY team.id DESC for json path"
    )
    .into(response);
});
