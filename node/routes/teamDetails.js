var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/:id", (request, response) => {
  request
    .sql(
      "SELECT t.id as 'team.Id', t.Name as 'team.Name', t.CreatedDate as 'team.CreatedDate',    " +
      "json_query((SELECT a.*,ta.TeamRoleID FROM [TeamAccount] as ta JOIN [Account] as a ON ta.AccountID = a.Id WHERE ta.TeamID =t.Id and ta.TeamRoleID =1 for json path, without_array_wrapper)) as 'team.LeaderAccount',     " +
      "(SELECT a.*,ta.TeamRoleID FROM [TeamAccount] as ta JOIN [Account] as a ON ta.AccountID = a.Id WHERE ta.TeamID =t.Id and ta.TeamRoleID =2 ORDER BY a.IsActive DESC, a.Username  ASC for json path) as 'team.MemberAccounts',     " +
      "json_query((select l.* from [TeamLocation] as tl JOIN [Location] as l ON tl.LocationID =l.Id  WHERE tl.TeamID =t.Id ORDER BY l.IsActive DESC, l.Name ASC for json path))  as 'team.Location'     " +


      "FROM Team as t     " +

      "WHERE t.Id = @id     " +
      "for json path, without_array_wrapper "
    )
    .param("Id", request.params.id, TYPES.Int)
    .into(response);
});
router.get("/:id/OnlyteamMember", (request, response) => {
  request
    .sql(
      "SELECT a.*,ta.TeamRoleID, tr.TeamRole  " +
      "FROM [TeamAccount] as ta  " +
      "JOIN [Account] as a ON ta.AccountID = a.Id  " +
      "JOIN [TeamRoles] as tr ON tr.Id = ta.TeamRoleID " +
      "JOIN [Team] as t ON t.Id =ta.TeamID " +
      "WHERE t.Id =@id ORDER BY ta.TeamRoleID ASC, a.IsActive DESC, a.Username  for json path "
    )
    .param("Id", request.params.id, TYPES.Int)
    .into(response);
});





