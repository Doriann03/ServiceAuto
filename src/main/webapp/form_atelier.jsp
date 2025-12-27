<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Atelier" %>
<%
    Atelier at = (Atelier) request.getAttribute("atelierDeEditat");
    boolean isEdit = (at != null);
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= isEdit ? "Editare" : "Adăugare" %> Atelier</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="welcome-section" style="max-width: 500px;">
    <h2><%= isEdit ? "Modifică Atelier" : "Adaugă Atelier Nou" %></h2>

    <form action="admin-atelier-actions" method="post">
        <% if(isEdit) { %> <input type="hidden" name="id" value="<%= at.getIda() %>"> <% } %>

        <label>Denumire Atelier:</label>
        <input type="text" name="nume" value="<%= isEdit ? at.getNume() : "" %>" required placeholder="ex: Mecanică Ușoară">

        <label>Adresă / Locație:</label>
        <input type="text" name="adresa" value="<%= isEdit ? at.getAdresa() : "" %>" required placeholder="ex: Hala B, Stand 3">

        <br><br>
        <button type="submit" class="btn btn-success">💾 Salvează</button>
        <a href="admin-ateliere" class="btn btn-danger">Anulează</a>
    </form>
</div>
</body>
</html>