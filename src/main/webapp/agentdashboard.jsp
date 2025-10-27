<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Agent Dashboard - Kamadhenu Milk Products</title>

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

        /* Navbar (same as Admin) */
        .custom-navbar {
            grid-area: nav;
            position: sticky;
            top: 0;
            z-index: 1030;
            background: #ffffff;
            border-bottom: 1px solid #eee5bf;
        }

        /* Sidebar (same as Admin) */
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

        /* Metric/Agent cards base styles */
        .metric-card, .agent-card {
            background: #fff;
            border: 1px solid #f2e6b3;
            border-radius: 16px;
            padding: 18px;
            box-shadow: 0 3px 14px rgba(0,0,0,0.06);
            transition: transform 0.08s ease, box-shadow 0.2s ease;
            height: 100%;
        }
        .metric-card:hover, .agent-card:hover { transform: translateY(-2px); }
        .metric-card { padding: 24px; display: flex; align-items: center; gap: 18px; min-height: 120px; }
        .metric-icon {
            width: 64px; height: 64px;
            border-radius: 12px;
            display: grid; place-items: center;
            background: var(--k-yellow-100);
            color: var(--k-brown-700);
        }
        .agent-id-badge {
            display:inline-block; background:#FFF3CD; color:#856404;
            font-weight:600; border-radius:12px; padding:4px 10px; font-size:.85rem; margin-bottom:10px;
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
            margin-top: 2rem;
        }
        footer h6, footer h5 { color: #fff; }
        footer a { color: #fff; text-decoration: none; }
        footer a:hover { text-decoration: underline; }
        footer .border-top { border-color: #666 !important; }
    </style>
</head>
<body>

<!-- Offcanvas Sidebar (Mobile) — same links as Admin -->
<div class="offcanvas offcanvas-start offcanvas-yellow" tabindex="-1" id="mobileSidebar">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title fw-bold">Dashboard</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body">
        <nav class="nav flex-column">
            <a class="nav-link" href="productDashboard"><i class="bi bi-grid"></i> Product Dashboard</a>
            <a class="nav-link" href="#"><i class="bi bi-cart"></i> Orders</a>
            <a class="nav-link active" href="agentdashboard"><i class="bi bi-people"></i> Agents</a>
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
                                <a class="dropdown-item text-danger d-flex align-items-center gap-2"
                                   href="adminloginsuccessfully">
                                    <i class="bi bi-arrow-return-left"></i>
                                    Admin Dashboard
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


    <!-- Sidebar (Desktop) — same links as Admin -->
    <aside class="sidebar d-none d-lg-flex flex-column">
        <h5 class="fw-bold ps-3">Dashboard</h5>
        <nav class="nav flex-column mt-2">
            <a class="nav-link" href="productDashboard"><i class="bi bi-grid"></i> Product Dashboard</a>
            <a class="nav-link" href="#"><i class="bi bi-cart"></i> Orders</a>
            <a class="nav-link active" href="agentdashboard"><i class="bi bi-people"></i> Agents</a>
            <a class="nav-link" href="#"><i class="bi bi-person-lines-fill"></i> Customers</a>
            <a class="nav-link text-danger mt-auto" href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </nav>
    </aside>

    <!-- Main Content (Agent Dashboard features preserved) -->
    <main class="p-4">

        <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-3 gap-3">

                <h3 class="mb-1">Agent Management</h3>
            <%
            Integer visitCount = (Integer) session.getAttribute("visitCount");
            if (visitCount == null) {
            visitCount = 1;
            } else {
            visitCount++;
            }
            session.setAttribute("visitCount", visitCount);
            %>

            <div class="d-flex justify-content-end my-2">
    <span class="badge text-dark fs-6 px-3 py-2 shadow-sm" style="background-color: #f8d7da;">
        <i class="bi bi-eye-fill me-1"></i> Page visits: <strong><%= visitCount %></strong>
    </span>
            </div>



            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addAgentModal">
                <i class="bi bi-plus-lg me-1"></i> Add Agent
            </button>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty param.addSuccess}">
            <div class="alert alert-success alert-dismissible fade show mb-3" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Agent added successfully!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty param.updateSuccess}">
            <div class="alert alert-success alert-dismissible fade show mb-3" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Agent updated successfully!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty param.deleteSuccess}">
            <div class="alert alert-success alert-dismissible fade show mb-3" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Agent deleted successfully!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show mb-3" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i> Error: ${param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
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

        <!-- Agent Cards -->
        <div class="row row-cols-1 row-cols-md-2 row-cols-xl-3 g-3" id="agentContainer">
            <c:choose>
                <c:when test="${not empty agentsList}">
                    <c:forEach items="${agentsList}" var="agent">
                        <div class="col agent-item">
                            <div class="agent-card h-100">
                                <div class="agent-id-badge">ID: ${agent.agentId}</div>
                                <h5 class="mb-1">${agent.firstName} ${agent.lastName}</h5>
                                <p class="email mb-1"><strong>Email:</strong> ${agent.email}</p>
                                <p class="phone mb-1"><strong>Phone:</strong> ${agent.phoneNumber}</p>
                                <p class="address mb-1"><strong>Address:</strong> ${agent.address}</p>
                                <p class="typesOfMilk mb-2"><strong>Type of Milk:</strong>
                                    <c:choose>
                                        <c:when test="${not empty agent.typesOfMilk}">${agent.typesOfMilk}</c:when>
                                        <c:otherwise>N/A</c:otherwise>
                                    </c:choose>
                                </p>
                                <div class="d-flex gap-2 mt-auto">
                                    <button class="btn btn-sm btn-outline-primary w-50"
                                            data-bs-toggle="modal"
                                            data-bs-target="#editAgentModal"
                                            data-id="${agent.agentId}"
                                            data-firstname="${agent.firstName}"
                                            data-lastname="${agent.lastName}"
                                            data-email="${agent.email}"
                                            data-phone="${agent.phoneNumber}"
                                            data-address="${agent.address}"
                                            data-type="${agent.typesOfMilk}">
                                        <i class="bi bi-pencil"></i> Edit
                                    </button>
                                    <button class="btn btn-sm btn-outline-danger w-50"
                                            onclick="confirmDelete(${agent.agentId}, '${agent.firstName} ${agent.lastName}')">
                                        <i class="bi bi-trash"></i> Delete
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-4 text-muted">
                        No agents found. Click “Add Agent” to get started.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Pagination -->
        <div class="d-flex justify-content-center my-3">
            <nav aria-label="Agent pagination">
                <ul class="pagination mb-0" id="paginationContainer"></ul>
            </nav>
        </div>
    </main>
