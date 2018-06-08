-- 1.	Hiển thị tất cả work order của ngày mai (tomorrow, next 7 days, past due, backlog, today)
---- 1.1 tomorrow
select *
from WorkOrder as wo join WorkOrderDetail as wod on wo.id = wod.WorkOrderID join WorkOrderStatus as wos on wo.StatusID = wos.Id
where convert(date, wod.StartDate) = dateadd(day, 1, convert(date, getdate())) 


---- 1.2 next 7 days

select *
from WorkOrder as wo join WorkOrderDetail as wod on wo.id = wod.WorkOrderID join WorkOrderStatus as wos on wo.StatusID = wos.Id
where convert(date, wod.StartDate) between convert(date, dateadd(day, 1, getdate())) and convert(date, dateadd(day, 8, getdate()))
order by wod.StartDate asc

---- 1.2 past due
select *
from WorkOrder as wo join WorkOrderDetail as wod on wo.id = wod.WorkOrderID join WorkOrderStatus as wos on wo.StatusID = wos.Id
where convert(date, getdate()) > convert(date, wo.DueDate) and wo.StatusID = (select wos.Id from WorkOrderStatus wos where wos.Name != N'Closed') 
order by wod.StartDate asc

---- 1.2 today
select *
from WorkOrder as wo join WorkOrderDetail as wod on wo.id = wod.WorkOrderID join WorkOrderStatus as wos on wo.StatusID = wos.Id
where convert(date, getdate()) = convert(date, wod.StartDate)

-- 2.	Hiển thị work order theo status “Open” (Requested/Opened/Approved/Working/Closed)
select * from WorkOrderStatus;
select * from WorkOrder;
exec [dbo].GetWorkOrderByStatusId @statusid = 2

-- 3.	Hiển thị những work order được tạo bởi Team Leader Name “Mattin Garrix”.
exec [dbo].GetWorkOrderByAccName @accname = N'Mattin Garrix'

-- 4.	Hiển thị những work order thuộc dự án Name “4S Linh Dong Apartment”.
exec [dbo].GetWorkOrderByProjectName @projectName = N'linh dong'

-- 5.	Hiển thị work order theo độ ưu tiên và ngày bắt đầu.
select *
from WorkOrder as wo join WorkOrderDetail as wod on wo.id = wod.WorkOrderID
order by wo.PriorityID desc, wod.StartDate asc

-- 6.	Hiển thị work order theo loại “Maintain” (Onsite / Upgrade / Maintain)
select * from WorkOrderCategory
exec [dbo].GetWorkOrderByWorkOrderCategory @categoryId = 3

---7.	Thống kê tổng số work order có status “Requested”. 
-- 8.	Thống kê tổng số work order đã được duyệt trong ngày. “Approved”
select * from WorkOrderStatus
exec [dbo].CountWorkOrderByStatusId @statusid = 1

-- 9.	Thống kê tổng số work order đang bị trễ hạn “Past Due”.
select count(*)
from WorkOrder as wo
where convert(date, getdate()) > convert(date, wo.DueDate)