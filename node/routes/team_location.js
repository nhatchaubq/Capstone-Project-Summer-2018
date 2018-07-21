const router = require("express").Router();
const TYPES = require("tedious").TYPES;

router.get("/:locationId/:teamId", (req, res) => {
  req
    .sql("select Id "
    + "   from TeamLocation as tl "
    + "   where tl.LocationID = @locationId and tl.TeamID = @teamId "
    + "   for json path, without_array_wrapper")
    .param("locationId", req.params.locationId, TYPES.Int)
    .param("teamId", req.params.teamId, TYPES.Int)
    .into(res);
});

router.post("/createTeamLocation", (req, res) => {
  req
    .sql(
      "insert into [TeamLocation](LocationID,TeamID,StartDate,OutDate) " +
        "values(@locationId, @teamId, GETDATE(), NULL)"
    )
    .param("locationId", req.body.locationId, TYPES.Int)
    .param("teamId", req.body.teamId, TYPES.Int)
    .exec(res);
});

module.exports = router;