</div>

<!-- Add Agent Modal -->
<div class="modal fade" id="addAgentModal" tabindex="-1" aria-labelledby="addAgentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="addAgent" method="post" novalidate>
                <div class="modal-header">
                    <h5 class="modal-title" id="addAgentModalLabel">Add New Agent</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="firstName" class="form-label">First Name</label>
                        <input type="text" class="form-control" id="firstName" name="firstName" required>
                    </div>
                    <div class="mb-3">
                        <label for="lastName" class="form-label">Last Name</label>
                        <input type="text" class="form-control" id="lastName" name="lastName" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="phoneNumber" class="form-label">Phone Number</label>
                        <input type="text" class="form-control" id="phoneNumber" name="phoneNumber"
                               required pattern="^\d{10}$" maxlength="10" placeholder="Enter 10-digit phone number">
                        <div class="form-text">Phone number must be exactly 10 digits.</div>
                    </div>
                    <div class="mb-3">
                        <label for="address" class="form-label">Address</label>
                        <textarea class="form-control" id="address" name="address" rows="2" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="milkTypes" class="form-label">Type of Milk</label>
                        <select class="form-select" id="milkTypes" name="typesOfMilk" required>
                            <option value="" disabled selected>Select Milk Type</option>
                            <option value="COW">Cow Milk</option>
                            <option value="BUFFALO">Buffalo Milk</option>
                            <option value="GOAT">Goat Milk</option>
                            <option value="A2">A2 Milk</option>
                            <option value="ORGANIC">Organic Milk</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Add Agent</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Agent Modal -->
