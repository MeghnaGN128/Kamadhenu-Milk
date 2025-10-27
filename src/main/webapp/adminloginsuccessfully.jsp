<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<html lang="en" xmlns:c="">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Admin Dashboard - Kamadhenu Milk Products</title>

    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet"/>

    <!-- External CSS -->
    <link href="CSS/styles.css" rel="stylesheet"/>

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

        /* Global layout wrapper */
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background: #faf9f4;
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

        /* Navbar */
        .custom-navbar {
            grid-area: nav;
            position: sticky;
            top: 0;
            z-index: 1030;
            background: #ffffff;
            border-bottom: 1px solid #eee5bf;
        }

        /* Sidebar */
        .sidebar {
            grid-area: sidebar;
            background: var(--k-yellow-50);
            border-right: 1px solid var(--k-yellow-400);
            position: sticky;
            top: 64px;
            height: calc(100vh - 64px);
            padding-top: 1rem;
            padding-bottom: 1rem;
            overflow-y: auto;
        }

        .sidebar h5 { color: var(--k-brown-700); }
        .sidebar .nav-link {
            color: var(--k-brown-700);
            padding: 10px 16px;
            border-radius: 8px;
            margin: 0 10px 8px 10px;
            transition: background-color 0.2s ease, color 0.2s ease;
            font-weight: 500;
            display: flex; align-items: center; gap: 0.5rem;
        }
        .sidebar .nav-link:hover {
            background: var(--k-yellow-200);
            color: var(--k-brown-800);
        }
        .sidebar .nav-link.active {
            background: var(--k-yellow-300);
            color: var(--k-brown-900);
            box-shadow: inset 2px 0 0 #C9A227;
        }

        /* Metric cards */
        .metric-card {
            background: #fff;
            border: 1px solid #f2e6b3;
            border-radius: 16px;
            padding: 24px;
            display: flex;
            align-items: center;
            gap: 18px;
            box-shadow: 0 3px 14px rgba(0,0,0,0.06);
            transition: transform 0.08s ease, box-shadow 0.2s ease;
            min-height: 120px;
        }
        .metric-card:hover { transform: translateY(-2px); }
        .metric-icon {
            width: 64px; height: 64px;
            border-radius: 12px;
            display: grid; place-items: center;
            background: var(--k-yellow-100);
            color: var(--k-brown-700);
        }

        /* Responsive fixes */
        @media (max-width: 991.98px) {
            .main-wrapper {
                grid-template-columns: 1fr;
                grid-template-areas:
                    "nav"
                    "main";
            }
            .sidebar { display: none; }
        }

        /* Offcanvas sidebar (mobile) */
        .offcanvas-yellow {
            background: var(--k-yellow-50);
            border-right: 1px solid var(--k-yellow-400);
        }

        /* Footer pinned to bottom */
        footer {
            flex-shrink: 0;
            background: #1f1f1f;
            color: #fff;
            padding: 40px 0 20px;
        }
        footer h6, footer h5 { color: #fff; }
        footer a { color: #fff; text-decoration: none; }
        footer a:hover { text-decoration: underline; }
        footer .border-top { border-color: #666 !important; }
    </style>
</head>
<body>

<!-- Offcanvas Sidebar (Mobile) -->
<div class="offcanvas offcanvas-start offcanvas-yellow" tabindex="-1" id="mobileSidebar">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title fw-bold">Dashboard</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body">
        <nav class="nav flex-column">
            <a class="nav-link" href="productDashboard"><i class="bi bi-grid"></i> Product Dashboard</a>
            <a class="nav-link" href="#"><i class="bi bi-cart"></i> Orders</a>
            <a class="nav-link" href="agentdashboard"><i class="bi bi-people"></i> Agents</a>
            <a class="nav-link" href="#"><i class="bi bi-person-lines-fill"></i> Customers</a>
            <a class="nav-link text-danger mt-3" href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </nav>
    </div>
</div>

<div class="main-wrapper">
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
                <div class="nav-item me-3">
                    <a class="nav-link" href="index.jsp">
                        <i class="bi bi-house-door me-1"></i>Home
                    </a>
                </div>
                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="adminDropdown"
                       role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="images/adminprofile.jpg" class="rounded-circle me-1" style="height:32px;width:32px;object-fit:cover;">
                        <span>${sessionScope.adminDTO != null ? sessionScope.adminDTO.adminName : 'Admin'}</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="adminDropdown">
                        <li class="dropdown-item text-center">
                            <img src="images/adminprofile.jpg" class="rounded-circle mb-2 border" style="height:80px;width:80px;object-fit:cover;">
                            <div class="fw-bold">${sessionScope.adminDTO != null ? sessionScope.adminDTO.adminName : 'Admin'}</div>
                            <div class="small text-muted">${sessionScope.adminDTO != null ? sessionScope.adminDTO.email : 'admin@kamadhenu.com'}</div>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item text-danger d-flex align-items-center gap-2" href="adminprofile">
                                <i class="bi bi-person-circle"></i> Profile
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item text-danger d-flex align-items-center gap-2" href="adminloginsuccessfully">
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

    <!-- Sidebar (Desktop) -->
    <aside class="sidebar d-none d-lg-flex flex-column">
        <h5 class="fw-bold ps-3">Dashboard</h5>
        <nav class="nav flex-column">
            <a class="nav-link" href="productDashboard"><i class="bi bi-grid"></i> Product Dashboard</a>
            <a class="nav-link" href="#"><i class="bi bi-cart"></i> Orders</a>
            <a class="nav-link" href="agentdashboard"><i class="bi bi-people"></i> Agents</a>
            <a class="nav-link" href="#"><i class="bi bi-person-lines-fill"></i> Customers</a>
            <a class="nav-link text-danger mt-auto" href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="p-4">
        <div class="mb-4">
            <h3>Welcome, ${sessionScope.adminDTO != null ? sessionScope.adminDTO.adminName : 'Admin'}</h3>
            <div class="text-muted">Email: ${sessionScope.adminDTO != null ? sessionScope.adminDTO.email : 'admin@kamadhenu.com'}</div>
        </div>

        <style>
            .metric-icon {
              background-color: lightpink; /* uniform light pink color */
              color: #fff; /* white icon color */
              display: flex;
              align-items: center;
              justify-content: center;
              width: 60px;
              height: 60px;
              border-radius: 50%;
              font-size: 1.5rem;
            }
        </style>

        <div class="row g-3">
            <div class="col-12 col-sm-6 col-lg-3">
                <div class="metric-card">
                    <div class="metric-icon"><i class="bi bi-person-badge-fill"></i></div>
                    <div>
                        <div class="label">Products</div>
                        <div class="value"><c:out value="${productCount}" default="0"/></div>
                    </div>
                </div>
            </div>

            <div class="col-12 col-sm-6 col-lg-3">
                <div class="metric-card">
                    <div class="metric-icon"><i class="bi bi-receipt-cutoff"></i></div>
                    <div>
                        <div class="label">Orders</div>
                        <div class="value"><c:out value="${ordersCount}" default="0"/></div>
                    </div>
                </div>
            </div>

            <div class="col-12 col-sm-6 col-lg-3">
                <div class="metric-card">
                    <div class="metric-icon"><i class="bi bi-people-fill"></i></div>
                    <div>
                        <div class="label">Customers</div>
                        <div class="value"><c:out value="${customersCount}" default="0"/></div>
                    </div>
                </div>
            </div>

            <div class="col-12 col-sm-6 col-lg-3">
                <div class="metric-card">
                    <div class="metric-icon"><i class="bi bi-person-badge-fill"></i></div>
                    <div>
                        <div class="label">Agents</div>
                        <div class="value"><c:out value="${agentCount}" default="0"/></div>
                    </div>
                </div>
            </div>
        </div>


    </main>
</div>

<!-- Footer (always bottom) -->
<footer class="mt-auto">
    <div class="container text-center text-md-start">
        <div class="row">
            <div class="col-md-4 mb-4">
                <h5 class="fw-bold">Kamadhenu Milk Products</h5>
                <p>Bringing you fresh milk, curd, ghee, paneer, and more from trusted farmers. Natural goodness with every drop.</p>
            </div>
            <div class="col-md-2 mb-4">
                <h6 class="fw-bold">Quick Links</h6>
                <ul class="list-unstyled">
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="register.jsp">Register</a></li>
                    <li><a href="adminLogin">Admin Login</a></li>
                    <li><a href="customerLogin.jsp">Customer Login</a></li>
                </ul>
            </div>
            <div class="col-md-3 mb-4">
                <h6 class="fw-bold">Contact</h6>
                <p><i class="bi bi-geo-alt-fill me-2"></i>Bengaluru, Karnataka</p>
                <p><i class="bi bi-envelope-fill me-2"></i>support@kamadhenu.com</p>
                <p><i class="bi bi-telephone-fill me-2"></i>+91 98765 43210</p>
            </div>
            <div class="col-md-3 mb-4">
                <h6 class="fw-bold">Follow Us</h6>
                <a href="#" class="me-3 fs-4"><i class="bi bi-facebook"></i></a>
                <a href="#" class="me-3 fs-4"><i class="bi bi-twitter"></i></a>
                <a href="#" class="me-3 fs-4"><i class="bi bi-instagram"></i></a>
                <a href="#" class="fs-4"><i class="bi bi-linkedin"></i></a>
            </div>
        </div>
        <div class="text-center border-top mt-3 pt-3">
            <p class="mb-0">&copy; 2025 Kamadhenu Milk Products. All Rights Reserved.</p>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
