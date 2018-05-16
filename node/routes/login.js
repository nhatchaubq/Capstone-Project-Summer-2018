var router = require('express').Router();
var TYPES = require('tedious').TYPES;

router.get('/:username/:password', function (request, response) {
    request.sql("select * from [User] where Username = @username and Password = @password for json path, without_array_wrapper")
        .param('username', request.params.username, TYPES.NVarChar)
        .param('password', request.params.password, TYPES.NVarChar)
        .into(response, '{}');
});

module.exports = router;