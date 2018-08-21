
var router = require("express").Router();
var TYPES = require("tedious").TYPES;

/* GET block by locationID */
router.get("/location/:id", (req, res) => {
    req
        .sql("select * from Block where locationID = @id for json path")
        .param("id", req.params.id, TYPES.Int)
        .into(res);
});

router.post('/:locationId', (req, res) => {
    req.sql("insert into [Block]([Name], LocationID, TotalFloor, TotalBasementFloor, [Description]) values(@blockName, @locationId, @totalFloor, @totalBasementFloor, @description); "
            + "select(select SCOPE_IDENTITY()) as [NewBlockId] for json path, without_array_wrapper;")
      .param('locationId', req.params.locationId, TYPES.Int)
      .param('blockName', req.body.blockName, TYPES.NVarChar)
      .param('totalFloor', req.body.totalFloor, TYPES.NVarChar)
      .param('totalBasementFloor', req.body.totalBasementFloor, TYPES.NVarChar)
      .param('description', req.body.description, TYPES.NVarChar)
      .into(res);
  });
  
  module.exports = router;

