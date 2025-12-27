<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>

<%
    // 1. Verificare Securitate: Daca nu e logat, il trimitem la login
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Client".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 2. Preluam mesajele de succes (de la programare) daca exista
    String msg = request.getParameter("msg");
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Client</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Un pic de stilizare extra pentru butoane sa arate bine */
        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr 1fr; /* Doua coloane */
            gap: 20px;
            max-width: 600px;
            margin: 30px auto;
        }
        .dashboard-btn {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 18px;
            transition: background 0.3s;
            text-align: center;
        }
        .dashboard-btn:hover {
            background-color: #0056b3;
        }
        .dashboard-btn span {
            font-size: 30px;
            margin-bottom: 10px;
            display: block;
        }
        .btn-logout {
            background-color: #dc3545;
        }
        .btn-logout:hover {
            background-color: #a71d2a;
        }
    </style>
</head>
<body>
<div class="welcome-section">
    <h1>Salut, <%= user.getNume() %> <%= user.getPrenume() %>!</h1>
    <p>Bine ai venit în contul tău.</p>

    <% if ("succes".equals(msg)) { %>
    <div style="background-color: #d4edda; color: #155724; padding: 15px; margin-bottom: 20px; border-radius: 5px; border: 1px solid #c3e6cb;">
        ✅ Programarea a fost înregistrată cu succes!
    </div>
    <% } %>

    <div class="dashboard-grid">

        <a href="servicii" class="dashboard-btn">
            <span>📋</span> Servicii Disponibile
        </a>

        <a href="programare" class="dashboard-btn">
            <span>📅</span> Programează Vehicul
        </a>

        <a href="istoric" class="dashboard-btn" style="background-color: #17a2b8;">
            <span>🕒</span> Istoric Lucrări
        </a>

        <a href="logout" class="dashboard-btn btn-logout">
            <span>🚪</span> Deconectare
        </a>

    </div>
</div>
</body>
</html>