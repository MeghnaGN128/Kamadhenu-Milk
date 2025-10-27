<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Kamadhenu Milk Products</title>

    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>

    <!-- External CSS -->
    <link href="CSS/styles.css" rel="stylesheet"/>

    <style>
        body {
            background-image: url('images/background.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
        footer a:hover {
            color: #00c853 !important; /* Green hover */
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
        <a class="navbar-brand fw-bold" href="#">
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
                <!-- Home Link -->
                <div class="nav-item me-3">
                    <a class="nav-link" href="index.jsp">
                        <i class="bi bi-house-door me-1"></i>Home
                    </a>
                </div>
                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="loginDropdown"
                       role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Login
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="loginDropdown">
                        <li><a class="dropdown-item" href="adminLogin">Admin Login</a></li>
                        <li><a class="dropdown-item" href="agentdashboard">Agent Login</a></li>
                        <li><a class="dropdown-item" href="customerLogin">Customer Login</a></li>
                        <li><a class="dropdown-item" href="adminloginsuccessfully">Admin Dashboard</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<header class="text-center py-5" style="background: transparent;">
    <h1 class="display-5 fw-bold">Welcome to Kamadhenu Milk Products</h1>

</header>

<!-- About Section -->
<div class="container my-5">
    <div class="row align-items-center">
        <div class="col-md-6">
            <img src="images/milk-products.jpg" alt="Milk Products"
                 class="img-fluid milk-product"
                 style="width: 500px; height: 300px;"/>
        </div>
        <div class="col-md-6">
            <h2>About Us</h2>
            <p>
                Kamadhenu Milk Products brings you the purity of nature with fresh milk,
                curd, paneer, ghee, and more — sourced directly from trusted farmers.
                Our mission is to deliver natural goodness with every drop.
            </p>
        </div>
    </div>
</div>

<!-- Products Section -->
<div class="container my-5">
    <h2 class="text-center mb-4">Our Products</h2>
    <div class="row text-center">
        <div class="col-md-3">
            <div class="p-3 rounded-circle" style="background:#e3f2fd; display:inline-block;">
                <i class="bi bi-cup-hot" style="font-size:48px; color:#1565c0;"></i>
            </div>
            <h5 class="mt-2">Milk</h5>
        </div>
        <div class="col-md-3">
            <div class="p-3 rounded-circle" style="background:#fff3e0; display:inline-block;">
                <i class="bi bi-basket-fill" style="font-size:48px; color:#ff9800;"></i>
            </div>
            <h5 class="mt-2">Curd</h5>
        </div>
        <div class="col-md-3">
            <div class="p-3 rounded-circle" style="background:#f1f8e9; display:inline-block;">
                <i class="bi bi-droplet-fill" style="font-size:48px; color:#388e3c;"></i>
            </div>
            <h5 class="mt-2">Ghee</h5>
        </div>
        <div class="col-md-3">
            <div class="p-3 rounded-circle" style="background:#fce4ec; display:inline-block;">
                <i class="bi bi-box2-heart" style="font-size:48px; color:#d81b60;"></i>
            </div>
            <h5 class="mt-2">Paneer</h5>
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
                    <li><a href="adminLogin" class="text-white text-decoration-none">Admin Login</a></li>
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
</body>
</html>