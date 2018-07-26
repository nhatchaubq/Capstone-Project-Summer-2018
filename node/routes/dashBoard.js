var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/", (request, response) => {
  request
    .sql(
      "SELECT (SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =(SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Requested')) as 'Dashboard.Requested', " +
      // dien-change count today,tomorrow WO and item count-start
      "(SELECT Count(wo.Id) FROM [WorkOrder] as wo " +
      "where convert(date, wo.ExpectingCloseDate) = convert(date, getdate())  " +
      "AND wo.CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE  woc.Name = N'Working') " +
      "AND wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'In Progress')	) as 'Dashboard.ReturnCountToday', " +

      "(SELECT Count(wo.Id) FROM [WorkOrder] as wo " +
      "where convert(date, dateadd(day, 1, getdate())) = convert(date, ExpectingCloseDate)  " +
      "AND wo.CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE  woc.Name = N'Working') " +
      "AND wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'In Progress')	) as 'Dashboard.ReturnCountTomorrow', " +

      "(SELECT Count(wo.Id) FROM [WorkOrder] as wo " +
      "where convert(date, wo.ExpectingCloseDate) = convert(date, getdate())  " +
      "AND wo.CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE  woc.Name = N'Maintain') " +
      "AND wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'In Progress')	) as 'Dashboard.MaintainCountToday', " +

      "(SELECT Count(wo.Id) FROM [WorkOrder] as wo " +
      "where convert(date, dateadd(day, 1, getdate())) = convert(date, ExpectingCloseDate)  " +
      "AND wo.CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE  woc.Name = N'Maintain') " +
      "AND wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'In Progress')	) as 'Dashboard.MaintainCountTomorrow', " +


      "(SELECT Count(wod.Id) FROM [WorkOrder] as wo " +
      "JOIN [WorkOrderDetail] as wod ON wod.WorkOrderID =wo.Id " +
      "where convert(date, wo.ExpectingCloseDate) = convert(date, getdate())  " +
      "AND  wod.ClosedDate is null  " +
      "AND wo.CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE  woc.Name = N'Working') " +
      "AND wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'In Progress')	) as 'Dashboard.ReturnCountTodayQItem', " +

      "(SELECT Count(wod.Id) FROM [WorkOrder] as wo " +
      "JOIN [WorkOrderDetail] as wod ON wod.WorkOrderID =wo.Id " +
      "where convert(date, dateadd(day, 1, getdate())) = convert(date, ExpectingCloseDate)  " +
      "AND  wod.ClosedDate is null  " +
      "AND wo.CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE  woc.Name = N'Working') " +
      "AND wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'In Progress')	) as 'Dashboard.ReturnCountTomorrowQItem', " +

      "(SELECT Count(wod.Id) FROM [WorkOrder] as wo " +
      "JOIN [WorkOrderDetail] as wod ON wod.WorkOrderID =wo.Id " +
      "where convert(date, wo.ExpectingCloseDate) = convert(date, getdate())  " +
      "AND  wod.ClosedDate is null  " +
      "AND wo.CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE  woc.Name = N'Maintain') " +
      "AND wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'In Progress')	) as 'Dashboard.MaintainCountTodayQItem', " +

      "(SELECT Count(wod.Id) FROM [WorkOrder] as wo " +
      "JOIN [WorkOrderDetail] as wod ON wod.WorkOrderID =wo.Id " +
      "where convert(date, dateadd(day, 1, getdate())) = convert(date, ExpectingCloseDate)  " +
      "AND  wod.ClosedDate is null  " +
      "AND wo.CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE  woc.Name = N'Maintain') " +
      "AND wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'In Progress')	) as 'Dashboard.MaintainCountTomorrowQItem', " +

      "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =(SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Checked')) as 'Dashboard.Checked', " +
      "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =(SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Approved')) as 'Dashboard.Approve', " +
      "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =(SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'In Progress')) as 'Dashboard.InProgress', " +
      "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =(SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Closed')) as 'Dashboard.Closed', " +
      "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =(SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Rejected')) as 'Dashboard.Rejected', " +
      "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =(SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Cancelled')) as 'Dashboard.Cancelled', +" +

      // old-maintain-and-working-start
      // "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, getdate()) = convert(date, ExpectingCloseDate)) as 'Dashboard.MaintainCountToday'," +
      // "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, dateadd(day, 1, getdate())) = convert(date, ExpectingCloseDate)) as 'Dashboard.MaintainCountTomorrow'," +
      // "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working')  and convert(date, getdate()) = convert(date, ExpectingCloseDate) ) as 'Dashboard.ReturnCountToday'," +
      // "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working')  and convert(date, dateadd(day, 1, getdate())) = convert(date, ExpectingCloseDate) ) as 'Dashboard.ReturnCountTomorrow'," +

      // "(SELECT Count(WorkOrderID) FROM [WorkOrderDetail] WHERE WorkOrderID IN (SELECT Id FROM [WorkOrder] WHERE CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain')   and convert(date, getdate()) = convert(date, ExpectingCloseDate))) as 'Dashboard.MaintainCountTodayQItem'," +
      // "(SELECT Count(WorkOrderID) FROM [WorkOrderDetail] WHERE WorkOrderID IN (SELECT Id FROM [WorkOrder] WHERE CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain')   and convert(date, dateadd(day, 1, getdate())) = convert(date, ExpectingCloseDate))) as 'Dashboard.MaintainCountTomorrowQItem'," +
      // "(SELECT Count(WorkOrderID) FROM [WorkOrderDetail] WHERE WorkOrderID IN (SELECT Id FROM [WorkOrder] WHERE CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working')  and convert(date, getdate()) = convert(date, ExpectingCloseDate))) as 'Dashboard.ReturnCountTodayQItem'," +
      // "(SELECT Count(WorkOrderID) FROM [WorkOrderDetail] WHERE WorkOrderID IN (SELECT Id FROM [WorkOrder] WHERE CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working')  and convert(date, dateadd(day, 1, getdate())) = convert(date, ExpectingCloseDate))) as 'Dashboard.ReturnCountTomorrowQItem'," +
      // old-maintain-and-working-end

      "(SELECT COUNT(StatusId)  FROM [EquipmentItem] WHERE StatusId = (SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = N'Available')) as 'PieChartData.Availble.Quantity', (SELECT es.Name FROM [EquipmentStatus] as es WHERE es.Name = N'Available') as 'PieChartData.Availble.Name'," +
      "(SELECT COUNT(StatusId)  FROM [EquipmentItem] WHERE StatusId = (SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = N'Working Approved')) as 'PieChartData.WorkingApproved.Quantity', (SELECT es.Name FROM [EquipmentStatus] as es WHERE es.Name = N'Working Approved') as 'PieChartData.WokingApproved.Name'," +
      "(SELECT COUNT(StatusId)  FROM [EquipmentItem] WHERE StatusId = (SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = N'Working')) as 'PieChartData.Working.Quantity', (SELECT es.Name FROM [EquipmentStatus] as es WHERE es.Name = N'Working') as 'PieChartData.Working.Name'," +
      "(SELECT COUNT(StatusId)  FROM [EquipmentItem] WHERE StatusId = (SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = N'Damaged')) as 'PieChartData.Damaged.Quantity', (SELECT es.Name FROM [EquipmentStatus] as es WHERE es.Name = N'Damaged') as 'PieChartData.Damaged.Name'," +
      "(SELECT COUNT(StatusId)  FROM [EquipmentItem] WHERE StatusId = (SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = N'Maintainance Approved')) as 'PieChartData.MaintainanceApproved.Quantity', (SELECT es.Name FROM [EquipmentStatus] as es WHERE es.Name = N'Maintainance Approved') as 'PieChartData.MaintainanceApproved.Name'," +
      "(SELECT COUNT(StatusId)  FROM [EquipmentItem] WHERE StatusId = (SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = N'Maintaining')) as 'PieChartData.Maintaining.Quantity', (SELECT es.Name FROM [EquipmentStatus] as es WHERE es.Name = N'Maintaining') as 'PieChartData.Maintaining.Name'," +
      "(SELECT COUNT(StatusId)  FROM [EquipmentItem] WHERE StatusId = (SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = N'Lost')) as 'PieChartData.Lost.Quantity', (SELECT es.Name FROM [EquipmentStatus] as es WHERE es.Name = N'Lost') as 'PieChartData.Lost.Name'," +
      "(SELECT COUNT(StatusId)  FROM [EquipmentItem] WHERE StatusId = (SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = N'Archived')) as 'PieChartData.Archived.Quantity', (SELECT es.Name FROM [EquipmentStatus] as es WHERE es.Name = N'Archived') as 'PieChartData.Archived.Name'," +
      "(SELECT COUNT(Id) FROM [WorkOrder] as wo Where wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Closed') and  CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -12))))  and (SELECT EOMONTH ( GETDATE(),  -11)))as 'LineChart.Maintain.Last11Month', " +
      "(SELECT COUNT(Id) FROM [WorkOrder] as wo Where wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Closed') and  CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -11))))  and (SELECT EOMONTH ( GETDATE(),  -10)))as 'LineChart.Maintain.Last10Month', " +
      "(SELECT COUNT(Id) FROM [WorkOrder] as wo Where wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Closed') and  CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -10))))  and (SELECT EOMONTH ( GETDATE(),  -9)))as 'LineChart.Maintain.Last9Month', " +
      "(SELECT COUNT(Id) FROM [WorkOrder] as wo Where wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Closed') and  CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -9))))  and (SELECT EOMONTH ( GETDATE(),  -8)))as 'LineChart.Maintain.Last8Month', " +
      "(SELECT COUNT(Id) FROM [WorkOrder] as wo Where wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Closed') and  CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -8))))  and (SELECT EOMONTH ( GETDATE(),  -7)))as 'LineChart.Maintain.Last7Month', " +
      "(SELECT COUNT(Id) FROM [WorkOrder] as wo Where wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Closed') and  CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -7))))  and (SELECT EOMONTH ( GETDATE(),  -6)))as 'LineChart.Maintain.Last6Month', " +
      "(SELECT COUNT(Id) FROM [WorkOrder] as wo Where wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Closed') and  CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -6))))  and (SELECT EOMONTH ( GETDATE(),  -5)))as 'LineChart.Maintain.Last5Month', " +
      "(SELECT COUNT(Id) FROM [WorkOrder] as wo Where wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Closed') and  CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -5))))  and (SELECT EOMONTH ( GETDATE(),  -4)))as 'LineChart.Maintain.Last4Month', " +
      "(SELECT COUNT(Id) FROM [WorkOrder] as wo Where wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Closed') and  CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -4))))  and (SELECT EOMONTH ( GETDATE(),  -3)))as 'LineChart.Maintain.Last3Month', " +
      "(SELECT COUNT(Id) FROM [WorkOrder] as wo Where wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Closed') and  CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -3))))  and (SELECT EOMONTH ( GETDATE(),  -2)))as 'LineChart.Maintain.Last2Month', " +
      "(SELECT COUNT(Id) FROM [WorkOrder] as wo Where wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Closed') and  CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -2))))  and (SELECT EOMONTH ( GETDATE(),  -1)))as 'LineChart.Maintain.LastMonth', " +
      "(SELECT COUNT(Id) FROM [WorkOrder] as wo Where wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Closed') and  CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -1))))  and (SELECT EOMONTH ( GETDATE(),  0)))as 'LineChart.Maintain.ThisMonth', " +
      "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -12))))  and (SELECT EOMONTH ( GETDATE(),-11)))as 'LineChart.Working.Last11Month'," +
      "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -11))))  and (SELECT EOMONTH ( GETDATE(),-10)))as 'LineChart.Working.Last10Month'," +
      "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -10))))  and (SELECT EOMONTH ( GETDATE(),-9)))as 'LineChart.Working.Last9Month'," +
      "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -9))))  and (SELECT EOMONTH ( GETDATE(), -8)))as 'LineChart.Working.Last8Month'," +
      "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -8))))  and (SELECT EOMONTH ( GETDATE(), -7)))as 'LineChart.Working.Last7Month'," +
      "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -7))))  and (SELECT EOMONTH ( GETDATE(), -6)))as 'LineChart.Working.Last6Month'," +
      "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -6))))  and (SELECT EOMONTH ( GETDATE(), -5)))as 'LineChart.Working.Last5Month'," +
      "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -5))))  and (SELECT EOMONTH ( GETDATE(), -4)))as 'LineChart.Working.Last4Month'," +
      "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -4))))  and (SELECT EOMONTH ( GETDATE(), -3)))as 'LineChart.Working.Last3Month'," +
      "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -3))))  and (SELECT EOMONTH ( GETDATE(), -2)))as 'LineChart.Working.Last2Month'," +
      "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -2))))  and (SELECT EOMONTH ( GETDATE(), -1)))as 'LineChart.Working.LastMonth'," +
      "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -1))))  and (SELECT EOMONTH ( GETDATE(), 0))) as 'LineChart.Working.ThisMonth'," +
      "(SELECT STUFF( CONVERT( char(11), DATEADD(month,-11,getdate())), 5, 5, '')) as 'LineChart.Month.Last11Month'," +
      "(SELECT STUFF( CONVERT( char(11), DATEADD(month,-10,getdate())), 5, 5, '')) as 'LineChart.Month.Last10Month', " +
      "(SELECT STUFF( CONVERT( char(11), DATEADD(month,-9,getdate())), 5, 5, '')) as 'LineChart.Month.Last9Month', " +
      "(SELECT STUFF( CONVERT( char(11), DATEADD(month,-8,getdate())), 5, 5, '')) as 'LineChart.Month.Last8Month', " +
      "(SELECT STUFF( CONVERT( char(11), DATEADD(month,-7,getdate())), 5, 5, '')) as 'LineChart.Month.Last7Month', " +
      "(SELECT STUFF( CONVERT( char(11), DATEADD(month,-6,getdate())), 5, 5, '')) as 'LineChart.Month.Last6Month', " +
      "(SELECT STUFF( CONVERT( char(11), DATEADD(month,-5,getdate())), 5, 5, '')) as 'LineChart.Month.Last5Month', " +
      "(SELECT STUFF( CONVERT( char(11), DATEADD(month,-4,getdate())), 5, 5, '')) as 'LineChart.Month.Last4Month', " +
      "(SELECT STUFF( CONVERT( char(11), DATEADD(month,-3,getdate())), 5, 5, '')) as 'LineChart.Month.Last3Month', " +
      "(SELECT STUFF( CONVERT( char(11), DATEADD(month,-2,getdate())), 5, 5, '')) as 'LineChart.Month.Last2Month'," +
      "(SELECT STUFF( CONVERT( char(11), DATEADD(month,-1,getdate())), 5, 5, '')) as 'LineChart.Month.LastMonth', " +
      "(SELECT STUFF( CONVERT( char(11), DATEADD(month,0,getdate())), 5, 5, '')) as 'LineChart.Month.ThisMonth', " +
      "(SELECT Name from [WorkOrderCategory] where Id =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain')) as 'LineChart.MaintainName'," +
      "(SELECT Name from [WorkOrderCategory] where Id =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working')) as 'LineChart.WorkingName'," +
      "(SELECT count(*) FROM [Equipment] as e JOIN [EquipmentItem] as ei ON ei.EquipmentID =e.Id WHERE StatusId not in (select es.Id from [EquipmentStatus] as es where es.Name = N'Available' or es.Name = N'Archived' or es.Name = N'Lost') ) as 'Doughnut.Today.UnAvailableItemCount'," +
      "(SELECT count(*) FROM [Equipment] as e JOIN [EquipmentItem] as ei ON ei.EquipmentID =e.Id WHERE StatusId =(select es.Id from [EquipmentStatus] as es where es.Name = N'Available') ) as 'Doughnut.Today.AvailableItemCount'," +
      "(select [Name] from EquipmentStatus where Id = (select es.Id from [EquipmentStatus] as es where es.Name = N'Available')) as 'Doughnut.Available.Name'," +
      "(select [Name] from EquipmentStatus where Id = (select es.Id from [EquipmentStatus] as es where es.Name = N'Working Approved')) as 'Doughnut.Unavailable.Name' ," +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Damaged') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -12))))  and (SELECT EOMONTH ( GETDATE(), -11))) as 'LC.Damaged.Last11Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Damaged') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -11))))  and (SELECT EOMONTH ( GETDATE(), -10))) as 'LC.Damaged.Last10Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Damaged') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -10))))  and (SELECT EOMONTH ( GETDATE(), -9))) as 'LC.Damaged.Last9Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Damaged') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -9))))  and (SELECT EOMONTH ( GETDATE(), -8))) as 'LC.Damaged.Last8Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Damaged') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -8))))  and (SELECT EOMONTH ( GETDATE(), -7))) as 'LC.Damaged.Last7Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Damaged') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -7))))  and (SELECT EOMONTH ( GETDATE(), -6))) as 'LC.Damaged.Last6Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Damaged') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -6))))  and (SELECT EOMONTH ( GETDATE(), -5))) as 'LC.Damaged.Last5Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Damaged') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -5))))  and (SELECT EOMONTH ( GETDATE(), -4))) as 'LC.Damaged.Last4Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Damaged') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -4))))  and (SELECT EOMONTH ( GETDATE(), -3))) as 'LC.Damaged.Last3Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Damaged') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -3))))  and (SELECT EOMONTH ( GETDATE(), -2))) as 'LC.Damaged.Last2Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Damaged') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -2))))  and (SELECT EOMONTH ( GETDATE(), -1))) as 'LC.Damaged.LastMonth', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Damaged') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -1))))  and (SELECT EOMONTH ( GETDATE(), 0))) as 'LC.Damaged.ThisMonth', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Lost') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -12))))  and (SELECT EOMONTH ( GETDATE(), -11))) as 'LC.Lost.Last11Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Lost') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -11))))  and (SELECT EOMONTH ( GETDATE(), -10))) as 'LC.Lost.Last10Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Lost') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -10))))  and (SELECT EOMONTH ( GETDATE(), -9))) as 'LC.Lost.Last9Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Lost') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -9))))  and (SELECT EOMONTH ( GETDATE(), -8))) as 'LC.Lost.Last8Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Lost') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -8))))  and (SELECT EOMONTH ( GETDATE(), -7))) as 'LC.Lost.Last7Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Lost') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -7))))  and (SELECT EOMONTH ( GETDATE(), -6))) as 'LC.Lost.Last6Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Lost') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -6))))  and (SELECT EOMONTH ( GETDATE(), -5))) as 'LC.Lost.Last5Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Lost') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -5))))  and (SELECT EOMONTH ( GETDATE(), -4))) as 'LC.Lost.Last4Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Lost') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -4))))  and (SELECT EOMONTH ( GETDATE(), -3))) as 'LC.Lost.Last3Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Lost') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -3))))  and (SELECT EOMONTH ( GETDATE(), -2))) as 'LC.Lost.Last2Month', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Lost') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -2))))  and (SELECT EOMONTH ( GETDATE(), -1))) as 'LC.Lost.LastMonth', " +
      " (SELECT COUNT(Id) FROM [EquipmentItemHistory] Where NewStatusID =(SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = 'Lost') and convert(date, [Date]) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -1))))  and (SELECT EOMONTH ( GETDATE(), 0))) as 'LC.Lost.ThisMonth' " +
      " FOR JSON PATH,  without_array_wrapper"
    ) //damaged equipment linechart
    .into(response);
});

