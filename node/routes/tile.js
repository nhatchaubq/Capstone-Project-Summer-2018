const router = require('express').Router();
const TYPES = require('tedious').TYPES;

router.post('/:floorId', (req, res) => {
    req.sql("insert into [Tile]([Name], FloorID, [Description]) values(@tileName, @floorId, @description);")
      .param('floorId', req.params.floorId, TYPES.Int)
      .param('tileName', req.body.tileName, TYPES.NVarChar)
      .param('description', req.body.description, TYPES.NVarChar)
      .exec(res);
  });

  module.exports = router;