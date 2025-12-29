<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.Vehicul" %>
<%@ page import="ro.serviceauto.serviceauto.model.Serviciu" %>
<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Programare Vehicul</title>
    <jsp:include page="includes/head.jsp" />
    <script>
        // JavaScript-ul RAMANE NESCHIMBAT pentru logica
        function toggleVehicleForm() {
            var option = document.querySelector('input[name="vehicleOption"]:checked').value;
            var existingDiv = document.getElementById("existing-vehicle-div");
            var newDiv = document.getElementById("new-vehicle-div");
            var selectBox = document.getElementsByName("vehiculID")[0];
            var inputs = newDiv.querySelectorAll("input");

            if (option === "existing") {
                existingDiv.style.display = "block";
                newDiv.style.display = "none";
                selectBox.required = true;
                inputs.forEach(input => input.required = false);
            } else {
                existingDiv.style.display = "none";
                newDiv.style.display = "block";
                selectBox.required = false;
                inputs.forEach(input => input.required = true);
            }
        }

        function checkAvailability() {
            var serviceId = document.getElementsByName("serviciuID")[0].value;
            var dateVal = document.getElementById("datePicker").value;
            var container = document.getElementById("availability-container");

            if (serviceId && dateVal) {
                // Afisam un loader mic
                container.innerHTML = '<div class="spinner-border text-primary spinner-border-sm" role="status"></div> Verific disponibilitatea...';

                fetch("check-availability?ids=" + serviceId + "&data=" + dateVal)
                    .then(response => response.text())
                    .then(html => { container.innerHTML = html; })
                    .catch(error => {
                        console.error('Error:', error);
                        container.innerHTML = '<span class="text-danger">Eroare la încărcare.</span>';
                    });
            } else {
                container.innerHTML = "<p class='text-muted small'>Selectați serviciul și data.</p>";
            }
        }
    </script>
</head>
<body class="bg-light">

<jsp:include page="includes/navbar_client.jsp" />

<div class="container pb-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card border-0 shadow-lg">
                <div class="card-header bg-primary text-white py-3">
                    <h4 class="mb-0 fw-bold"><i class="fa-regular fa-calendar-check me-2"></i> Programare Service</h4>
                </div>
                <div class="card-body p-4">

                    <form action="programare" method="post">

                        <div class="card mb-4 border-light shadow-sm bg-light">
                            <div class="card-body">
                                <h5 class="fw-bold text-primary mb-3"><i class="fa-solid fa-car me-2"></i>Pas 1: Alege Vehiculul</h5>

                                <div class="btn-group w-100 mb-3" role="group">
                                    <input type="radio" class="btn-check" name="vehicleOption" id="optExisting" value="existing" checked onchange="toggleVehicleForm()">
                                    <label class="btn btn-outline-primary" for="optExisting">Din Istoric</label>

                                    <input type="radio" class="btn-check" name="vehicleOption" id="optNew" value="new" onchange="toggleVehicleForm()">
                                    <label class="btn btn-outline-primary" for="optNew">Înscrie Vehicul Nou</label>
                                </div>

                                <div id="existing-vehicle-div">
                                    <label class="form-label fw-bold">Selectează mașina:</label>
                                    <select name="vehiculID" class="form-select" required>
                                        <option value="">-- Alege mașina ta --</option>
                                        <%
                                            List<Vehicul> vehicule = (List<Vehicul>) request.getAttribute("listaVehicule");
                                            if (vehicule != null && !vehicule.isEmpty()) {
                                                for (Vehicul v : vehicule) {
                                        %>
                                        <option value="<%= v.getIdv() %>">
                                            <%= v.getMarca() %> <%= v.getModel() %> (<%= v.getNrInmatriculare() %>)
                                        </option>
                                        <%      }
                                        } else { %>
                                        <option value="" disabled>Nu ai vehicule. Selectează "Înscrie Vehicul Nou".</option>
                                        <% } %>
                                    </select>
                                </div>

                                <div id="new-vehicle-div" style="display: none;">
                                    <div class="row g-2">
                                        <div class="col-md-6"><input type="text" name="marca" placeholder="Marca (ex: Audi)" class="form-control"></div>
                                        <div class="col-md-6"><input type="text" name="model" placeholder="Model (ex: A4)" class="form-control"></div>
                                        <div class="col-md-6"><input type="text" name="nrInmatriculare" placeholder="Nr. Înmatriculare" class="form-control text-uppercase"></div>
                                        <div class="col-md-6"><input type="text" name="serieSasiu" placeholder="Serie Șasiu" class="form-control text-uppercase"></div>
                                        <div class="col-md-6"><input type="text" name="tip" placeholder="Tip (ex: Sedan)" class="form-control"></div>
                                        <div class="col-md-6"><input type="text" name="motor" placeholder="Motor (ex: 2.0 TDI)" class="form-control"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card mb-4 border-light shadow-sm bg-light">
                            <div class="card-body">
                                <h5 class="fw-bold text-primary mb-3"><i class="fa-solid fa-tools me-2"></i>Pas 2: Serviciul Dorit</h5>
                                <label class="form-label fw-bold">Tip operațiune:</label>
                                <select name="serviciuID" class="form-select" required onchange="checkAvailability()">
                                    <option value="">-- Selectează serviciul --</option>
                                    <%
                                        List<Serviciu> servicii = (List<Serviciu>) request.getAttribute("listaServicii");
                                        if (servicii != null) {
                                            for (Serviciu s : servicii) {
                                    %>
                                    <option value="<%= s.getIds() %>">
                                        <%= s.getNume() %> (aprox. <%= s.getDurataEstimata() %> min)
                                    </option>
                                    <%      } } %>
                                </select>
                            </div>
                        </div>

                        <div class="card mb-4 border-light shadow-sm bg-light">
                            <div class="card-body">
                                <h5 class="fw-bold text-primary mb-3"><i class="fa-solid fa-clock me-2"></i>Pas 3: Data și Ora</h5>
                                <div class="row">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Alege data:</label>
                                        <input type="date" id="datePicker" name="dataProgCal" class="form-control" required onchange="checkAvailability()">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Intervale Orare Disponibile:</label>
                                        <div id="availability-container" class="border rounded p-3 bg-white" style="min-height: 50px;">
                                            <p class="text-muted small mb-0">Selectați serviciul și data pentru a încărca orele.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-success btn-lg fw-bold shadow-sm">
                                ✅ Finalizează Programarea
                            </button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>