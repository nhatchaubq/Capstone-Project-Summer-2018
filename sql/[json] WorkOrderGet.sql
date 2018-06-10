select (select wo.*, wos.Name as [WorkOrderStatus], acc.Username as [RequestUsername], acc.Fullname as [RequestFullname], p.[Name] as [Priority], p.TagHexColor as [PriorityColor], 
		pr.[Name] as [ProjectName], lo.[Name] as [LocationAddress], (json_query((select wod.*, json_query((select * from EquipmentItem as ei where ei.Id = wod.EquipmentItemId for json path, without_array_wrapper)) as [EquipmentItem]
							from WorkOrderDetail as wod
							where wod.WorkOrderID = wo.Id 
							for json path))) as [WorkOrderDetails]
from WorkOrder as wo join WorkOrderStatus as wos on wo.StatusID = wos.Id
	join Account as acc on wo.RequestUserID = acc.Id
	join [Priority] as p on wo.PriorityID = p.Id
	join Project as pr on wo.ProjectId = pr.Id
	join [Location] as lo on pr.LocationID = lo.Id
for json path) as [WorkOrders] for json path, without_array_wrapper