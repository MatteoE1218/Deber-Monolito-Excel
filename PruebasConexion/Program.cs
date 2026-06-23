// Program.cs en el proyecto PruebasConexion
using System;
using Datos;

class Program
{
    static int Main(string[] args)
    {
        if (VerificadorConexion.ProbarTodo())
        {
            Console.WriteLine("PRUEBA_EXITOSA");
            return 0; // Código 0 = Éxito para Jenkins
        }
        else
        {
            Console.WriteLine("PRUEBA_FALLIDA");
            return 1; // Código 1 = Error para Jenkins
        }
    }
}