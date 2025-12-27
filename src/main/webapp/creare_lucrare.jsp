<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.Angajat" %>

<!DOCTYPE html>
<html>
<head>
    <title>Deschide Lucrare</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="welcome-section">
    <h2>Deschide Comandă de Lucru</h2>
    <p>Pentru programarea ID: <%= request.getAttribute("idProgramare") %></p>

    <form action="admin-creare-lucrare" method="post">
        <input type="hidden" name="idProgramare" value="<%= request.getAttribute("idProgramare") %>">

        <label>Asignează Mecanic:</label>
        <select name="idAngajat" required style="width:100%; padding:10px; margin-bottom:15px;">
            <option value="">-- Alege Mecanic --</option>
            <%
                List<Angajat> mecanici = (List<Angajat>) request.getAttribute("listaMecanici");
                if(mecanici != null) {
                    for(Angajat a : mecanici) {
            %>
            <option value="<%= a.getIdAngajat() %>">
                <%= a.getNume() %> <%= a.getPrenume() %> (<%= a.getFunctie() %>)
            </option>
            <% }} %>
        </select>

        <label>Observații Inițiale / Descriere:</label>
        <textarea name="descriere" rows="4" style="width:100%;" placeholder="Ex: Clientul a reclamat zgomote la motor..."></textarea>
        <br><br>

        <button type="submit" class="btn">🚀 Pornește Lucrarea</button>
        <a href="admin-programari" class="btn btn-danger">Anulează</a>
    </form>
</div>
</body>
</html>