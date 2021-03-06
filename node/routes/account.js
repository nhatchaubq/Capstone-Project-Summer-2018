var router = require("express").Router();
var TYPES = require("tedious").TYPES;

/* GET request, for select */
router.get("/", function (request, response) {
  request
    .sql(
      "SELECT acc.Id as 'Account.Id', acc.Username as 'Account.Username', acc.Password as 'Account.Password', acc.Email as 'Account.Email', " +
      "acc.Fullname as 'Account.Fullname', acc.Phone as 'Account.Phone', acc.IsActive as 'Account.IsActive', acc.StartDate as 'Account.StartDate', " +
      "acc.EndDate as 'Account.EndDate', acc.AvatarImage as 'Account.AvatarImage', acc.RoleID as 'Account.RoleId', r.Name as 'Account.Role.Name' " +
      "FROM [Account] as acc JOIN [Role] as r ON acc.RoleID = r.Id " +
      "ORDER BY acc.IsActive DESC,acc.Username ASC " +
      "for json path"
    )
    .into(response);
});

// search-start

router.get("/search/:value", function (request, response) {
  request
    .sql(
      "SELECT distinct acc.* FROM [Account] as acc " +
      "Join [Role] as r ON r.Id = acc.RoleID  " +
      "WHERE acc.Username like N'%' + @searchText + '%' " +
      "or acc.Fullname like N'%' + @searchText + '%'" +
      "or acc.Email like N'%' + @searchText + '%'" +
      "or acc.Phone like N'%' + @searchText + '%' " +
      "or r.Name like N'%' + @searchText + '%' " +
      "ORDER BY acc.IsActive DESC,acc.Username ASC " +
      "for json path "
    )
    .param("searchText", request.params.value, TYPES.NVarChar)
    .into(response);
});
router.get("/getAllWorkOrderOfthatAcc/:id", function (request, response) {
  request
    .sql(
      "SELECT wo.* FROM [WorkOrder] as wo  " +
      "JOIN Account as acc ON acc.Id =wo.RequestUserID   " +

      "WHERE wo.StatusID NOT IN (SELECT ws.Id FROM [WorkOrderStatus] as ws WHERE ws.Name = N'Closed' or ws.Name = N'Cancelled' )   " +
      "and acc.Id = @accId for json path  "

    )
    .param("accId", request.params.id, TYPES.NVarChar)
    .into(response);
});

// search-end

/* POST request, for insert */
router.post("/", (request, response) => {
  request
    .sql(
      "insert into [Account](Username, Password, Email, Fullname, Phone, IsActive, StartDate, EndDate, RoleId, AvatarImage)" +
      " values(@username, @password, @email, @fullname, @phone, 'True', getdate(), @enddate, @roleid, @avatarimage)"
    )
    .param("username", request.body.account.username, TYPES.NVarChar)
    .param("password", request.body.account.password, TYPES.NVarChar)
    .param("fullname", request.body.account.fullname, TYPES.NVarChar)
    .param("phone", request.body.account.phone, TYPES.NVarChar)
    .param("email", request.body.account.email, TYPES.NVarChar)
    .param("isActive", request.body.account.isActive, TYPES.Bit)
    .param("startdate", request.body.account.startdate, TYPES.NVarChar)
    .param("roleid", request.body.account.roleid, TYPES.Int)
    .param("enddate", request.body.account.enddate, TYPES.Int)
    .param("avatarimage", request.body.avatarimage, TYPES.NVarChar)

    .exec(response);
});

/* PUT request, for update */

router.put('/:id', function (request, response) {
  request.sql('update [Account] set Fullname = @fullname, Password = @password, IsActive = @isActive, Email = @email, Phone = @phone, AvatarImage = @avatarimage  where Id = @id')
    .param('id', request.params.id, TYPES.Int)
    .param('fullname', request.body.account.Fullname, TYPES.NVarChar)
    .param('password', request.body.account.Password, TYPES.NVarChar)
    .param('isActive', request.body.account.IsActive, TYPES.NVarChar)
    .param('email', request.body.account.Email, TYPES.NVarChar)
    .param('phone', request.body.account.Phone, TYPES.NVarChar)
    .param("avatarimage", request.body.avatarimage, TYPES.NVarChar)
    .exec(response);
});
router.put('/edit/id')

/* DELETE request, for delete */
router.delete("/:id", function (request, response) {
  request
    .sql("delete from [Account] where Id = @id")
    .param("id", request.params.id, TYPES.NVarChar)
    .exec(response);
});
// router.put("/changeYourPass", function(request, response) {
//   request
//     .sql("update [Account] set Password = @password where Id = @id")
//     .param("id", request.body.tmpAcc.id, TYPES.Int)
//     .param("password", request.body.tmpAcc.password, TYPES.NVarChar)
//     .exec(response);
// });

module.exports = router;