var router = require("express").Router();
var TYPES = require("tedious").TYPES;

/* GET status history of an Item by ID */
router.get("/:id", (req, res) => {
  req
    .sql(
      "SELECT acc.Fullname, CONVERT(date,eih.[Date]) as [Date] , eih.Description, " +
        "json_query((select [Name] " +
        "from EquipmentStatus as es " +
        "where Id = eih.OldStatusID " +
        "for json path, without_array_wrapper)) as [OldStatus], " +
        "json_query((select [Name] " +
        "from EquipmentStatus as es " +
        "where Id = eih.NewStatusID " +
        "for json path, without_array_wrapper)) as [NewStatus] " +
        "FROM EquipmentItemHistory eih " +
        "JOIN EquipmentItem as ei on ei.Id = eih.EquipmentItemID " +
        "JOIN Account as acc on acc.Id = eih.ByUserID " +
        "WHERE eih.EquipmentItemID = @id " +
        "order by eih.[Date] desc " +
        "for json path"
    )
    .param("id", req.params.id, TYPES.Int)
    .into(res);
});
module.exports = router;
