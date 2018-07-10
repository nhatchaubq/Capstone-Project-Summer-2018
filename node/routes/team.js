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
router.get("/getAllTeam", (request, response) => {
  request.sql("select * from [Team] for json path").into(response);
});
router.post("/", (request, response) => {
  request
    .sql(
      "insert into [Team](Name, CreatedDate )" +
        " values(@name, @createdDate ) " +
        "select(select SCOPE_IDENTITY()) as [NewTeamId] for json path, without_array_wrapper"
    )
    .param("name", request.body.team.name, TYPES.NVarChar)
    .param("createdDate", request.body.team.createdDate, TYPES.NVarChar)

    .into(response);
});
router.get("/getTeamByLocation/:id", (request, response) => {
  request
    .sql(
      "select a.*,m.NameOfTeam,m.IdOfTeam " +
        " from Account as a join " +
        "  (select ta.AccountID, t.Name as 'NameOfTeam', t.Id as 'IdOfTeam' " +
        " from Team as t join TeamLocation as tl on tl.TeamID = t.Id " +
        " 		   join TeamAccount as ta on ta.TeamID = t.Id " +
        " where tl.LocationID = @locationId and ta.TeamRoleID = 1) as m on a.Id = m.AccountID " +
        " for json path"
    )
    .param("locationId", request.params.id, TYPES.Int)
    .into(response);
});

router.put("/changeMemberToLeader", (request, response) => {
  request
    .sql("exec ChangeLeaderToMember&MeToLiByAccountID(19/06)")
    .into(response);
});

module.exports = router;
