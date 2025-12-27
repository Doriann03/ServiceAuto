<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.Vehicul" %>
<%@ page import="ro.serviceauto.serviceauto.model.Serviciu" %>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Programare Vehicul</title>
    <link rel="stylesheet" href="css/style.css">
    <script>
        // 1. Functie pentru comutare intre Vehicul Existent si Nou
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

        // 2. Functie AJAX pentru tabelul de disponibilitate
        function checkAvailability() {
            var serviceId = document.getElementsByName("serviciuID")[0].value;
            var dateVal = document.getElementById("datePicker").value;
            var container = document.getElementById("availability-container");

            if (serviceId && dateVal) {
                // Facem cererea catre Servletul Java
                fetch("check-availability?ids=" + serviceId + "&data=" + dateVal)
                    .then(response => response.text())
                    .then(html => {
                        container.innerHTML = html;
                    })
                    .catch(error => console.error('Error:', error));
            } else {
                container.innerHTML = "<p>Selectați un serviciu și o dată pentru a vedea orarul.</p>";
            }
        }
    </script>
</head>
<body>
<div class="welcome-section" style="max-width: 800px;">
    <h2>Programare Service</h2>

    <form action="programare" method="post">

        <div class="section-box" style="border: 1px solid #ccc; padding: 15px; margin-bottom: 20px; border-radius:5px;">
            <h3>1. Date Vehicul</h3>

            <label><input type="radio" name="vehicleOption" value="existing" checked onchange="toggleVehicleForm()"> Selectează din istoricul tău</label>
            <label style="margin-left: 20px;"><input type="radio" name="vehicleOption" value="new" onchange="toggleVehicleForm()"> Înscrie vehicul nou</label>
            <br><br>

            <div id="existing-vehicle-div">
                <select name="vehiculID" required style="width: 100%; padding: 8px;">
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
                    <option value="" disabled>Nu ai vehicule înregistrate. Selectează "Înscrie vehicul nou".</option>
                    <% } %>
                </select>
            </div>

            <div id="new-vehicle-div" style="display: none;">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                    <input type="text" name="marca" placeholder="Marca (ex: Audi)" class="input-field">
                    <input type="text" name="model" placeholder="Model (ex: A4)" class="input-field">
                    <input type="text" name="nrInmatriculare" placeholder="Nr. Înmatriculare" class="input-field">
                    <input type="text" name="serieSasiu" placeholder="Serie Șasiu" class="input-field">
                    <input type="text" name="tip" placeholder="Tip (ex: Sedan)" class="input-field">
                    <input type="text" name="motor" placeholder="Motor (ex: 2.0 TDI)" class="input-field">
                </div>
            </div>
        </div>

        <div class="section-box" style="border: 1px solid #ccc; padding: 15px; margin-bottom: 20px; border-radius:5px;">
            <h3>2. Serviciu Dorit</h3>
            <select name="serviciuID" required onchange="checkAvailability()" style="width: 100%; padding: 8px;">
                <option value="">-- Selectează serviciul --</option>
                <%
                    List<Serviciu> servicii = (List<Serviciu>) request.getAttribute("listaServicii");
                    if (servicii != null) {
                        for (Serviciu s : servicii) {
                %>
                <option value="<%= s.getIds() %>">
                    <%= s.getNume() %> (aprox. <%= s.getDurataEstimata() %> min)
                </option>
                <%      }
                }
                %>
            </select>
        </div>

        <div class="section-box" style="border: 1px solid #ccc; padding: 15px; margin-bottom: 20px; border-radius:5px;">
            <h3>3. Data și Ora</h3>
            <label>Alege data:</label>
            <input type="date" id="datePicker" required onchange="checkAvailability()" style="padding: 8px;">

            <br><br>
            <div id="availability-container">
                <p style="color: gray;">Selectează un serviciu și o dată pentru a vedea orele disponibile.</p>
            </div>
        </div>

        <button type="submit" class="btn" style="width: 100%; font-size: 18px;">Finalizează Programarea</button>
    </form>
</div>
</body>
</html>