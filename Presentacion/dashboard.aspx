<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="Presentacion.dashboard" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Dashboard - Liquid Glass Charts</title>
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
        .carousel-item img {
            height: 350px;
            object-fit: cover;
            border-radius: 12px;
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
                <li class="nav-item"><a class="nav-link text-white fw-semibold" href="Rombo.aspx">🔷 Recuperación Rombo</a></li>
            </ul>
        </div>
    </div>
</nav>
    <form id="form1" runat="server">
        <div class="container py-5">
            
            <div class="text-center mb-5">
                <h1 class="glow-title display-5">DASHBOARD & ANALYTICS</h1>
                <p class="text-secondary">Visualización de Catálogos y Métricas del Sistema</p>
            </div>

            <div class="row g-4">
                <div class="col-md-6">
                    <div class="card liquid-glass p-4 h-100">
                        <div class="border-bottom border-secondary border-opacity-25 pb-2 mb-4">
                            <h5 class="m-0 text-white" style="color: #cbd5e1;">Galería de Componentes Activos</h5>
                        </div>

                        <div id="productCarousel" class="carousel slide shadow" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <asp:Repeater ID="rptCarrusel" runat="server">
                                    <ItemTemplate>
                                        <div class='<%# Container.ItemIndex == 0 ? "carousel-item active" : "carousel-item" %>'>
                                            <img src='<%# ResolveUrl(Eval("RutaImagen").ToString()) %>' class="d-block w-100" alt="Producto" onerror="this.src='https://placehold.co/600x350/1e293b/10b981?text=Sin+Imagen';" />
                                            <div class="carousel-caption d-none d-md-block" style="background: rgba(15, 23, 42, 0.7); border-radius: 8px;">
                                                <h5><%# Eval("Nombre") %></h5>
                                                <p>Categoría: <%# Eval("Categoria") %> - Base: <%# Eval("Precio", "{0:C}") %></p>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#productCarousel" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Anterior</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#productCarousel" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Siguiente</span>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card liquid-glass p-4 h-100 align-items-center">
                        <div class="border-bottom border-secondary border-opacity-25 pb-2 mb-4 w-100 text-start">
                            <h5 class="m-0 text-white" style="color: #cbd5e1;">Volumen Físico por Categoría</h5>
                        </div>

                        <asp:Chart ID="chartCategorias" runat="server" Width="450px" Height="320px" BackColor="Transparent">
                            <Series>
                                <asp:Series Name="Productos" ChartType="Pie" XValueMember="Categoria" YValueMembers="Cantidad" 
                                    IsValueShownAsLabel="True" LabelForeColor="White" Font="Segoe UI, 10pt, style=Bold">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1" BackColor="Transparent"></asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    </div>
                </div>
            </div>

        </div>
    </form>
</body>
</html>