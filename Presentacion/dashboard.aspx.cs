using System;
using System.Data;
using System.Collections.Generic;
using System.Web.UI;
using Negocio;

namespace Presentacion
{
    public partial class dashboard : System.Web.UI.Page
    {
        private CN_Producto negocioPro = new CN_Producto();

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Session["UsuarioLogueado"] == null)
            {
                Response.Redirect("login.aspx");
            }

            if (!IsPostBack)
            {
                CargarCarrusel();
                CargarGrafico();
            }
        }

        private void CargarCarrusel()
        {
            var listaProductos = (System.Collections.IEnumerable)negocioPro.ListarProductos();
            List<object> datosCarrusel = new List<object>();

          
            foreach (object p in listaProductos)
            {
                string nombre = DataBinder.Eval(p, "nombre_pro").ToString();

                object objCat = DataBinder.Eval(p, "categoria_pro");
                string categoria = objCat != null && !string.IsNullOrEmpty(objCat.ToString()) ? objCat.ToString() : "General";

                decimal precio = Convert.ToDecimal(DataBinder.Eval(p, "precio_pro"));

                string rutaImg = "";
                try
                {
                    object objImg = DataBinder.Eval(p, "ruta_imagen_pro");
                    rutaImg = objImg != null ? objImg.ToString() : "";
                }
                catch { }

                // Si subiste múltiples imágenes separadas por coma, extraemos solo la primera foto
                string fotoPrincipal = string.IsNullOrEmpty(rutaImg) ?
                    "https://placehold.co/600x350/1e293b/10b981?text=" + nombre :
                    rutaImg.Split(',')[0];

                datosCarrusel.Add(new
                {
                    Nombre = nombre,
                    Categoria = categoria,
                    Precio = precio,
                    RutaImagen = fotoPrincipal
                });
            }

            rptCarrusel.DataSource = datosCarrusel;
            rptCarrusel.DataBind();
        }

        private void CargarGrafico()
        {
            Dictionary<string, int> datosEstadisticos = negocioPro.ObtenerEstadisticasCategorias();

            DataTable dt = new DataTable();
            dt.Columns.Add("Categoria", typeof(string));
            dt.Columns.Add("Cantidad", typeof(int));

            foreach (var fila in datosEstadisticos)
            {
                dt.Rows.Add(fila.Key, fila.Value);
            }

            chartCategorias.DataSource = dt;
            chartCategorias.DataBind();
        }

    }
}