router.get("/:id/equipmentitem", (request, response) => {
  request
    .sql(
      // "SELECT workorder.Id as [WorkOrderId], workorder.[Name] as [WorkOrderName], wos.[Name] as [WorkOrderStatusName], json_query((select e.Id, e.[Name], e.[Image], u.[Name] as [Unit], (select ei2.*, " +
      // "json_query((select wodr.*, es.[Name] as [ReturnedStatusName] " +
      // "from WorkOrderDetailReturn as wodr " +
      // "join EquipmentStatus as es on wodr.ReturnedStatusId = es.Id " +
      // "where wodr.WorkOrderDetailId = wod2.Id " +
      // "for json path, without_array_wrapper)) as [DetailReturn] " +
      // "from WorkOrder as wo2 join WorkOrderDetail as wod2 on wo2.Id = wod2.WorkOrderID " +
      // "join EquipmentItem as ei2 on wod2.EquipmentItemID = ei2.Id " +
      // "where wo2.Id = workorder.Id and ei2.EquipmentID = e.Id for json path) as [EquipmentItems] " +
      // "from Equipment as e join [Unit] as u on e.UnitID = u.Id " +
      // "where e.Id in (select distinct e.Id " +
      // "from Equipment as e join EquipmentItem as ei on e.Id = ei.EquipmentID " +
      // "where ei.id in (select wod.EquipmentItemID " +
      // "from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID " +
      // "where wo.Id = workorder.Id)) ORDER BY e.Name " +
      // " for json path)) as [Equipment] " +
      // "FROM Team as t " +
      // "JOIN [TeamLocation] as tl ON tl.TeamID = t.Id " +
      // "JOIN [WorkOrder] as workorder ON workorder.TeamLocationID = tl.Id " +
      // "join [WorkOrderStatus] as wos on workorder.StatusID = wos.Id " +
      // "WHERE t.Id = @Id " +
      // "ORDER BY e.Name ASC, " +
      // "for json path "

      "SELECT workorder.Id as [WorkOrderId], workorder.[Name] as [WorkOrderName], wos.[Name] as [WorkOrderStatusName], json_query((select e.Id, e.[Name], e.[Image], u.[Name] as [Unit], (select ei2.*,  " +
      "json_query((select wodr.*, es.[Name] as [ReturnedStatusName]   " +
      "from WorkOrderDetailReturn as wodr   " +
      "join EquipmentStatus as es on wodr.ReturnedStatusId = es.Id   " +
      "where wodr.WorkOrderDetailId = wod2.Id   " +
      "for json path, without_array_wrapper)) as [DetailReturn]   " +
      "from WorkOrder as wo2 join WorkOrderDetail as wod2 on wo2.Id = wod2.WorkOrderID   " +
      "join EquipmentItem as ei2 on wod2.EquipmentItemID = ei2.Id   " +
      "where wo2.Id = workorder.Id and ei2.EquipmentID = e.Id for json path) as [EquipmentItems]   " +
      "from Equipment as e join [Unit] as u on e.UnitID = u.Id   " +
      "where e.Id in (select distinct e.Id   " +
      "from Equipment as e join EquipmentItem as ei on e.Id = ei.EquipmentID   " +
      "where ei.id in (select wod.EquipmentItemID   " +
      "from WorkOrder as wo join WorkOrderDetail as wod on wo.Id = wod.WorkOrderID   " +
      "where wo.Id = workorder.Id ))  ORDER BY e.Name DESC " +
      "for json path)) as [Equipment]   " +
      "FROM Team as t   " +
      "JOIN [TeamLocation] as tl ON tl.TeamID = t.Id   " +
      "JOIN [WorkOrder] as workorder ON workorder.TeamLocationID = tl.Id   " +
      "join [WorkOrderStatus] as wos on workorder.StatusID = wos.Id   " +
      "WHERE t.Id = @Id   " +
      "for json path "
    )
    .param("Id", request.params.id, TYPES.Int)
    .into(response);
});


router.get("/:id/item", (request, response) => {
  request
    .sql(
      "select ei.*,e.Name, wo.Name as 'WordOrderName' " +
      "from TeamLocation as tl join WorkOrder as wo on tl.Id = wo.TeamLocationID " +
      "join WorkOrderStatus as ws on ws.Id = wo.StatusID " +
      "join WorkOrderDetail as wd on wd.WorkOrderID = wo.Id " +
      "join EquipmentItem as ei on ei.Id = wd.EquipmentItemID " +
      "Join Equipment as e on ei.EquipmentID= e.Id " +
      "where ws.Name = 'In Progress' and tl.TeamID = @Id and wd.ClosedDate is null " +
      "ORDER BY e.Name ASC " +
      "for json path "
    )
    .param("Id", request.params.id, TYPES.Int)
    .into(response);
});
// router.get("/getMembersInTeam/:id", (request, response) => {
//     request
//         .sql("exec [dbo].[GetTeamDetailsByTeamId] @id")
//         .param('id', request.params.id, TYPES.Int)
//         .into(response);
// });

/* DELETE request, for delete */
router.delete("/:id/:accountId", (request, response) => {
  request
    .sql(
      "delete from [TeamAccount] where AccountID= @accountId and TeamID = @id"
    )
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
router.put("/:id/:memberID/:leaderId", (request, response) => {
  // request.sql('update [TeamAccount] set TeamRoleID = 1 where TeamID = @id and AccountID = @accountID')
  request
    .sql(
      "update [TeamAccount] set TeamRoleID = 2  where TeamID=@id and AccountID =@leaderId; " +
      "update [TeamAccount] set TeamRoleID = 1  where TeamID=@id and AccountID =@memberID; "
    )
    .param("id", request.params.id, TYPES.Int)
    .param("memberID", request.params.memberID, TYPES.Int)
    .param("leaderId", request.params.leaderId, TYPES.Int)
    .exec(response);
});

module.exports = router;