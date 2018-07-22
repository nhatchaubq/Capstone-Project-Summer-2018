var router = require('express').Router();
var TYPES = require('tedious').TYPES;

router.get('/:id', (request, response) => {
    request.sql(
            "	select acc.* , json_query((select * from [Role] where Id = acc.RoleID for json path, without_array_wrapper)) as [SystemRole],  " +
            "(select t.*, json_query((select *    " +
            "from TeamRoles as tr   " +
            "where Id = (select TeamRoleID    " +
            "from TeamAccount    " +
            "where TeamID = t.Id and AccountID = 34) ORDER BY tr.TeamRole DESC for json path, without_array_wrapper)) as [TeamRole]   " +
            "from Team as t   " +
            "where Id in (select TeamId from TeamAccount where AccountID = 34)   " +

            "for json path) as [Teams]   " +
            "from Account as acc where acc.Id = 34   " +
            "for json path, without_array_wrapper"
        )
        .param('accId', request.params.id, TYPES.Int)
        .into(response);
});


module.exports = router;