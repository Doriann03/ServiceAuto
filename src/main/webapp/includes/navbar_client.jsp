<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>
<%
    // Recuperam userul pentru a afisa numele in meniu
    Client userNav = (Client) session.getAttribute("user");
    String numeUser = (userNav != null) ? userNav.getPrenume() : "Client";
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="dashboard_client.jsp">
            <i class="fa-solid fa-car-side me-2"></i> Service Auto
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="dashboard_client.jsp"><i class="fa-solid fa-house me-1"></i> Acasă</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="servicii"><i class="fa-solid fa-list me-1"></i> Servicii</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="programare"><i class="fa-regular fa-calendar-plus me-1"></i> Programare Nouă</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="istoric"><i class="fa-solid fa-clock-rotate-left me-1"></i> Istoric</a>
                </li>
            </ul>
            <div class="d-flex align-items-center">
                <span class="text-white me-3 d-none d-lg-block">Salut, <strong><%= numeUser %></strong>!</span>
                <a href="logout" class="btn btn-outline-light btn-sm fw-bold">
                    <i class="fa-solid fa-right-from-bracket me-1"></i> Ieșire
                </a>
            </div>
        </div>
    </div>
</nav>