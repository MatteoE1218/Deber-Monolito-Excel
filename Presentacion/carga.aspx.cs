using System;
using System.Data;
using System.IO;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;

namespace Presentacion
{
    public partial class carga : System.Web.UI.Page
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
                Session["DatosExcel"] = null;
            }
        }

        protected void btnPrevisualizar_Click(object sender, EventArgs e)
        {
            if (!fuInventario.HasFile)
            {
                lblMensaje.Text = "Por favor, seleccione un archivo plano válido.";
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                List<Dictionary<string, string>> listaRegistros = new List<Dictionary<string, string>>();
                DataTable dt = new DataTable();

                
                dt.Columns.Add("Proveedor");
                dt.Columns.Add("RUC");
                dt.Columns.Add("Producto");
                dt.Columns.Add("Categoria");
                dt.Columns.Add("Precio");
                dt.Columns.Add("RutaImagen");

                using (StreamReader reader = new StreamReader(fuInventario.PostedFile.InputStream))
                {
                    string linea;
                    bool esPrimeraLinea = true;

                    while ((linea = reader.ReadLine()) != null)
                    {
                        if (string.IsNullOrEmpty(linea.Trim())) continue;

                        
                        if (esPrimeraLinea)
                        {
                            esPrimeraLinea = false;
                            continue;
                        }

                        string[] celdas = linea.Split(',');

                     
                        if (celdas.Length >= 6)
                        {
                            DataRow row = dt.NewRow();
                            row["Proveedor"] = celdas[0].Trim();
                            row["RUC"] = celdas[1].Trim();
                            row["Producto"] = celdas[2].Trim();
                            row["Categoria"] = celdas[3].Trim();
                            row["Precio"] = celdas[4].Trim();

                           
                            string nombreFoto = celdas[5].Trim();
                            string rutaRelativa = "~/Imagenes/" + nombreFoto;

                            row["RutaImagen"] = rutaRelativa;
                            dt.Rows.Add(row);

                            Dictionary<string, string> dict = new Dictionary<string, string>();
                            dict["Proveedor"] = celdas[0].Trim();
                            dict["RUC"] = celdas[1].Trim();
                            dict["Producto"] = celdas[2].Trim();
                            dict["Categoria"] = celdas[3].Trim();
                            dict["Precio"] = celdas[4].Trim();
                            dict["RutaImagen"] = rutaRelativa; 

                            listaRegistros.Add(dict);
                        }
                    }
                }

               
                Session["DatosExcel"] = listaRegistros;

                
                gvPrevisualizar.DataSource = dt;
                gvPrevisualizar.DataBind();

                btnProcesar.Enabled = dt.Rows.Count > 0;
                lblMensaje.Text = $"Análisis completado. {dt.Rows.Count} registros listos para importación.";
                lblMensaje.ForeColor = System.Drawing.Color.DeepSkyBlue;
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al procesar el archivo: " + ex.Message;
                lblMensaje.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnProcesar_Click(object sender, EventArgs e)
        {
            var datos = Session["DatosExcel"] as List<Dictionary<string, string>>;
            if (datos != null)
            {
                try
                {
                    negocioPro.ProcesarCargaMasiva(datos);
                    lblMensaje.Text = "¡Importación masiva completada de forma exitosa en la Base de Datos!";
                    lblMensaje.ForeColor = System.Drawing.Color.LimeGreen;
                    btnProcesar.Enabled = false;
                    gvPrevisualizar.DataSource = null;
                    gvPrevisualizar.DataBind();
                }
                catch (Exception ex)
                {
                    lblMensaje.Text = "Error en el guardado relacional: " + ex.Message;
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}