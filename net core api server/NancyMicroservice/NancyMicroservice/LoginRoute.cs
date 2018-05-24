using System;
using Nancy;
using System.Data.SqlClient;

namespace NancyMicroservice
{
    public class LoginRoute : NancyModule
    {
        public LoginRoute() : base("/login")
        {
            Get["/{username}/{password}"] = Login;
        }

        public dynamic Login(dynamic parameters)
        {
            using (var connection = new SqlConnection(Sql.PATH))
            {
                try
                {
                    connection.Open();
                    var query = string.Format("select * from [User] where Username = {0} and Password = {1} for json auto, without_array_wrapper",
                        parameters.username, parameters.password);
                    var command = new SqlCommand(query, connection);
                    var result = command.ExecuteReader();
                    result.Read();
                    return Response.AsText(result[0] as string, "application/json");
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                    return e.Message;
                }
            }
        }
    }

    
}
