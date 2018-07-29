const router = require('express').Router();
const distance = require('google-distance-matrix');
distance.key('AIzaSyDNEXkpy7Eb76G8TciF6DzydzD4y4tZg4c');

router.post('/distancematrix', (req, res) => {
    const origins = req.body.origins;
    const destinations = req.body.destinations;
    const travelMode = req.body.travelMode;

    distance.matrix(origins, destinations, travelMode, function(err, distances) {
        if (!err) {
            res.json(distances.rows);
        }
    });

});

module.exports = router;