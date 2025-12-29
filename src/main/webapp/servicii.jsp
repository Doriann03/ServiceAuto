<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.dto.ServiciuAfisare" %>
<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Servicii Disponibile</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body class="bg-light">

<jsp:include page="includes/navbar_client.jsp" />

<div class="container">
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3">
            <h4 class="mb-0 fw-bold text-dark"><i class="fa-solid fa-tags me-2 text-primary"></i> Servicii & Prețuri</h4>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                <tr>
                    <th class="ps-4">Denumire Serviciu</th>
                    <th>Descriere</th>
                    <th>Durată Estimată</th>
                    <th>Atelier / Locație</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<ServiciuAfisare> lista = (List<ServiciuAfisare>) request.getAttribute("listaServicii");
                    if (lista != null && !lista.isEmpty()) {
                        for (ServiciuAfisare s : lista) {
                %>
                <tr>
                    <td class="ps-4 fw-bold text-primary"><%= s.getNumeServiciu() %></td>
                    <td class="text-muted"><%= s.getDescriere() %></td>
                    <td><span class="badge bg-light text-dark border"><i class="fa-regular fa-clock me-1"></i> <%= s.getDurata() %> min</span></td>
                    <td>
                        <small class="d-block fw-bold"><%= s.getNumeAtelier() %></small>
                        <small class="text-muted"><i class="fa-solid fa-location-dot me-1"></i> <%= s.getAdresaAtelier() %></small>
                    </td>
                </tr>
                <%  } } else { %>
                <tr>
                    <td colspan="4" class="text-center p-5 text-muted">Momentan nu sunt servicii disponibile.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>