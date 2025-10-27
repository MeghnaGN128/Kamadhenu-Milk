
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Admin Login - Kamadhenu Milk Products</title>

    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>


    <!-- External CSS -->
    <link href="CSS/styles.css" rel="stylesheet"/>

    <style>
        body {
            background: url("images/admin.jpg") no-repeat center center fixed;
            background-size: cover;
        }
        .card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
        }
        footer a:hover {
            color: #00c853 !important;
            transition: 0.3s;
        }
        footer .bi {
            transition: transform 0.3s;
        }
        footer .bi:hover {
            transform: scale(1.2);
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<!-- Navbar -->
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
                    <a class="nav-link dropdown-toggle" href="#" id="loginDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        Login
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="loginDropdown">
                        <li><a class="dropdown-item" href="agentdashboard">Agent Login</a></li>
                        <li><a class="dropdown-item" href="adminloginsuccessfully">Admin Dashboard</a></li>
                        <li><a class="dropdown-item" href="customerLogin.jsp">Customer Login</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- Admin Login Form -->
<div class="container d-flex justify-content-center align-items-center flex-grow-1 my-5">
    <div class="card shadow p-4" style="max-width:400px; width:100%;">
        <h3 class="text-center mb-4">Admin Login</h3>

        <!-- Success / Error Messages -->
        <c:if test="${not empty message}">
            <div class="alert ${message.contains('successfully') ? 'alert-success' : 'alert-danger'}" id="alertMessage">
                ${message}
            </div>
        </c:if>

    <!-- Login Form -->
    <form action="adminLoginSuccess" method="post">
        <div class="mb-3">
            <label for="adminName" class="form-label">Admin email</label>
            <input type="text" class="form-control" id="adminName" name="adminName" placeholder="Enter admin email" required/>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required/>
        </div>
        <button type="submit" class="btn btn-success w-100">Login</button>
    </form>

    <!-- Forgot Password -->
    <div class="text-center mt-3">
        <a href="adminForgotPassword" class="text-decoration-none text-primary">Forgot Password?</a>
    </div>
</div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white pt-5 pb-4 mt-auto">
    <div class="container text-center text-md-start">
        <div class="row">
            <!-- About -->
            <div class="col-md-4 col-lg-4 col-xl-4 mx-auto mb-4">
                <h5 class="text-uppercase fw-bold mb-3">Kamadhenu Milk Products</h5>
                <p>
                    Bringing you fresh milk, curd, ghee, paneer and more from trusted farmers.
                    Natural goodness with every drop.
                </p>
            </div>
            <!-- Quick Links -->
            <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
                <h6 class="text-uppercase fw-bold mb-3">Quick Links</h6>
                <ul class="list-unstyled">
                    <li><a href="index.jsp" class="text-white text-decoration-none">Home</a></li>
                    <li><a href="adminLogin.jsp" class="text-white text-decoration-none">Admin Login</a></li>
                    <li><a href="customerLogin.jsp" class="text-white text-decoration-none">Customer Login</a></li>
                    <li><a href="agentLogin.jsp" class="text-white text-decoration-none">Agent Login</a></li>
                </ul>
            </div>
            <!-- Contact -->
            <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mb-4">
                <h6 class="text-uppercase fw-bold mb-3">Contact</h6>
                <p><i class="bi bi-geo-alt-fill me-2"></i> Bengaluru, Karnataka</p>
                <p><i class="bi bi-envelope-fill me-2"></i> support@kamadhenu.com</p>
                <p><i class="bi bi-telephone-fill me-2"></i> +91 98765 43210</p>
            </div>
            <!-- Social -->
            <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mb-4">
                <h6 class="text-uppercase fw-bold mb-3">Follow Us</h6>
                <a href="#" class="text-white fs-4 me-3"><i class="bi bi-facebook"></i></a>
                <a href="#" class="text-white fs-4 me-3"><i class="bi bi-twitter"></i></a>
                <a href="#" class="text-white fs-4 me-3"><i class="bi bi-instagram"></i></a>
                <a href="#" class="text-white fs-4"><i class="bi bi-linkedin"></i></a>
            </div>
        </div>
        <!-- Copyright -->
        <div class="text-center pt-3 border-top border-secondary">
            <p class="mb-0">&copy; 2025 Kamadhenu Milk Products. All Rights Reserved.</p>
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Auto-hide Alert after 3s -->
<script>
    setTimeout(() => {
        const alertBox = document.getElementById("alertMessage");
        if (alertBox) {
            alertBox.style.transition = "opacity 2.0s ease";
            alertBox.style.opacity = "0";
            setTimeout(() => alertBox.remove(), 500);
        }
    }, 3000);
</script>

</body>
</html>
