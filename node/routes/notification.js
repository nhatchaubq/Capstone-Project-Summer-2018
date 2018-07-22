const router = require('express').Router();
const TYPES = require("tedious").TYPES;

module.exports = function(io) {
    router.get('/all/:userId', (req, res) => {
        req.sql("select noti.Id as [Id], noti.[Content] as [Content], noti.CreatedDate as [CreatedDate], accNoti.NotificationStatus as [Status], noti.Metadata as [Metadata] "
        + " from [Notification] as noti join AccountNotification as accNoti on noti.Id = accNoti.NotificationId "
        + " where accNoti.AccountId = @userId "
        + " order by noti.CreatedDate desc "
        + " for json path")
        .param('userId', req.params.userId, TYPES.Int)
        .into(res);
    });

    router.get('/top50/:userId', (req, res) => {
        req.sql("select top 50 noti.Id as [Id], noti.[Content] as [Content], noti.CreatedDate as [CreatedDate], accNoti.NotificationStatus as [Status], noti.Metadata as [Metadata] "
        + " from [Notification] as noti join AccountNotification as accNoti on noti.Id = accNoti.NotificationId "
        + " where accNoti.AccountId = @userId "
        + " order by noti.CreatedDate desc "
        + " for json path")
        .param('userId', req.params.userId, TYPES.Int)
        .into(res);
    });

    router.post('/accounts', (req, res) => {
        req.sql("declare @newNotificationId int; "
        + "      insert into [Notification]([Content], CreatedDate, Metadata) values(@notificationContent, getdate(), @metaData); "
        + "      set @newNotificationId = (select SCOPE_IDENTITY()); "
        + "      declare @accId int; "
        + "      select acc.Id, acc.Username into #accounts "
        + "      from Account as acc join [Role] as ro on acc.RoleID = ro.Id "
        + "      where ro.[Name] = @userRole "
        + "      while exists(select * from #accounts) "
        + "      begin "
        + "          select top 1 @accId = Id "
        + "          from #accounts "
        + "          insert into AccountNotification(AccountId, NotificationId, NotificationStatus) values(@accId, @newNotificationId, 0); "
        + "          delete #accounts where Id = @accId "
        + "      end "
        + "      drop table #accounts ")
        .param('notificationContent', req.body.notificationContent, TYPES.NVarChar)
        .param('userRole', req.body.userRole, TYPES.NVarChar)
        .param('metaData', req.body.metaData, TYPES.NVarChar)
        .done((fn) => {
            io.sockets.emit('NEW_NOTIFICATION', {needToUpdateNotification: req.body.needToUpdateNotification});
            res.end();
        })
        .exec(res);
    });

    router.post('/userid/:userId', (req, res) => {
        req.sql("declare @newNotificationId int; "
        + "      insert into [Notification]([Content], CreatedDate, Metadata) values(@notificationContent, getdate(), @metaData); "
        + "      set @newNotificationId = (select SCOPE_IDENTITY()); "        
        + "      insert into AccountNotification(AccountId, NotificationId, NotificationStatus) values(@userId, @newNotificationId, 0); ")
        .param('userId', req.params.userId, TYPES.Int)
        .param('notificationContent', req.body.notificationContent, TYPES.NVarChar)
        .param('metaData', req.body.metaData, TYPES.NVarChar)
        .done((fn) => {
            io.sockets.emit('NEW_NOTIFICATION', {message: 'New notification'});
            res.end();
        })
        .exec(res);
    });

    router.put('/status/all', (req, res) => {
        req.sql("update AccountNotification set NotificationStatus = 1 where AccountId = @userId")
            .param('userId', req.body.userId, TYPES.Int)
            .exec(res);
    });

    router.put('/status/:notiId', (req, res) => {
        req.sql("declare @currentStatus bit; "
                + " set @currentStatus = (select NotificationStatus from AccountNotification where AccountId = @userId and NotificationId = @notiId); "
                + " if @currentStatus = 0 "
                + "     update AccountNotification set NotificationStatus = 1 where AccountId = @userId and NotificationId = @notiId "
                + " else "
                + "     update AccountNotification set NotificationStatus = 0 where AccountId = @userId and NotificationId = @notiId ")
            .param('notiId', req.params.notiId, TYPES.Int)
            .param('userId', req.body.userId, TYPES.Int)
            .exec(res);
    });

    return router;
}