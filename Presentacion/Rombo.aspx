<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Rombo.aspx.cs" Inherits="Presentacion.Rombo" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Recuperación Rombo - Liquid Glass</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
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
        .btn-glow {
            background-color: #10b981;
            color: white;
            border: none;
            transition: all 0.3s ease;
        }
        .btn-glow:hover {
            background-color: #059669;
            box-shadow: 0 0 15px rgba(16, 185, 129, 0.5);
            color: white;
        }
        /* Forzamos el color verde neón brillante para el rombo */
        .rombo-container pre {
            color: #10b981 !important; 
            text-shadow: 0 0 8px rgba(16, 185, 129, 0.4);
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
                    <li class="nav-item"><a class="nav-link active text-white fw-bold border-bottom border-success" href="Rombo.aspx">🔷 Recuperación Rombo</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <form id="form1" runat="server">
        <div class="container py-5">
            
            <div class="text-center mb-5">
                <h1 class="glow-title display-5">RECUPERACIÓN</h1>
                <p class="text-secondary">Generador Dinámico de Rombo en Espiral con Marco</p>
            </div>

            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card liquid-glass p-5 text-center">
                        
                        <div class="row justify-content-center mb-4">
                            <div class="col-md-6">
                                <label class="form-label text-white-50">Ingrese el tamaño del rombo (n):</label>
                                <div class="input-group shadow-sm">
                                    <asp:TextBox ID="txtTamanio" runat="server" CssClass="form-control bg-dark text-white border-secondary" type="number" placeholder="Ej: 5"></asp:TextBox>
                                    <asp:Button ID="btnGenerarRombo" runat="server" Text="Dibujar Rombo" CssClass="btn btn-glow fw-bold px-4" OnClick="btnGenerarRombo_Click" />
                                </div>
                            </div>
                        </div>

                        <hr class="border-secondary opacity-25 mb-4" />

                        <div class="rombo-container d-flex justify-content-center align-items-center" style="min-height: 250px; overflow-x: auto;">
                            <asp:Label ID="lblRombo" runat="server"></asp:Label>
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </form>
</body>
</html>