var router = require("express").Router();
var TYPES = require("tedious").TYPES;

/* GET floor by block */
router.get("/block/:id", (req, res) => {
    req
        .sql("select * from Floor where BlockID = @id for json path")
        .param("id", req.params.id, TYPES.Int)
        .into(res);
});
module.exports = router;