var router = require("express").Router();
var TYPES = require("tedious").TYPES;

/* GET request, for select */
router.get("/", (request, response) => {
  request
    .sql(
      "SELECT  team.Id as 'Team.Id', team.Name as 'Team.Name', team.CreatedDate as 'Team.CreatedDate',team.Status as 'Team.Status', json_query((select count(*) as [Quantity]  " +
      "from TeamAccount   " +
      "where TeamID = team.Id for json path, without_array_wrapper)) as [Team.Members],   " +
      "json_query((select acc.*  " +
      "from TeamAccount as ta  " +
      "JOIN TeamRoles as tr ON tr.Id= ta.TeamRoleID  " +
      "JOIN Account as acc ON ta.AccountID =acc.Id   " +
      "where TeamID = team.Id and tr.Id =(SELECT Id from [TeamRoles] where TeamRole = N'Leader') for json path, without_array_wrapper)) as [Team.TeamLeader]  " +
      "FROM [Team] as team  " +
      "ORDER BY Team.Status DESC, Team.Name ASC " +
      " for json path"
    )

    .into(response);
});
router.get("/wo/getAllWorkOrderThatLeaderHad/:id/", (request, response) => {
  request
    .sql(
      "select wo.Id,wo.Name from [WorkOrder] as wo  " +
      "JOIN TeamLocation as tl ON wo.TeamLocationID =tl.Id   " +
      "JOIN Team as t ON tl.TeamID =t.Id    " +
      "JOIN WorkOrderStatus as ws ON wo.StatusID = ws.Id " +
      "WHERE t.Id = @id  and wo.StatusID NOT IN ( SELECT ws.Id FROM [WorkOrderStatus] as ws WHERE ws.Name = N'Closed' or ws.Name = N'Cancelled') " +
      "for json path "
    )
    .param("id", request.params.id, TYPES.Int)
    .param("teamId", request.params.teamId, TYPES.Int)
    .into(response);
});
router.get("/wo/getAllLocationThatTeamHad/:id/", (request, response) => {
  request
    .sql(
      "select l.Name from [Location] as l  " +
      "JOIN TeamLocation as tl ON tl.LocationID =l.Id     " +
      "JOIN Team as t ON tl.TeamID =t.Id      " +

      "WHERE t.Id = @id  and l.Id IN ( SELECT l.Id FROM [Location] as l WHERE l.IsActive = 'True' )   "
    )
    .param("id", request.params.id, TYPES.Int)
    .param("teamId", request.params.teamId, TYPES.Int)
    .into(response);
});

router.get("/search/:value", function (request, response) {
  request
    .sql(
      // "SELECT distinct t.* " +
      // "FROM [Team] as t " +
      // "JOIN [TeamAccount] as ta ON ta.TeamID =t.Id " +
      // "JOIN [Account] as acc ON acc.Id =ta.AccountID " +
      // "JOIN [Role] as r ON r.Id = acc.RoleID" +
      // "WHERE t.Name like N'%' + @searchText + '%' or t.CreatedDate like N'%' + @searchText + '%' " +
      // "or (acc.Username like N'%' + @searchText + '%' and ta.TeamRoleID = (select tr.Id from [TeamRoles] as tr where tr.TeamRole ='Leader')) " +
      // "ORDER BY t.Name DESC " +
      // "for json path "
      "SELECT distinct t.* " +
      "FROM [Team] as t   " +
      "JOIN [TeamAccount] as ta ON ta.TeamID =t.Id   " +
      "JOIN [Account] as acc ON acc.Id =ta.AccountID   " +
      "JOIN [Role] as r ON r.Id = acc.RoleID  " +
      "WHERE t.Name like N'%' + @searchText + '%' or t.CreatedDate like N'%' + @searchText + '%'   " +
      // "or (acc.Username like N'%' + @searchText + '%' and ta.TeamRoleID = (select tr.Id from [TeamRoles] as tr where tr.TeamRole ='Leader'))   " +
      "or (acc.Username like N'%' + @searchText + '%' )   " +
      "ORDER BY t.Name DESC   " +
      "for json path"
    )
    .param("searchText", request.params.value, TYPES.NVarChar)
    .into(response);
});

router.get("/getAllTeam", (request, response) => {
  request.sql("select * from [Team] for json path").into(response);
});
router.post("/", (request, response) => {
  request
    .sql(
      "insert into [Team](Name, CreatedDate, Status )" +
      " values(@name, getdate(), 'True' ) " +
      "select(select SCOPE_IDENTITY()) as [NewTeamId] for json path, without_array_wrapper"
    )
    .param("name", request.body.team.name, TYPES.NVarChar)
    .param("createdDate", request.body.team.createdDate, TYPES.NVarChar)

    .into(response);
});
router.get("/getTeamByLocation/:id", (request, response) => {
  request
    .sql(
      "select a.*,m.NameOfTeam,m.IdOfTeam,(select a.* from Account as a join TeamAccount as ta on a.Id = ta.AccountID  " +
      " where ta.TeamRoleID = 2 and ta.TeamID = m.IdOfTeam for json path) as 'Members' " +
      "   from Account as a join " +
      "     (select ta.AccountID, t.Name as 'NameOfTeam', t.Id as 'IdOfTeam', ta.TeamRoleID " +
      " from Team as t join TeamLocation as tl on tl.TeamID = t.Id " +
      " join TeamAccount as ta on ta.TeamID = t.Id " +
      " where tl.LocationID = @locationId and ta.TeamRoleID = 1) as m on a.Id = m.AccountID " +
      " for json path"
    )
    // "exec [GetTeamByLocation] @locationId"
    .param("locationId", request.params.id, TYPES.Int)
    .into(response);
});

router.put("/changeMemberToLeader", (request, response) => {
  request
    .sql("exec ChangeLeaderToMember&MeToLiByAccountID(19/06)")
    .into(response);
});

router.put("/:id", function (request, response) {
  request
    .sql("update [Team] set Name = @Name,Status = @Status where Id = @id")
    .param("id", request.params.id, TYPES.Int)
    .param("Name", request.body.team.Name, TYPES.NVarChar)
    .param("Status", request.body.team.Status, TYPES.Bit)

    .exec(response);
});

module.exports = router;