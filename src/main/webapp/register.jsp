<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Înregistrare Cont</title>
    <jsp:include page="includes/head.jsp" />
    <style>
        body {
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .register-card {
            width: 100%;
            max-width: 700px; /* Mai lat decat login */
            border: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border-radius: 15px;
            overflow: hidden;
        }
        .register-header {
            background-color: #28a745;
            color: white;
            padding: 20px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="card register-card">
    <div class="register-header">
        <h3 class="mb-0 fw-bold"><i class="fa-solid fa-user-plus me-2"></i> Creează Cont Nou</h3>
        <p class="mb-0 small opacity-75">Completează formularul pentru a deveni client.</p>
    </div>

    <div class="card-body p-4 bg-white">
        <%
            String err = (String) request.getAttribute("errorMessage");
            if (err != null) {
        %>
        <div class="alert alert-danger text-center"><%= err %></div>
        <% } %>

        <form action="register" method="post">

            <h6 class="text-muted text-uppercase small fw-bold mb-3 border-bottom pb-2">Date Personale</h6>
            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label">Nume</label>
                    <input type="text" name="nume" class="form-control" value="<%= request.getAttribute("oldNume") != null ? request.getAttribute("oldNume") : "" %>" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Prenume</label>
                    <input type="text" name="prenume" class="form-control" value="<%= request.getAttribute("oldPrenume") != null ? request.getAttribute("oldPrenume") : "" %>" required>
                </div>
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label">Telefon</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
                        <input type="text" name="telefon" class="form-control" value="<%= request.getAttribute("oldTel") != null ? request.getAttribute("oldTel") : "" %>" required>
                    </div>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Email</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                        <input type="email" name="email" class="form-control" value="<%= request.getAttribute("oldEmail") != null ? request.getAttribute("oldEmail") : "" %>" required>
                    </div>
                </div>
            </div>

            <h6 class="text-muted text-uppercase small fw-bold mb-3 border-bottom pb-2 mt-4">Securitate Cont</h6>
            <div class="mb-3">
                <label class="form-label">Username</label>
                <div class="input-group">
                    <span class="input-group-text">@</span>
                    <input type="text" name="username" class="form-control" value="<%= request.getAttribute("oldUser") != null ? request.getAttribute("oldUser") : "" %>" required placeholder="Alege un nume de utilizator">
                </div>
            </div>

            <div class="row g-3 mb-4">
                <div class="col-md-6">
                    <label class="form-label">Parolă</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Confirmă Parola</label>
                    <input type="password" name="password_confirm" class="form-control" required>
                </div>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-success fw-bold py-2 shadow-sm">
                    Înregistrează-te
                </button>
            </div>
        </form>
    </div>
    <div class="card-footer text-center bg-light py-3">
        Ai deja cont? <a href="login.jsp" class="fw-bold text-success text-decoration-none">Autentifică-te aici</a>
    </div>
</div>

</body>
</html>