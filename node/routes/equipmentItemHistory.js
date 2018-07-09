var router = require("express").Router();
var TYPES = require("tedious").TYPES;

/* GET status history of an Item by ID */
router.get("/:id", (req, res) => {
    req
        .sql("exec GetHistoryStatusAnItemById_Tien @id")
        .param("id", req.params.id, TYPES.Int)
        .into(res);
});
module.exports = router;