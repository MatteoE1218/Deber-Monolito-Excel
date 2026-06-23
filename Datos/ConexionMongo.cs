using System;
using System.Collections.Generic;
using System.Linq;
using MongoDB.Driver;

namespace Datos
{
    public class ConexionMongo
    {
        
        private const string CadenaConexion = "mongodb://localhost:27017";
        private const string NombreBaseDatos = "InventarioDB";
        private const string Coleccion = "Productos";

       
        private IMongoCollection<ProductoMongo> ObtenerColeccion()
        {
            var cliente = new MongoClient(CadenaConexion);
            var baseDatos = cliente.GetDatabase(NombreBaseDatos);
            return baseDatos.GetCollection<ProductoMongo>(Coleccion);
        }

        
        public void InsertarMasivo(List<ProductoMongo> listaProductos)
        {
            if (listaProductos != null && listaProductos.Count > 0)
            {
                var coleccion = ObtenerColeccion();
                coleccion.InsertMany(listaProductos);
            }
        }

       
        public List<ProductoMongo> LeerTodos()
        {
            var coleccion = ObtenerColeccion();
            return coleccion.Find(filtro => true).ToList();
        }
        
        public void Insertar(ProductoMongo p)
        {
            ObtenerColeccion().InsertOne(p);
        }

        
        public void Actualizar(string id, ProductoMongo p)
        {
            ObtenerColeccion().ReplaceOne(x => x.Id == id, p);
        }

     
        public void Eliminar(string id)
        {
            ObtenerColeccion().DeleteOne(x => x.Id == id);
        }

        
        public void EliminarTodo()
        {
            ObtenerColeccion().DeleteMany(filtro => true);
        }
    }
}