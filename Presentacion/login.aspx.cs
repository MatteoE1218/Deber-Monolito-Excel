using System;
using System.Web.UI;
using Negocio;

namespace Presentacion
{
    public partial class login : System.Web.UI.Page
    {
        private CN_Usuario negocioUsu = new CN_Usuario();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
             
                if (Session["UsuarioLogueado"] != null)
                {
                    Response.Redirect("dashboard.aspx");
                }
            }
        }

        protected void lnkIrRegistro_Click(object sender, EventArgs e)
        {
            pnlLogin.Visible = false;
            pnlRegistro.Visible = true;
            pnlRecuperar.Visible = false;
        }

        protected void lnkIrRecuperar_Click(object sender, EventArgs e)
        {
            pnlLogin.Visible = false;
            pnlRegistro.Visible = false;
            pnlRecuperar.Visible = true;
        }

        protected void lnkVolverLogin_Click(object sender, EventArgs e)
        {
            pnlLogin.Visible = true;
            pnlRegistro.Visible = false;
            pnlRecuperar.Visible = false;
        }

        
        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            string correo = txtCorreoLogin.Text.Trim();
            string clave = txtClaveLogin.Text.Trim();

            if (negocioUsu.ValidarAcceso(correo, clave))
            {
                
                Session["UsuarioLogueado"] = correo;
                Response.Redirect("dashboard.aspx");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorLogin", "alert('Correo o contraseña incorrectos.');", true);
            }
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            string correo = txtCorreoReg.Text.Trim();
            string clave = txtClaveReg.Text.Trim();

            if (string.IsNullOrEmpty(correo) || string.IsNullOrEmpty(clave)) return;

            if (negocioUsu.RegistrarUsuario(correo, clave))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ExitoReg", "alert('¡Cuenta creada! Ahora puedes iniciar sesión.');", true);
                txtCorreoReg.Text = ""; txtClaveReg.Text = "";
                lnkVolverLogin_Click(null, null); // Devuelve al login
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorReg", "alert('Ese correo ya se encuentra registrado.');", true);
            }
        }

        protected void btnRecuperar_Click(object sender, EventArgs e)
        {
            string correo = txtCorreoRec.Text.Trim();
            if (string.IsNullOrEmpty(correo)) return;

            if (negocioUsu.RecuperarYEnviarClave(correo))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ExitoRec", "alert('Se ha enviado una clave temporal a tu correo. Revisa también la carpeta de SPAM.');", true);
                txtCorreoRec.Text = "";
                lnkVolverLogin_Click(null, null);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorRec", "alert('No se encontró el correo o hubo un error de conexión SMTP.');", true);
            }
        }
    }
}