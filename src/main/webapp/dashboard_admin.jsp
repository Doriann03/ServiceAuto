<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>

<%
    // 1. Luam userul de pe sesiune
    Client user = (Client) session.getAttribute("user");

    // 2. VERIFICARE CORECTA: Daca nu e logat SAU nu e "Admin", afara!
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Admin</title> <link rel="stylesheet" href="css/style.css">
    <style>
        .admin-buttons {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            max-width: 600px;
            margin: 30px auto;
        }
        .admin-btn {
            padding: 20px;
            background-color: #343a40; /* Culoare inchisa pt admin */
            color: white;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            font-size: 18px;
        }
        .admin-btn:hover { background-color: #23272b; }
        .btn-danger { background-color: #dc3545; }
    </style>
</head>
<body>
<div class="welcome-section">
    <h1>Panou Administrare</h1>
    <p>Salut, <%= user.getNume() %>! Ești autentificat ca: <strong>Administrator</strong></p>

    <div class="admin-buttons">
        <a href="admin-programari" class="admin-btn">
            📅 Gestionează Programări
        </a>

        <a href="admin-lucrari" class="admin-btn" style="background-color: #17a2b8;">
            🔧 Lucrări Active
        </a>

        <a href="admin-clienti" class="admin-btn">
            👥 Gestionează Clienți
        </a>

        <a href="admin-vehicule" class="admin-btn" style="background-color: #20c997;">
            🚗 Gestionează Vehicule
        </a>

        <a href="admin-angajati" class="admin-btn">
            👥 Gestionează Angajați
        </a>

        <a href="admin-servicii" class="admin-btn" style="background-color: #fd7e14;">
            🛠️ Gestionează Servicii
        </a>

        <a href="admin-ateliere" class="admin-btn" style="background-color: #e83e8c;">
            🏢 Gestionează Ateliere
        </a>

        <a href="admin-materiale" class="admin-btn" style="background-color: #343a40;">
            ⚙️ Gestionează Stocuri
        </a>

        <a href="admin-istoric" class="admin-btn" style="background-color: #17a2b8;">📋 Istoric Admin</a>

        <a href="admin-istoric-client" class="admin-btn" style="background-color: #007bff;">
            👥 Istoric Clienți
        </a>

        <a href="logout" class="admin-btn btn-danger">
            🚪 Deconectare
        </a>


    </div>
</div>
</body>
</html>