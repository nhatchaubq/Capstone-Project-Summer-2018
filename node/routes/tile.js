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

// get equipments of tile (structure: equipment[]: equipmentItem{})
router.get("/equipmentItems/:tileId", (req, res) => {
  req
    .sql(
      "select e.*, u.[Name] as [Unit], json_query((select ei.* " +
        "                                          from EquipmentItem as ei " +
        "                                          where ei.EquipmentID = e.Id and ei.TileID = @tileId " +
        "                                          for json path)) as [EquipmentItems] " +
        " from Equipment as e join [Unit] as u on e.UnitID = u.Id " +
        " where e.Id in (select distinct ei.EquipmentID " +
        "                 from EquipmentItem as ei join Tile as t on ei.TileID = t.Id " +
        "                 where t.Id = @tileId) " +
        " for json path"
    )
    .param("tileId", req.params.tileId, TYPES.Int)
    .into(res);
});

router.post("/:floorId", (req, res) => {
  req
    .sql(
      "insert into [Tile]([Name], FloorID, [Description]) values(@tileName, @floorId, @description);"
    )
    .param("floorId", req.params.floorId, TYPES.Int)
    .param("tileName", req.body.tileName, TYPES.NVarChar)
    .param("description", req.body.description, TYPES.NVarChar)
    .exec(res);
});

module.exports = router;
