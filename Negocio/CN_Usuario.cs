using System;
using System.Linq;
using System.Text;
using System.Security.Cryptography;
using System.Net.Mail;
using System.Net;

namespace Negocio
{
    public class CN_Usuario
    {
        private Datos.CD_Conexion conexionBase = new Datos.CD_Conexion();

        // 1. MOTOR DE ENCRIPTACIÓN SHA-256 (Nivel Bancario)
        private string EncriptarClave(string clavePlana)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(clavePlana));
                StringBuilder constructor = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    constructor.Append(bytes[i].ToString("x2")); // Convierte a Hexadecimal
                }
                return constructor.ToString();
            }
        }

        // 2. REGISTRAR NUEVO USUARIO
        public bool RegistrarUsuario(string correo, string clave)
        {
            var db = (dynamic)conexionBase.ObtenerContexto();

            // Verificamos que el correo no exista ya
            foreach (var u in db.tbl_usuario)
            {
                if (u.correo_usu.ToString().ToLower() == correo.ToLower()) return false;
            }

            Type tipoUsuario = db.GetType().Assembly.GetType("Datos.tbl_usuario");
            dynamic nuevoUsu = Activator.CreateInstance(tipoUsuario);
            nuevoUsu.correo_usu = correo.ToLower();
            nuevoUsu.clave_usu = EncriptarClave(clave); // ¡Se guarda encriptada!

            var tablaUsuario = db.GetType().GetProperty("tbl_usuario").GetValue(db, null);
            tablaUsuario.InsertOnSubmit(nuevoUsu);
            db.SubmitChanges();

            return true;
        }

        // 3. VALIDAR LOGIN
        public bool ValidarAcceso(string correo, string clavePlana)
        {
            var db = (dynamic)conexionBase.ObtenerContexto();
            string claveEncriptada = EncriptarClave(clavePlana);

            foreach (var u in db.tbl_usuario)
            {
                if (u.correo_usu.ToString().ToLower() == correo.ToLower() && u.clave_usu.ToString() == claveEncriptada)
                {
                    return true; // Credenciales correctas
                }
            }
            return false; // Credenciales inválidas
        }

        // 4. RECUPERAR CONTRASEÑA POR CORREO (SMTP GOOGLE)
        public bool RecuperarYEnviarClave(string correo)
        {
            var db = (dynamic)conexionBase.ObtenerContexto();
            dynamic usuarioEncontrado = null;

            foreach (var u in db.tbl_usuario)
            {
                if (u.correo_usu.ToString().ToLower() == correo.ToLower())
                {
                    usuarioEncontrado = u;
                    break;
                }
            }

            if (usuarioEncontrado == null) return false; // El correo no está registrado

            // Generar una contraseña temporal aleatoria de 8 caracteres
            string nuevaClaveTemp = Guid.NewGuid().ToString().Substring(0, 8);

            // Actualizar la base de datos con la nueva clave encriptada
            usuarioEncontrado.clave_usu = EncriptarClave(nuevaClaveTemp);
            db.SubmitChanges();

            // Configurar y Enviar Correo mediante SMTP
            try
            {
                MailMessage mensaje = new MailMessage();
                mensaje.From = new MailAddress("matteo.estevez18@gmail.com", "Sistema de Inventario Excel");
                mensaje.To.Add(correo);
                mensaje.Subject = "Recuperación de Contraseña - Inventario";
                mensaje.Body = $"<h3>Hola,</h3><p>Has solicitado recuperar tu acceso.</p><p>Tu nueva contraseña temporal es: <strong>{nuevaClaveTemp}</strong></p><p>Te recomendamos cambiarla una vez ingreses al sistema.</p>";
                mensaje.IsBodyHtml = true;

                SmtpClient clienteSmtp = new SmtpClient("smtp.gmail.com", 587);
                clienteSmtp.Credentials = new NetworkCredential("matteo.estevez18@gmail.com", "uupl falo kfqe yeaz");
                clienteSmtp.EnableSsl = true;

                clienteSmtp.Send(mensaje);
                return true;
            }
            catch (Exception)
            {
                return false; // Falló el envío del correo (bloqueo de firewall, internet, etc.)
            }
        }
    }
}