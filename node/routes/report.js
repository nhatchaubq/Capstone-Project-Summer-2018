var router = require("express").Router();
var TYPES = require("tedious").TYPES;

router.get("/equipment", (req, res) => {
  req.sql("exec GetEquipmentForReport ").into(res);
});

router.get("/getCategory", (req, res) => {
  req
    .sql("select * from [EquipmentCategory] order by [Name] for json path")
    .into(res);
});

router.get("/getEquipmentOverview", (req, res) => {
  req
    .sql(
      "select e.Id,e.Name,e.MadeIn,e.CategoryID,v.BusinessName as 'Vendor',ec.Name as 'Category',ei.Quantity,json_query((select tmpEi.*,e.[Name],e.[Image],ec.[Name] as Category,tmpEs.[Name] as 'Status' " +
        "																		from EquipmentItem as tmpEi  join EquipmentStatus as tmpEs on tmpEi.StatusId = tmpEs.Id " +
        "																	where tmpEi.EquipmentID = e.Id for json path)) as 'Detail' " +
        "	from Equipment as e join Vendor as v on e.VendorID = v.Id " +
        "	join EquipmentCategory as ec on e.CategoryID = ec.Id " +
        "	join(select e.Id, count(*) as 'Quantity'  " +
        "					from Equipment as e join EquipmentItem as ei on e.Id = ei.EquipmentID " +
        "				group by e.Id) as ei on e.Id = ei.Id " +
        "	for json path	"
    )
    .into(res);
});

router.get("/getUsingEquipment", (req, res) => {
  req
    .sql(
      "select distinct ei.Id,e.[Name],ei.SerialNumber,l.[Name] as 'Location',t.[Name] as 'Tile',f.[Name] as 'Floor',b.[Name] as 'Block',wd.StartDate,wd.FinishedDate,tm.[Name] as 'Team' " +
        " from EquipmentItem as ei join Equipment as e on ei.EquipmentID = e.Id " +
        " 				 join WorkOrderDetail as wd on wd.EquipmentItemID = ei.Id " +
        " 			 join WorkOrder as w on w.Id = wd.WorkOrderID " +
        " 		 join TeamLocation as tl on tl.Id = w.TeamLocationID " +
        " 	 join Team as tm on tm.Id = tl.TeamID							  " +
        "  join Tile as t on ei.TileID = t.Id " +
        " join[Floor] as f on f.Id = t.FloorID " +
        " join[Block] as b on b.Id = f.BlockID " +
        " join[Location] as l on l.Id = b.LocationID	 " +
        " where ei.StatusId = 4 for json path	"
    )
    .into(res);
});

router.get("/getStatusEquipment", (req, res) => {
  req
    .sql(
      "select distinct e.Id,e.[Name],e.MadeIn,e.[Description], " +
        "	json_query((select COUNT(*) as [Quantity], json_query(( " +
        "	 select  ei.*, e.[Name], e.[Image], e.MadeIn " +
        "					  from EquipmentItem as ei  " +
        "					  where EquipmentID = e.Id and StatusId = 5  " +
        "						  for json path)) as 'Detail' " +
        "	from EquipmentItem " +
        "	where EquipmentID = e.Id and StatusId = 5 " +
        "	for json path, without_array_wrapper)) as[DAMAGED], " +
        "	json_query((select COUNT(*) as [Quantity], json_query((" +
        "	select  ei.*, e.[Name], e.[Image], e.MadeIn " +
        "				  from EquipmentItem as ei  " +
        "			  where EquipmentID = e.Id and StatusId = 7  " +
        "			  for json path)) as 'Detail' " +
        "	from EquipmentItem " +
        "	where EquipmentID = e.Id and StatusId = 7 " +
        "	for json path, without_array_wrapper)) as[LOST], " +
        "	json_query((select COUNT(*) as [Quantity], json_query((" +
        "	  select  ei.*, e.[Name], e.[Image], e.MadeIn " +
        "									  from EquipmentItem as ei  " +
        "									  where EquipmentID = e.Id and StatusId = 8 " +
        "								  for json path)) as 'Detail' " +
        "	from EquipmentItem " +
        "	where EquipmentID = e.Id and StatusId = 8 " +
        "	for json path, without_array_wrapper)) as[ARCHIVE] " +
        "	from EquipmentItem as ei join Equipment as e on e.Id = ei.EquipmentID " +
        "	where StatusId = 8 or StatusId = 7 or StatusId = 5 " +
        "	for json path"
    )
    .into(res);
});

