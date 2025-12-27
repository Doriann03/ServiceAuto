<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>
<%@ page import="ro.serviceauto.serviceauto.model.Serviciu" %>
<%@ page import="java.util.List" %>

<%
    // 1. Securitate: Verificam daca e Admin
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 2. Verificam daca avem date pregatite in sesiune pentru PREVIEW
    // Atentie: Numele atributului trebuie sa coincida cu cel din Servlet ("previewServicii")
    List<Serviciu> listaPreview = (List<Serviciu>) session.getAttribute("previewServicii");
    boolean showPreview = (listaPreview != null && !listaPreview.isEmpty());
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Import Servicii</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .preview-table { width: 100%; border-collapse: collapse; margin-top: 15px; font-size: 14px; }
        .preview-table th, .preview-table td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        .preview-table th { background-color: #e9ecef; }
        .alert-box { padding: 10px; margin-bottom: 15px; border-radius: 5px; }
        .alert-error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .alert-warning { background-color: #fff3cd; color: #856404; border: 1px solid #ffeeba; }
        .instruction-box { background: #f8f9fa; padding: 15px; border: 1px dashed #ccc; margin-bottom: 20px; }
    </style>
</head>
<body>
<div class="welcome-section" style="max-width: 900px;">
    <h2>📥 Importă Servicii din Excel</h2>

    <% if (request.getParameter("error") != null) { %>
    <div class="alert-box alert-error">
        ❌ Eroare: <%= request.getParameter("error") %>
    </div>
    <% } %>

    <% if (!showPreview) { %>
    <div class="instruction-box">
        <p>Încarcă un fișier <strong>.xlsx</strong> care să respecte următoarea structură:</p>
        <code style="display:block; background:#eee; padding:10px; margin-top:5px;">
            Coloana A: Denumire Serviciu<br>
            Coloana B: Descriere<br>
            Coloana C: Durată (minute)<br>
            Coloana D: ID Atelier (Număr, ex: 1, 2)
        </code>
        <br>
        <small><em>* Primul rând din Excel este considerat Antet și va fi ignorat.</em></small>
    </div>

    <form action="admin-import-servicii" method="post" enctype="multipart/form-data">
        <input type="hidden" name="step" value="preview">

        <label>Selectează fișierul:</label>
        <input type="file" name="fisierExcel" accept=".xlsx" required style="padding: 10px; border: 1px solid #ccc; width: 100%;">
        <br><br>

        <div style="display:flex; gap:10px;">
            <button type="submit" class="btn btn-success">🔎 Vizualizare Date</button>
            <a href="admin-servicii" class="btn btn-danger">Înapoi</a>
        </div>
    </form>

    <% } else { %>
    <div class="alert-box alert-warning">
        ⚠️ <strong>Atenție!</strong> Datele de mai jos NU sunt salvate încă. Verifică dacă coloanele corespund.
    </div>

    <div style="max-height: 400px; overflow-y: auto;">
        <table class="preview-table">
            <thead>
            <tr>
                <th>#</th>
                <th>Denumire</th>
                <th>Descriere</th>
                <th>Durată (min)</th>
                <th>ID Atelier</th>
            </tr>
            </thead>
            <tbody>
            <%
                int idx = 1;
                for (Serviciu s : listaPreview) {
            %>
            <tr>
                <td><%= idx++ %></td>
                <td><%= s.getNume() %></td>
                <td><%= s.getDescriere() %></td>
                <td><%= s.getDurataEstimata() %></td>
                <td style="text-align:center;"><%= s.getIda() %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <br>

    <div style="display: flex; gap: 15px; justify-content: center;">
        <form action="admin-import-servicii" method="post">
            <input type="hidden" name="step" value="save">
            <button type="submit" class="btn btn-success" style="font-size: 18px; padding: 12px 24px;">
                ✅ Confirmă Importul
            </button>
        </form>

        <form action="admin-import-servicii" method="post">
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