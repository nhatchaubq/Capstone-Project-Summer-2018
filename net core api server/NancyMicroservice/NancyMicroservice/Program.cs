using System;
using Nancy.Hosting.Self;

namespace NancyMicroservice
{
    class Program
    {
        static void Main(string[] args)
        {
            var url = "http://127.0.0.1:3001";
            using (var server = new NancyHost(new Uri(url)))
            {
                server.Start();
                Console.WriteLine("Nancy Microservice is listening on {0}", url);
                Console.Read();
            }
        }
    }
    
}