router.get("/getAvailableEquipment", (req, res) => {
  req
    .sql(
      "select ei.*,e.Name,l.[Name] as 'Location',t.[Name] as 'Tile',f.[Name] as 'Floor',b.[Name] as 'Block' " +
        "from Equipment as e join EquipmentItem as ei on e.Id = ei.EquipmentID " +
        "join Tile as t on ei.TileID = t.Id " +
        "join[Floor] as f on f.Id = t.FloorID " +
        "join[Block] as b on b.Id = f.BlockID " +
        "join[Location] as l on l.Id = b.LocationID " +
        "where ei.StatusId = 1 " +
        "for json path"
    )
    .into(res);
});

router.get("/getMaintenanceCalendar", (req, res) => {
  req
    .sql(
      "select ei.*,e.[Name],l.[Name] as 'Location',es.[Name] as 'Status',b.[Name] as 'Block',f.[Name] as 'Floor',t.[Name] as 'Tile' " +
        "  from EquipmentItem as ei join Equipment as e on ei.EquipmentID = e.Id " +
        " 					 join Tile as t on ei.TileID = t.Id " +
        " 				 join[Floor] as f on f.Id = t.FloorID " +
        " 			 join[Block] as b on b.Id = f.BlockID " +
        " 		 join[Location] as l on l.Id = b.LocationID " +
        " 	 join EquipmentStatus as es on es.Id = ei.StatusId " +
        " for json path	"
    )
    .into(res);
});

router.get("/getWorkorderOverview", (req, res) => {
  req
    .sql(
      "select w.Id,w.Name,w.CreateDate,w.DueDate,w.Description,w.ClosedDate,a.Fullname,ws.Name as 'Status',wc.Name as 'Category',p.Name as 'Priority',t.Name as 'Team',l.Name as 'Location' " +
        " from WorkOrder as w join WorkOrderStatus as ws on w.StatusID = ws.Id						 " +
        " 			join WorkOrderCategory as wc on w.CategoryID = wc.Id						 " +
        " 		join Account as a on w.RequestUserID = a.Id " +
        " 	join[Priority] as p on w.PriorityID = p.Id " +
        " join TeamLocation as tl on w.TeamLocationID = tl.Id " +
        " join Team as t on t.Id = tl.TeamID " +
        " join[Location] as l on tl.LocationID = l.Id " +
        " where w.ClosedDate IS NULL " +
        " for json path"
    )
    .into(res);
});

router.get("/getLateWorkorder", (req, res) => {
  req
    .sql(
      "select w.Id,w.Name,w.CreateDate,w.DueDate,w.Description,w.ClosedDate,a.Fullname,ws.Name as 'Status',wc.Name as 'Category',p.Name as 'Priority',t.Name as 'Team',l.Name as 'Location', " +
        " DATEDIFF(DAY, w.DueDate, GETDATE()) as 'LateDays', JSON_QUERY((select * " +
        " from Account as tmpA " +
        " 	where tmpA.Id = w.RequestUserID for json path)) as 'Contact' " +
        " from WorkOrder as w join WorkOrderStatus as ws on w.StatusID = ws.Id " +
        " join WorkOrderCategory as wc on w.CategoryID = wc.Id " +
        " join Account as a on w.RequestUserID = a.Id " +
        " join[Priority] as p on w.PriorityID = p.Id " +
        " join TeamLocation as tl on w.TeamLocationID = tl.Id " +
        " join Team as t on t.Id = tl.TeamID " +
        " join[Location] as l on tl.LocationID = l.Id " +
        " where w.ClosedDate IS NULL and DATEDIFF(DAY, w.DueDate, GETDATE()) > 0 and ws.Id = 4 " +
        " for json path"
    )
    .into(res);
});

