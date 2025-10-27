<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Admin Profile - Dairy Admin</title>

    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>
    <!-- External CSS -->
    <link href="CSS/styles.css" rel="stylesheet"/>

    <style>
        .custom-navbar {
            background-color: #fff9c4 !important;
            padding: 0.8rem 1rem;
            border-bottom: 1px solid #e0e0e0;
        }
        .custom-navbar .nav-link,
        .custom-navbar .navbar-brand { color: #333 !important; font-weight: 500; }
        .custom-navbar .nav-link:hover { color: #d84315 !important; }
        .admin-profile-card { padding: 2rem; }
        .admin-profile-img { width: 120px; height: 120px; object-fit: cover; }
    </style>
</head>
<body>

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
                        <li><a class="dropdown-item" href="adminloginsuccessfully">Admin Dashboard</a></li>
                        <li><a class="dropdown-item" href="customerLogin">Customer Login</a></li>


                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>


<!-- Success Message -->
<c:if test="${not empty message}">
    <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<!-- Profile Card -->
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow admin-profile-card text-center">
                <div class="card-body">
                    <img src="images/adminprofile.jpg" alt="Admin Profile" class="rounded-circle mb-3 admin-profile-img"/>
                    <h5 class="fw-bold">${sessionScope.adminDTO.adminName}</h5>
                    <p class="small text-muted">${sessionScope.adminDTO.email}</p>
                    <p class="small text-muted">${sessionScope.adminDTO.mobileNumber}</p>
                    <hr/>

                    <!-- Buttons -->
                    <button class="btn btn-primary mb-2" type="button" data-bs-toggle="collapse" data-bs-target="#updateProfileForm">
                        Update Profile
                    </button>
                    <form action="logout" method="get" class="d-inline">
                        <button type="submit" class="btn btn-danger mb-2">Logout</button>
                    </form>

                    <!-- Update Profile Form -->
                    <div class="collapse mt-3" id="updateProfileForm">
                        <form action="updateAdminProfile" method="post">
                            <input type="hidden" name="adminId" value="${sessionScope.adminDTO.adminId}"/>

                            <div class="mb-3 text-start">
                                <label class="form-label">Name</label>
                                <input type="text" name="adminName" class="form-control"
                                       value="${sessionScope.adminDTO.adminName}" required/>
                            </div>

                            <div class="mb-3 text-start">
                                <label class="form-label">Email</label>
                                <input type="email" name="email" class="form-control"
                                       value="${sessionScope.adminDTO.email}" readonly/>
                            </div>

                            <div class="mb-3 text-start">
                                <label class="form-label">Mobile Number</label>
                                <input type="text" name="mobileNumber" class="form-control"
                                       value="${sessionScope.adminDTO.mobileNumber}" required/>
                            </div>

                            <div class="mb-3 text-start">
                                <label class="form-label">Password</label>
                                <input type="password" name="password" class="form-control"
                                       placeholder="Enter new password"/>
                                <small class="text-muted">Leave blank to keep existing password</small>
                            </div>

                            <button type="submit" class="btn btn-success">Save Changes</button>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white pt-4 pb-3 mt-auto">
    <div class="container text-center text-md-start">
        <div class="row">
            <div class="col-md-4 mb-3">
                <h5 class="fw-bold mb-2">Kamadhenu Milk Products</h5>
                <p> Bringing you fresh milk, curd, ghee, paneer and more from trusted farmers.
                    Natural goodness with every drop.</p>
            </div>
            <div class="col-md-2 mb-3">
                <h6 class="fw-bold mb-2">Quick Links</h6>
                <ul class="list-unstyled">
                    <li><a href="index.jsp" class="text-white text-decoration-none">Home</a></li>
                    <li><a href="register.jsp" class="text-white text-decoration-none">Register</a></li>
                    <li><a href="adminLogin.jsp" class="text-white text-decoration-none">Admin Login</a></li>
                    <li><a href="customerLogin.jsp" class="text-white text-decoration-none">Customer Login</a></li>
                </ul>
            </div>
            <div class="col-md-3 mb-3">
                <h6 class="fw-bold mb-2">Contact</h6>
                <p><i class="bi bi-geo-alt-fill me-2"></i>Bengaluru, Karnataka</p>
                <p><i class="bi bi-envelope-fill me-2"></i>support@dairyadmin.com</p>
                <p><i class="bi bi-telephone-fill me-2"></i>+91 98765 43210</p>
            </div>
            <div class="col-md-3 mb-3">
                <h6 class="fw-bold mb-2">Follow Us</h6>
                <a href="#" class="text-white fs-5 me-2"><i class="bi bi-facebook"></i></a>
                <a href="#" class="text-white fs-5 me-2"><i class="bi bi-twitter"></i></a>
                <a href="#" class="text-white fs-5 me-2"><i class="bi bi-instagram"></i></a>
                <a href="#" class="text-white fs-5"><i class="bi bi-linkedin"></i></a>
            </div>
        </div>
        <div class="text-center pt-2 border-top border-secondary">
            <p class="mb-0">&copy; 2025 Dairy Admin. All Rights Reserved.</p>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
