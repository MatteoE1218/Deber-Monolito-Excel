using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Datos; // Importante para llamar a ConexionMongo y ProductoMongo

namespace Negocio
{
    public class CN_Producto
    {
        // Instancia directa a tu nueva conexión de Mongo
        private ConexionMongo datosMongo = new ConexionMongo();

        // 1. SELECT (Optimizado: ya no necesita buscar en otra tabla)
        public IEnumerable ListarProductos()
        {
            var listaMongo = datosMongo.LeerTodos();

            // Transformamos los datos a los nombres exactos que tu GridView ya espera
            return listaMongo.Select(p => new
            {
                id_pro = p.Id, // Mongo usa IDs de texto (ObjectId)
                id_prov = 0, // Mantenemos el campo por compatibilidad con tu interfaz
                NombreProveedor = string.IsNullOrEmpty(p.Proveedor) ? "Sin proveedor" : p.Proveedor,
                nombre_pro = p.NombreProducto,
                categoria_pro = p.Categoria,
                precio_pro = p.Precio,
                ruta_imagen_pro = p.RutaImagen ?? ""
            }).ToList();
        }

        // 2. INSERT (Cambiamos el idProv numérico por el string del proveedor)
        public void InsertarProducto(string nombreProveedor, string nombre, string categoria, decimal precio, string rutaImagen)
        {
            var nuevo = new ProductoMongo
            {
                Proveedor = nombreProveedor,
                NombreProducto = nombre,
                Categoria = categoria,
                Precio = Convert.ToDouble(precio),
                RutaImagen = rutaImagen
            };
            datosMongo.Insertar(nuevo);
        }

        // 3. UPDATE
        public void EditarProducto(string idPro, string nombreProveedor, string nombre, string categoria, decimal precio, string rutaImagen)
        {
            var productoActualizado = new ProductoMongo
            {
                Id = idPro, // Mantenemos el ID original para que Mongo sepa cuál reemplazar
                Proveedor = nombreProveedor,
                NombreProducto = nombre,
                Categoria = categoria,
                Precio = Convert.ToDouble(precio),
                RutaImagen = rutaImagen
            };
            datosMongo.Actualizar(idPro, productoActualizado);
        }

        // 4. DELETE
        public void EliminarProducto(string idPro)
        {
            datosMongo.Eliminar(idPro);
        }

        // 5. SELECT CON FILTRO (Búsqueda en memoria)
        public IEnumerable FiltrarProductos(string criterio)
        {
            string busqueda = criterio.ToLower().Trim();
            var listaMongo = datosMongo.LeerTodos();

            var filtrados = listaMongo.Where(p =>
                (p.NombreProducto != null && p.NombreProducto.ToLower().Contains(busqueda)) ||
                (p.Categoria != null && p.Categoria.ToLower().Contains(busqueda))
            ).ToList();

            return filtrados.Select(p => new
            {
                id_pro = p.Id,
                id_prov = 0,
                NombreProveedor = string.IsNullOrEmpty(p.Proveedor) ? "Sin proveedor" : p.Proveedor,
                nombre_pro = p.NombreProducto,
                categoria_pro = p.Categoria,
                precio_pro = p.Precio,
                ruta_imagen_pro = p.RutaImagen ?? ""
            }).ToList();
        }

        // 6. PROCESAR CARGA MASIVA (Muchísimo más rápido con Mongo)
        public void ProcesarCargaMasiva(List<Dictionary<string, string>> registrosExcel)
        {
            // REQUISITO DEBER: Borrar datos anteriores. En Mongo se hace en 1 sola línea instantánea.
            datosMongo.EliminarTodo();

            List<ProductoMongo> listaAInsertar = new List<ProductoMongo>();

            foreach (var fila in registrosExcel)
            {
                listaAInsertar.Add(new ProductoMongo
                {
                    Proveedor = fila["Proveedor"].Trim(),
                    RUC = fila["RUC"].Trim(),
                    NombreProducto = fila["Producto"].Trim(),
                    Categoria = fila["Categoria"].Trim(),
                    Precio = Convert.ToDouble(fila["Precio"].Trim()),
                    RutaImagen = fila.ContainsKey("RutaImagen") ? fila["RutaImagen"].Trim() : ""
                });
            }

            // Inserción masiva de golpe
            if (listaAInsertar.Count > 0)
            {
                datosMongo.InsertarMasivo(listaAInsertar);
            }
        }

        // 7. OBTENER ESTADÍSTICAS POR CATEGORÍA PARA EL CHART
        public Dictionary<string, int> ObtenerEstadisticasCategorias()
        {
            var listaMongo = datosMongo.LeerTodos();
            Dictionary<string, int> estadisticas = new Dictionary<string, int>();

            foreach (var p in listaMongo)
            {
                string cat = string.IsNullOrEmpty(p.Categoria) ? "Sin Categoría" : p.Categoria.Trim();

                if (estadisticas.ContainsKey(cat))
                {
                    estadisticas[cat]++;
                }
                else
                {
                    estadisticas[cat] = 1;
                }
            }
            return estadisticas;
        }
    }
}