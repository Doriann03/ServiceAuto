<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>
<%
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Client".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp");
        return;
    }
    String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Dashboard Client</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body class="bg-light">

<jsp:include page="includes/navbar_client.jsp" />

<div class="container">

    <% if ("succes".equals(msg)) { %>
    <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
        <i class="fa-solid fa-check-circle fa-lg me-2"></i> <strong>Succes!</strong> Programarea ta a fost înregistrată.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <div class="bg-white p-5 rounded-3 shadow-sm mb-4 border-start border-5 border-primary">
        <h1 class="display-6 fw-bold text-dark">Salutare, <%= user.getPrenume() %>! 👋</h1>
        <p class="col-md-8 fs-5 text-muted">Bine ai venit în aplicația de gestionare a mașinii tale. Ce dorești să faci astăzi?</p>
    </div>

    <div class="row g-4">

        <div class="col-md-4">
            <div class="card h-100 border-0 shadow-sm hover-effect">
                <div class="card-body text-center p-4">
                    <div class="bg-primary text-white rounded-circle d-inline-flex p-3 mb-3">
                        <i class="fa-regular fa-calendar-plus fa-2x"></i>
                    </div>
                    <h4 class="card-title fw-bold">Programare Nouă</h4>
                    <p class="card-text text-muted">Alege un serviciu și o dată convenabilă pentru tine.</p>
                    <a href="programare" class="btn btn-outline-primary stretched-link fw-bold">Programează</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100 border-0 shadow-sm hover-effect">
                <div class="card-body text-center p-4">
                    <div class="bg-info text-white rounded-circle d-inline-flex p-3 mb-3">
                        <i class="fa-solid fa-clock-rotate-left fa-2x"></i>
                    </div>
                    <h4 class="card-title fw-bold">Istoric & Status</h4>
                    <p class="card-text text-muted">Vezi starea reparațiilor curente și istoricul complet.</p>
                    <a href="istoric" class="btn btn-outline-info stretched-link fw-bold">Vezi Istoric</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100 border-0 shadow-sm hover-effect">
                <div class="card-body text-center p-4">
                    <div class="bg-secondary text-white rounded-circle d-inline-flex p-3 mb-3">
                        <i class="fa-solid fa-list-check fa-2x"></i>
                    </div>
                    <h4 class="card-title fw-bold">Catalog Servicii</h4>
                    <p class="card-text text-muted">Consultă lista de prețuri și serviciile oferite de noi.</p>
                    <a href="servicii" class="btn btn-outline-secondary stretched-link fw-bold">Vezi Oferta</a>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
    .hover-effect { transition: transform 0.3s; }
    .hover-effect:hover { transform: translateY(-5px); }
</style>
</body>
</html>