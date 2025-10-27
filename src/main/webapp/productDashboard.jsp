<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Product Dashboard - Kamadhenu Milk Products</title>

    <!-- Bootstrap CSS & Icons -->
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
            padding-bottom: 1rem;
            overflow-y: auto;
        }

        .sidebar h5 {
            color: var(--k-brown-700);
        }

        .sidebar .nav-link {
            color: var(--k-brown-700);
            padding: 10px 16px;
            border-radius: 8px;
            margin: 0 10px 8px 10px;
            transition: background-color 0.2s ease, color 0.2s ease;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
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

        @media (max-width: 991.98px) {
            .main-wrapper {
                grid-template-columns: 1fr;
                grid-template-areas:
                    "nav"
                    "main";
            }

            .sidebar {
                display: none;
            }
        }

        .offcanvas-yellow {
            background: var(--k-yellow-50);
            border-right: 1px solid var(--k-yellow-400);
        }

        footer {
            flex-shrink: 0;
            background: #1f1f1f;
            color: #fff;
            padding: 40px 0 20px;
            margin-top: 2rem;
        }

        footer h6, footer h5 {
            color: #fff;
        }

        footer a {
            color: #fff;
            text-decoration: none;
        }

        footer a:hover {
            text-decoration: underline;
        }

        footer .border-top {
            border-color: #666 !important;
        }

        /* Agent/Product cards base styles */
        .agent-card, .product-card {
            background: #fff;
            border: 1px solid #f2e6b3;
            border-radius: 16px;
            padding: 18px;
            box-shadow: 0 3px 14px rgba(0,0,0,0.06);
            transition: transform 0.08s ease, box-shadow 0.2s ease;
            height: 100%;
        }

        .agent-card:hover, .product-card:hover {
            transform: translateY(-2px);
        }

        .agent-id-badge, .product-id-badge {
            display: inline-block;
            background: #FFF3CD;
            color: #856404;
            font-weight: 600;
            border-radius: 12px;
            padding: 4px 10px;
            font-size: .85rem;
            margin-bottom: 10px;
        }
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
            <a class="nav-link active" href="productDashboard"><i class="bi bi-grid"></i> Product Dashboard</a>
            <a class="nav-link" href="#"><i class="bi bi-cart"></i> Orders</a>
            <a class="nav-link" href="agentdashboard"><i class="bi bi-people"></i> Agents</a>
            <a class="nav-link" href="#"><i class="bi bi-person-lines-fill"></i> Customers</a>
            <a class="nav-link text-danger mt-3" href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </nav>
    </div>
</div>

<div class="main-wrapper">
    <!-- Navbar -->
    <!-- Navbar -->
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
            <a class="nav-link active" href="productDashboard"><i class="bi bi-grid"></i> Product Dashboard</a>
            <a class="nav-link" href="#"><i class="bi bi-cart"></i> Orders</a>
            <a class="nav-link" href="agentdashboard"><i class="bi bi-people"></i> Agents</a>
            <a class="nav-link" href="#"><i class="bi bi-person-lines-fill"></i> Customers</a>
            <a class="nav-link text-danger mt-auto" href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="p-4" style="grid-area: main;">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3>Products Dashboard</h3>

        <%
        Integer visitCount = (Integer) session.getAttribute("visitCount");
        if (visitCount == null) {
        visitCount = 1;
        } else {
        visitCount++;
        }
        session.setAttribute("visitCount", visitCount);
        %>

        <!-- Page Visits Badge - Light Color -->
        <div class="d-flex justify-content-end my-2">
    <span class="badge text-dark fs-6 px-3 py-2 shadow-sm" style="background-color: #f8d7da;">
        <i class="bi bi-eye-fill me-1"></i> Page visits: <strong><%= visitCount %></strong>
    </span>
        </div>
            <div class="d-flex gap-2">
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">Add New Product</button>
        </div>
        </div>
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Search Card -->
        <div class="card mb-3">
            <div class="card-body p-3">
                <form class="row g-2" role="search" onsubmit="return false;">
                    <div class="col-12 col-md-10">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                            <input class="form-control" type="search" id="searchInput" placeholder="Search by ID, Name, Email, Phone, Address, Milk Type…" aria-label="Search agents">
                        </div>
                    </div>
                    <div class="col-12 col-md-2">
                        <button class="btn btn-primary w-100" type="button" id="searchBtn">
                            <span class="d-none d-md-inline">Search</span>
                            <i class="bi bi-search d-md-none"></i>
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Product Cards Matrix -->
        <c:choose>
            <c:when test="${not empty allProducts}">
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                    <c:forEach var="product" items="${allProducts}">
                        <div class="col">
                            <div class="product-card">
                                <div class="product-id-badge">ID: ${product.productId}</div>
                                <h5 class="mb-2">${product.productName}</h5>
                                <p class="mb-1">
                                    <strong>Type: </strong>
                                    <span class="badge ${product.productType == 'SELL' ? 'bg-success' : 'bg-info'}">
                                        ${not empty product.productType ? product.productType : 'N/A'}
                                    </span>
                                </p>
                                <p class="mb-3">
                                    <strong>Price: </strong>
                                    <c:choose>
                                        <c:when test="${not empty product.productPrice}">
                                            ₹${String.format("%.2f", product.productPrice)}
                                        </c:when>
                                        <c:otherwise>N/A</c:otherwise>
                                    </c:choose>
                                </p>
                                <div class="d-flex gap-2 mt-auto">
                                    <button class="btn btn-sm btn-outline-primary w-50"
                                            onclick="editProduct(${product.productId}, '${product.productName}', '${product.productType}', ${product.productPrice})">
                                        <i class="bi bi-pencil"></i> Edit
                                    </button>
                                    <button class="btn btn-sm btn-outline-danger w-50"
                                            onclick="deleteProduct(${product.productId}, this)">
                                        <i class="bi bi-trash"></i> Delete
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-info">No products found. Please add some products.</div>
            </c:otherwise>
        </c:choose>

        <!-- Pagination Controls -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Product pagination">
                <ul class="pagination justify-content-center mt-4">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>

        <!-- Add/Edit Product Modal -->
        <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="save" method="post" id="productForm">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" id="productId" name="productId"/>
                            <div class="mb-3">
                                <label for="productName" class="form-label">Product Name</label>
                                <input type="text" class="form-control" id="productName" name="productName" required/>
                            </div>
                            <div class="mb-3">
                                <label class="form-label d-block">Product Type</label>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="productType" id="sellOption" value="SELL" required/>
                                    <label class="form-check-label" for="sellOption">Sell</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="productType" id="buyOption" value="BUY" required/>
                                    <label class="form-check-label" for="buyOption">Buy</label>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="productPrice" class="form-label">Price</label>
                                <input type="number" step="0.01" class="form-control" id="productPrice" name="productPrice" required/>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save Product</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </main>
</div>

<!-- Footer -->
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

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function deleteProduct(productId, button) {
        if (confirm('Are you sure you want to delete this product?')) {
            const card = button.closest('.col');
            card.style.transition = 'opacity 0.3s';
            card.style.opacity = '0';
            setTimeout(() => card.remove(), 300);
            fetch('deleteProduct?productId=' + productId, { method: 'GET' });
        }
    }

    function editProduct(id, name, type, price) {
        document.getElementById('addProductModalLabel').textContent = 'Edit Product';
        document.getElementById('productId').value = id;
        document.getElementById('productName').value = name;
        document.getElementById('productPrice').value = price;
        if (type === 'SELL') document.getElementById('sellOption').checked = true;
        else if (type === 'BUY') document.getElementById('buyOption').checked = true;
        document.getElementById('productForm').action = 'updateProduct';
        new bootstrap.Modal(document.getElementById('addProductModal')).show();
    }

    document.getElementById('addProductModal').addEventListener('hidden.bs.modal', function () {
        document.getElementById('productForm').reset();
        document.getElementById('productId').value = '';
        document.getElementById('addProductModalLabel').textContent = 'Add New Product';
        document.getElementById('productForm').action = 'save';
    });
</script>
</body>
</html>
