var router = require("express").Router();
var TYPES = require("tedious").TYPES;

/* GET request, for select */
router.get("/", function(request, response) {
  request
    .sql(
      "SELECT acc.Id as 'Account.Id', acc.Username as 'Account.Username', acc.Password as 'Account.Password', acc.Email as 'Account.Email', " +
        "acc.Fullname as 'Account.Fullname', acc.Phone as 'Account.Phone', acc.IsActive as 'Account.IsActive', acc.StartDate as 'Account.StartDate', " +
        "acc.EndDate as 'Account.EndDate', acc.AvatarImage as 'Account.AvatarImage', acc.RoleID as 'Account.RoleId', r.Name as 'Account.Role.Name', " +
        "acc.DepartmentID as 'Account.DepartmentId', d.Name as 'Account.Department.Name' " +
        "FROM [Account] as acc JOIN [Role] as r ON acc.RoleID = r.Id " +
        "JOIN [Department] as d ON acc.DepartmentID = d.Id " +
        "ORDER BY acc.StartDate DESC for json path"
    )
    .into(response);
});

/* POST request, for insert */
router.post("/", (request, response) => {
  request
    .sql(
<<<<<<< HEAD
      "insert into [Account](Username, Password, Email, Fullname, Phone, isActive, StartDate, EndDate, RoleId, AvatarImage, TeamId, DepartmentId)" +
        " values(@username, @password, @email, @fullname, @phone, @isactive, @startdate, @enddate, @roleid, @avatarimage, @teamid, @departmentid)"
    )
    .param("username", request  .body.username, TYPES.NVarChar)
    .param("password", request.body.password, TYPES.NVarChar)
    .param("email", request.body.email, TYPES.NVarChar)
    .param("fullname", request.body.fullname, TYPES.NVarChar)
    .param("phone", request.body.phone, TYPES.NVarChar)
    .param("isactive", request.body.isactive, TYPES.Bit)
    .param("startdate", request.body.startdate, TYPES.DateTime)
    .param("enddate", request.body.enddate, TYPES.DateTime)
    .param("roleid", request.body.roleid, TYPES.Int)
    .param("avatarimage", request.body.avatarimage, TYPES.NVarChar)
    .param("teamid", request.body.teamid, TYPES.Int)
    .param("departmentid", request.body.departmentid, TYPES.Int)
=======
      "insert into [Account](Username, Password, Email, Fullname, Phone, IsActive, StartDate, EndDate, RoleId, AvatarImage)" +
        " values(@username, @password, @email, @fullname, @phone, @isActive, @startdate, @enddate, @roleid, @avatarimage)"
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

>>>>>>> d8a13d2bdb7b1a7194b80ca106a7fab1fb881f9b
    .exec(response);
});

/* PUT request, for update */
router.put("/:id", function(request, response) {
  request
    .sql(
      "update [Account] set Password = @password, Fullname = @fullname, Birthday = @birthday where Id = @id"
    )
    .param("password", request.params.id, TYPES.NVarChar)
    .param("fullname", request.body.email, TYPES.NVarChar)
    .param("birthday", request.body.fullname, TYPES.NVarChar)
    .exec(response);
});

/* DELETE request, for delete */
router.delete("/:id", function(request, response) {
  request
    .sql("delete from [Account] where Id = @id")
    .param("id", request.params.id, TYPES.NVarChar)
    .exec(response);
});

module.exports = router;
