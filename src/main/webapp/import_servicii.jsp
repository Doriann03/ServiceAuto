<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>
<%@ page import="ro.serviceauto.serviceauto.model.Serviciu" %>
<%@ page import="java.util.List" %>

<%
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp"); return;
    }

    List<Serviciu> listaPreview = (List<Serviciu>) session.getAttribute("previewServicii");
    boolean showPreview = (listaPreview != null && !listaPreview.isEmpty());
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Import Servicii</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body>
<div class="d-flex">

    <jsp:include page="includes/sidebar_admin.jsp" />

    <div class="main-content flex-grow-1 bg-light">
        <div class="container p-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="dashboard_admin.jsp">Home</a></li>
                        <li class="breadcrumb-item"><a href="admin-servicii">Servicii</a></li>
                        <li class="breadcrumb-item active">Import Excel</li>
                    </ol>
                </nav>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card card-dashboard border-0 shadow-lg">
                        <div class="card-header bg-warning text-dark py-3">
                            <h4 class="mb-0 fw-bold"><i class="fa-solid fa-file-import me-2"></i> Import Servicii</h4>
                        </div>
                        <div class="card-body p-4">

                            <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-danger d-flex align-items-center mb-4">
                                <i class="fa-solid fa-triangle-exclamation fa-2x me-3"></i>
                                <div><strong>Eroare:</strong> <%= request.getParameter("error") %></div>
                            </div>
                            <% } %>

                            <% if (!showPreview) { %>
                            <div class="alert alert-info border-0 shadow-sm mb-4">
                                <h6 class="alert-heading fw-bold"><i class="fa-solid fa-circle-info me-2"></i> Instrucțiuni Fișier Excel (.xlsx)</h6>
                                <hr>
                                <p class="mb-2">Ordinea coloanelor este obligatorie:</p>
                                <ol class="mb-0 small fw-bold">
                                    <li>Denumire Serviciu</li>
                                    <li>Descriere</li>
                                    <li>Durată (minute)</li>
                                    <li>ID Atelier (Cifră)</li>
                                </ol>
                                <div class="mt-2 text-muted fst-italic small">* Primul rând (header) este ignorat automat.</div>
                            </div>

                            <form action="admin-import-servicii" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="step" value="preview">

                                <label class="form-label fw-bold">Alege Fișierul</label>
                                <div class="input-group mb-4">
                                    <input type="file" name="fisierExcel" class="form-control" accept=".xlsx" required>
                                    <button class="btn btn-primary" type="submit">
                                        <i class="fa-solid fa-magnifying-glass me-2"></i> Previzualizare
                                    </button>
                                </div>
                                <div class="text-end">
                                    <a href="admin-servicii" class="btn btn-outline-secondary">Anulează</a>
                                </div>
                            </form>

                            <% } else { %>
                            <div class="alert alert-warning border-0 shadow-sm d-flex align-items-center">
                                <i class="fa-solid fa-eye fa-2x me-3"></i>
                                <div>
                                    <strong>Mod Previzualizare:</strong> Datele de mai jos NU sunt salvate încă.
                                    Verifică corectitudinea lor înainte de confirmare.
                                </div>
                            </div>

                            <div class="table-responsive border rounded mb-4" style="max-height: 400px;">
                                <table class="table table-striped table-hover mb-0 font-monospace small">
                                    <thead class="table-dark sticky-top">
                                    <tr>
                                        <th>#</th>
                                        <th>Denumire</th>
                                        <th>Descriere</th>
                                        <th>Durată</th>
                                        <th>ID Atelier</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <% int idx = 1; for (Serviciu s : listaPreview) { %>
                                    <tr>
                                        <td><%= idx++ %></td>
                                        <td><%= s.getNume() %></td>
                                        <td><%= s.getDescriere() %></td>
                                        <td><%= s.getDurataEstimata() %> min</td>
                                        <td class="text-center fw-bold"><%= s.getIda() %></td>
                                    </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>

                            <div class="d-flex gap-2 justify-content-center">
                                <form action="admin-import-servicii" method="post">
                                    <input type="hidden" name="step" value="save">
                                    <button type="submit" class="btn btn-success fw-bold px-4 py-2 shadow-sm">
                                        <i class="fa-solid fa-check-circle me-2"></i> Confirmă Importul
                                    </button>
                                </form>

                                <form action="admin-import-servicii" method="post">
                                    <input type="hidden" name="step" value="cancel">
                                    <button type="submit" class="btn btn-danger fw-bold px-4 py-2 shadow-sm">
                                        <i class="fa-solid fa-xmark me-2"></i> Renunță
                                    </button>
                                </form>
                            </div>
                            <% } %>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>