var router = require("express").Router();
var TYPES = require("tedious").TYPES;

/* GET block by locationID */
router.get("/location/:id", (req, res) => {
    req
        .sql("select * from Block where locationID = @id for json path")
        .param("id", req.params.id, TYPES.Int)
        .into(res);
});
module.exports = router;