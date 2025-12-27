<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Vehicul" %>
<%
    Vehicul v = (Vehicul) request.getAttribute("vehiculDeEditat");
    boolean isEdit = (v != null);
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= isEdit ? "Editare" : "Adăugare" %> Vehicul</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="welcome-section" style="max-width: 600px;">
    <h2><%= isEdit ? "Modifică Vehicul" : "Adaugă Vehicul Nou" %></h2>

    <form action="admin-vehicul-actions" method="post">
        <% if(isEdit) { %> <input type="hidden" name="id" value="<%= v.getIdv() %>"> <% } %>

        <div style="display:grid; grid-template-columns: 1fr 1fr; gap:10px;">
            <div>
                <label>Marcă:</label>
                <input type="text" name="marca" value="<%= isEdit ? v.getMarca() : "" %>" required>
            </div>
            <div>
                <label>Model:</label>
                <input type="text" name="model" value="<%= isEdit ? v.getModel() : "" %>" required>
            </div>
        </div>

        <label>Nr. Înmatriculare:</label>
        <input type="text" name="nrInmatriculare" value="<%= isEdit ? v.getNrInmatriculare() : "" %>" required>

        <label>Serie Șasiu (VIN):</label>
        <input type="text" name="serieSasiu" value="<%= isEdit ? v.getSerieSasiu() : "" %>" required>

        <div style="display:grid; grid-template-columns: 1fr 1fr; gap:10px;">
            <div>
                <label>Tip (ex: Sedan):</label>
                <input type="text" name="tip" value="<%= isEdit ? v.getTip() : "" %>">
            </div>
            <div>
                <label>Motor (ex: 2.0 TDI):</label>
                <input type="text" name="motor" value="<%= isEdit ? v.getMotor() : "" %>">
            </div>
        </div>

        <br>
        <button type="submit" class="btn btn-success">💾 Salvează</button>
        <a href="admin-vehicule" class="btn btn-danger">Anulează</a>
    </form>
</div>
</body>
</html>