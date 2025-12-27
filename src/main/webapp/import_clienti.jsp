<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>
<%@ page import="java.util.List" %>
<%
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp"); return;
    }

    // Verificam daca avem date pregatite pentru preview
    List<Client> listaPreview = (List<Client>) session.getAttribute("listaImportPreview");
    boolean showPreview = (listaPreview != null && !listaPreview.isEmpty());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Import Clienți</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .preview-table { width: 100%; border-collapse: collapse; margin-top: 15px; font-size: 14px; }
        .preview-table th, .preview-table td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        .preview-table th { background-color: #e9ecef; }
        .alert-box { padding: 10px; margin-bottom: 15px; border-radius: 5px; }
        .alert-error { background-color: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
<div class="welcome-section" style="max-width: 900px;">
    <h2>Importă Clienți din Excel</h2>

    <% if (request.getParameter("error") != null) { %>
    <div class="alert-box alert-error">Eroare: <%= request.getParameter("error") %></div>
    <% } %>

    <% if (!showPreview) { %>
    <div style="background: #f8f9fa; padding: 15px; border: 1px dashed #ccc; margin-bottom: 20px;">
        <p>Încarcă un fișier <strong>.xlsx</strong> (fără ID pe prima coloană!)</p>
        <strong>Structură Coloane:</strong><br>
        Nume | Prenume | Telefon | Email | Username | Parolă | Rol
    </div>

    <form action="admin-import-clienti" method="post" enctype="multipart/form-data">
        <input type="hidden" name="step" value="preview">

        <input type="file" name="fisierExcel" accept=".xlsx" required style="padding: 10px;">
        <br><br>
        <button type="submit" class="btn btn-success">🔎 Vizualizare Date</button>
        <a href="clienti_admin.jsp" class="btn btn-danger">Înapoi</a>
    </form>

    <% } else { %>
    <div style="background: #fff3cd; padding: 10px; border: 1px solid #ffeeba; color: #856404;">
        ⚠️ <strong>Atenție!</strong> Datele de mai jos NU sunt salvate încă. Verifică dacă sunt corecte (fără coloane decalate).
    </div>

    <div style="max-height: 400px; overflow-y: auto;">
        <table class="preview-table">
            <thead>
            <tr>
                <th>#</th>
                <th>Nume</th>
                <th>Prenume</th>
                <th>Telefon</th>
                <th>Email</th>
                <th>Username</th>
                <th>Rol</th>
            </tr>
            </thead>
            <tbody>
            <% int idx = 1; for (Client c : listaPreview) { %>
            <tr>
                <td><%= idx++ %></td>
                <td><%= c.getNume() %></td>
                <td><%= c.getPrenume() %></td>
                <td><%= c.getTelefon() %></td>
                <td><%= c.getEmail() %></td>
                <td><%= c.getUsername() %></td>
                <td><%= c.getTipUtilizator() %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <br>

    <div style="display: flex; gap: 10px; justify-content: center;">
        <form action="admin-import-clienti" method="post">
            <input type="hidden" name="step" value="save">
            <button type="submit" class="btn btn-success" style="font-size: 18px;">✅ Confirmă Importul</button>
        </form>

        <form action="admin-import-clienti" method="post">
            <input type="hidden" name="step" value="cancel">
            <button type="submit" class="btn btn-danger">❌ Anulează / Încarcă altul</button>
        </form>
    </div>
    <% } %>
</div>
</body>
</html>