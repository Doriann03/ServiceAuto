<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Autentificare - Service Auto</title>
    <jsp:include page="includes/head.jsp" />
    <style>
        body {
            background: linear-gradient(135deg, #0d6efd 0%, #0dcaf0 100%); /* Fundal gradient albastru */
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            width: 100%;
            max-width: 400px;
            border: none;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            border-radius: 15px;
        }
        .form-control:focus {
            box-shadow: none;
            border-color: #0d6efd;
        }
    </style>
</head>
<body>

<div class="card login-card p-4">
    <div class="card-body">
        <div class="text-center mb-4">
            <i class="fa-solid fa-car-side fa-3x text-primary mb-2"></i>
            <h3 class="fw-bold text-dark">Bun venit!</h3>
            <p class="text-muted small">Introdu datele pentru a te autentifica.</p>
        </div>

        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
        <div class="alert alert-danger text-center p-2 small">
            <i class="fa-solid fa-circle-exclamation me-1"></i> <%= error %>
        </div>
        <% } %>

        <form action="login" method="post">
            <div class="mb-3">
                <label class="form-label fw-bold small text-secondary">Utilizator / Email</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="fa-solid fa-user"></i></span>
                    <input type="text" name="username" class="form-control" placeholder="Introdu user sau email" required>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label fw-bold small text-secondary">Parolă</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="fa-solid fa-lock"></i></span>
                    <input type="password" name="password" class="form-control" placeholder="•••••••" required>
                </div>
            </div>

            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-primary fw-bold py-2 shadow-sm">
                    Autentificare <i class="fa-solid fa-arrow-right-to-bracket ms-2"></i>
                </button>
            </div>

            <div class="text-center border-top pt-3">
                <span class="text-muted small">Nu ai cont?</span>
                <a href="register.jsp" class="text-decoration-none fw-bold ms-1">Înregistrează-te aici</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>