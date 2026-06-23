using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Datos
{
    public class ProductoMongo
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string Id { get; set; }

        public string Proveedor { get; set; }
        public string RUC { get; set; }
        public string NombreProducto { get; set; }
        public string Categoria { get; set; }
        public double Precio { get; set; }
        public string RutaImagen { get; set; }
    }
}