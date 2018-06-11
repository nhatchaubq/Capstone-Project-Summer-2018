var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/", (request, respone) =>{
    request
    .sql(
        "select * from [Team] for json path"
    )
    .into(respone);
} );
module.exports = router;

