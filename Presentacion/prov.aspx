<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="prov.aspx.cs" Inherits="Presentacion.prov" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Gestión de Proveedores - Liquid Glass</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        /* Fondo Oscuro Profundo */
        body {
            background-color: #0f172a;
            color: #f8fafc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: radial-gradient(circle at 10% 20%, rgba(16, 185, 129, 0.1) 0%, transparent 45%),
                              radial-gradient(circle at 90% 80%, rgba(59, 130, 246, 0.08) 0%, transparent 50%);
            background-attachment: fixed;
            min-height: 100vh;
        }

        /* Contenedor Efecto Vidrio Líquido */
        .liquid-glass {
            background: rgba(30, 41, 59, 0.55);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.07);
            border-top: 1px solid rgba(255, 255, 255, 0.18);
            border-radius: 16px;
            box-shadow: 0 12px 40px 0 rgba(0, 0, 0, 0.4);
        }

        /* Títulos con brillo Esmeralda */
        .glow-title {
            color: #10b981;
            text-shadow: 0 0 15px rgba(16, 185, 129, 0.3);
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        /* Inputs Estilo Oscuro Translúcido */
        .glass-input {
            background: rgba(15, 23, 42, 0.6) !important;
            border: 1px solid rgba(255, 255, 255, 0.1) !important;
            color: #f8fafc !important;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .glass-input:focus {
            border-color: #10b981 !important;
            box-shadow: 0 0 10px rgba(16, 185, 129, 0.25) !important;
        }

        /* Botones */
        .btn-glow-emerald {
            background: linear-gradient(135deg, #059669 0%, #10b981 100%);
            color: #ffffff !important;
            border: none;
            font-weight: 600;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .btn-glow-emerald:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 22px rgba(16, 185, 129, 0.55);
        }

        /* Tabla Personalizada Dark Glass con Letras Claras */
        .glass-table {
            color: #e2e8f0 !important;
            vertical-align: middle;
        }
        .glass-table th {
            background: rgba(16, 185, 129, 0.15) !important;
            color: #10b981 !important;
            border-bottom: 2px solid rgba(16, 185, 129, 0.3) !important;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
        }
        .glass-table td, .glass-table span {
            background: transparent !important;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05) !important;
            color: #f1f5f9 !important; /* Forza texto claro */
        }
        .glass-table tr:hover td {
            background: rgba(255, 255, 255, 0.03) !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        
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

        <div class="container pb-5">
            <div class="text-center mb-5">
                <h1 class="glow-title display-5">MANTENIMIENTO DE PROVEEDORES</h1>
                <p class="text-secondary">Gestión de Catálogo de Distribuidores Físicos y Digitales</p>
            </div>
            
            <div class="card liquid-glass p-4 mb-4 shadow-sm">
                <div class="border-bottom border-secondary border-opacity-25 pb-2 mb-4">
                    <h5 class="m-0 text-white-50 text-uppercase fs-6" style="color: #cbd5e1;">Datos del Proveedor</h5>
                </div>
                
                <div class="row g-3">
                    <asp:HiddenField ID="hfIdProv" runat="server" />
                    
                    <div class="col-md-5">
                        <label class="form-label text-secondary small fw-semibold">Nombre o Razón Social:</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control glass-input" placeholder="Ej. Corporación ABC"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label text-secondary small fw-semibold">RUC Institucional:</label>
                        <asp:TextBox ID="txtRuc" runat="server" CssClass="form-control glass-input" placeholder="Ej. 1792345678001"></asp:TextBox>
                    </div>
                    <div class="col-md-3 d-flex align-items-end gap-2">
                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-glow-emerald w-100 py-2" OnClick="btnGuardar_Click" />
                        <asp:Button ID="btnCancelar" runat="server" Text="Limpiar" CssClass="btn btn-outline-secondary w-100 py-2" OnClick="btnCancelar_Click" />
                    </div>
                </div>
            </div>

            <div class="card liquid-glass p-4 shadow-sm">
                <div class="border-bottom border-secondary border-opacity-25 pb-2 mb-3">
                    <h5 class="m-0 text-white-50 text-uppercase fs-6" style="color: #cbd5e1;">Lista de Proveedores Registrados</h5>
                </div>
                
                <div class="table-responsive">
                    <asp:GridView ID="gvProveedores" runat="server" CssClass="table glass-table m-0" 
                        AutoGenerateColumns="False" DataKeyNames="id_prov" 
                        OnRowCommand="gvProveedores_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="id_prov" HeaderText="ID" ItemStyle-Width="60px" />
                            <asp:BoundField DataField="nombre_prov" HeaderText="Proveedor" />
                            <asp:BoundField DataField="ruc_prov" HeaderText="RUC" ItemStyle-Width="180px" />
                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="180px">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEditar" runat="server" CommandName="Editar" CommandArgument='<%# Eval("id_prov") %>' CssClass="btn btn-sm btn-outline-warning me-2" style="border-radius:6px;">Editar</asp:LinkButton>
                                    <asp:LinkButton ID="lnkEliminar" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("id_prov") %>' CssClass="btn btn-sm btn-outline-danger" style="border-radius:6px;" OnClientClick="return confirm('¿Seguro que deseas eliminar este proveedor? Sus productos asociados se borrarán en cascada.');">Eliminar</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            
        </div>
    </form>
</body>
</html>