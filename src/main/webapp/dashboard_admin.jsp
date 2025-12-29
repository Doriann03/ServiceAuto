<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>
<%
    // Securitate
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp"); return;
    }

    // Preluam datele din Servlet (daca sunt null, punem 0)
    Integer nrClienti = (Integer) request.getAttribute("nrClienti");
    Integer nrVehicule = (Integer) request.getAttribute("nrVehicule");
    Integer nrProgramari = (Integer) request.getAttribute("nrProgramari");
    Integer nrLucrari = (Integer) request.getAttribute("nrLucrari");

    // Date pentru Grafice (String-uri gata formatate pt JS)
    String chartStatusData = (String) request.getAttribute("chartStatusData");
    String chartZileLabels = (String) request.getAttribute("chartZileLabels");
    String chartZileData = (String) request.getAttribute("chartZileData");

    // Fallback daca intram direct pe JSP fara Servlet (evitam erori)
    if(chartStatusData == null) chartStatusData = "0,0,0";
%>
<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Panou Admin - Service Auto</title>
    <jsp:include page="includes/head.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<div class="d-flex">
    <jsp:include page="includes/sidebar_admin.jsp" />

    <div class="flex-grow-1 bg-light">
        <nav class="navbar navbar-light bg-white shadow-sm px-4 justify-content-between">
            <span class="navbar-brand mb-0 h1">Bine ai venit, <%= user.getNume() %>! 👋</span>
            <span class="text-muted small"><i class="fa-regular fa-calendar me-1"></i> Azi: <%= java.time.LocalDate.now() %></span>
        </nav>

        <div class="main-content container-fluid">

            <div class="row g-4 mb-5">
                <div class="col-md-3">
                    <div class="card card-dashboard bg-primary text-white h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-uppercase mb-1 opacity-75">Clienți Totali</h6>
                                    <h2 class="mb-0 fw-bold"><%= nrClienti != null ? nrClienti : 0 %></h2>
                                </div>
                                <i class="fa-solid fa-users fa-3x opacity-25"></i>
                            </div>
                        </div>
                        <a href="admin-clienti" class="card-footer text-white text-decoration-none small bg-primary border-0" style="filter: brightness(0.9);">Vezi detalii ➡</a>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card card-dashboard bg-success text-white h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-uppercase mb-1 opacity-75">Vehicule</h6>
                                    <h2 class="mb-0 fw-bold"><%= nrVehicule != null ? nrVehicule : 0 %></h2>
                                </div>
                                <i class="fa-solid fa-car fa-3x opacity-25"></i>
                            </div>
                        </div>
                        <a href="admin-vehicule" class="card-footer text-white text-decoration-none small bg-success border-0" style="filter: brightness(0.9);">Vezi flota ➡</a>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card card-dashboard bg-warning text-dark h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-uppercase mb-1 opacity-75">Programări</h6>
                                    <h2 class="mb-0 fw-bold"><%= nrProgramari != null ? nrProgramari : 0 %></h2>
                                </div>
                                <i class="fa-regular fa-calendar-check fa-3x opacity-25"></i>
                            </div>
                        </div>
                        <a href="admin-programari" class="card-footer text-dark text-decoration-none small bg-warning border-0" style="filter: brightness(0.9);">Calendar ➡</a>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card card-dashboard bg-danger text-white h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-uppercase mb-1 opacity-75">Lucrări (Devize)</h6>
                                    <h2 class="mb-0 fw-bold"><%= nrLucrari != null ? nrLucrari : 0 %></h2>
                                </div>
                                <i class="fa-solid fa-screwdriver-wrench fa-3x opacity-25"></i>
                            </div>
                        </div>
                        <a href="admin-lucrari" class="card-footer text-white text-decoration-none small bg-danger border-0" style="filter: brightness(0.9);">Vezi lucrări ➡</a>
                    </div>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-md-8">
                    <div class="card card-dashboard border-0 shadow-sm h-100">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0 fw-bold text-dark"><i class="fa-solid fa-chart-line me-2 text-primary"></i>Activitate Programări (7 zile)</h5>
                        </div>
                        <div class="card-body">
                            <canvas id="lineChart" style="max-height: 300px;"></canvas>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card card-dashboard border-0 shadow-sm h-100">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0 fw-bold text-dark"><i class="fa-solid fa-chart-pie me-2 text-warning"></i>Distribuție Status</h5>
                        </div>
                        <div class="card-body d-flex justify-content-center">
                            <div style="width: 250px; height: 250px;">
                                <canvas id="pieChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <div class="card card-dashboard border-0 shadow-sm">
                        <div class="card-body d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="fw-bold mb-1">Audit Sistem</h5>
                                <p class="text-muted mb-0 small">Verifică ultimele acțiuni efectuate de administratori și clienți.</p>
                            </div>
                            <div>
                                <a href="admin-istoric" class="btn btn-outline-info me-2"><i class="fa-solid fa-user-shield me-1"></i> Log Admin</a>
                                <a href="admin-istoric-client" class="btn btn-outline-primary"><i class="fa-solid fa-users me-1"></i> Log Clienți</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // 1. Configurarea Graficului Liniar (Programari pe Zile)
    const ctxLine = document.getElementById('lineChart').getContext('2d');
    new Chart(ctxLine, {
        type: 'line',
        data: {
            labels: [<%= chartZileLabels != null ? chartZileLabels : "'Azi'" %>], // Zilele din Java
            datasets: [{
                label: 'Programări Noi',
                data: [<%= chartZileData != null ? chartZileData : "0" %>], // Numerele din Java
                borderColor: '#0d6efd', // Albastru Bootstrap
                backgroundColor: 'rgba(13, 110, 253, 0.1)',
                borderWidth: 2,
                tension: 0.4, // Linia putin curbata
                fill: true,
                pointRadius: 4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } }
        }
    });

    // 2. Configurarea Graficului Placinta (Statusuri)
    const ctxPie = document.getElementById('pieChart').getContext('2d');
    new Chart(ctxPie, {
        type: 'doughnut',
        data: {
            labels: ['Programat', 'În lucru', 'Finalizat'],
            datasets: [{
                data: [<%= chartStatusData %>], // Datele din Java: ex "5, 2, 10"
                backgroundColor: [
                    '#0d6efd', // Programat - Albastru
                    '#ffc107', // In lucru - Galben
                    '#198754'  // Finalizat - Verde
                ],
                hoverOffset: 4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { position: 'bottom' }
            }
        }
    });
</script>

</body>
</html>