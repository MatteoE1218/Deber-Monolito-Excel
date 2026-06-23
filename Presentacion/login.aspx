<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Presentacion.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Acceso al Sistema - Inventario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #0f172a;
            color: #f8fafc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: radial-gradient(circle at 10% 20%, rgba(16, 185, 129, 0.15) 0%, transparent 45%),
                              radial-gradient(circle at 90% 80%, rgba(59, 130, 246, 0.1) 0%, transparent 50%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .liquid-glass {
            background: rgba(30, 41, 59, 0.65);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-top: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            box-shadow: 0 15px 50px 0 rgba(0, 0, 0, 0.5);
            width: 100%;
            max-width: 420px;
            padding: 2.5rem;
        }
        .glow-title {
            color: #10b981;
            text-shadow: 0 0 15px rgba(16, 185, 129, 0.3);
            font-weight: 700;
        }
        .glass-input {
            background: rgba(15, 23, 42, 0.6) !important;
            border: 1px solid rgba(255, 255, 255, 0.1) !important;
            color: #f8fafc !important;
            border-radius: 8px;
        }
        .glass-input:focus {
            border-color: #10b981 !important;
            box-shadow: 0 0 10px rgba(16, 185, 129, 0.25) !important;
        }
        .btn-glow {
            background: linear-gradient(135deg, #059669 0%, #10b981 100%);
            color: #fff !important;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
            transition: all 0.3s;
        }
        .btn-glow:hover { transform: translateY(-2px); box-shadow: 0 6px 22px rgba(16, 185, 129, 0.5); }
        .text-link { color: #cbd5e1; cursor: pointer; text-decoration: none; font-size: 0.9rem; transition: 0.2s; }
        .text-link:hover { color: #10b981; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="liquid-glass text-center">
            <h2 class="glow-title mb-1">EXCEL INVENTORY</h2>
            <p class="text-secondary mb-4 small">Plataforma Segura de Gestión</p>

            <asp:Panel ID="pnlLogin" runat="server">
                <div class="mb-3 text-start">
                    <label class="form-label text-white-50 small">Correo Electrónico</label>
                    <asp:TextBox ID="txtCorreoLogin" runat="server" CssClass="form-control glass-input" placeholder="ejemplo@correo.com"></asp:TextBox>
                </div>
                <div class="mb-4 text-start">
                    <label class="form-label text-white-50 small">Contraseña</label>
                    <asp:TextBox ID="txtClaveLogin" runat="server" CssClass="form-control glass-input" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                </div>
                <asp:Button ID="btnIngresar" runat="server" Text="INICIAR SESIÓN" CssClass="btn btn-glow w-100 py-2 mb-3" OnClick="btnIngresar_Click" />
                
                <div class="d-flex justify-content-between mt-3">
                    <asp:LinkButton ID="lnkIrRegistro" runat="server" CssClass="text-link" OnClick="lnkIrRegistro_Click">Crear una cuenta</asp:LinkButton>
                    <asp:LinkButton ID="lnkIrRecuperar" runat="server" CssClass="text-link" OnClick="lnkIrRecuperar_Click">¿Olvidaste tu clave?</asp:LinkButton>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlRegistro" runat="server" Visible="false">
                <h6 class="text-white mb-3">Crear Nueva Cuenta</h6>
                <div class="mb-3 text-start">
                    <label class="form-label text-white-50 small">Nuevo Correo</label>
                    <asp:TextBox ID="txtCorreoReg" runat="server" CssClass="form-control glass-input" placeholder="tu@correo.com"></asp:TextBox>
                </div>
                <div class="mb-4 text-start">
                    <label class="form-label text-white-50 small">Crear Contraseña</label>
                    <asp:TextBox ID="txtClaveReg" runat="server" CssClass="form-control glass-input" TextMode="Password"></asp:TextBox>
                </div>
                <asp:Button ID="btnRegistrar" runat="server" Text="REGISTRARSE" CssClass="btn btn-primary w-100 py-2 mb-3 border-0 shadow" style="background: #3b82f6;" OnClick="btnRegistrar_Click" />
                <asp:LinkButton ID="lnkVolverLogin1" runat="server" CssClass="text-link" OnClick="lnkVolverLogin_Click">← Volver al Login</asp:LinkButton>
            </asp:Panel>

            <asp:Panel ID="pnlRecuperar" runat="server" Visible="false">
                <h6 class="text-white mb-3">Recuperación de Acceso</h6>
                <p class="text-secondary small mb-3">Ingresa tu correo y te enviaremos una contraseña temporal (Revisa tu bandeja de entrada o SPAM).</p>
                <div class="mb-4 text-start">
                    <label class="form-label text-white-50 small">Correo Registrado</label>
                    <asp:TextBox ID="txtCorreoRec" runat="server" CssClass="form-control glass-input" placeholder="tu@correo.com"></asp:TextBox>
                </div>
                <asp:Button ID="btnRecuperar" runat="server" Text="ENVIAR CORREO" CssClass="btn btn-warning w-100 py-2 mb-3 border-0 shadow text-dark fw-bold" OnClick="btnRecuperar_Click" />
                <asp:LinkButton ID="lnkVolverLogin2" runat="server" CssClass="text-link" OnClick="lnkVolverLogin_Click">← Volver al Login</asp:LinkButton>
            </asp:Panel>

        </div>
    </form>
</body>
</html>