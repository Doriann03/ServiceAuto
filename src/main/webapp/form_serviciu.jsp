<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Serviciu" %>
<%@ page import="ro.serviceauto.serviceauto.model.Atelier" %>
<%@ page import="java.util.List" %>
<%
    Serviciu s = (Serviciu) request.getAttribute("serviciuDeEditat");
    boolean isEdit = (s != null);
    List<Atelier> ateliere = (List<Atelier>) request.getAttribute("listaAteliere");
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= isEdit ? "Editare" : "Adăugare" %> Serviciu</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="welcome-section" style="max-width: 500px;">
    <h2><%= isEdit ? "Modifică Serviciu" : "Adaugă Serviciu" %></h2>
    <form action="admin-serviciu-actions" method="post">
        <% if(isEdit) { %> <input type="hidden" name="id" value="<%= s.getIds() %>"> <% } %>

        <label>Denumire:</label>
        <input type="text" name="nume" value="<%= isEdit ? s.getNume() : "" %>" required>

        <label>Descriere:</label>
        <input type="text" name="descriere" value="<%= isEdit ? s.getDescriere() : "" %>">

        <label>Durată (minute):</label>
        <input type="number" name="durata" value="<%= isEdit ? s.getDurataEstimata() : "60" %>" required>

        <label>Atelier:</label>
        <select name="ida" required style="width:100%; padding:10px; margin-bottom:15px;">
            <% if(ateliere != null) { for(Atelier a : ateliere) { %>
            <option value="<%= a.getIda() %>" <%= (isEdit && s.getIda() == a.getIda()) ? "selected" : "" %>>
                <%= a.getNume() %>
            </option>
            <% }} %>
        </select>

        <button type="submit" class="btn">Salvare</button>
        <a href="admin-servicii" class="btn" style="background:grey;">Anulare</a>
    </form>
</div>
</body>
</html>