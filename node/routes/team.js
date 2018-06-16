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
router.get("/getTeamByLocation/:id",(request,response) =>{
      request
      .sql("exec GetTeamByLocation @locationId")
      .param('locationId',request.params.id,TYPES.Int)
      .into(response);
});
module.exports = router;

 