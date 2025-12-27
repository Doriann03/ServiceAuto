<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Înregistrare Cont</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* ... stilurile raman la fel ... */
        .register-container { width: 400px; margin: 50px auto; padding: 30px; background: white; border-radius: 8px; box-shadow: 0 0 15px rgba(0,0,0,0.1); font-family: Arial, sans-serif; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; color: #333; }
        .form-group input { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .alert-error { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 15px; text-align: center; }
        .btn-register { width: 100%; padding: 10px; background: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
        .btn-register:hover { background: #218838; }
        .login-link { text-align: center; margin-top: 15px; font-size: 14px; }
    </style>
</head>
<body style="background-color: #f4f4f4;">

<div class="register-container">
    <h2 style="text-align:center; color:#333;">Creează Cont</h2>

    <% String err = (String) request.getAttribute("errorMessage");
        if (err != null) { %>
    <div class="alert-error"><%= err %></div>
    <% } %>

    <form action="register" method="post">
        <div class="form-group">
            <label>Nume:</label>
            <input type="text" name="nume" value="<%= request.getAttribute("oldNume") != null ? request.getAttribute("oldNume") : "" %>" required>
        </div>

        <div class="form-group">
            <label>Prenume:</label>
            <input type="text" name="prenume" value="<%= request.getAttribute("oldPrenume") != null ? request.getAttribute("oldPrenume") : "" %>" required>
        </div>

        <div class="form-group">
            <label>Username:</label>
            <input type="text" name="username" value="<%= request.getAttribute("oldUser") != null ? request.getAttribute("oldUser") : "" %>" required placeholder="Alege un nume de utilizator">
        </div>

        <div class="form-group">
            <label>Telefon:</label>
            <input type="text" name="telefon" value="<%= request.getAttribute("oldTel") != null ? request.getAttribute("oldTel") : "" %>" required>
        </div>

        <div class="form-group">
            <label>Email:</label>
            <input type="email" name="email" value="<%= request.getAttribute("oldEmail") != null ? request.getAttribute("oldEmail") : "" %>" required>
        </div>

        <div class="form-group">
            <label>Parolă:</label>
            <input type="password" name="password" required>
        </div>

        <div class="form-group">
            <label>Confirmă Parola:</label>
            <input type="password" name="password_confirm" required>
        </div>

        <button type="submit" class="btn-register">Înregistrează-te</button>
    </form>

    <div class="login-link">
        Ai deja cont? <a href="login.jsp" style="color:#007bff; text-decoration:none;">Autentifică-te aici</a>
    </div>
</div>
</body>
</html>