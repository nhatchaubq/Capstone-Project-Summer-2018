
var router = require("express").Router();
var TYPES = require("tedious").TYPES;

/* GET tile by floorID */
router.get("/floor/:id", (req, res) => {
    req
        .sql("select * from Tile where FloorID = @id for json path")
        .param("id", req.params.id, TYPES.Int)
        .into(res);
});



router.post('/:floorId', (req, res) => {
    req.sql("insert into [Tile]([Name], FloorID, [Description]) values(@tileName, @floorId, @description);")
      .param('floorId', req.params.floorId, TYPES.Int)
      .param('tileName', req.body.tileName, TYPES.NVarChar)
      .param('description', req.body.description, TYPES.NVarChar)
      .exec(res);
  });

  module.exports = router;
