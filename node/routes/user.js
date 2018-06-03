var router = require('express').Router();
var TYPES = require('tedious').TYPES;

/* GET request, for select */
router.get('/', function (request, response) {
    request.sql("select * from [Account] for json path")
        .into(response, '[]');
});

/* POST request, for insert */
router.post('/', (request, response) => {
    request.sql("insert into [Account](Username, Password, Email, Fullname, Phone, isActive, StartDate, EndDate, RoleId, AvatarImage, TeamId, DepartmentId)" +
        " values(@username, @password, @email, @fullname, @phone, @isactive, @startdate, @enddate, @roleid, @avatarimage, @teamid, @departmentid)")
        .param('username', request.body.username, TYPES.NVarChar)
        .param('password', request.body.password, TYPES.NVarChar)
        .param('email', request.body.email, TYPES.NVarChar)
        .param('fullname', request.body.fullname, TYPES.NVarChar)
        .param('phone', request.body.phone, TYPES.NVarChar)
        .param('isactive', request.body.isactive, TYPES.Bit)
        .param('startdate', request.body.startdate, TYPES.DateTime)
        .param('enddate', request.body.enddate, TYPES.DateTime)
        .param('roleid', request.body.roleid, TYPES.Int)
        .param('avatarimage', request.body.avatarimage, TYPES.NVarChar)
        .param('teamid', request.body.teamid, TYPES.Int)
        .param('departmentid', request.body.departmentid, TYPES.Int)
        .exec(response);
});

/* PUT request, for update */
router.put('/:id', function(request, response) {
    request.sql('update [Account] set Password = @password, Fullname = @fullname, Birthday = @birthday where Id = @id')
        .param('password', request.params.id, TYPES.NVarChar)
        .param('fullname', request.body.email, TYPES.NVarChar)
        .param('birthday', request.body.fullname, TYPES.NVarChar)
        .exec(response);
});

/* DELETE request, for delete */
router.delete('/:id', function(request, response) {
    request.sql('delete from [Account] where Id = @id')
        .param('id', request.params.id, TYPES.NVarChar)
        .exec(response);
});

module.exports = router;