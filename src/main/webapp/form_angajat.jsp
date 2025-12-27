<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Angajat" %>
<%@ page import="ro.serviceauto.serviceauto.model.Atelier" %>
<%@ page import="java.util.List" %>
<%
    Angajat ang = (Angajat) request.getAttribute("angajatDeEditat");
    boolean isEdit = (ang != null);
    List<Atelier> ateliere = (List<Atelier>) request.getAttribute("listaAteliere");
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= isEdit ? "Editare" : "Adăugare" %> Angajat</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="welcome-section" style="max-width: 500px;">
    <h2><%= isEdit ? "Modifică Angajat" : "Adaugă Angajat Nou" %></h2>

    <form action="admin-angajat-actions" method="post">
        <% if(isEdit) { %> <input type="hidden" name="id" value="<%= ang.getIdAngajat() %>"> <% } %>

        <label>Nume:</label>
        <input type="text" name="nume" value="<%= isEdit ? ang.getNume() : "" %>" required>

        <label>Prenume:</label>
        <input type="text" name="prenume" value="<%= isEdit ? ang.getPrenume() : "" %>" required>

        <label>Funcție (ex: Mecanic, Electrician):</label>
        <input type="text" name="functie" value="<%= isEdit ? ang.getFunctie() : "" %>" required>

        <label>Atelier:</label>
        <select name="ida" required style="width:100%; padding:10px; margin-bottom:15px;">
            <%
                if(ateliere != null) {
                    for(Atelier at : ateliere) {
                        boolean selected = isEdit && (ang.getIda() == at.getIda());
            %>
            <option value="<%= at.getIda() %>" <%= selected ? "selected" : "" %>>
                <%= at.getNume() %>
            </option>
            <% }} %>
        </select>

        <button type="submit" class="btn btn-success">💾 Salvează</button>
        <a href="admin-angajati" class="btn btn-danger">Anulează</a>
    </form>
</div>
</body>
</html>