const router = require('express').Router();
const TYPES = require('tedious').TYPES;

router.get('/:locationId/:teamId', (req, res) => {
    req.sql('exec [dbo].GetTeamLocationId @locationId, @teamId')
        .param('locationId', req.params.locationId, TYPES.Int)
        .param('teamId', req.params.teamId, TYPES.Int)
        .into(res);
});

module.exports = router;