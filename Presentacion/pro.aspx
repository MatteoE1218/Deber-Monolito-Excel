<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pro.aspx.cs" Inherits="Presentacion.pro" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Inventario - Liquid Glass</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #0f172a;
            color: #f8fafc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: radial-gradient(circle at 10% 20%, rgba(16, 185, 129, 0.1) 0%, transparent 45%), radial-gradient(circle at 90% 80%, rgba(59, 130, 246, 0.08) 0%, transparent 50%);
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
            letter-spacing: 0.5px;
        }

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

            .glass-input option {
                background: #1e293b;
                color: #f8fafc;
            }

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

            .glass-table td {
                background: transparent !important;
                border-bottom: 1px solid rgba(255, 255, 255, 0.05) !important;
            }

            .glass-table tr:hover td {
                background: rgba(255, 255, 255, 0.03) !important;
            }

        .pagination table {
            margin: auto;
        }

        .pagination td a, .pagination td span {
            padding: 6px 12px;
            margin: 0 3px;
            border-radius: 6px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            background: rgba(30, 41, 59, 0.4);
            color: #f8fafc;
            text-decoration: none;
        }

        .pagination td span {
            background: #10b981 !important;
            color: #fff;
        }

        .glass-table td, .glass-table span {
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
                <h1 class="glow-title display-5">EXCEL INVENTORY SYSTEM</h1>
                <p class="text-secondary">Mantenimiento Avanzado de Productos & Catálogos</p>
            </div>

            <div class="card liquid-glass p-4 mb-4">
                <div class="border-bottom border-secondary border-opacity-25 pb-2 mb-4">
                    <h5 class="m-0 text-white-50 text-uppercase fs-6" style="color: #cbd5e1;">Registrar / Editar Componente</h5>
                </div>

                <div class="row g-3">
                    <asp:HiddenField ID="hfIdPro" runat="server" />

                    <div class="col-md-3">
                        <label class="form-label text-secondary small fw-semibold">Proveedor Asociado</label>
                        <asp:DropDownList ID="ddlProveedor" runat="server" CssClass="form-select glass-input"></asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label text-secondary small fw-semibold">Nombre del Artículo</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control glass-input" placeholder="Ej. Monitor Ultrawide 34'"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label text-secondary small fw-semibold">Categoría Lineal</label>
                        <asp:TextBox ID="txtCategoria" runat="server" CssClass="form-control glass-input" placeholder="Ej. Hardware"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label text-secondary small fw-semibold">Precio Unitario ($)</label>
                        <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control glass-input" placeholder="0.00"></asp:TextBox>
                    </div>
                    <div class="col-md-12 mt-3">
                        <label class="form-label text-secondary small fw-semibold">Fotografías del Producto (Puedes seleccionar varias)</label>
                        <div class="d-flex flex-column gap-3">
                            <asp:FileUpload ID="fuImagen" runat="server" CssClass="form-control glass-input w-50" accept=".png,.jpg,.jpeg" AllowMultiple="true" onchange="mostrarVistaPrevia(this)" />

                            <div id="vistaPreviaContenedor" class="d-flex flex-wrap gap-2"></div>
                        </div>
                    </div>

                    <div class="col-12 d-flex justify-content-end gap-2 mt-4">
                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar Item" CssClass="btn btn-glow-emerald px-4 py-2" OnClick="btnGuardar_Click" />
                    </div>
                </div>
            </div>

            <asp:ScriptManager ID="ScriptManager1" runat="server" />

            <div class="card liquid-glass p-4 mb-4">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <label class="form-label text-secondary small fw-semibold">Búsqueda Predictiva de Inventario (Estilo Facebook)</label>
                        <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control glass-input"
                            placeholder="Escribe el nombre del producto o categoría..."
                            AutoPostBack="True" OnTextChanged="txtBuscar_TextChanged"></asp:TextBox>
                    </div>
                    <div class="col-md-6 text-end pt-4">
                        <span class="badge bg-success p-2">Filtro Asíncrono Activo</span>
                    </div>
                </div>
            </div>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="card liquid-glass p-4">
                        <div class="border-bottom border-secondary border-opacity-25 pb-2 mb-3">
                            <h5 class="m-0 text-white-50 text-uppercase fs-6" style="color: #cbd5e1;">Inventario Disponible</h5>
                        </div>

                        <div class="table-responsive">
                            <asp:GridView ID="gvProductos" runat="server" CssClass="table glass-table m-0"
                                AutoGenerateColumns="False" DataKeyNames="id_pro"
                                AllowPaging="True" PageSize="5"
                                OnRowCommand="gvProductos_RowCommand"
                                OnPageIndexChanging="gvProductos_PageIndexChanging">
                                <PagerStyle CssClass="pagination justify-content-center text-white pt-3" />
                                <Columns>
                                    <asp:BoundField DataField="id_pro" HeaderText="ID" ItemStyle-Width="60px" />

                                    <asp:BoundField DataField="NombreProveedor" HeaderText="Proveedor" />

                                    <asp:BoundField DataField="nombre_pro" HeaderText="Producto" />
                                    <asp:BoundField DataField="categoria_pro" HeaderText="Categoría" />
                                    <asp:BoundField DataField="precio_pro" HeaderText="Precio" DataFormatString="{0:C}" />
                                    <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="180px">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkEditar" runat="server" CommandName="Editar" CommandArgument='<%# Eval("id_pro") %>' CssClass="btn btn-sm btn-outline-warning me-2" Style="border-radius: 6px;">Modificar</asp:LinkButton>
                                            <asp:LinkButton ID="lnkEliminar" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("id_pro") %>' CssClass="btn btn-sm btn-outline-danger" Style="border-radius: 6px;" OnClientClick="return confirm('¿Remover este artículo?');">Remover</asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="txtBuscar" EventName="TextChanged" />
                </Triggers>
            </asp:UpdatePanel>

        </div>
    </form>
    <script>
        function mostrarVistaPrevia(input) {
            const contenedor = document.getElementById('vistaPreviaContenedor');
            contenedor.innerHTML = ''; // Limpia fotos anteriores si eliges otras

            if (input.files && input.files.length > 0) {
                for (let i = 0; i < input.files.length; i++) {
                    let reader = new FileReader();
                    reader.onload = function (e) {
                        let img = document.createElement('img');
                        img.src = e.target.result; // Asigna la imagen en memoria
                        img.style.width = '80px';
                        img.style.height = '80px';
                        img.style.objectFit = 'cover';
                        img.style.borderRadius = '8px';
                        img.style.border = '2px solid #10b981'; // Borde esmeralda
                        contenedor.appendChild(img);
                    }
                    reader.readAsDataURL(input.files[i]); // Lee el archivo
                }
            }
        }
    </script>
</body>
</html>
