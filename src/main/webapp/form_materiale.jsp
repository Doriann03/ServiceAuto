<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.MaterialePiese" %>
<%@ page import="ro.serviceauto.serviceauto.model.Serviciu" %>
<%@ page import="java.util.List" %>
<%
    MaterialePiese m = (MaterialePiese) request.getAttribute("materialDeEditat");
    boolean isEdit = (m != null);
    List<Serviciu> servicii = (List<Serviciu>) request.getAttribute("listaServicii");
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= isEdit ? "Editare" : "Adăugare" %> Material</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="welcome-section" style="max-width: 500px;">
    <h2><%= isEdit ? "Modifică Piesa" : "Adaugă Piesa Nouă" %></h2>
    <form action="admin-materiale-actions" method="post">
        <% if(isEdit) { %> <input type="hidden" name="id" value="<%= m.getIdMat() %>"> <% } %>

        <label>Denumire:</label>
        <input type="text" name="denumire" value="<%= isEdit ? m.getDenumire() : "" %>" required>

        <div style="display:grid; grid-template-columns: 1fr 1fr; gap:10px;">
            <div>
                <label>Cantitate (Stoc):</label>
                <input type="number" name="cantitate" value="<%= isEdit ? m.getCantitate() : "0" %>" required>
            </div>
            <div>
                <label>Preț Unitar (RON):</label>
                <input type="number" step="0.01" name="pretUnitar" value="<%= isEdit ? m.getPretUnitar() : "0.00" %>" required>
            </div>
        </div>

        <label>Asociat cu Serviciul:</label>
        <select name="ids" required style="width:100%; padding:10px; margin-bottom:15px;">
            <% if(servicii != null) { for(Serviciu s : servicii) { %>
            <option value="<%= s.getIds() %>" <%= (isEdit && m.getIds() == s.getIds()) ? "selected" : "" %>>
                <%= s.getNume() %>
            </option>
            <% }} %>
        </select>

        <button type="submit" class="btn btn-success">💾 Salvează</button>
        <a href="admin-materiale" class="btn btn-danger">Anulează</a>
    </form>
</div>
</body>
</html>