var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/", (request, response) => {
  request
    .sql(
      "SELECT (SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =(SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Requested')) as 'Dashboard.Requested', " +
      "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =(SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Checked')) as 'Dashboard.Checked', " +
      "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =(SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Approved')) as 'Dashboard.Approve', " +
      "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =(SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'In Progress')) as 'Dashboard.InProgress', " +
      "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =(SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Closed')) as 'Dashboard.Closed', " +
      "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =(SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Rejected')) as 'Dashboard.Rejected', " +
      "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =(SELECT wos.Id FROM [WorkOrderStatus] as wos WHERE wos.Name = N'Cancelled')) as 'Dashboard.Cancelled', +" +
      "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, getdate()) = convert(date, ExpectingCloseDate)) as 'Dashboard.MaintainCountToday'," +
      "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, dateadd(day, 1, getdate())) = convert(date, ExpectingCloseDate)) as 'Dashboard.MaintainCountTomorrow'," +
      "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working')  and convert(date, getdate()) = convert(date, ExpectingCloseDate) ) as 'Dashboard.ReturnCountToday'," +
      "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working')  and convert(date, dateadd(day, 1, getdate())) = convert(date, ExpectingCloseDate) ) as 'Dashboard.ReturnCountTomorrow'," +
      "(SELECT Count(WorkOrderID) FROM [WorkOrderDetail] WHERE WorkOrderID IN (SELECT Id FROM [WorkOrder] WHERE CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain')   and convert(date, getdate()) = convert(date, ExpectingCloseDate))) as 'Dashboard.MaintainCountTodayQItem'," +
      "(SELECT Count(WorkOrderID) FROM [WorkOrderDetail] WHERE WorkOrderID IN (SELECT Id FROM [WorkOrder] WHERE CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain')   and convert(date, dateadd(day, 1, getdate())) = convert(date, ExpectingCloseDate))) as 'Dashboard.MaintainCountTomorrowQItem'," +
      "(SELECT Count(WorkOrderID) FROM [WorkOrderDetail] WHERE WorkOrderID IN (SELECT Id FROM [WorkOrder] WHERE CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working')  and convert(date, getdate()) = convert(date, ExpectingCloseDate))) as 'Dashboard.ReturnCountTodayQItem'," +
      "(SELECT Count(WorkOrderID) FROM [WorkOrderDetail] WHERE WorkOrderID IN (SELECT Id FROM [WorkOrder] WHERE CategoryID = (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working')  and convert(date, dateadd(day, 1, getdate())) = convert(date, ExpectingCloseDate))) as 'Dashboard.ReturnCountTomorrowQItem'," +
      "(SELECT COUNT(StatusId)  FROM [EquipmentItem] WHERE StatusId = (SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = N'Available')) as 'PieChartData.Availble.Quantity', (SELECT es.Name FROM [EquipmentStatus] as es WHERE es.Name = N'Available') as 'PieChartData.Availble.Name'," +
      "(SELECT COUNT(StatusId)  FROM [EquipmentItem] WHERE StatusId = (SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = N'Working Approved')) as 'PieChartData.WorkingApproved.Quantity', (SELECT es.Name FROM [EquipmentStatus] as es WHERE es.Name = N'Working Approved') as 'PieChartData.WokingApproved.Name'," +
      "(SELECT COUNT(StatusId)  FROM [EquipmentItem] WHERE StatusId = (SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = N'Working')) as 'PieChartData.Working.Quantity', (SELECT es.Name FROM [EquipmentStatus] as es WHERE es.Name = N'Working') as 'PieChartData.Working.Name'," +
      "(SELECT COUNT(StatusId)  FROM [EquipmentItem] WHERE StatusId = (SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = N'Damaged')) as 'PieChartData.Damaged.Quantity', (SELECT es.Name FROM [EquipmentStatus] as es WHERE es.Name = N'Damaged') as 'PieChartData.Damaged.Name'," +
      "(SELECT COUNT(StatusId)  FROM [EquipmentItem] WHERE StatusId = (SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = N'Maintainance Approved')) as 'PieChartData.MaintainanceApproved.Quantity', (SELECT es.Name FROM [EquipmentStatus] as es WHERE es.Name = N'Maintainance Approved') as 'PieChartData.MaintainanceApproved.Name'," +
      "(SELECT COUNT(StatusId)  FROM [EquipmentItem] WHERE StatusId = (SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = N'Maintaining')) as 'PieChartData.Maintaining.Quantity', (SELECT es.Name FROM [EquipmentStatus] as es WHERE es.Name = N'Maintaining') as 'PieChartData.Maintaining.Name'," +
      "(SELECT COUNT(StatusId)  FROM [EquipmentItem] WHERE StatusId = (SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = N'Lost')) as 'PieChartData.Lost.Quantity', (SELECT es.Name FROM [EquipmentStatus] as es WHERE es.Name = N'Lost') as 'PieChartData.Lost.Name'," +
      "(SELECT COUNT(StatusId)  FROM [EquipmentItem] WHERE StatusId = (SELECT es.Id FROM [EquipmentStatus] as es WHERE es.Name = N'Archived')) as 'PieChartData.Archived.Quantity', (SELECT es.Name FROM [EquipmentStatus] as es WHERE es.Name = N'Archived') as 'PieChartData.Archived.Name'," + // "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -10))))  and (SELECT EOMONTH ( GETDATE(),-9)))as 'LineChart.Maintain.Last9Month'," + // "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = 2 and  StatusID =4) as  'Dashboard.ReturnCountTomorrow'," + // "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = 2 and  StatusID =4) as  'Dashboard.ReturnCountToday'," + // "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = 1 and  StatusID =4) as 'Dashboard.MaintainCountTomorrow'," + // "(SELECT Count(Id) FROM [WorkOrder] WHERE CategoryID = 1 and  StatusID =4) as 'Dashboard.MaintainCountToday'," + // "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -11))))  and (SELECT EOMONTH ( GETDATE(),-10)))as 'LineChart.Maintain.Last10Month'," + // "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -12))))  and (SELECT EOMONTH ( GETDATE(),-11)))as 'LineChart.Maintain.Last11Month'," + //start maintain(old) // "(SELECT Count(WorkOrderID) FROM [WorkOrderDetail] WHERE WorkOrderID IN (SELECT Id FROM [WorkOrder] WHERE CategoryID = 2 and StatusID =4 and convert(date, dateadd(day, 1, getdate())) = convert(date, ExpectingCloseDate))) as 'Dashboard.ReturnCountTomorrowQItem'" + // "(SELECT COUNT(Id)   FROM [WorkOrder]   WHERE StatusID =5 ) as 'LineChart.Closed.Quantity'," +
      // "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -9))))  and (SELECT EOMONTH ( GETDATE(), -8)))as 'LineChart.Maintain.Last8Month'," +
      // "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -8))))  and (SELECT EOMONTH ( GETDATE(), -7)))as 'LineChart.Maintain.Last7Month'," +
      // "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -7))))  and (SELECT EOMONTH ( GETDATE(), -6)))as 'LineChart.Maintain.Last6Month'," +
      // "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -6))))  and (SELECT EOMONTH ( GETDATE(), -5)))as 'LineChart.Maintain.Last5Month'," +
      // "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -5))))  and (SELECT EOMONTH ( GETDATE(), -4)))as 'LineChart.Maintain.Last4Month'," +
      // "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -4))))  and (SELECT EOMONTH ( GETDATE(), -3)))as 'LineChart.Maintain.Last3Month'," +
      // "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -3))))  and (SELECT EOMONTH ( GETDATE(), -2)))as 'LineChart.Maintain.Last2Month'," +
      // "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -2))))  and (SELECT EOMONTH ( GETDATE(), -1)))as 'LineChart.Maintain.LastMonth'," +
      // "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -1))))  and (SELECT EOMONTH ( GETDATE(),  0)))as 'LineChart.Maintain.ThisMonth'," +
      //end maintain(old)

      //start maintain(new)
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
      "(SELECT COUNT(Id) FROM [WorkOrder] Where CategoryID =(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working') and convert(date, ClosedDate) between (SELECT convert(date, dateadd(day, 1,EOMONTH (GETDATE(), -1))))  and (SELECT EOMONTH ( GETDATE(), 0))) as 'LineChart.Working.ThisMonth'," + // "(SELECT LEFT(DATENAME(MONTH, DATEADD(month,-9,getdate())),3) + ' ' + RIGHT('00' + CAST(YEAR(GETDATE()) AS VARCHAR),2)) as 'LineChart.Month.Last9Month'," + // "(SELECT LEFT(DATENAME(MONTH, DATEADD(month,-10,getdate())),3) + ' ' + RIGHT('00' + CAST(YEAR(GETDATE()) AS VARCHAR),2)) as 'LineChart.Month.Last10Month'," + // "(SELECT LEFT(DATENAME(MONTH, DATEADD(month,-11,getdate())),3) + ' ' + RIGHT('00' + CAST(YEAR(GETDATE()) AS VARCHAR),2)) as 'LineChart.Month.Last11Month'," + // get  name of month start (old) //end maintain(new) //end woking
      // "(SELECT LEFT(DATENAME(MONTH, DATEADD(month,-8,getdate())),3) + ' ' + RIGHT('00' + CAST(YEAR(GETDATE()) AS VARCHAR),2)) as 'LineChart.Month.Last8Month'," +
      // "(SELECT LEFT(DATENAME(MONTH, DATEADD(month,-7,getdate())),3) + ' ' + RIGHT('00' + CAST(YEAR(GETDATE()) AS VARCHAR),2)) as 'LineChart.Month.Last7Month'," +
      // "(SELECT LEFT(DATENAME(MONTH, DATEADD(month,-6,getdate())),3) + ' ' + RIGHT('00' + CAST(YEAR(GETDATE()) AS VARCHAR),2)) as 'LineChart.Month.Last6Month'," +
      // "(SELECT LEFT(DATENAME(MONTH, DATEADD(month,-5,getdate())),3) + ' ' + RIGHT('00' + CAST(YEAR(GETDATE()) AS VARCHAR),2)) as 'LineChart.Month.Last5Month'," +
      // "(SELECT LEFT(DATENAME(MONTH, DATEADD(month,-4,getdate())),3) + ' ' + RIGHT('00' + CAST(YEAR(GETDATE()) AS VARCHAR),2)) as 'LineChart.Month.Last4Month'," +
      // "(SELECT LEFT(DATENAME(MONTH, DATEADD(month,-3,getdate())),3) + ' ' + RIGHT('00' + CAST(YEAR(GETDATE()) AS VARCHAR),2)) as 'LineChart.Month.Last3Month'," +
      // "(SELECT LEFT(DATENAME(MONTH, DATEADD(month,-2,getdate())),3) + ' ' + RIGHT('00' + CAST(YEAR(GETDATE()) AS VARCHAR),2)) as 'LineChart.Month.Last2Month'," +
      // "(SELECT LEFT(DATENAME(MONTH, DATEADD(month,-1,getdate())),3) + ' ' + RIGHT('00' + CAST(YEAR(GETDATE()) AS VARCHAR),2)) as 'LineChart.Month.LastMonth'," +
      // "(SELECT LEFT(DATENAME(MONTH, DATEADD(month,0,getdate())),3) + ' ' + RIGHT('00' + CAST(YEAR(GETDATE()) AS VARCHAR),2)) as 'LineChart.Month.ThisMonth'," +
      // get name of month end(old)

      // get  name of month start (new)
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
      "(SELECT count(*) FROM [Equipment] as e JOIN [EquipmentItem] as ei ON ei.EquipmentID =e.Id WHERE StatusId !=(select es.Id from [EquipmentStatus] as es where es.Name = N'Available') ) as 'Doughnut.Today.UnAvailableItemCount'," +
      "(SELECT count(*) FROM [Equipment] as e JOIN [EquipmentItem] as ei ON ei.EquipmentID =e.Id WHERE StatusId =(select es.Id from [EquipmentStatus] as es where es.Name = N'Available') ) as 'Doughnut.Today.AvailableItemCount'," +
      "(select [Name] from EquipmentStatus where Id = (select es.Id from [EquipmentStatus] as es where es.Name = N'Available')) as 'Doughnut.Available.Name'," +
      "(select [Name] from EquipmentStatus where Id = (select es.Id from [EquipmentStatus] as es where es.Name = N'Working Approved')) as 'Doughnut.Unavailable.Name'" + // "json_query((select * from WorkOrder as wo where convert(date, wo.ExpectingCloseDate) = convert(date, getdate()) and wo.CategoryID=2 for json path)) as 'todayWokingOrder'," + // "json_query((select * from WorkOrder as wo where convert(date, wo.ExpectingCloseDate) = dateadd(day, 1, convert(date, getdate())) and wo.CategoryID=1 for json path)) as 'tomorrowMaintainOrder'," + // "json_query((select * from WorkOrder as wo where convert(date, wo.ExpectingCloseDate) = convert(date, getdate()) and wo.CategoryID=1 for json path)) as 'todayMaintainOrder'," + //work order start(old) // get name of month end(new) //line chart(line's name ) end
        // "json_query((select * from WorkOrder as wo where convert(date, wo.ExpectingCloseDate) = dateadd(day, 1, convert(date, getdate())) and wo.CategoryID=2 for json path)) as 'tomorrowWokingOrder'" +
        //work order end(old)
      "json_query((select wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor]," +
      "                l.Id as [Location.Id], l.[Name] as [Location.Name], l.[Address] as [Location.Address], " +
      "                t.Id as [Team.Id], t.[Name] as [Team.Name]" +
      "        from WorkOrder as wo" +
      "        join WorkOrderStatus as wos on wo.StatusID = wos.Id" +
      "       join Account as acc on wo.RequestUserID = acc.Id" +
      "        join [Priority] as p on wo.PriorityID = p.Id" +
      "        join TeamLocation as tl on wo.TeamLocationID = tl.Id" +
      "       join [Location] as l on tl.LocationID = l.Id" +
      "       join Team as t on tl.TeamID = t.Id" +
      "        where convert(date, wo.ExpectingCloseDate) = convert(date, getdate()) and wo.CategoryID=1 " +
      "        order by wo.CreateDate desc" +
      "       for json path)) as 'todayMaintainOrder'," +
      "json_query((select wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor]," +
      "                  l.Id as [Location.Id], l.[Name] as [Location.Name], l.[Address] as [Location.Address], " +
      "                t.Id as [Team.Id], t.[Name] as [Team.Name]" +
      "      from WorkOrder as wo" +
      "      join WorkOrderStatus as wos on wo.StatusID = wos.Id" +
      "      join Account as acc on wo.RequestUserID = acc.Id" +
      "      join [Priority] as p on wo.PriorityID = p.Id" +
      "      join TeamLocation as tl on wo.TeamLocationID = tl.Id" +
      "      join [Location] as l on tl.LocationID = l.Id" +
      "      join Team as t on tl.TeamID = t.Id" +
      "      where convert(date, wo.ExpectingCloseDate) = dateadd(day, 1, convert(date, getdate())) and wo.CategoryID=1 " +
      "      order by wo.CreateDate desc" +
      "      for json path)) as 'tomorrowMaintainOrder'," +
      "json_query((select wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor]," +
      "                l.Id as [Location.Id], l.[Name] as [Location.Name], l.[Address] as [Location.Address], " +
      "              t.Id as [Team.Id], t.[Name] as [Team.Name]" +
      "    from WorkOrder as wo" +
      "    join WorkOrderStatus as wos on wo.StatusID = wos.Id" +
      "    join Account as acc on wo.RequestUserID = acc.Id" +
      "    join [Priority] as p on wo.PriorityID = p.Id" +
      "    join TeamLocation as tl on wo.TeamLocationID = tl.Id" +
      "     join [Location] as l on tl.LocationID = l.Id" +
      "    join Team as t on tl.TeamID = t.Id" +
      "    where convert(date, wo.ExpectingCloseDate) = convert(date, getdate()) and wo.CategoryID=2 " +
      "    order by wo.CreateDate desc" +
      "    for json path)) as 'todayWokingOrder'," +
      "json_query((select wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor]," +
      "                  l.Id as [Location.Id], l.[Name] as [Location.Name], l.[Address] as [Location.Address], " +
      "                t.Id as [Team.Id], t.[Name] as [Team.Name]" +
      "     from WorkOrder as wo" +
      "     join WorkOrderStatus as wos on wo.StatusID = wos.Id" +
      "     join Account as acc on wo.RequestUserID = acc.Id" +
      "   join [Priority] as p on wo.PriorityID = p.Id" +
      "    join TeamLocation as tl on wo.TeamLocationID = tl.Id" +
      "    join [Location] as l on tl.LocationID = l.Id" +
      "   join Team as t on tl.TeamID = t.Id" +
      "   where convert(date, wo.ExpectingCloseDate) = dateadd(day, 1, convert(date, getdate())) and wo.CategoryID=2 " +
      "   order by wo.CreateDate desc" +
      "  for json path)) as 'tomorrowWokingOrder'" +
      */
        //work order end(new)
        "FOR JSON PATH,  without_array_wrapper"
    )
    .into(response);
});
router.get("/workorderdb", (request, response) => {
  request
    .sql(
      "SELECT" +

        "(json_query((select wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor],  json_query((select count(wod.Id) as [Quantity] from WorkOrderDetail as wod join WorkOrder as wo1 on wod.WorkOrderId = wo1.Id where wo.Id = wo1.Id for json path, without_array_wrapper)) as [Detail], " +
        "   l.Id as [Location.Id], l.[Name] as [Location.Name], l.[Address] as [Location.Address],  " +
        "t.Id as [Team.Id], t.[Name] as [Team.Name] " +
        "from WorkOrder as wo " +
        " join WorkOrderStatus as wos on wo.StatusID = wos.Id " +
        " join Account as acc on wo.RequestUserID = acc.Id " +
        "join [Priority] as p on wo.PriorityID = p.Id " +
        "join TeamLocation as tl on wo.TeamLocationID = tl.Id " +
        "join [Location] as l on tl.LocationID = l.Id " +
        "join Team as t on tl.TeamID = t.Id " +
        " where convert(date, wo.ExpectingCloseDate) = convert(date, getdate()) and wo.CategoryID=(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain')  " +
        " for json path))) as 'todayMaintainOrder', " +
        " (json_query((select wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor],  json_query((select count(wod.Id) as [Quantity] from WorkOrderDetail as wod join WorkOrder as wo1 on wod.WorkOrderId = wo1.Id where wo.Id = wo1.Id for json path, without_array_wrapper)) as [Detail],  " +
        " l.Id as [Location.Id], l.[Name] as [Location.Name], l.[Address] as [Location.Address],  " +
        "     t.Id as [Team.Id], t.[Name] as [Team.Name] " +
        "from WorkOrder as wo " +
        "  join WorkOrderStatus as wos on wo.StatusID = wos.Id " +
        "  join Account as acc on wo.RequestUserID = acc.Id " +
        "   join [Priority] as p on wo.PriorityID = p.Id " +
        "   join TeamLocation as tl on wo.TeamLocationID = tl.Id " +
        "   join [Location] as l on tl.LocationID = l.Id " +
        " join Team as t on tl.TeamID = t.Id " +
        " where convert(date, wo.ExpectingCloseDate) = dateadd(day, 1, convert(date, getdate())) and wo.CategoryID= (SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Maintain')  " +
        "  for json path))) as 'tomorrowMaintainOrder', " +
        "(json_query((select wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor],  json_query((select count(wod.Id) as [Quantity] from WorkOrderDetail as wod join WorkOrder as wo1 on wod.WorkOrderId = wo1.Id where wo.Id = wo1.Id for json path, without_array_wrapper)) as [Detail], " +
        "  l.Id as [Location.Id], l.[Name] as [Location.Name], l.[Address] as [Location.Address],  " +
        "t.Id as [Team.Id], t.[Name] as [Team.Name] " +
        " from WorkOrder as wo " +
        " join WorkOrderStatus as wos on wo.StatusID = wos.Id " +
        " join Account as acc on wo.RequestUserID = acc.Id " +
        " join [Priority] as p on wo.PriorityID = p.Id " +
        "  join TeamLocation as tl on wo.TeamLocationID = tl.Id " +
        "  join [Location] as l on tl.LocationID = l.Id " +
        "  join Team as t on tl.TeamID = t.Id " +
        "where convert(date, wo.ExpectingCloseDate) = convert(date, getdate()) and wo.CategoryID=(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working')" +
        " for json path))) as 'todayWokingOrder', " +
        " (json_query((select wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor], json_query((select count(wod.Id) as [Quantity] from WorkOrderDetail as wod join WorkOrder as wo1 on wod.WorkOrderId = wo1.Id where wo.Id = wo1.Id for json path, without_array_wrapper)) as [Detail], " +
        "          l.Id as [Location.Id], l.[Name] as [Location.Name], l.[Address] as [Location.Address],  " +
        "       t.Id as [Team.Id], t.[Name] as [Team.Name] " +
        " from WorkOrder as wo " +
        " join WorkOrderStatus as wos on wo.StatusID = wos.Id " +
        " join Account as acc on wo.RequestUserID = acc.Id " +
        "join [Priority] as p on wo.PriorityID = p.Id " +
        " join TeamLocation as tl on wo.TeamLocationID = tl.Id " +
        " join [Location] as l on tl.LocationID = l.Id " +
        " join Team as t on tl.TeamID = t.Id " +
        "  where convert(date, wo.ExpectingCloseDate) = dateadd(day, 1, convert(date, getdate())) and wo.CategoryID=(SELECT woc.Id FROM [WorkOrderCategory] as woc WHERE woc.Name = N'Working')  " +
        " for json path))) as 'tomorrowWokingOrder' " +
        " FOR JSON PATH,  without_array_wrapper"
    )
    .into(response);
});
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
        "	FROM [Equipment] as e  " +
        "WHERE e.CategoryID = ec.Id) " +
        "for json path, without_array_wrapper)) as 'Unavailable' " +
        "from EquipmentCategory as ec " +
        "for json path "
    )
    .into(res);
});
module.exports = router;
