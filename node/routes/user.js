var router = require('express').Router();
var TYPES = require('tedious').TYPES;

/* GET request, for select */
router.get('/', function (request, response) {
    request.sql("select * from [User] for json path")
        .into(response, '[]');
});

/* POST request, for insert */
router.post('/', (request, response) => {
    request.sql("insert into [USER](Username, Password, Email, Fullname, Birthday) values(@username, @password, @email, @fullname, @birthday)")
        .param('username', request.body.username, TYPES.NVarChar)
        .param('password', request.body.password, TYPES.NVarChar)
        .param('email', request.body.email, TYPES.NVarChar)
        .param('fullname', request.body.fullname, TYPES.NVarChar)
        .param('birthday', request.body.birthday, TYPES.Date)
        .exec(response);
});

/* PUT request, for update */
router.put('/:id', function(request, response) {
    request.sql('update [User] set Password = @password, Fullname = @fullname, Birthday = @birthday where Id = @id')
        .param('password', request.params.id, TYPES.NVarChar)
        .param('fullname', request.body.email, TYPES.NVarChar)
        .param('birthday', request.body.fullname, TYPES.NVarChar)
        .exec(response);
});

/* DELETE request, for delete */
router.delete('/:id', function(request, response) {
    request.sql('delete from [User] where Id = @id')
        .param('id', request.params.id, TYPES.NVarChar)
        .exec(response);
});

module.exports = router;