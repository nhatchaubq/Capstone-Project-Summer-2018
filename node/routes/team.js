var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/", (request, respone) =>{
    request
    .sql(
        "select * from [Team] for json path"
    )
    .into(respone);
} );
router.post("/", (request, response) => {
  request
    .sql(
      "insert into [Team](Name, CreatedDate )" +
        " values(@name, @createdDate )"
    )
    .param("name", request.body.name, TYPES.NVarChar)
    .param("createdDate", request.body.createdDate, TYPES.DateTime)

    .exec(response);
  });
module.exports = router;


