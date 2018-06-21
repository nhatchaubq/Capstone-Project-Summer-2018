const router = require("express").Router();
const TYPES = require("tedious").TYPES;

router.get("/:locationId/:teamId", (req, res) => {
  req
    .sql("exec [dbo].GetTeamLocationId @locationId, @teamId")
    .param("locationId", req.params.locationId, TYPES.Int)
    .param("teamId", req.params.teamId, TYPES.Int)
    .into(res);
});

router.post("/createTeamLocation", (req, res) => {
  req
    .sql("exec CreateTeamLocation @locationId,@teamId")
    .param("locationId", req.body.locationId, TYPES.Int)
    .param("teamId", req.body.teamId, TYPES.Int)
    .exec(res);
});

module.exports = router;
