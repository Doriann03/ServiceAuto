<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Autentificare - Service Auto</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<h2>Autentificare</h2>

<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
<p style="color:red"><%= error %></p>
<% } %>

<form action="login" method="post">
    <label>Username:<br>
        <input type="text" name="username" required>
    </label><br><br>

    <label>Parolă:<br>
        <input type="password" name="password" required>
    </label><br><br>

    <button type="submit">Autentificare</button>
</form>

<p style="margin-top: 20px;">
    Nu ai cont? <a href="register.jsp">Înregistrează-te aici</a>
</p>
</body>
</html>