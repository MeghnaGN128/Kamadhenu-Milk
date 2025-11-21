<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>

<html lang="en" xmlns:c="">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>View Collections - Kamadhenu Milk Products</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="CSS/styles.css"/>

    <style>
        :root {
            --k-yellow-50: #FFF9DB;
            --k-yellow-100: #FFF4BF;
            --k-yellow-200: #FFEAA7;
            --k-yellow-300: #FFD866;
            --k-yellow-400: #F2D16D;
            --k-brown-900: #2C2300;
            --k-brown-800: #3F3200;
            --k-brown-700: #5B4A00;
        }

        body {
            background: #faf9f4;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            font-family: Arial, Helvetica, sans-serif;
        }

        .main-wrapper {
            flex: 1 0 auto;
            display: grid;
            grid-template-columns: 260px 1fr;
            grid-template-rows: auto 1fr;
            grid-template-areas:
                    "nav nav"
                    "sidebar main";
        }

        .custom-navbar {
            grid-area: nav;
            position: sticky;
            top: 0;
            z-index: 1030;
            background: #ffffff;
            border-bottom: 1px solid #eee5bf;
        }

        .sidebar {
            grid-area: sidebar;
            background: var(--k-yellow-50);
            border-right: 1px solid var(--k-yellow-400);
            position: sticky;
            top: 64px;
            height: calc(100vh - 64px);
            padding-top: 1rem;
            overflow-y: auto;
        }

        .sidebar h5 {
            color: var(--k-brown-700);
            padding-left: 1rem;
        }

        .sidebar .nav-link {
            color: var(--k-brown-700);
            padding: 10px 16px;
            border-radius: 8px;
            margin: 0 10px 8px 10px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .sidebar .nav-link:hover {
            background: var(--k-yellow-200);
            color: var(--k-brown-900);
        }

        .sidebar .nav-link.active {
            background: var(--k-yellow-300);
            color: var(--k-brown-900);
            box-shadow: inset 2px 0 0 #C9A227;
        }

        .card {
            border-radius: 14px;
            border: 1px solid #f2e6b3;
            box-shadow: 0 3px 14px rgba(0,0,0,0.06);
        }

        .card-header {
            background: var(--k-yellow-100);
            border-bottom: 1px solid var(--k-yellow-300);
            font-weight: 600;
        }

        .table th {
            background: var(--k-yellow-200);
            color: var(--k-brown-900);
            font-weight: 600;
        }

        .btn-primary {
            background: var(--k-yellow-300);
            border-color: var(--k-yellow-400);
            color: var(--k-brown-900);
            font-weight: 600;
        }

        .btn-primary:hover {
            background: var(--k-yellow-200);
        }

        footer {
            background: #1f1f1f;
            padding: 40px 0 20px;
            color: white;
        }
    </style>
</head>

<body>

<div class="main-wrapper">

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg custom-navbar">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#">
                <span class="logo-badge">
                    <img src="images/logo.jpg" alt="Kamadhenu Logo" style="height:50px;"/>
                </span>
                Kamadhenu Milk
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#mobileSidebar">
                <i class="bi bi-list"></i>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <div class="navbar-nav ms-auto">
                    <div class="nav-item me-3">
                        <a class="nav-link" href="index.jsp">
                            <i class="bi bi-house-door me-1"></i>Home
                        </a>
                    </div>

                    <div class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="adminDropdown"
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="images/adminprofile.jpg"
                                 class="rounded-circle me-1 border"
                                 style="height:32px;width:32px;object-fit:cover;">
                            <span>${sessionScope.adminDTO != null ? sessionScope.adminDTO.adminName : 'Admin'}</span>
                        </a>

                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="adminDropdown" style="min-width:260px;">
                            <li class="dropdown-item text-center">
                                <img src="images/adminprofile.jpg" class="rounded-circle mb-2 border"
                                     style="height:80px;width:80px;object-fit:cover;">
                                <div class="fw-bold">
                                    ${sessionScope.adminDTO != null ? sessionScope.adminDTO.adminName : 'Admin'}
                                </div>
                                <div class="small text-muted">
                                    ${sessionScope.adminDTO != null ? sessionScope.adminDTO.email : 'admin@kamadhenu.com'}
                                </div>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item text-danger d-flex align-items-center gap-2" href="adminprofile">
                                    <i class="bi bi-person-circle"></i> Profile
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item text-danger d-flex align-items-center gap-2" href="dashboard">
                                    <i class="bi bi-arrow-return-left"></i> Admin Dashboard
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item text-danger d-flex align-items-center gap-2" href="logout">
                                    <i class="bi bi-box-arrow-right"></i> Logout
                                </a>
                            </li>
                        </ul>
                    </div>

                </div>
            </div>
        </div>
    </nav>

    <!-- SIDEBAR -->
    <aside class="sidebar d-none d-lg-flex flex-column">
        <h5 class="fw-bold">Dashboard</h5>

        <nav class="nav flex-column">
            <a class="nav-link" href="productDashboard"><i class="bi bi-grid"></i> Product Dashboard</a>
            <a class="nav-link" href="#"><i class="bi bi-cart"></i> Orders</a>
            <a class="nav-link" href="agentdashboard"><i class="bi bi-people"></i> Agents</a>
            <a class="nav-link" href="#"><i class="bi bi-person-lines-fill"></i> Customers</a>
            <a class="nav-link" href="milkCollection"><i class="bi bi-droplet"></i> Milk Collection</a>
            <a class="nav-link active" href="viewCollection"><i class="bi bi-collection"></i> View Collections</a>
            <a class="nav-link" href="paymentDetails"><i class="bi bi-credit-card"></i> Payment Details</a>
            <a class="nav-link text-danger mt-auto" href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </nav>
    </aside>

    <!-- MAIN CONTENT -->
    <main class="p-4">

        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3 class="mb-0">Collections</h3>

            <a href="milkCollection" class="btn btn-success d-flex align-items-center gap-2">
                <i class="bi bi-plus-circle"></i> New Collection
            </a>
        </div>

        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h6 class="m-0">Showing all collections</h6>

                <form class="d-flex gap-2">
                    <input type="date" name="date" class="form-control" style="max-width:200px;">
                    <button class="btn btn-primary">Search</button>
                </form>
            </div>


            <div class="card-body">

                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>Agent</th>
                            <th>Phone</th>
                            <th>Milk Type</th>
                            <th>Price (₹/L)</th>
                            <th>Qty (L)</th>
                            <th>Total (₹)</th>
                            <th>Action</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="c" items="${collectionList}">
                            <tr>
                                <td>${c.agentName}</td>
                                <td>${c.phoneNumber}</td>
                                <td>${c.typeOfMilk}</td>
                                <td>${c.price}</td>
                                <td>${c.quantity}</td>
                                <td>${c.totalAmount}</td>

                                <td>
                                    <button class="btn btn-sm btn-primary view-btn"
                                            data-id="${c.milkCollectionId}">
                                        View
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>

                    </table>
                </div>

            </div>
        </div>

    </main>

</div>

<!-- FOOTER -->
<footer class="bg-dark text-white pt-5 pb-4 mt-auto">
    <div class="container text-center text-md-start">
        <div class="row">
            <div class="col-md-4 col-lg-4 col-xl-4 mx-auto mb-4">
                <h5 class="text-uppercase fw-bold mb-3">Kamadhenu Milk Products</h5>
                <p>Bringing you fresh milk, curd, ghee, paneer and more from trusted farmers. Natural goodness with every drop.</p>
            </div>

            <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
                <h6 class="text-uppercase fw-bold mb-3">Quick Links</h6>
                <ul class="list-unstyled">
                    <li><a href="index.jsp" class="text-white text-decoration-none">Home</a></li>
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

<!-- MODAL (POPUP) -->
<div class="modal fade" id="collectionModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">

            <div class="modal-header bg-warning">
                <h5 class="modal-title">Collection Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <h6 class="text-primary">Agent Information</h6>
                <div class="row mb-3">
                    <div class="col-md-6"><strong>Name:</strong> <span id="agentName"></span></div>
                    <div class="col-md-6"><strong>Email:</strong> <span id="email"></span></div>
                    <div class="col-md-6"><strong>Phone:</strong> <span id="phoneNumber"></span></div>
                    <div class="col-md-6"><strong>Address:</strong> <span id="address"></span></div>
                </div>

                <h6 class="text-primary mt-3">Milk Collection Details</h6>
                <div class="row">
                    <div class="col-md-6"><strong>Milk Type:</strong> <span id="typesOfMilk"></span></div>
                    <div class="col-md-6"><strong>Price per L:</strong> ₹<span id="price"></span></div>
                    <div class="col-md-6"><strong>Quantity:</strong> <span id="quantity"></span> L</div>
                    <div class="col-md-6"><strong>Total Amount:</strong> ₹<span id="totalAmount"></span></div>
                </div>

            </div>

            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

<!-- AJAX SCRIPT -->
<script>
    document.addEventListener("DOMContentLoaded", function () {

        document.querySelectorAll(".view-btn").forEach(btn => {
            btn.addEventListener("click", function () {

                let id = this.getAttribute("data-id");

                fetch("viewSingleCollection?id=" + id)
                    .then(response => response.json())
                    .then(dto => {

                        document.getElementById("agentName").innerText = dto.agentName;
                        document.getElementById("email").innerText = dto.email;
                        document.getElementById("phoneNumber").innerText = dto.phoneNumber;
                        document.getElementById("address").innerText = dto.address;

                        document.getElementById("typesOfMilk").innerText = dto.typesOfMilk;
                        document.getElementById("price").innerText = dto.price;
                        document.getElementById("quantity").innerText = dto.quantity;
                        document.getElementById("totalAmount").innerText = dto.totalAmount;

                        var modal = new bootstrap.Modal(document.getElementById("collectionModal"));
                        modal.show();
                    });
            });
        });

    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
