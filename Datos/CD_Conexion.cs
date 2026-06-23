using System;

namespace Datos
{
    public class CD_Conexion
    {
        private static string cadenaConexion =
@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\matte\source\repos\excel\Datos\InventarioDB.mdf;Integrated Security=True";

        // Devuelve el contexto como object para que no haya problemas de protección
        public object ObtenerContexto()
        {
            return new DataClasses1DataContext(cadenaConexion);
        }
    }
}