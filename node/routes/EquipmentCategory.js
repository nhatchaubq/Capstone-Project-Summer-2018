var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/getAllCate", (request, response) => {
  request
    .sql("SELECT * From [EquipmentCategory] order by Name for json path")
    .into(response);
});

router.delete("/deleteCategory/:id", (req, res) => {
  req
    .sql("delete from EquipmentCategory where Id = @categoryId")
    .param("categoryId", req.params.id, TYPES.Int)
    .exec(res);
});

router.get("/getAllItems", (req, res) => {
  req
    .sql(
      "select distinct ec.Id as 'CategoryId',ec.Name as 'CategoryName'" +
      " from EquipmentCategory as ec join Equipment as e on ec.Id = e.CategoryID " +
      "							 join EquipmentItem as ei on ei.EquipmentID = e.Id " +
      " for json path "
    )
    .into(res);
});

router.put("/editCategory", (request, respone) => {
  request
    .sql(
      "Update [EquipmentCategory] set Name = @name, Description = @description " +
      "where Id = @categoryId"
    )
    .param("categoryId", request.body.newCategory.id, TYPES.Int)
    .param("name", request.body.newCategory.name, TYPES.NVarChar)
    .param("description", request.body.newCategory.description, TYPES.NVarChar)
    .exec(respone);
});

router.post("/createCategory", (request, response) => {
  request
    .sql(
      "INSERT INTO EquipmentCategory (Name, Description) VALUES (@name, @description)"
    )
    .param("name", request.body.newCategory.name, TYPES.NVarChar)
    .param("description", request.body.newCategory.description, TYPES.NVarChar)
    .exec(response);
});
router.post("/categoryName/", (request, response) => {
  request
    .sql("INSERT INTO EquipmentCategory (Name) VALUES (@name)")
    .param("name", request.body.name, TYPES.NVarChar)
    .exec(response);
});
module.exports = router;