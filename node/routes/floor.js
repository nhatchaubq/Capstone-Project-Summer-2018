const router = require('express').Router();
const TYPES = require('tedious').TYPES;

router.post('/:blockId', (req, res) => {
    req.sql("insert into [Floor]([Name], BlockID, [Description]) values(@floorName, @blockId, @description); "
            + "select(select SCOPE_IDENTITY()) as [NewFloorId] for json path, without_array_wrapper;")
      .param('blockId', req.params.blockId, TYPES.Int)
      .param('floorName', req.body.floorName, TYPES.NVarChar)
      .param('description', req.body.description, TYPES.NVarChar)
      .into(res);
  });

module.exports = router;
