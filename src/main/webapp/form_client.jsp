<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>
<%
    Client clientEdit = (Client) request.getAttribute("clientDeEditat");
    boolean isEdit = (clientEdit != null);
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= isEdit ? "Editare Client" : "Adăugare Client Nou" %></title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="welcome-section" style="max-width: 600px;">
    <h2><%= isEdit ? "Modifică Client: " + clientEdit.getNume() : "Adaugă Client Nou" %></h2>

    <form action="admin-client-actions" method="post">
        <% if(isEdit) { %>
        <input type="hidden" name="id" value="<%= clientEdit.getIdc() %>">
        <% } %>

        <label>Nume:</label>
        <input type="text" name="nume" value="<%= isEdit ? clientEdit.getNume() : "" %>" required>

        <label>Prenume:</label>
        <input type="text" name="prenume" value="<%= isEdit ? clientEdit.getPrenume() : "" %>" required>

        <label>Telefon:</label>
        <input type="text" name="telefon" value="<%= isEdit ? clientEdit.getTelefon() : "" %>" required>

        <label>Email:</label>
        <input type="email" name="email" value="<%= isEdit ? clientEdit.getEmail() : "" %>" required>

        <label>Username:</label>
        <input type="text" name="username" value="<%= isEdit ? clientEdit.getUsername() : "" %>" required>

        <% if(!isEdit) { %>
        <label>Parola (Doar la creare):</label>
        <input type="password" name="password" required>
        <% } %>

        <label>Tip Utilizator:</label>
        <select name="tipUtilizator">
            <option value="Client" <%= (isEdit && "Client".equals(clientEdit.getTipUtilizator())) ? "selected" : "" %>>Client</option>
            <option value="Admin" <%= (isEdit && "Admin".equals(clientEdit.getTipUtilizator())) ? "selected" : "" %>>Admin</option>
        </select>
        <br><br>

        <button type="submit" class="btn btn-success"><%= isEdit ? "💾 Salvează Modificările" : "➕ Adaugă Client" %></button>
        <a href="admin-clienti" class="btn btn-danger">Anulează</a>
    </form>
</div>
</body>
</html>