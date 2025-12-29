<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Vehicul" %>
<%
    Vehicul v = (Vehicul) request.getAttribute("vehiculDeSters");
    // Daca cineva intra direct pe pagina fara date, il trimitem inapoi
    if (v == null) { response.sendRedirect("admin-vehicule"); return; }
%>
<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Confirmare Ștergere</title>
    <jsp:include page="includes/head.jsp" />
    <style>
        body { background-color: #eee; } /* Fundal gri pt a scoate in evidenta alerta */
    </style>
</head>
<body class="d-flex align-items-center min-vh-100 justify-content-center">

<div class="card border-danger shadow-lg" style="max-width: 600px; width: 100%;">
    <div class="card-header bg-danger text-white py-3 text-center">
        <h3 class="mb-0 fw-bold"><i class="fa-solid fa-triangle-exclamation me-2"></i> ATENȚIE: Ștergere Critică</h3>
    </div>
    <div class="card-body p-5 text-center">

        <h5 class="text-muted mb-3">Sunteți pe cale să ștergeți vehiculul:</h5>
        <h2 class="fw-bold mb-1"><%= v.getMarca() %> <%= v.getModel() %></h2>
        <h4 class="badge bg-dark fs-5 text-uppercase mb-4" style="font-family: monospace;"><%= v.getNrInmatriculare() %></h4>

        <div class="alert alert-warning text-start border border-warning">
            <i class="fa-solid fa-circle-info me-2 text-warning"></i>
            <strong>Conflict de date:</strong> Acest vehicul are istoric activ în service (Programări, Lucrări, Devize).
            Baza de date a blocat ștergerea standard pentru protecție.
        </div>

        <p class="text-danger fw-bold">
            Dacă confirmați, sistemul va executa o <span class="text-decoration-underline">Ștergere în Cascadă</span>:
        </p>

        <ul class="list-group list-group-flush text-start mb-4 small">
            <li class="list-group-item"><i class="fa-solid fa-trash-can text-danger me-2"></i> Se șterge vehiculul.</li>
            <li class="list-group-item"><i class="fa-solid fa-trash-can text-danger me-2"></i> Se șterg toate programările asociate.</li>
            <li class="list-group-item"><i class="fa-solid fa-trash-can text-danger me-2"></i> Se șterg toate lucrările și datele financiare legate de el.</li>
        </ul>

        <div class="d-grid gap-3">
            <a href="admin-vehicul-actions?action=delete&id=<%= v.getIdv() %>&confirm=true" class="btn btn-danger btn-lg fw-bold shadow">
                DA, Înțeleg riscurile și Șterg Tot
            </a>
            <a href="admin-vehicule" class="btn btn-secondary btn-lg">
                NU, Anulează operațiunea
            </a>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>