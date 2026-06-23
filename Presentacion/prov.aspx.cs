using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio; 

namespace Presentacion
{
    public partial class prov : System.Web.UI.Page
    {
        
        private CN_Proveedor negocioProv = new CN_Proveedor();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UsuarioLogueado"] == null)
            {
                Response.Redirect("login.aspx");
            }
            if (!IsPostBack)
            {
                CargarTabla();
            }
        }

        
        private void CargarTabla()
        {
            gvProveedores.DataSource = negocioProv.ListarProveedores();
            gvProveedores.DataBind();
        }

        private void LimpiarFormulario()
        {
            hfIdProv.Value = "";
            txtNombre.Text = "";
            txtRuc.Text = "";
            btnGuardar.Text = "Guardar";
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtNombre.Text) || string.IsNullOrEmpty(txtRuc.Text)) return;

            if (string.IsNullOrEmpty(hfIdProv.Value))
            {
                
                negocioProv.InsertarProveedor(txtNombre.Text.Trim(), txtRuc.Text.Trim());
            }
            else
            {
                
                int id = Convert.ToInt32(hfIdProv.Value);
                negocioProv.EditarProveedor(id, txtNombre.Text.Trim(), txtRuc.Text.Trim());
            }

            LimpiarFormulario();
            CargarTabla();
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
        }

        
        protected void gvProveedores_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                
                GridViewRow fila = (GridViewRow)((LinkButton)e.CommandSource).NamingContainer;
                hfIdProv.Value = id.ToString();
                txtNombre.Text = fila.Cells[1].Text;
                txtRuc.Text = fila.Cells[2].Text;
                btnGuardar.Text = "Actualizar";
            }
            else if (e.CommandName == "Eliminar")
            {
                
                negocioProv.EliminarProveedor(id);
                LimpiarFormulario();
                CargarTabla();
            }
        }
    }
}