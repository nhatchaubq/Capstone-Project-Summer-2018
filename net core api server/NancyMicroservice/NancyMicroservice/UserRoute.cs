using System;
using System.Data;
using Nancy;
using System.Data.SqlClient;

namespace NancyMicroservice
{
    public class UserRoute : NancyModule
    {
        public UserRoute() : base("/user")
        {
            Get["/"] = GetUsers;
            Get["/{id}"] = GetUserById;
            Post["/"] = CreateUser;
            Put["{id}"] = UpdateUser;
            Delete["/{id}"] = DeleteUser;
        }

        private dynamic GetUsers(dynamic parameters)
        {
            using (var connection = new SqlConnection(Sql.PATH))
            {
                try
                {
                    connection.Open();
                    var query = "select * from [User] for json auto";
                    var command = new SqlCommand(query, connection);
                    var result = command.ExecuteReader();
                    result.Read();
                    return Response.AsText(result[0] as string, "application/json");
                }
                catch (Exception e)
                {
                    var response = (Response) e.Message;
                    response.StatusCode = HttpStatusCode.InternalServerError;
                    return response;
                }
            }
        }

        private dynamic GetUserById(dynamic parameters)
        {
            using (var connection = new SqlConnection(Sql.PATH))
            {
                try
                {
                    connection.Open();
                    var query = $"select * from [User] where Id = {parameters.id} for json auto, without_array_wrapper";
                    var command = new SqlCommand(query, connection);
                    var result = command.ExecuteReader();
                    result.Read();
                    return Response.AsText(result[0] as string, "application/json");
                }
                catch (Exception e)
                {
                    var response = (Response)e.Message;
                    response.StatusCode = HttpStatusCode.InternalServerError;
                    return response;
                }
            }
        }

        private static dynamic CreateUser(dynamic parameters)
        {
            using (var connection = new SqlConnection(Sql.PATH))
            {
                try
                {
                    connection.Open();
                    var query = "insert into [User](Username, Password, Email, Fullname, Birthday)" +
                                " values(@username, @password, @email, @fullname, @birthday)";
                    var command = new SqlCommand(query, connection);

                    command.Parameters.Add("@username", SqlDbType.NVarChar);
                    command.Parameters["@username"].Value = parameters.username.ToString();

                    command.Parameters.Add("@password", SqlDbType.NVarChar);
                    command.Parameters["@password"].Value = parameters.password.ToString();

                    command.Parameters.Add("@email", SqlDbType.NVarChar);
                    command.Parameters["@email"].Value = parameters.email.ToString();

                    command.Parameters.Add("@fullname", SqlDbType.NVarChar);
                    command.Parameters["@fullname"].Value = parameters.fullname ?? DBNull.Value;

                    command.Parameters.Add("@birthday", SqlDbType.DateTime);
                    command.Parameters["@birthday"].Value = parameters.birthday ?? DBNull.Value;

                    command.ExecuteNonQuery();
                    return new Response
                    {
                        StatusCode = HttpStatusCode.OK,
                    };
                }
                catch (Exception e)
                {
                    var response = (Response)e.Message;
                    response.StatusCode = HttpStatusCode.InternalServerError;
                    return response;
                }
            }
        }

        private static dynamic UpdateUser(dynamic parameters)
        {
            using (var connection = new SqlConnection(Sql.PATH))
            {
                try
                {
                    connection.Open();
                    var query = $"update [User] set Password = {parameters.password}" +
                                $", Fullname = {parameters.fullname}" +
                                $", Birthday = {parameters.birthday} where Id = {parameters.id}";
                    var command = new SqlCommand(query, connection);
                    command.ExecuteNonQuery();
                    return new Response
                    {
                        StatusCode = HttpStatusCode.OK
                    };
                }
                catch (Exception e)
                {
                    var response = (Response)e.Message;
                    response.StatusCode = HttpStatusCode.InternalServerError;
                    return response;
                }
            }
        }

        private static dynamic DeleteUser(dynamic parameters)
        {
            using (var connection = new SqlConnection(Sql.PATH))
            {
                try
                {
                    connection.Open();
                    var query = $"delete from [User] where Id = {parameters.id}";
                    var command = new SqlCommand(query, connection);
                    command.ExecuteNonQuery();
                    return new Response
                    {
                        StatusCode = HttpStatusCode.OK
                    };
                }
                catch (Exception e)
                {
                    var response = (Response)e.Message;
                    response.StatusCode = HttpStatusCode.InternalServerError;
                    return response;
                }
            }
        }
    }
}
