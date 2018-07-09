var router = require("express").Router();
var TYPES = require("tedious").TYPES;

/*Get Tile by ID*/
router.get("/:id", (req, res) => {
    req
        .sql("select * from Tile where Id = @id for json path")
        .param("id", req.params.id, TYPES.Int)
        .into(res);
});

/* GET tile by floorID */
router.get("/floor/:id", (req, res) => {
    req
        .sql("select * from Tile where FloorID = @id for json path")
        .param("id", req.params.id, TYPES.Int)
        .into(res);
});

module.exports = router;