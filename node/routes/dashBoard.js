var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/", (request, response) => {
  request
    .sql(
      "SELECT (SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =1 ) as 'Dashboard.Requested'," +
        "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =2 ) as 'Dashboard.Checked'," +
        "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =3 ) as 'Dashboard.Approve'," +
        "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =4 ) as 'Dashboard.InProgress'," +
        "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =5 ) as 'Dashboard.Closed'," +
        "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =6 ) as 'Dashboard.Rejected'," +
        "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =1009 ) as 'Dashboard.Cancelled'," +
        // "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = 1 and  StatusID =4) as 'Dashboard.MaintainCountToday'," +
        // "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = 1 and  StatusID =4) as 'Dashboard.MaintainCountTomorrow'," +
        // "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = 2 and  StatusID =4) as  'Dashboard.ReturnCountToday'," +
        // "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = 2 and  StatusID =4) as  'Dashboard.ReturnCountTomorrow'," +
        "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = 1 and convert(date, getdate()) = convert(date, DueDate)) as 'Dashboard.MaintainCountToday'," +
        "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = 1 and convert(date, dateadd(day, 1, getdate())) = convert(date, DueDate)) as 'Dashboard.MaintainCountTomorrow'," +
        "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = 2 and  StatusID =4 and convert(date, getdate()) = convert(date, DueDate) ) as 'Dashboard.ReturnCountToday'," +
        "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = 2 and  StatusID =4 and convert(date, dateadd(day, 1, getdate())) = convert(date, DueDate) ) as 'Dashboard.ReturnCountTomorrow'," +
        "(SELECT Count(WorkOrderID) FROM [WorkOrderDetail] WHERE WorkOrderID IN (SELECT Id FROM [WorkOrder] WHERE CategoryID = 1 and StatusID =4)) as 'Dashboard.MaintainCountTodayQItem'," +
        "(SELECT Count(WorkOrderID) FROM [WorkOrderDetail] WHERE WorkOrderID IN (SELECT Id FROM [WorkOrder] WHERE CategoryID = 1 and StatusID =4)) as 'Dashboard.MaintainCountTomorrowQItem'," +
        "(SELECT Count(WorkOrderID) FROM [WorkOrderDetail] WHERE WorkOrderID IN (SELECT Id FROM [WorkOrder] WHERE CategoryID = 2 and StatusID =4)) as 'Dashboard.ReturnCountTodayQItem'," +
        "(SELECT Count(WorkOrderID) FROM [WorkOrderDetail] WHERE WorkOrderID IN (SELECT Id FROM [WorkOrder] WHERE CategoryID = 2 and StatusID =4)) as 'Dashboard.ReturnCountTomorrowQItem'" +
        // "(SELECT Count(WorkOrderID) FROM [WorkOrderDetail] WHERE WorkOrderID IN (SELECT Id FROM [WorkOrder] WHERE CategoryID = 2 and StatusID =4 and convert(date, dateadd(day, 1, getdate())) = convert(date, DueDate))) as 'Dashboard.ReturnCountTomorrowQItem'" +
        "FOR JSON PATH,  without_array_wrapper"
    )
    .into(response);
});

module.exports = router;
