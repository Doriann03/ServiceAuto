<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="d-flex flex-column flex-shrink-0 p-3 text-white sidebar" style="width: 260px;">
    <a href="admin-dashboard" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
        <i class="fa-solid fa-car-side fa-2x me-2"></i>
        <span class="fs-4 fw-bold">Service Auto</span>
    </a>
    <hr>

    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <a href="admin-dashboard" class="nav-link text-white">
                <i class="fa-solid fa-gauge"></i> Panou Control
            </a>
        </li>
        <li>
            <a href="admin-programari" class="nav-link text-white">
                <i class="fa-regular fa-calendar-check"></i> Programări
            </a>
        </li>
        <li>
            <a href="admin-lucrari" class="nav-link text-white">
                <i class="fa-solid fa-screwdriver-wrench"></i> Lucrări Active
            </a>
        </li>

        <hr style="border-color: #555;"> <li>
        <a href="admin-clienti" class="nav-link text-white">
            <i class="fa-solid fa-users"></i> Clienți
        </a>
    </li>
        <li>
            <a href="admin-vehicule" class="nav-link text-white">
                <i class="fa-solid fa-car"></i> Vehicule
            </a>
        </li>
        <li>
            <a href="admin-ateliere" class="nav-link text-white">
                <i class="fa-solid fa-warehouse"></i> Ateliere
            </a>
        </li>
        <li>
            <a href="admin-angajati" class="nav-link text-white">
                <i class="fa-solid fa-user-tie"></i> Angajați
            </a>
        </li>
        <li>
            <a href="admin-servicii" class="nav-link text-white">
                <i class="fa-solid fa-list"></i> Servicii
            </a>
        </li>
        <li>
            <a href="admin-materiale" class="nav-link text-white">
                <i class="fa-solid fa-boxes-stacked"></i> Stoc Piese
            </a>
        </li>

        <hr style="border-color: #555;"> <li>
        <a href="admin-istoric" class="nav-link text-white" style="color: #17a2b8;">
            <i class="fa-solid fa-clipboard-list"></i> Istoric Admin
        </a>
    </li>
        <li>
            <a href="admin-istoric-client" class="nav-link text-white" style="color: #007bff;">
                <i class="fa-solid fa-clock-rotate-left"></i> Istoric Clienți
            </a>
        </li>
    </ul>
    <hr>

    <div class="dropdown">
        <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
            <div class="rounded-circle bg-primary d-flex justify-content-center align-items-center me-2" style="width: 32px; height: 32px;">
                <i class="fa-solid fa-user"></i>
            </div>
            <strong>Admin</strong>
        </a>
        <ul class="dropdown-menu dropdown-menu-dark text-small shadow" aria-labelledby="dropdownUser1">
            <li><a class="dropdown-item" href="logout">Deconectare</a></li>
        </ul>
    </div>
</div>