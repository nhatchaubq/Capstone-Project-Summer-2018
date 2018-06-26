var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/", (request, response) => {
    request.sql("SELECT (SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =1 ) as 'Dashboard.Requested'," +
            "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =2 ) as 'Dashboard.Checked'," +
            "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =3 ) as 'Dashboard.Approve'," +
            "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =4 ) as 'Dashboard.InProgress'," +
            "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =5 ) as 'Dashboard.Closed'," +
            "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =6 ) as 'Dashboard.Rejected'," +
            "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =1009 ) as 'Dashboard.Cancelled'" +
            "FOR JSON PATH,  without_array_wrapper")
        .into(response);
});




module.exports = router;