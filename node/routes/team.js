var router = require("express").Router();
var TYPES = require("tedious").TYPES;

/* GET request, for select */
router.get("/", (request, response) => {
  request
    .sql(
      "SELECT team.Id as 'Team.Id', team.Name as 'Team.Name', team.CreatedDate as 'Team.CreatedDate' " +
      "FROM [Team] as team " +
      "ORDER BY team.id DESC for json path"
    )
<<<<<<< HEAD
    .into(respone);
} );
module.exports = router;

=======
    .into(response);
});
router.post("/", (request, response) => {
  request
    .sql(
      "insert into [Team](Name, CreatedDate )" +
      " values(@name, @createdDate )"
    )
    .param("name", request.body.team.name, TYPES.NVarChar)
    .param("createdDate", request.body.team.createdDate, TYPES.NVarChar)

    .exec(response);
});
module.exports = router;
>>>>>>> 4f8cba56be6200fefde2a058edf80bbb379c3454
