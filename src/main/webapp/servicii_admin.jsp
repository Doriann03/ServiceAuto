<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.Serviciu" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>

<%
    // 1. SECURITATE: Verificam daca utilizatorul este Admin
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 2. LOGICA DE SORTARE (Helper)
    // Preluam parametrii curenti de sortare trimisi de Servlet
    String currentSort = (String) request.getAttribute("currentSort");
    String currentDir = (String) request.getAttribute("currentDir"); // "ASC" sau "DESC"

    // Definim o functie mica (lambda) care genereaza link-urile din capul de tabel
    // Aceasta calculeaza automat daca urmatorul click trebuie sa fie ASC sau DESC
    java.util.function.BiFunction<String, String, String> getSortLink = (colName, label) -> {
        String newDir = "ASC"; // Default
        String arrow = "";     // Fara sageata initial

        // Daca deja sortam dupa coloana asta
        if (colName.equals(currentSort)) {
            if ("ASC".equals(currentDir)) {
                newDir = "DESC";
                arrow = " 🔼"; // Sageata sus (crescator)
            } else {
                newDir = "ASC";
                arrow = " 🔽"; // Sageata jos (descrescator)
            }
        }

        // Construim link-ul HTML
        return "<a href='admin-servicii?sort=" + colName + "&dir=" + newDir + "' style='color:white; text-decoration:none;'>"
                + label + arrow + "</a>";
    };
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Gestiune Servicii</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Stiluri specifice pentru bara de actiuni */
        .toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        .search-area form {
            display: flex;
            gap: 5px;
        }
        .actions-area {
            display: flex;
            gap: 10px;
        }
        /* Culori butoane */
        .btn-add { background-color: #28a745; }      /* Verde */
        .btn-pdf { background-color: #dc3545; }      /* Rosu */
        .btn-xls { background-color: #17a2b8; }      /* Albastru deschis */
        .btn-import { background-color: #6f42c1; }   /* Mov */

        /* Tabel */
        .table-admin th {
            background-color: #343a40;
            color: white;
            padding: 10px;
            text-align: left;
        }
        .table-admin td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        .table-admin tr:nth-child(even) { background-color: #f2f2f2; }
    </style>
</head>
<body>
<div class="admin-home" style="max-width: 1100px;">
    <h2>🛠️ Bază de date: Servicii</h2>
    <a href="dashboard_admin.jsp" class="btn">⬅ Înapoi la Dashboard</a>
    <br><br>

    <div class="toolbar">

        <div class="search-area">
            <form action="admin-servicii" method="get">
                <input type="text" name="search" placeholder="Caută serviciu..." style="padding: 8px; width: 250px;">
                <button type="submit" class="btn">🔍 Caută</button>
                <a href="admin-servicii" class="btn" style="background:#6c757d;">Reset</a>
            </form>
        </div>

        <div class="actions-area">
            <a href="admin-serviciu-actions?action=new" class="btn btn-add">➕ Adaugă</a>
            <a href="admin-export-servicii?type=pdf" class="btn btn-pdf" target="_blank">📄 PDF</a>
            <a href="admin-export-servicii?type=excel" class="btn btn-xls">📊 Excel</a>
            <a href="import_servicii.jsp" class="btn btn-import">📥 Import</a>
        </div>
    </div>

    <table class="table-admin" style="width:100%; border-collapse:collapse;">
        <thead>
        <tr>
            <th>ID</th>
            <th><%= getSortLink.apply("nume", "Denumire") %></th>
            <th><%= getSortLink.apply("descriere", "Descriere") %></th>
            <th><%= getSortLink.apply("durata", "Durată (min)") %></th>
            <th><%= getSortLink.apply("atelier", "Atelier") %></th>
            <th>Acțiuni</th>
        </tr>
        </thead>
        <tbody>
        <%
            // Preluam lista trimisa de Servlet
            List<Serviciu> list = (List<Serviciu>) request.getAttribute("listaServicii");

            if (list != null && !list.isEmpty()) {
                for (Serviciu s : list) {
        %>
        <tr>
            <td><%= s.getIds() %></td>
            <td><strong><%= s.getNume() %></strong></td>
            <td><%= s.getDescriere() %></td>
            <td><%= s.getDurataEstimata() %> min</td>
            <td><%= s.getNumeAtelier() != null ? s.getNumeAtelier() : "<span style='color:red;'>Neasignat</span>" %></td>
            <td>
                <a href="admin-serviciu-actions?action=edit&id=<%= s.getIds() %>" style="text-decoration:none; font-size:1.2em; margin-right:10px;" title="Editează">✏️</a>
                <a href="admin-serviciu-actions?action=delete&id=<%= s.getIds() %>" style="text-decoration:none; font-size:1.2em;" title="Șterge" onclick="return confirm('Sigur vrei să ștergi acest serviciu?');">🗑️</a>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="6" style="text-align:center; padding:20px;">
                Nu s-au găsit servicii în baza de date.
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>