<div class="modal fade" id="editAgentModal" tabindex="-1" aria-labelledby="editAgentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="updateAgent" method="post" novalidate>
                <div class="modal-header">
                    <h5 class="modal-title" id="editAgentModalLabel">Edit Agent</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="editAgentId" name="agentId">
                    <div class="mb-3">
                        <label for="editFirstName" class="form-label">First Name</label>
                        <input type="text" class="form-control" id="editFirstName" name="firstName" required>
                    </div>
                    <div class="mb-3">
                        <label for="editLastName" class="form-label">Last Name</label>
                        <input type="text" class="form-control" id="editLastName" name="lastName" required>
                    </div>
                    <div class="mb-3">
                        <label for="editEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="editEmail" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="editPhoneNumber" class="form-label">Phone Number</label>
                        <input type="text" class="form-control" id="editPhoneNumber" name="phoneNumber"
                               required pattern="^\d{10}$" maxlength="10">
                    </div>
                    <div class="mb-3">
                        <label for="editAddress" class="form-label">Address</label>
                        <textarea class="form-control" id="editAddress" name="address" rows="2" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="editTypesOfMilk" class="form-label">Type of Milk</label>
                        <select class="form-select" id="editTypesOfMilk" name="typesOfMilk" required>
                            <option value="" disabled>Select Milk Type</option>
                            <option value="COW">Cow Milk</option>
                            <option value="BUFFALO">Buffalo Milk</option>
                            <option value="GOAT">Goat Milk</option>
                            <option value="A2">A2 Milk</option>
                            <option value="ORGANIC">Organic Milk</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Update Agent</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Footer (same as Admin) -->
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
<script>
    // Fill Edit Agent modal on open
    document.addEventListener('DOMContentLoaded', function () {
      var editAgentModal = document.getElementById('editAgentModal');
      if (editAgentModal) {
        editAgentModal.addEventListener('show.bs.modal', function (event) {
          var button = event.relatedTarget;
          document.getElementById('editAgentId').value = button.getAttribute('data-id') || '';
          document.getElementById('editFirstName').value = button.getAttribute('data-firstname') || '';
          document.getElementById('editLastName').value = button.getAttribute('data-lastname') || '';
          document.getElementById('editEmail').value = button.getAttribute('data-email') || '';
          document.getElementById('editPhoneNumber').value = button.getAttribute('data-phone') || '';
          document.getElementById('editAddress').value = button.getAttribute('data-address') || '';
          document.getElementById('editTypesOfMilk').value = button.getAttribute('data-type') || '';
        });
      }

      // Delete confirm
      window.confirmDelete = function (id, agentName) {
        if (confirm('Are you sure you want to delete ' + agentName + '?')) {
          window.location.href = 'deleteAgent?id=' + encodeURIComponent(id);
        }
      }

      // Filtering + Pagination (client-side)
      const rowsPerPage = 6;
      let currentPage = 1;
      const agentContainer = document.getElementById('agentContainer');
      const agentItems = Array.from(agentContainer.querySelectorAll('.agent-item'));
      let filteredItems = [...agentItems];
      const paginationContainer = document.getElementById('paginationContainer');
      const searchInput = document.getElementById('searchInput');
      const searchBtn = document.getElementById('searchBtn');

      function displayPage(page){
        const pageCount = Math.max(1, Math.ceil(filteredItems.length / rowsPerPage));
        currentPage = Math.min(Math.max(1, page), pageCount);
        const start = (currentPage - 1) * rowsPerPage;
        const end = start + rowsPerPage;

        agentItems.forEach(item => item.classList.add('d-none'));
        filteredItems.slice(start, end).forEach(item => item.classList.remove('d-none'));

        renderPagination();
      }

      function renderPagination(){
        const pageCount = Math.ceil(filteredItems.length / rowsPerPage);
        paginationContainer.innerHTML = '';
        if (pageCount <= 1){ return; }

        function addItem(label, disabled, onClick, ariaLabel){
          const li = document.createElement('li');
          li.className = 'page-item' + (disabled ? ' disabled' : '');
          const a = document.createElement('a');
          a.className = 'page-link';
          a.href = 'javascript:void(0)';
          a.innerHTML = label;
          if (ariaLabel) a.setAttribute('aria-label', ariaLabel);
          if (!disabled) a.addEventListener('click', onClick);
          li.appendChild(a);
          paginationContainer.appendChild(li);
        }

        addItem('&laquo;', currentPage === 1, () => displayPage(currentPage-1), 'Previous');

        let startPage = Math.max(1, currentPage - 2);
        let endPage = Math.min(pageCount, startPage + 4);
        if (startPage > 1){
          addItem('1', false, () => displayPage(1));
          if (startPage > 2){
            const dots = document.createElement('li');
            dots.className = 'page-item disabled';
            dots.innerHTML = '<span class="page-link">...</span>';
            paginationContainer.appendChild(dots);
          }
        }

        for (let i=startPage;i<=endPage;i++){
          const li = document.createElement('li');
          li.className = 'page-item' + (i === currentPage ? ' active' : '');
          const a = document.createElement('a');
          a.className = 'page-link';
          a.href = 'javascript:void(0)';
          a.textContent = i;
          a.addEventListener('click', () => displayPage(i));
          li.appendChild(a);
          paginationContainer.appendChild(li);
        }

        if (endPage < pageCount){
          if (endPage < pageCount - 1){
            const dots = document.createElement('li');
            dots.className = 'page-item disabled';
            dots.innerHTML = '<span class="page-link">...</span>';
            paginationContainer.appendChild(dots);
          }
          addItem(String(pageCount), false, () => displayPage(pageCount));
        }

        addItem('&raquo;', currentPage === pageCount, () => displayPage(currentPage+1), 'Next');
      }

      function normalize(text){ return (text || '').toString().trim().toLowerCase(); }

      function filterAgents(){
        const filter = normalize(searchInput.value);
        filteredItems = agentItems.filter(function(agent){
          if (!filter) return true;

          const id = normalize((agent.querySelector('.agent-id-badge')?.textContent || '').replace(/^\s*ID:\s*/i,''));
          const name = normalize(agent.querySelector('h5')?.textContent);
          const email = normalize((agent.querySelector('p.email')?.textContent || '').replace(/^\s*Email:\s*/i,''));
          const phone = normalize((agent.querySelector('p.phone')?.textContent || '').replace(/^\s*Phone:\s*/i,''));
          const address = normalize((agent.querySelector('p.address')?.textContent || '').replace(/^\s*Address:\s*/i,''));
          const types = normalize((agent.querySelector('p.typesOfMilk')?.textContent || '').replace(/^\s*Type of Milk:\s*/i,''));

          return id.includes(filter) || name.includes(filter) || email.includes(filter) ||
                 phone.includes(filter) || address.includes(filter) || types.includes(filter);
        });

        displayPage(1);
      }

      searchBtn?.addEventListener('click', filterAgents);
      searchInput?.addEventListener('keyup', filterAgents);

      // Initial paint
      displayPage(1);
    });
</script>
</body>
</html>
