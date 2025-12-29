<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.Angajat" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>

<%
    // Securitate
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Preluam ID-ul programarii pentru afisare
    String idProg = (String) request.getAttribute("idProgramare");
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Deschide Lucrare</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body>
<div class="d-flex">

    <jsp:include page="includes/sidebar_admin.jsp" />

    <div class="main-content flex-grow-1 bg-light">
        <div class="container p-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="dashboard_admin.jsp">Home</a></li>
                        <li class="breadcrumb-item"><a href="admin-programari">Programări</a></li>
                        <li class="breadcrumb-item active">Deschide Lucrare</li>
                    </ol>
                </nav>
                <a href="admin-programari" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left me-1"></i> Înapoi
                </a>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-6">

                    <div class="card card-dashboard border-0 shadow-lg">
                        <div class="card-header bg-success text-white py-3">
                            <h4 class="mb-0 fw-bold">
                                <i class="fa-solid fa-screwdriver-wrench me-2"></i>
                                Deschide Comandă de Lucru
                            </h4>
                        </div>
                        <div class="card-body p-4">

                            <div class="alert alert-light border border-success d-flex align-items-center mb-4" role="alert">
                                <i class="fa-regular fa-calendar-check fa-2x text-success me-3"></i>
                                <div>
                                    <small class="text-muted text-uppercase fw-bold">Referință Programare</small>
                                    <div class="fs-5 fw-bold text-dark">ID #<%= idProg %></div>
                                </div>
                            </div>

                            <form action="admin-creare-lucrare" method="post">
                                <input type="hidden" name="idProgramare" value="<%= idProg %>">

                                <div class="mb-4">
                                    <label class="form-label fw-bold">Asignează Mecanic Responsabil</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white"><i class="fa-solid fa-user-gear text-primary"></i></span>
                                        <select name="idAngajat" class="form-select" required>
                                            <option value="" selected disabled>-- Selectează din listă --</option>
                                            <%
                                                List<Angajat> mecanici = (List<Angajat>) request.getAttribute("listaMecanici");
                                                if(mecanici != null) {
                                                    for(Angajat a : mecanici) {
                                            %>
                                            <option value="<%= a.getIdAngajat() %>">
                                                <%= a.getNume() %> <%= a.getPrenume() %> (<%= a.getFunctie() %>)
                                            </option>
                                            <% }} %>
                                        </select>
                                    </div>
                                    <div class="form-text">Mecanicul va fi notificat de noua sarcină.</div>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label fw-bold">Observații Inițiale / Diagnostic</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white"><i class="fa-solid fa-clipboard-list text-secondary"></i></span>
                                        <textarea name="descriere" class="form-control" rows="4" placeholder="Ex: Clientul a reclamat zgomote la motor la turații mari..." required></textarea>
                                    </div>
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-success btn-lg shadow-sm fw-bold">
                                        <i class="fa-solid fa-play me-2"></i> PORNEȘTE LUCRAREA
                                    </button>
                                    <a href="admin-programari" class="btn btn-outline-danger mt-2">
                                        Renunță
                                    </a>
                                </div>

                            </form>
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>