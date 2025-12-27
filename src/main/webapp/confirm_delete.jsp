<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Vehicul" %>
<%
    Vehicul v = (Vehicul) request.getAttribute("vehiculDeSters");
    if (v == null) { response.sendRedirect("admin-vehicule"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Confirmare Ștergere</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .warning-box {
            max-width: 600px;
            margin: 100px auto;
            background: #fff3cd;
            border: 1px solid #ffeeba;
            color: #856404;
            padding: 30px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .btn-danger-confirm {
            background-color: #dc3545; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; font-weight: bold;
        }
        .btn-secondary {
            background-color: #6c757d; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;
        }
    </style>
</head>
<body>
<div class="warning-box">
    <h2 style="color:#721c24;">⚠️ Atenție!</h2>

    <p style="font-size: 18px;">
        Sunteți pe cale să ștergeți vehiculul: <br>
        <strong><%= v.getMarca() %> <%= v.getModel() %></strong> (<%= v.getNrInmatriculare() %>)
    </p>

    <hr style="border:0; border-top:1px solid #faeCCb; margin: 20px 0;">

    <p style="text-align: justify; margin-bottom: 30px;">
        Acest vehicul figurează în baza de date cu <strong>Istoric de Service</strong> (Programări și Lucrări).
        <br><br>
        Dacă continuați, sistemul va șterge <strong>AUTOMAT</strong>:
    <ul style="text-align: left;">
        <li>Vehiculul din sistem.</li>
        <li>Toate programările asociate acestui vehicul.</li>
        <li>Toate lucrările și devizele asociate programărilor.</li>
    </ul>
    <br>
    <strong>Această acțiune este ireversibilă!</strong>
    </p>

    <div style="display:flex; justify-content: center; gap: 20px;">
        <a href="admin-vehicul-actions?action=delete&id=<%= v.getIdv() %>&confirm=true" class="btn-danger-confirm">
            DA, Șterge tot (Cascadă)
        </a>

        <a href="admin-vehicule" class="btn-secondary">
            NU, Anulează
        </a>
    </div>
</div>
</body>
</html>