// dien change working and maintain- start

router.get("/workorderdb", (request, response) => {
  request
    .sql(
      "SELECT" +

      "(json_query((select distinct wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor],  json_query((select count(wod.Id) as [Quantity] from WorkOrderDetail as wod join WorkOrder as wo1 on wod.WorkOrderId = wo1.Id where wo.Id = wo1.Id AND wod.ClosedDate is null for json path, without_array_wrapper)) as [Detail],  " +

      "l.Id as [Location.Id], l.[Name] as [Location.Name], l.[Address] as [Location.Address],    " +
      "t.Id as [Team.Id], t.[Name] as [Team.Name]   " +
      "from WorkOrder as wo   " +
      "join WorkOrderStatus as wos on wo.StatusID = wos.Id   " +
      "join Account as acc on wo.RequestUserID = acc.Id   " +
      "join [Priority] as p on wo.PriorityID = p.Id   " +
      "join TeamLocation as tl on wo.TeamLocationID = tl.Id   " +
      "join [Location] as l on tl.LocationID = l.Id   " +
      "JOIN [WorkOrderDetail] as wod ON wod.WorkOrderID = wo.Id " +
      "join Team as t on tl.TeamID = t.Id   " +
      "where convert(date, wo.ExpectingCloseDate) = convert(date, getdate())   " +
      "AND wo.CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE  woc.Name = N'Maintain') " +
      "AND wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'In Progress')		 " +
      "AND  wod.ClosedDate is null  " +
      "for json path))) as 'todayMaintainOrder',   " +

      "(json_query((select distinct wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor],  json_query((select count(wod.Id) as [Quantity] from WorkOrderDetail as wod join WorkOrder as wo1 on wod.WorkOrderId = wo1.Id where wo.Id = wo1.Id AND wod.ClosedDate is null for json path, without_array_wrapper)) as [Detail],  " +
      "l.Id as [Location.Id], l.[Name] as [Location.Name], l.[Address] as [Location.Address],    " +
      "t.Id as [Team.Id], t.[Name] as [Team.Name]   " +
      "from WorkOrder as wo   " +
      "join WorkOrderStatus as wos on wo.StatusID = wos.Id   " +
      "join Account as acc on wo.RequestUserID = acc.Id   " +
      "join [Priority] as p on wo.PriorityID = p.Id   " +
      "join TeamLocation as tl on wo.TeamLocationID = tl.Id   " +
      "join [Location] as l on tl.LocationID = l.Id   " +
      "JOIN [WorkOrderDetail] as wod ON wod.WorkOrderID = wo.Id " +
      "join Team as t on tl.TeamID = t.Id   " +
      "where convert(date, wo.ExpectingCloseDate) = dateadd(day, 1, convert(date, getdate()))   " +
      "AND wo.CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE  woc.Name = N'Maintain') " +
      "AND wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'In Progress')		 " +
      "AND  wod.ClosedDate is null  " +
      "for json path))) as 'tomorrowMaintainOrder',   " +

      "(json_query((select distinct wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor],  json_query((select count(wod.Id) as [Quantity] from WorkOrderDetail as wod join WorkOrder as wo1 on wod.WorkOrderId = wo1.Id where wo.Id = wo1.Id AND wod.ClosedDate is null for json path, without_array_wrapper)) as [Detail],  " +
      "l.Id as [Location.Id], l.[Name] as [Location.Name], l.[Address] as [Location.Address],    " +
      "t.Id as [Team.Id], t.[Name] as [Team.Name]   " +
      "from WorkOrder as wo   " +
      "join WorkOrderStatus as wos on wo.StatusID = wos.Id   " +
      "join Account as acc on wo.RequestUserID = acc.Id   " +
      "join [Priority] as p on wo.PriorityID = p.Id   " +
      "join TeamLocation as tl on wo.TeamLocationID = tl.Id   " +
      "join [Location] as l on tl.LocationID = l.Id   " +
      "JOIN [WorkOrderDetail] as wod ON wod.WorkOrderID = wo.Id " +
      "join Team as t on tl.TeamID = t.Id   " +
      "where convert(date, wo.ExpectingCloseDate) = convert(date, getdate())  " +
      "AND wo.CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE  woc.Name = N'Working') " +
      "AND wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'In Progress')		 " +
      "AND  wod.ClosedDate is null  " +
      "for json path))) as 'todayWokingOrder',   " +

      "(json_query((select distinct wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor],  json_query((select count(wod.Id) as [Quantity] from WorkOrderDetail as wod join WorkOrder as wo1 on wod.WorkOrderId = wo1.Id where wo.Id = wo1.Id AND wod.ClosedDate is null for json path, without_array_wrapper)) as [Detail],  " +
      "l.Id as [Location.Id], l.[Name] as [Location.Name], l.[Address] as [Location.Address],    " +
      "t.Id as [Team.Id], t.[Name] as [Team.Name]   " +
      "from WorkOrder as wo   " +
      "join WorkOrderStatus as wos on wo.StatusID = wos.Id   " +
      "join Account as acc on wo.RequestUserID = acc.Id   " +
      "join [Priority] as p on wo.PriorityID = p.Id   " +
      "join TeamLocation as tl on wo.TeamLocationID = tl.Id   " +
      "join [Location] as l on tl.LocationID = l.Id   " +
      "JOIN [WorkOrderDetail] as wod ON wod.WorkOrderID = wo.Id " +
      "join Team as t on tl.TeamID = t.Id   " +
      "where convert(date, wo.ExpectingCloseDate) = dateadd(day, 1, convert(date, getdate()))  " +
      "AND wo.CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE  woc.Name = N'Working') " +
      "AND wo.StatusID = (SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'In Progress')		 " +
      "AND  wod.ClosedDate is null  " +
      "for json path))) as 'tomorrowWokingOrder'   " +
      " FOR JSON PATH,  without_array_wrapper"
    )
    .into(response);
});

// dien change working and maintain- end
router.get("/getCategory", (req, res) => {
  req
    .sql(
      "select ec.*, json_query((SELECT count(*) as [Quanity] " +
      "FROM [EquipmentItem] as ei " +
      "WHERE ei.StatusId = (select Id from EquipmentStatus where [Name] = N'Available')  " +
      "and ei.EquipmentID IN (SELECT e.Id  " +
      "FROM [Equipment] as e  " +
      "WHERE e.CategoryID = ec.Id) " +
      "for json path, without_array_wrapper)) as 'Available', json_query((SELECT count(*) as [Quanity] " +
      "FROM [EquipmentItem] as ei " +
      "WHERE ei.StatusId NOT IN (select Id from EquipmentStatus where [Name] = N'Available')  " +
      "and ei.EquipmentID in (SELECT e.Id  " +
      " FROM [Equipment] as e  " +
      "WHERE e.CategoryID = ec.Id) " +
      "for json path, without_array_wrapper)) as 'Unavailable' " +
      "from EquipmentCategory as ec " +
      "for json path "
    )
    .into(res);
});
module.exports = router;