router.get("/getClosedWorkorder", (req, res) => {
  req
    .sql(
      "select w.*,t.Name as 'Team',json_query((select COUNT(*) as 'quantity',json_query((select wd.*,ei.SerialNumber,e.Image,e.Name as 'Equipment',es.Name 'ReturnedStatus' " +
        " from WorkOrderDetail as wd join WorkOrderDetailReturn as wdr on wdr.WorkOrderDetailId = wd.Id " +
        " 																												   join EquipmentItem as ei on wd.EquipmentItemID = ei.Id " +
        " join Equipment as e on e.Id = ei.EquipmentID " +
        " join EquipmentStatus as es on es.Id = wdr.ReturnedStatusId " +
        " where wd.WorkOrderID = w.Id and wdr.ReturnedStatusId = 1 for json path)) as 'Detail' " +
        " from WorkOrderDetail as wd join WorkOrderDetailReturn as wdr on wdr.WorkOrderDetailId = wd.Id " +
        " where wd.WorkOrderID = w.Id and wdr.ReturnedStatusId = 1 for json path, without_array_wrapper)) as 'Available', " +
        " json_query((select COUNT(*) as 'quantity', json_query((select wd.*, ei.SerialNumber, e.Image, e.Name as 'Equipment', es.Name 'ReturnedStatus' " +
        " from WorkOrderDetail as wd join WorkOrderDetailReturn as wdr on wdr.WorkOrderDetailId = wd.Id " +
        " join EquipmentItem as ei on wd.EquipmentItemID = ei.Id " +
        " join Equipment as e on e.Id = ei.EquipmentID " +
        " join EquipmentStatus as es on es.Id = wdr.ReturnedStatusId " +
        " where wd.WorkOrderID = w.Id and wdr.ReturnedStatusId = 5 for json path)) as 'Detail' " +
        " from WorkOrderDetail as wd join WorkOrderDetailReturn as wdr on wdr.WorkOrderDetailId = wd.Id " +
        " where wd.WorkOrderID = w.Id and wdr.ReturnedStatusId = 5 for json path, without_array_wrapper)) as 'Damaged', " +
        " json_query((select COUNT(*) as 'quantity', json_query((select wd.*, ei.SerialNumber, e.Image, e.Name as 'Equipment', es.Name 'ReturnedStatus' " +
        " 																						from WorkOrderDetail as wd join WorkOrderDetailReturn as wdr on wdr.WorkOrderDetailId = wd.Id " +
        " join EquipmentItem as ei on wd.EquipmentItemID = ei.Id " +
        " join Equipment as e on e.Id = ei.EquipmentID " +
        " join EquipmentStatus as es on es.Id = wdr.ReturnedStatusId " +
        " where wd.WorkOrderID = w.Id and wdr.ReturnedStatusId = 7 for json path)) as 'Detail' " +
        " from WorkOrderDetail as wd join WorkOrderDetailReturn as wdr on wdr.WorkOrderDetailId = wd.Id " +
        " where wd.WorkOrderID = w.Id and wdr.ReturnedStatusId = 7 for json path, without_array_wrapper)) as 'Lost' " +
        " from WorkOrder as w join TeamLocation as tl on tl.Id = w.TeamLocationID " +
        " join Team as t on t.Id = tl.TeamID " +
        " where w.ClosedDate Is not null  for json path"
    )
    .into(res);
});

module.exports = router;
