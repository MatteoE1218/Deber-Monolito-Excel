using System;
using System.Data.SqlClient;
using MongoDB.Driver;

namespace Datos
{
    public static class VerificadorConexion
    {
        // Cadenas de conexión extraídas de tu configuración
        private static readonly string SqlConn = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\matte\source\repos\excel\Datos\InventarioDB.mdf;Integrated Security=True";
        private static readonly string MongoConn = "mongodb://localhost:27017";
        private static readonly string MongoDbName = "InventarioDB";

        public static bool ProbarTodo()
        {
            try
            {
                // 1. Probar SQL Server
                using (SqlConnection conn = new SqlConnection(SqlConn))
                {
                    conn.Open();
                    Console.WriteLine("SQL Server: Conectado correctamente.");
                }

                // 2. Probar MongoDB
                var mongoClient = new MongoClient(MongoConn);
                // Usamos la base de datos que especificaste
                var database = mongoClient.GetDatabase(MongoDbName);
                database.RunCommand((Command<dynamic>)"{ping:1}");
                Console.WriteLine("MongoDB: Conectado correctamente.");

                return true; // Todo salió bien
            }
            catch (Exception ex)
            {
                // Imprimimos el error para saber qué falló en la consola
                Console.WriteLine("Error en la conexión: " + ex.Message);
                return false; // Falló la conexión
            }
        }
    }
}