using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace Negocio
{
    public class CN_Proveedor
    {
        private Datos.CD_Conexion conexionBase = new Datos.CD_Conexion();

        
        public IEnumerable ListarProveedores()
        {
            var db = (dynamic)conexionBase.ObtenerContexto();
            List<object> lista = new List<object>();

            foreach (var item in db.tbl_proveedor)
            {
                lista.Add(item);
            }
            return lista;
        }

        
        public void InsertarProveedor(string nombre, string ruc)
        {
            var db = (dynamic)conexionBase.ObtenerContexto();
            
            var tablas = db.GetType().GetProperty("tbl_proveedor").GetValue(db, null);

           
            Type tipoProveedor = db.GetType().Assembly.GetType("Datos.tbl_proveedor");
            dynamic nuevo = Activator.CreateInstance(tipoProveedor);

            nuevo.nombre_prov = nombre;
            nuevo.ruc_prov = ruc;

            tablas.InsertOnSubmit(nuevo);
            db.SubmitChanges();
        }

        
        public void EditarProveedor(int idProv, string nombre, string ruc)
        {
            var db = (dynamic)conexionBase.ObtenerContexto();
            foreach (dynamic p in db.tbl_proveedor)
            {
                if (p.id_prov == idProv)
                {
                    p.nombre_prov = nombre;
                    p.ruc_prov = ruc;
                    break;
                }
            }
            db.SubmitChanges();
        }

        
        public void EliminarProveedor(int idProv)
        {
            var db = (dynamic)conexionBase.ObtenerContexto();

            foreach (var prod in db.tbl_producto)
            {
                if (prod.id_prov == idProv)
                {
                    prod.id_prov = null;
                }
            }

           
            foreach (var prov in db.tbl_proveedor)
            {
                if (prov.id_prov == idProv)
                {
                    var tablaProv = db.GetType().GetProperty("tbl_proveedor").GetValue(db, null);
                    tablaProv.DeleteOnSubmit(prov);
                    break;
                }
            }

            db.SubmitChanges();
        }
    }
}