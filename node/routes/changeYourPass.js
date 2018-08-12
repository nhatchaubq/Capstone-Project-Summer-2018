var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.put("/", function (request, response) {
    request
        .sql("update [Account] set Password = @password where Id = @id ")
        .param("id", request.body.tmpAcc.id, TYPES.Int)
        .param("password", request.body.tmpAcc.password, TYPES.NVarChar)
        .exec(response);
});




module.exports = router;