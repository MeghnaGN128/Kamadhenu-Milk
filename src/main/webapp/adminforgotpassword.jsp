<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Forgot Password - Kamadhenu Milk Products</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>
    <link href="CSS/styles.css" rel="stylesheet"/>


    <style>
        body {
            background-image: url('images/background.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            font-family: Arial, sans-serif;
        }
        .container-box {
            max-width: 520px;
            margin: 80px auto;
            background: #fff;
            padding: 28px 32px;
            border-radius: 10px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
        }
        h1 { font-size: 22px; margin: 0 0 12px; color: #111827; }
        label { display: block; margin: 12px 0 6px; color: #374151; font-weight: 600; }
        input[type="email"] { width: 100%; padding: 10px 12px; border: 1px solid #d1d5db; border-radius: 8px; outline: none; }
        .actions { margin-top: 16px; display: flex; gap: 12px; align-items: center; }
        button { background: #2563eb; color: #fff; border: none; padding: 10px 16px; border-radius: 8px; cursor: pointer; }
        .info { background: #eff6ff; border: 1px solid #bfdbfe; color: #1e40af; padding: 10px 12px; border-radius: 8px; margin: 14px 0; }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<!-- Updated Navbar -->
<nav class="navbar navbar-expand-lg custom-navbar">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">
            <span class="logo-badge">
                <img src="images/logo.jpg" alt="Kamadhenu Logo" style="height:50px;"/>
            </span>
            Kamadhenu Milk
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="index.jsp">
                    <i class="bi bi-house-door me-1"></i>Home
                </a>
                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="loginDropdown" role="button" data-bs-toggle="dropdown">
                        Login
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="loginDropdown">
                        <li><a class="dropdown-item" href="adminLogin">Admin Login</a></li>
                        <li><a class="dropdown-item" href="agentdashboard">Agent Login</a></li>
                        <li><a class="dropdown-item" href="customerLogin.jsp">Customer Login</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>

<div class="container-box">
    <h1>Forgot your password?</h1>
    <p>Enter your registered email to receive a link to set a new password.</p>

    <c:if test="${not empty info}">
        <div class="info">${info}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/sendResetLink" method="post">
        <input type="hidden" name="source" value="forgot" />
        <label for="email">Email</label>
        <input id="email" type="email" name="email" value="${email}" required />

        <div class="actions">
            <button type="submit">Send Reset Link</button>
            <a href="${pageContext.request.contextPath}/adminLogin">Back to Login</a>
        </div>
    </form>
</div>

<footer class="bg-dark text-white pt-5 pb-4 mt-auto">
    <div class="container text-center text-md-start">
        <div class="row">
            <div class="col-md-4 col-lg-4 col-xl-4 mx-auto mb-4">
                <h5 class="text-uppercase fw-bold mb-3">Kamadhenu Milk Products</h5>
                <p>Bringing you fresh milk, curd, ghee, paneer and more from trusted farmers.</p>
            </div>
            <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
                <h6 class="text-uppercase fw-bold mb-3">Quick Links</h6>
                <ul class="list-unstyled">
                    <li><a href="index.jsp" class="text-white text-decoration-none">Home</a></li>
                    <li><a href="register.jsp" class="text-white text-decoration-none">Register</a></li>
                    <li><a href="adminLogin" class="text-white text-decoration-none">Admin Login</a></li>
                </ul>
            </div>
            <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mb-4">
                <h6 class="text-uppercase fw-bold mb-3">Contact</h6>
                <p><i class="bi bi-geo-alt-fill me-2"></i> Bengaluru, Karnataka</p>
                <p><i class="bi bi-envelope-fill me-2"></i> support@kamadhenu.com</p>
                <p><i class="bi bi-telephone-fill me-2"></i> +91 98765 43210</p>
            </div>
            <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mb-4">
                <h6 class="text-uppercase fw-bold mb-3">Follow Us</h6>
                <a href="#" class="text-white fs-4 me-3"><i class="bi bi-facebook"></i></a>
                <a href="#" class="text-white fs-4 me-3"><i class="bi bi-twitter"></i></a>
                <a href="#" class="text-white fs-4 me-3"><i class="bi bi-instagram"></i></a>
                <a href="#" class="text-white fs-4"><i class="bi bi-linkedin"></i></a>
            </div>
        </div>
        <div class="text-center pt-3 border-top border-secondary">
            <p class="mb-0">&copy; 2025 Kamadhenu Milk Products. All Rights Reserved.</p>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
