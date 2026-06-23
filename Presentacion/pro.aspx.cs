using Negocio;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Presentacion
{
    public partial class pro : System.Web.UI.Page
    {
        private CN_Producto negocioPro = new CN_Producto();
        private CN_Proveedor negocioProv = new CN_Proveedor();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UsuarioLogueado"] == null)
            {
                Response.Redirect("login.aspx");
            }
            if (!IsPostBack)
            {
                CargarComboProveedores();
                CargarTablaProductos();
            }
        }

        private void CargarComboProveedores()
        {
            ddlProveedor.DataSource = negocioProv.ListarProveedores();
            ddlProveedor.DataValueField = "id_prov";
            ddlProveedor.DataTextField = "nombre_prov";
            ddlProveedor.DataBind();
            ddlProveedor.Items.Insert(0, new ListItem("-- Seleccione un Proveedor --", ""));
        }

        private void CargarTablaProductos()
        {
            gvProductos.DataSource = negocioPro.ListarProductos();
            gvProductos.DataBind();
        }

        private void LimpiarFormulario()
        {
            hfIdPro.Value = "";
            ddlProveedor.SelectedIndex = 0;
            txtNombre.Text = "";
            txtCategoria.Text = "";
            txtPrecio.Text = "";
            btnGuardar.Text = "Guardar Item";
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlProveedor.SelectedValue) || string.IsNullOrEmpty(txtNombre.Text) || string.IsNullOrEmpty(txtPrecio.Text)) return;

            // --- CORRECCIÓN MONGODB ---
            // Tomamos el NOMBRE del proveedor en lugar del ID numérico
            string nombreProveedor = ddlProveedor.SelectedItem.Text;
            string nombre = txtNombre.Text.Trim();
            string categoria = txtCategoria.Text.Trim();
            decimal precio = Convert.ToDecimal(txtPrecio.Text.Trim());

            // --- LÓGICA MULTI-IMAGEN BLINDADA ---
            string rutaImagen = "";

            if (fuImagen.HasFiles) // Detecta si hay 1 o más archivos
            {
                List<string> rutasGuardadas = new List<string>();

                foreach (var archivo in fuImagen.PostedFiles)
                {
                    try
                    {
                        if (archivo.ContentLength > 2097152) continue; // Ignora si pesa más de 2MB

                        string extension = System.IO.Path.GetExtension(archivo.FileName).ToLower();
                        if (extension != ".jpg" && extension != ".jpeg" && extension != ".png") continue;

                        string nombreArchivo = Guid.NewGuid().ToString() + extension;
                        string rutaFisica = Server.MapPath("~/Imagenes/") + nombreArchivo;

                        archivo.SaveAs(rutaFisica);
                        rutasGuardadas.Add("~/Imagenes/" + nombreArchivo); // Guarda la ruta individual
                    }
                    catch (Exception) { /* Ignora fallos individuales y sigue con las demás fotos */ }
                }

                rutaImagen = string.Join(",", rutasGuardadas);
            }

            // --- LÓGICA DE GUARDADO MONGO ---
            if (string.IsNullOrEmpty(hfIdPro.Value))
            {
                // Enviamos el nombreProveedor en lugar del idProv
                negocioPro.InsertarProducto(nombreProveedor, nombre, categoria, precio, rutaImagen);
            }
            else
            {
                // CORRECCIÓN MONGODB: El ID se lee como string, quitamos el Convert.ToInt32
                string idPro = hfIdPro.Value;
                negocioPro.EditarProducto(idPro, nombreProveedor, nombre, categoria, precio, rutaImagen);
            }

            LimpiarFormulario();
            CargarTablaProductos();
        }

        protected void gvProductos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Page" || e.CommandName == "Sort") return;

            // CORRECCIÓN MONGODB: Leemos el CommandArgument como un simple string de texto
            string id = e.CommandArgument.ToString();

            if (e.CommandName == "Editar")
            {
                LinkButton btnEditar = (LinkButton)e.CommandSource;
                GridViewRow fila = (GridViewRow)btnEditar.NamingContainer;

                hfIdPro.Value = id;

                // CORRECCIÓN MONGODB: Como en Mongo guardamos el nombre directo del proveedor,
                // forzamos al combo a seleccionarlo usando el Texto en lugar del Value numérico.
                // IMPORTANTE: Asegúrate de que fila.Cells[1] sigue siendo la columna donde se muestra el proveedor.
                string nombreProvCelda = Server.HtmlDecode(fila.Cells[1].Text).Trim();
                if (ddlProveedor.Items.FindByText(nombreProvCelda) != null)
                {
                    ddlProveedor.ClearSelection();
                    ddlProveedor.Items.FindByText(nombreProvCelda).Selected = true;
                }

                txtNombre.Text = Server.HtmlDecode(fila.Cells[2].Text).Trim();
                txtCategoria.Text = Server.HtmlDecode(fila.Cells[3].Text).Trim();

                string precioTexto = Server.HtmlDecode(fila.Cells[4].Text).Replace("$", "").Replace("€", "").Trim();
                txtPrecio.Text = precioTexto;

                btnGuardar.Text = "Actualizar Item";
            }
            else if (e.CommandName == "Eliminar")
            {
                // Enviamos el id tipo string directamente
                negocioPro.EliminarProducto(id);
                LimpiarFormulario();
                CargarTablaProductos();
            }
        }

        protected void txtBuscar_TextChanged(object sender, EventArgs e)
        {
            gvProductos.PageIndex = 0; // Reseteamos la página a la inicial al filtrar
            EjecutarFiltro();
        }

        protected void gvProductos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvProductos.PageIndex = e.NewPageIndex;
            EjecutarFiltro();
        }

        private void EjecutarFiltro()
        {
            if (string.IsNullOrEmpty(txtBuscar.Text.Trim()))
            {
                CargarTablaProductos();
            }
            else
            {
                gvProductos.DataSource = negocioPro.FiltrarProductos(txtBuscar.Text.Trim());
                gvProductos.DataBind();
            }
        }
    }
}