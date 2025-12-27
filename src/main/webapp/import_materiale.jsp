<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>
<%@ page import="ro.serviceauto.serviceauto.model.MaterialePiese" %>
<%@ page import="java.util.List" %>

<%
    // 1. SECURITATE: Verificam daca e Admin
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 2. LOGICA DE STARE: Verificam daca avem date pregatite pentru PREVIEW
    // Atributul "previewMateriale" este pus in sesiune de Servlet dupa upload
    List<MaterialePiese> listaPreview = (List<MaterialePiese>) session.getAttribute("previewMateriale");
    boolean showPreview = (listaPreview != null && !listaPreview.isEmpty());
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Import Materiale & Piese</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .preview-table { width: 100%; border-collapse: collapse; margin-top: 15px; font-size: 14px; }
        .preview-table th, .preview-table td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        .preview-table th { background-color: #e9ecef; }
        .alert-box { padding: 10px; margin-bottom: 15px; border-radius: 5px; }
        .alert-error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .alert-warning { background-color: #fff3cd; color: #856404; border: 1px solid #ffeeba; }
        .instruction-box { background: #f8f9fa; padding: 15px; border: 1px dashed #ccc; margin-bottom: 20px; }
        code { font-family: Consolas, monospace; color: #d63384; }
    </style>
</head>
<body>
<div class="welcome-section" style="max-width: 900px;">
    <h2>📥 Importă Stoc Piese din Excel</h2>

    <% if (request.getParameter("error") != null) { %>
    <div class="alert-box alert-error">
        ❌ Eroare: <%= request.getParameter("error") %>
    </div>
    <% } %>

    <% if (!showPreview) { %>
    <div class="instruction-box">
        <p>Încarcă un fișier <strong>.xlsx</strong> respectând următoarea ordine a coloanelor:</p>
        <div style="margin-top:10px; line-height: 1.6;">
            <code>Col A: Denumire Piesă</code> (Text)<br>
            <code>Col B: Cantitate</code> (Număr întreg)<br>
            <code>Col C: Preț Unitar</code> (Număr, ex: 150.50)<br>
            <code>Col D: ID Serviciu Asociat</code> (Număr, ex: 1 pentru Schimb Ulei)
        </div>
        <br>
        <small><em>* Primul rând din Excel (Antetul) va fi ignorat automat.</em></small>
    </div>

    <form action="admin-import-materiale" method="post" enctype="multipart/form-data">
        <input type="hidden" name="step" value="preview">

        <label style="font-weight:bold;">Selectează fișierul Excel:</label>
        <input type="file" name="fisierExcel" accept=".xlsx" required style="padding: 10px; border: 1px solid #ccc; width: 100%; margin-bottom: 20px;">

        <div style="display:flex; gap:10px;">
            <button type="submit" class="btn btn-success">🔎 Vizualizare Date</button>
            <a href="admin-materiale" class="btn btn-danger">Înapoi la Tabel</a>
        </div>
    </form>

    <% } else { %>
    <div class="alert-box alert-warning">
        ⚠️ <strong>Atenție!</strong> Datele de mai jos NU sunt salvate încă în baza de date. Verifică dacă coloanele sunt aliniate corect.
    </div>

    <div style="max-height: 400px; overflow-y: auto; border: 1px solid #ddd;">
        <table class="preview-table">
            <thead>
            <tr>
                <th>#</th>
                <th>Denumire Piesă</th>
                <th>Cantitate</th>
                <th>Preț Unitar (RON)</th>
                <th>ID Serviciu</th>
            </tr>
            </thead>
            <tbody>
            <%
                int idx = 1;
                for (MaterialePiese m : listaPreview) {
            %>
            <tr>
                <td><%= idx++ %></td>
                <td><%= m.getDenumire() %></td>
                <td style="font-weight:bold; color:<%= m.getCantitate() < 5 ? "red" : "green" %>">
                    <%= m.getCantitate() %>
                </td>
                <td><%= m.getPretUnitar() %></td>
                <td><%= m.getIds() %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <br>

    <div style="display: flex; gap: 15px; justify-content: center;">
        <form action="admin-import-materiale" method="post">
            <input type="hidden" name="step" value="save">
            <button type="submit" class="btn btn-success" style="font-size: 18px; padding: 12px 24px;">
                ✅ Confirmă Importul
            </button>
        </form>

        <form action="admin-import-materiale" method="post">
            <input type="hidden" name="step" value="cancel">
            <button type="submit" class="btn btn-danger" style="font-size: 18px; padding: 12px 24px;">
                ❌ Anulează
            </button>
        </form>
    </div>
    <% } %>
</div>
</body>
</html>