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
      "insert into [Account](Username, Password, Email, Fullname, Phone, isActive, StartDate, EndDate, RoleId, AvatarImage, TeamId, DepartmentId)" +
        " values(@username, @password, @email, @fullname, @phone, @isactive, @startdate, @enddate, @roleid, @avatarimage, @teamid, @departmentid)"
    )
    .param("username", request.body.username, TYPES.NVarChar)
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
    .exec(response);
});

/* PUT request, for update */
router.put("/:id", function(request, response) {
  console.log(request.body);
  request
    .sql(
      "update [Account] set Password = @password, Email = @email, Fullname = @fullname where Id = @id"
    )
    .param("id", request.params.id)
    .param("password", request.body.password, TYPES.NVarChar)
    .param("email", request.body.email, TYPES.NVarChar)
    .param("fullname", request.body.fullname, TYPES.NVarChar)
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
