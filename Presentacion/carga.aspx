<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="carga.aspx.cs" Inherits="Presentacion.carga" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Carga Masiva - Liquid Glass</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #0f172a;
            color: #f8fafc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: radial-gradient(circle at 10% 20%, rgba(16, 185, 129, 0.1) 0%, transparent 45%),
                              radial-gradient(circle at 90% 80%, rgba(59, 130, 246, 0.08) 0%, transparent 50%);
            background-attachment: fixed;
            min-height: 100vh;
        }
        .liquid-glass {
            background: rgba(30, 41, 59, 0.55);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.07);
            border-top: 1px solid rgba(255, 255, 255, 0.18);
            border-radius: 16px;
            box-shadow: 0 12px 40px 0 rgba(0, 0, 0, 0.4);
        }
        .glow-title {
            color: #10b981;
            text-shadow: 0 0 15px rgba(16, 185, 129, 0.3);
            font-weight: 700;
        }
        .file-input-custom {
            background: rgba(15, 23, 42, 0.6) !important;
            border: 1px solid rgba(255, 255, 255, 0.1) !important;
            color: #cbd5e1 !important;
        }
        .btn-glow-emerald {
            background: linear-gradient(135deg, #059669 0%, #10b981 100%);
            color: #ffffff !important;
            border: none;
            font-weight: 600;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
            transition: all 0.3s ease;
        }
        .btn-glow-emerald:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 22px rgba(16, 185, 129, 0.55);
        }
        .glass-table {
            color: #e2e8f0 !important;
        }
        .glass-table th {
            background: rgba(16, 185, 129, 0.15) !important;
            color: #10b981 !important;
            border-bottom: 2px solid rgba(16, 185, 129, 0.3) !important;
        }
        .glass-table td {
            background: transparent !important;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05) !important;
            color: #f1f5f9 !important;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark mb-4 sticky-top" style="background: rgba(15, 23, 42, 0.85); backdrop-filter: blur(12px); border-bottom: 1px solid rgba(16, 185, 129, 0.3);">
    <div class="container">
        <a class="navbar-brand glow-title" href="dashboard.aspx">EXCEL INVENTORY</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto gap-3">
                <li class="nav-item"><a class="nav-link text-white fw-semibold" href="dashboard.aspx">📈 Dashboard</a></li>
                <li class="nav-item"><a class="nav-link text-white fw-semibold" href="prov.aspx">🏢 Proveedores</a></li>
                <li class="nav-item"><a class="nav-link text-white fw-semibold" href="pro.aspx">📦 Productos</a></li>
                <li class="nav-item"><a class="nav-link text-white fw-semibold" href="carga.aspx">☁️ Carga Masiva</a></li>
            </ul>
        </div>
    </div>
</nav>
    <form id="form1" runat="server">
        <div class="container py-5">
            
            <div class="text-center mb-5">
                <h1 class="glow-title display-5">PROCESADOR DE ARCHIVOS PLANOS</h1>
                <p class="text-secondary">Carga Masiva e Importación de Catálogos Relacionales</p>
            </div>

            <div class="card liquid-glass p-4 mb-5">
                <div class="border-bottom border-secondary border-opacity-25 pb-2 mb-4">
                    <h5 class="m-0 text-white-50 text-uppercase fs-6" style="color: #cbd5e1;">Seleccionar Archivo CSV de Inventario</h5>
                </div>
                
                <div class="row g-3 align-items-center">
                    <div class="col-md-7">
                        <asp:FileUpload ID="fuInventario" runat="server" CssClass="form-control file-input-custom" />
                    </div>
                    <div class="col-md-5 d-flex gap-2">
                        <asp:Button ID="btnPrevisualizar" runat="server" Text="Analizar y Previsualizar" CssClass="btn btn-outline-info w-100" style="border-radius:8px;" OnClick="btnPrevisualizar_Click" />
                        <asp:Button ID="btnProcesar" runat="server" Text="Confirmar y Guardar" CssClass="btn btn-glow-emerald w-100" Enabled="false" OnClick="btnProcesar_Click" />
                    </div>
                </div>
                <div class="mt-3">
                    <asp:Label ID="lblMensaje" runat="server" CssClass="fw-bold" ForeColor="#10b981"></asp:Label>
                </div>
            </div>

            <div class="card liquid-glass p-4">
                <div class="border-bottom border-secondary border-opacity-25 pb-2 mb-3">
                    <h5 class="m-0 text-white-50 text-uppercase fs-6" style="color: #cbd5e1;">Previsualización de Datos en Memoria</h5>
                </div>
                <div class="table-responsive">
                    <asp:GridView ID="gvPrevisualizar" runat="server" CssClass="table glass-table m-0" AutoGenerateColumns="True">
                    </asp:GridView>
                </div>
            </div>

        </div>
    </form>
</body>
</html>