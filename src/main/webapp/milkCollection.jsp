<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <title>Milk Collection - Kamadhenu Milk Products</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet"/>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>

    <!-- External CSS -->
    <link href="CSS/styles.css" rel="stylesheet"/>


    <!-- jsQR for image decoding (used for uploaded QR images) -->
    <script src="https://cdn.jsdelivr.net/npm/jsqr@1.4.0/dist/jsQR.js"></script>

    <!-- Kamadhenu Theme CSS (merged with product-collection look) -->
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
        body { min-height: 100vh; display:flex; flex-direction:column; background:#faf9f4; font-family:Arial,Helvetica,sans-serif; }
        .main-wrapper { flex:1 0 auto; display:grid; grid-template-columns:260px 1fr; grid-template-rows:auto 1fr; grid-template-areas: "nav nav" "sidebar main"; }
        .custom-navbar { grid-area: nav; position:sticky; top:0; z-index:1030; background:#ffffff; border-bottom:1px solid #eee5bf; }
        .sidebar { grid-area: sidebar; background:var(--k-yellow-50); border-right:1px solid var(--k-yellow-400); position:sticky; top:64px; height:calc(100vh - 64px); padding-top:1rem; padding-bottom:1rem; overflow-y:auto; }
        .sidebar h5 { color:var(--k-brown-700); padding-left:1rem; }
        .sidebar .nav-link { color:var(--k-brown-700); padding:10px 16px; border-radius:8px; margin:0 10px 8px 10px; transition:0.2s; font-weight:500; display:flex; align-items:center; gap:.5rem; }
        .sidebar .nav-link:hover { background:var(--k-yellow-200); color:var(--k-brown-800); }
        .sidebar .nav-link.active { background:var(--k-yellow-300); color:var(--k-brown-900); box-shadow: inset 2px 0 0 #C9A227; }
        .k-card { background:#fff; border:1px solid #f2e6b3; border-radius:16px; padding:20px; box-shadow:0 3px 14px rgba(0,0,0,0.06); }
        .btn-primary { background-color:var(--k-yellow-300); border-color:var(--k-yellow-400); color:var(--k-brown-900); font-weight:bold; }
        .btn-primary:hover { background-color:var(--k-yellow-200); color:var(--k-brown-800); border-color:var(--k-yellow-300); }
        .btn-outline-secondary { border-color:var(--k-brown-700); color:var(--k-brown-700); }
        .btn-outline-secondary:hover { background:var(--k-yellow-100); color:var(--k-brown-900); }
        table thead { background:var(--k-yellow-200); color:var(--k-brown-900); }
        table tbody tr:hover { background:var(--k-yellow-50); }
        footer { background:#1f1f1f; color:#fff; padding:25px 0 20px; }
        .form-help { font-size:.85rem; color:#6c757d; margin-top:.25rem; }
        .spinner-xs { width:1rem; height:1rem; border-width:.15em; }
        #qr-reader { width:100%; min-height:320px; background:#000; display:flex; align-items:center; justify-content:center; color:#fff; }
        .qr-modal .modal-dialog { max-width:820px; }
        .file-scan-input { display:none; }
        .camera-select { min-width:200px; }
        .input-group .btn { border-left:0; }
        .navbar-brand img { height:50px; object-fit:cover; margin-right:.75rem; }
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
                        <a class="nav-link dropdown-toggle d-flex align-items-center"
                           href="#" id="adminDropdown"
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">

                            <img src="images/adminprofile.jpg" class="rounded-circle me-1"
                                 style="height:32px;width:32px;object-fit:cover;">

                            <span>${sessionScope.adminDTO != null ? sessionScope.adminDTO.adminName : 'Admin'}</span>
                        </a>

                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="adminDropdown">
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

    <!-- SIDEBAR -->
    <aside class="sidebar d-none d-lg-flex flex-column">
        <h5 class="fw-bold">Dashboard</h5>
        <nav class="nav flex-column">
            <a class="nav-link" href="productDashboard"><i class="bi bi-grid"></i> Product Dashboard</a>
            <a class="nav-link" href="#"><i class="bi bi-cart"></i> Orders</a>
            <a class="nav-link" href="agentdashboard"><i class="bi bi-people"></i> Agents</a>
            <a class="nav-link" href="#"><i class="bi bi-person-lines-fill"></i> Customers</a>
            <a class="nav-link active" href="milkCollection"><i class="bi bi-droplet"></i> Milk Collection</a>
            <a class="nav-link" href="viewCollection"><i class="bi bi-collection"></i> View Collections</a>
            <a class="nav-link" href="paymentDetails"><i class="bi bi-credit-card"></i> Payment Details</a>
            <a class="nav-link text-danger mt-auto" href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </nav>
    </aside>

    <!-- MAIN CONTENT -->
    <main class="p-4" role="main" style="grid-area: main;">
        <div class="d-flex align-items-center justify-content-between mb-3">
            <div>
                <h3 class="fw-bold mb-0">Milk Collection</h3>
                <div class="text-muted">Capture collected milk details from agents.</div>
            </div>
            <div>
                <a href="milkCollection" class="btn btn-outline-secondary btn-sm"><i class="fa-solid fa-rotate-right me-1"></i> Refresh</a>
            </div>
        </div>

        <!-- Alerts -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>

        <!-- FORM CARD -->
        <div class="k-card mb-4">
            <form id="mcForm" action="saveProductCollection" method="post" novalidate>
                <!-- Hidden PK + agentId -->
                <input type="hidden" name="productCollectionId" value="${productCollection.productCollectionId}" />
                <input type="hidden" id="agentId" name="agentId" value="${productCollection.agent != null ? productCollection.agent.agentId : ''}" />

                <div class="row g-3">
                    <!-- Admin -->
                    <div class="col-md-4">
                        <label class="form-label">Admin</label>
                        <input type="text" class="form-control" value="${sessionScope.adminDTO != null ? sessionScope.adminDTO.adminName : ''}" readonly>
                        <input type="hidden" name="adminId" value="${sessionScope.adminDTO != null ? sessionScope.adminDTO.adminId : ''}">
                        <div class="form-help">Auto-filled from logged-in admin</div>
                    </div>

                    <!-- Phone Number + lookup + QR -->
                    <div class="col-md-4">
                        <label for="phoneNumber" class="form-label">Phone Number</label>
                        <div class="input-group">
                            <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber"
                                   value="${productCollection.phoneNumber}"
                                   pattern="^(?:\\+?91[-\\s]?|0)?[6-9]\\d{9}$"
                                   placeholder="e.g. 9876543210 or +91 98765 43210" required>
                            <button class="btn btn-outline-secondary" type="button" id="lookupBtn" title="Lookup by phone">
                                <span class="default-text"><i class="fa-solid fa-magnifying-glass"></i></span>
                                <span class="loading d-none"><span class="spinner-border spinner-xs" role="status" aria-hidden="true"></span></span>
                            </button>
                            <button class="btn btn-outline-primary" type="button" id="scanQrBtn" title="Scan Agent QR">
                                <i class="fa-solid fa-qrcode"></i>
                            </button>
                        </div>
                        <div class="invalid-feedback">Enter a valid Indian mobile (10 digits; +91/0 allowed).</div>
                        <div id="lookupMsg" class="form-help"></div>
                    </div>

                    <!-- Agent Name (DTO-only) -->
                    <div class="col-md-4">
                        <label for="name" class="form-label">Agent Name</label>
                        <input type="text" class="form-control" id="name" name="name" value="${productCollection.name}" readonly>
                        <div class="form-help">Auto-filled from phone number or QR scan. Not stored in entity.</div>
                    </div>

                    <!-- Agent Email (DTO-only) -->
                    <div class="col-md-4">
                        <label for="email" class="form-label">Agent Email</label>
                        <input type="email" class="form-control" id="email" name="email" value="${productCollection.email}" readonly>
                        <div class="form-help">Auto-filled from phone number or QR scan. Not stored in entity.</div>
                    </div>

                    <!-- Type of Milk (from backend products) -->
                    <div class="col-md-4">
                        <label for="typeOfMilk" class="form-label">Type of Milk</label>
                        <select class="form-select" id="typeOfMilk" name="typeOfMilk" required>
                            <option value="" disabled <c:if test="${empty productCollection.typeOfMilk}">selected</c:if>>Select type...</option>
                            <c:forEach items="${products}" var="p">
                                <option value="${p.productName}" data-price="${p.productPrice}" <c:if test="${productCollection.typeOfMilk == p.productName}">selected</c:if>>
                                ${p.productName} — ₹${p.productPrice}
                                </option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Please select a milk type.</div>
                    </div>

                    <!-- Price (auto from selected product) -->
                    <div class="col-md-4">
                        <label for="price" class="form-label">Unit Price (₹/L)</label>
                        <input type="number" step="0.01" min="0" class="form-control" id="price" name="price" value="${productCollection.price}" readonly>
                        <div class="form-help">Auto-filled from selected product.</div>
                    </div>

                    <!-- Quantity -->
                    <div class="col-md-4">
                        <label for="quantity" class="form-label">Quantity (L)</label>
                        <input type="number" step="0.001" min="0.001" class="form-control" id="quantity" name="quantity" value="${productCollection.quantity}" required>
                        <div class="invalid-feedback">Enter a valid quantity.</div>
                    </div>

                    <!-- Total Amount -->
                    <div class="col-md-4">
                        <label for="totalAmount" class="form-label">Total Amount (₹)</label>
                        <input type="number" step="0.01" min="0" class="form-control" id="totalAmount" name="totalAmount" value="${productCollection.totalAmount}" readonly>
                        <div class="form-help">Auto-calculated as Price × Quantity</div>
                    </div>
                </div>

                <div class="mt-4 d-flex gap-2">
                    <button type="submit" class="btn btn-success"><i class="fa-solid fa-floppy-disk me-1"></i> Save</button>
                    <button type="reset" class="btn btn-outline-secondary"><i class="fa-solid fa-eraser me-1"></i> Reset</button>
                    <a href="productCollectionList" class="btn btn-outline-primary"><i class="fa-solid fa-table-list me-1"></i> View Collections</a>
                </div>
            </form>
        </div>

        <!-- RECENT COLLECTIONS -->
        <c:if test="${not empty recentCollections}">
            <div class="k-card">
                <h5 class="fw-bold mb-3">Recent Collections</h5>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                        <tr>
                            <th>#ID</th>
                            <th>Agent</th>
                            <th>Milk Type</th>
                            <th class="text-end">Price (₹/L)</th>
                            <th class="text-end">Qty (L)</th>
                            <th class="text-end">Total (₹)</th>
                            <th>Collected At</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${recentCollections}" var="pc">
                            <tr>
                                <td>${pc.productCollectionId}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${pc.agent != null}">
                                            ${pc.agent.firstName} ${pc.agent.lastName}
                                        </c:when>
                                        <c:otherwise>—</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${pc.typeOfMilk}</td>
                                <td class="text-end">${pc.price}</td>
                                <td class="text-end">${pc.quantity}</td>
                                <td class="text-end fw-semibold">${pc.totalAmount}</td>
                                <td>${pc.collectedAt}</td>
                                <td class="text-end">
                                    <a href="productCollection/view?id=${pc.productCollectionId}" class="btn btn-sm btn-outline-secondary">
                                        <i class="fa-regular fa-eye"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>

    </main>
</div>

<!-- QR Scanner Modal -->
<div class="modal fade qr-modal" id="qrModal" tabindex="-1" aria-labelledby="qrModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header d-flex align-items-center gap-2">
                <h5 class="modal-title">Scan Agent QR</h5>
                <select id="cameraSelect" class="form-select camera-select ms-3" style="width:auto;">
                    <option value="">Detecting cameras...</option>
                </select>
                <button type="button" class="btn-close ms-auto" data-bs-dismiss="modal" aria-label="Close" id="closeScannerBtn"></button>
            </div>
            <div class="modal-body">
                <div id="qr-reader" class="w-100">Please allow camera access to scan QR.</div>

                <!-- hidden canvas used for image decoding -->
                <canvas id="qr-canvas" style="display:none;"></canvas>

                <div class="mt-3 text-center">
                    <small class="text-muted">If your camera isn't supported, upload a QR image instead.</small>
                    <div class="mt-2">
                        <input type="file" accept="image/*" id="qrFileInput" class="file-scan-input">
                        <button class="btn btn-sm btn-outline-secondary" id="uploadQrBtn"><i class="fa-solid fa-image me-1"></i> Scan from image</button>
                    </div>
                </div>
                <div id="qrStatus" class="mt-2"></div>
            </div>
        </div>
    </div>
</div>

<!-- FOOTER -->
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

<!-- JS: Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- JavaScript: form behavior, lookup, QR scanning, price/total calculation -->
<script>
    // --- Basic form validation + normalize phone before submit
    (function () {
        const form = document.getElementById('mcForm');
        const phoneEl = document.getElementById('phoneNumber');

        form.addEventListener('submit', function (event) {
            phoneEl.value = normalizeIndianPhone(phoneEl.value);
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    })();

    // --- Helpers for phone normalization/validation
    function normalizeIndianPhone(raw) {
        if (!raw) return '';
        const digits = raw.replace(/\D+/g, '');
        return digits.length >= 10 ? digits.slice(-10) : digits;
    }
    function isValidIndianPhone(raw) {
        return /^[6-9]\d{9}$/.test(normalizeIndianPhone(raw));
    }

    // --- Price & total calculation
    const priceEl = document.getElementById('price');
    const qtyEl = document.getElementById('quantity');
    const totalEl = document.getElementById('totalAmount');
    const typeEl  = document.getElementById('typeOfMilk');

    function calcTotal() {
        const p = parseFloat(priceEl.value);
        const q = parseFloat(qtyEl.value);
        totalEl.value = (!isNaN(p) && !isNaN(q)) ? (p * q).toFixed(2) : '';
    }
    function setPriceFromType() {
        const opt = typeEl?.options[typeEl.selectedIndex];
        if (!opt) return;
        const price = opt.getAttribute('data-price');
        priceEl.value = (price !== null && price !== '') ? parseFloat(price).toFixed(2) : '';
        calcTotal();
    }
    typeEl && typeEl.addEventListener('change', setPriceFromType);
    qtyEl && qtyEl.addEventListener('input', calcTotal);
    window.addEventListener('DOMContentLoaded', function () { setPriceFromType(); calcTotal(); });

    // --- Agent lookup by phone number
    (function agentLookupInit() {
        const phoneEl  = document.getElementById('phoneNumber');
        const nameEl   = document.getElementById('name');
        const emailEl  = document.getElementById('email');
        const agentIdEl = document.getElementById('agentId');
        const lookupBtn = document.getElementById('lookupBtn');
        const msgEl     = document.getElementById('lookupMsg');
        const url       = '<c:url value="/productCollection/getAgentByPhoneNumber"/>';

        const showLoading = (loading) => {
            const def = lookupBtn.querySelector('.default-text');
            const spn = lookupBtn.querySelector('.loading');
            if (loading) { def.classList.add('d-none'); spn.classList.remove('d-none'); }
            else { spn.classList.add('d-none'); def.classList.remove('d-none'); }
        };
        const setMsg = (text, type='muted') => {
            msgEl.className = 'form-help text-' + type;
            msgEl.textContent = text || '';
        };
        const clearAgentFields = () => {
            agentIdEl.value = '';
            nameEl.value = '';
            emailEl.value = '';
        };
        const fillAgent = (dto) => {
            agentIdEl.value = dto.agentId ?? '';
            const first = (dto.firstName || '').trim();
            const last  = (dto.lastName || '').trim();
            nameEl.value = (first + ' ' + last).trim();
            emailEl.value = dto.email || '';
        };

        async function lookup() {
            setMsg('', 'muted');
            clearAgentFields();
            const normalized = normalizeIndianPhone(phoneEl.value);

            if (!/^[6-9]\d{9}$/.test(normalized)) {
                setMsg('Enter a valid Indian mobile (10 digits; +91/0 allowed).', 'danger');
                return;
            }

            try {
                showLoading(true);
                const resp = await fetch(url + '?phoneNumber=' + encodeURIComponent(normalized), {
                    headers: {'Accept': 'application/json'}
                });
                if (resp.ok) {
                    const dto = await resp.json();
                    if (dto && dto.agentId) {
                        fillAgent(dto);
                        phoneEl.value = normalized;
                        setMsg('Agent found and filled.', 'success');
                    } else {
                        setMsg('No agent data returned.', 'warning');
                    }
                } else if (resp.status === 404) {
                    setMsg('Agent not found for this phone number.', 'danger');
                } else {
                    setMsg('Lookup failed. Try again.', 'danger');
                }
            } catch (e) {
                setMsg('Network error during lookup.', 'danger');
            } finally {
                showLoading(false);
            }
        }

        // Debounce typing
        let t;
        phoneEl && phoneEl.addEventListener('input', function () {
            clearTimeout(t);
            t = setTimeout(lookup, 400);
        });
        // Manual click
        lookupBtn && lookupBtn.addEventListener('click', lookup);
        // Prefill if phone already present
        window.addEventListener('DOMContentLoaded', function () {
            if (isValidIndianPhone(phoneEl.value)) lookup();
        });
    })();

    /**************************************************************************
     * QR scanner integration: try to load html5-qrcode and fall back to
     * native getUserMedia + jsQR for live scanning; also support image uploads.
     **************************************************************************/
    (function qrScannerInit() {
        const scanBtn = document.getElementById('scanQrBtn');
        const modalEl = document.getElementById('qrModal');
        const qrStatus = document.getElementById('qrStatus');
        const qrFileInput = document.getElementById('qrFileInput');
        const uploadQrBtn = document.getElementById('uploadQrBtn');
        const closeScannerBtn = document.getElementById('closeScannerBtn');
        const cameraSelect = document.getElementById('cameraSelect');
        const qrReaderDiv = document.getElementById('qr-reader');

        const HTML5_QR_VERSION = '2.3.8';
        const HTML5_QR_LIB_SOURCES = [
            '<c:url value="/js/vendor/html5-qrcode.min.js"/>',
            'https://cdn.jsdelivr.net/npm/html5-qrcode@' + HTML5_QR_VERSION + '/html5-qrcode.min.js',
            'https://cdnjs.cloudflare.com/ajax/libs/html5-qrcode/' + HTML5_QR_VERSION + '/html5-qrcode.min.js',
            'https://unpkg.com/html5-qrcode'
        ];

        let libLoadPromise = null;
        function loadScript(url) {
            return new Promise((resolve, reject) => {
                const s = document.createElement('script');
                s.src = url;
                s.async = true;
                s.crossOrigin = 'anonymous';
                s.onload = resolve;
                s.onerror = () => reject(new Error('Failed to load script: ' + url));
                document.head.appendChild(s);
            });
        }
        async function ensureHtml5QrLoaded() {
            if (window.Html5Qrcode) return;
            if (libLoadPromise) return libLoadPromise;
            libLoadPromise = (async () => {
                let lastErr;
                for (const url of HTML5_QR_LIB_SOURCES) {
                    try {
                        await loadScript(url);
                        if (window.Html5Qrcode) return Promise.resolve();
                        lastErr = new Error('Global Html5Qrcode not found after loading ' + url);
                    } catch (e) {
                        lastErr = e;
                    }
                }
                throw lastErr || new Error('html5-qrcode failed to load from all sources');
            })();
            return libLoadPromise;
        }

        let html5Qr = null;
        let currentCameraId = null;
        let nativeStream = null;
        let nativeRafId = null;
        let usingNativeFallback = false;

        const modal = new bootstrap.Modal(modalEl, {keyboard: true});

        scanBtn && scanBtn.addEventListener('click', function () {
            qrReaderDiv.innerHTML = 'Please allow camera access to scan QR.';
            qrStatus.innerHTML = '<small class="text-muted">Detecting cameras...</small>';
            cameraSelect.disabled = false;
            cameraSelect.innerHTML = '<option value="">Detecting cameras...</option>';

            if (!window.isSecureContext && !/^localhost$|^127(\.0){3}$/.test(location.hostname)) {
                qrStatus.innerHTML = '<div class="text-warning">Tip: Cameras require HTTPS or localhost.</div>';
            }

            modal.show();

            ensureHtml5QrLoaded()
                .then(() => {
                    usingNativeFallback = false;
                    initCamerasAndStart();
                })
                .catch(err => {
                    console.warn('html5-qrcode could not be loaded, falling back to native scanner', err);
                    usingNativeFallback = true;
                    cameraSelect.innerHTML = '<option value="">Default camera</option>';
                    cameraSelect.disabled = true;
                    startNativeScanner();
                });
        });

        modalEl.addEventListener('hidden.bs.modal', function () {
            stopScanner();
            stopNativeScanner();
            cameraSelect.innerHTML = '<option value="">Detecting cameras...</option>';
            cameraSelect.disabled = false;
            qrStatus.innerHTML = '';
            qrFileInput.value = '';
        });

        closeScannerBtn.addEventListener('click', function () { modal.hide(); });

        uploadQrBtn.addEventListener('click', function () { qrFileInput.click(); });

        qrFileInput.addEventListener('change', function (e) {
            const file = e.target.files && e.target.files[0];
            if (!file) return;
            qrStatus.innerHTML = '<small class="text-muted">Scanning uploaded image...</small>';
            scanImageFile(file)
                .then(decodedText => {
                    if (decodedText) {
                        handleScanSuccess(decodedText);
                    } else {
                        qrStatus.innerHTML = '<div class="text-danger">No QR code found in the image.</div>';
                    }
                })
                .catch(err => {
                    console.error('scanImageFile error', err);
                    qrStatus.innerHTML = '<div class="text-danger">Failed to scan image: ' + (err.message || '') + '</div>';
                })
                .finally(() => { qrFileInput.value = ''; });
        });

        cameraSelect.addEventListener('change', function () {
            if (usingNativeFallback) return;
            const id = cameraSelect.value;
            if (!id) return;
            if (id === currentCameraId) return;
            startScannerWithCamera(id);
        });

        // init cameras and start (html5-qrcode path)
        async function initCamerasAndStart() {
            try {
                if (!window.Html5Qrcode || !Html5Qrcode.getCameras) {
                    throw new Error('Html5Qrcode library not available');
                }
                const devices = await Html5Qrcode.getCameras();
                cameraSelect.innerHTML = '';
                if (!devices || devices.length === 0) {
                    cameraSelect.innerHTML = '<option value="">No camera found</option>';
                    qrStatus.innerHTML = '<div class="text-danger">No camera detected. Use "Scan from image" instead.</div>';
                    return;
                }
                devices.forEach((cam, idx) => {
                    const opt = document.createElement('option');
                    opt.value = cam.id;
                    opt.text = cam.label || ('Camera ' + (idx + 1));
                    cameraSelect.appendChild(opt);
                });
                let preferred = devices[0].id;
                for (const d of devices) {
                    if (/back|rear|environment|camera 1/i.test(d.label)) { preferred = d.id; break; }
                }
                cameraSelect.value = preferred;
                startScannerWithCamera(preferred);
            } catch (err) {
                console.error('getCameras error', err);
                cameraSelect.innerHTML = '<option value="">Camera access failed</option>';
                qrStatus.innerHTML = '<div class="text-danger">Unable to access cameras. Give permission or use image upload.</div>';
            }
        }

        function startScannerWithCamera(cameraId) {
            stopScanner();
            currentCameraId = cameraId;
            qrStatus.innerHTML = '<small class="text-muted">Starting camera...</small>';
            try {
                html5Qr = new Html5Qrcode("qr-reader", { verbose: false });
            } catch (e) {
                console.error('Html5Qrcode constructor error', e);
                qrStatus.innerHTML = '<div class="text-danger">Camera init failed.</div>';
                return;
            }
            const config = { fps: 10, qrbox: { width: 280, height: 280 }, experimentalFeatures: { useBarCodeDetectorIfSupported: true } };
            html5Qr.start(
                cameraId,
                config,
                (decodedText, decodedResult) => {
                    qrStatus.innerHTML = '<div class="text-success"><i class="fa-solid fa-circle-check me-1"></i> QR scanned</div>';
                    stopScanner();
                    handleScanSuccess(decodedText);
                },
                (errorMessage) => { /* per-frame errors ignored */ }
            ).then(() => {
                qrStatus.innerHTML = '<div class="text-success">Camera started. Point to a QR code.</div>';
            }).catch(err => {
                console.error('html5Qr.start error', err);
                qrStatus.innerHTML = '<div class="text-danger">Camera start failed: ' + (err.message || err) + '</div>';
            });
        }

        function stopScanner() {
            if (html5Qr) {
                try { html5Qr.stop().then(()=> html5Qr.clear()).catch(()=>{}); } catch (e) {}
                html5Qr = null;
            }
            currentCameraId = null;
            const qrReader = document.getElementById('qr-reader');
            if (qrReader) { qrReader.innerHTML = 'Please allow camera access to scan QR.'; }
        }

        // Native fallback (getUserMedia + jsQR)
        function startNativeScanner() {
            stopNativeScanner();
            if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
                qrStatus.innerHTML = '<div class="text-danger">Camera not supported in this browser.</div>';
                return;
            }
            qrReaderDiv.innerHTML = '<video id="qr-video" autoplay muted playsinline style="width:100%;max-height:420px;background:#000"></video>';
            const video = document.getElementById('qr-video');
            navigator.mediaDevices.getUserMedia({ video: { facingMode: { ideal: 'environment' } } })
                .then(stream => {
                    nativeStream = stream;
                    video.srcObject = stream;
                    qrStatus.innerHTML = '<div class="text-success">Camera started. Point to a QR code.</div>';
                    tick();
                })
                .catch(err => { qrStatus.innerHTML = '<div class="text-danger">Camera start failed: ' + (err.message || err) + '</div>'; });

            function tick() {
                const canvas = document.getElementById('qr-canvas');
                const ctx = canvas.getContext('2d');
                if (!video || video.readyState !== video.HAVE_ENOUGH_DATA) {
                    nativeRafId = requestAnimationFrame(tick);
                    return;
                }
                canvas.width = video.videoWidth;
                canvas.height = video.videoHeight;
                ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
                const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
                const code = jsQR(imageData.data, imageData.width, imageData.height, { inversionAttempts: 'attemptBoth' });
                if (code && code.data) {
                    stopNativeScanner();
                    handleScanSuccess(code.data);
                    setTimeout(() => modal.hide(), 300);
                    return;
                }
                nativeRafId = requestAnimationFrame(tick);
            }
        }

        function stopNativeScanner() {
            if (nativeRafId) cancelAnimationFrame(nativeRafId);
            nativeRafId = null;
            if (nativeStream) nativeStream.getTracks().forEach(t => t.stop());
            nativeStream = null;
        }

        // parse minimal vCard fields we need (FN, TEL, EMAIL)
        function parseVCard(vcardText) {
            const raw = vcardText.replace(/\r\n/g, '\n').replace(/\r/g, '\n');
            const lines = raw.split('\n');
            const result = {};
            for (let i=0;i<lines.length;i++) {
                let line = lines[i].trim();
                if (!line) continue;
                while (i < lines.length - 1 && /^[ \t]/.test(lines[i+1])) {
                    line += lines[i+1].trim();
                    i++;
                }
                if (/^TEL/i.test(line)) {
                    const parts = line.split(':');
                    if (parts.length >= 2) result.tel = parts.slice(1).join(':').replace(/[^+\d]/g,'');
                } else if (/^FN:/i.test(line)) {
                    result.fn = line.substring(line.indexOf(':')+1).trim();
                } else if (/^EMAIL/i.test(line)) {
                    const parts = line.split(':');
                    if (parts.length >= 2) result.email = parts.slice(1).join(':').trim();
                } else if (/^N:/i.test(line) && !result.fn) {
                    const val = line.substring(line.indexOf(':')+1).trim();
                    const parts = val.split(';');
                    const first = (parts[1] || '').trim();
                    const last  = (parts[0] || '').trim();
                    const fullname = (first + ' ' + last).trim();
                    if (fullname) result.fn = fullname;
                }
            }
            return result;
        }

        // handle decoded QR text
        function handleScanSuccess(text) {
            const phoneEl  = document.getElementById('phoneNumber');
            const nameEl   = document.getElementById('name');
            const emailEl  = document.getElementById('email');
            const agentIdEl = document.getElementById('agentId');
            const lookupMsg = document.getElementById('lookupMsg');

            if (/BEGIN:VCARD/i.test(text)) {
                const v = parseVCard(text);
                if (v.tel) phoneEl.value = normalizeIndianPhone(v.tel);
                if (v.fn) nameEl.value = v.fn;
                if (v.email) emailEl.value = v.email;
                agentIdEl.value = '';

                if (phoneEl.value && /^[6-9]\d{9}$/.test(phoneEl.value)) {
                    lookupByPhoneAfterScan(phoneEl.value);
                } else {
                    lookupMsg.className = 'form-help text-warning';
                    lookupMsg.textContent = 'Scanned contact filled. If phone is invalid for this region, adjust manually.';
                }
                setTimeout(()=> modal.hide(), 700);
                return;
            }

            const onlyDigits = text.replace(/\D/g,'');
            if (onlyDigits.length >= 10) {
                const last10 = onlyDigits.slice(-10);
                document.getElementById('phoneNumber').value = last10;
                lookupByPhoneAfterScan(last10);
                setTimeout(()=> modal.hide(), 500);
                return;
            }

            qrStatus.innerHTML = '<div class="text-danger">Scanned QR content not recognized. Supported: vCard or phone number.</div>';
        }

        function lookupByPhoneAfterScan(phone) {
            const url = '<c:url value="/productCollection/getAgentByPhoneNumber"/>';
            const phoneEl = document.getElementById('phoneNumber');
            const nameEl = document.getElementById('name');
            const emailEl = document.getElementById('email');
            const agentIdEl = document.getElementById('agentId');
            const lookupMsg = document.getElementById('lookupMsg');

            fetch(url + '?phoneNumber=' + encodeURIComponent(phone), { headers: {'Accept':'application/json'} })
                .then(resp => {
                    if (resp.ok) return resp.json();
                    if (resp.status === 404) throw new Error('notfound');
                    throw new Error('lookup failed');
                })
                .then(dto => {
                    if (dto && dto.agentId) {
                        agentIdEl.value = dto.agentId;
                        nameEl.value = (dto.firstName || '') + (dto.lastName ? (' ' + dto.lastName) : '');
                        emailEl.value = dto.email || emailEl.value;
                        lookupMsg.className = 'form-help text-success';
                        lookupMsg.textContent = 'Agent found and filled from server.';
                    } else {
                        lookupMsg.className = 'form-help text-warning';
                        lookupMsg.textContent = 'No agent record found for this phone. Filled contact only.';
                    }
                })
                .catch(err => {
                    if (err.message === 'notfound') {
                        lookupMsg.className = 'form-help text-warning';
                        lookupMsg.textContent = 'No agent record found for this phone. Filled contact only.';
                    } else {
                        lookupMsg.className = 'form-help text-danger';
                        lookupMsg.textContent = 'Server lookup failed. Contact filled locally.';
                    }
                });
        }

        // scan uploaded image using jsQR
        function scanImageFile(file) {
            return new Promise((resolve, reject) => {
                if (!file.type.match(/^image\//)) { return reject(new Error('Selected file is not an image')); }
                const reader = new FileReader();
                reader.onerror = () => reject(new Error('Failed to read file'));
                reader.onload = () => {
                    const img = new Image();
                    img.onerror = () => reject(new Error('Invalid image file'));
                    img.onload = () => {
                        try {
                            const canvas = document.getElementById('qr-canvas');
                            const ctx = canvas.getContext('2d');
                            const maxDim = 1200;
                            let w = img.naturalWidth; let h = img.naturalHeight;
                            const scale = Math.min(1, maxDim / Math.max(w, h));
                            w = Math.floor(w * scale); h = Math.floor(h * scale);
                            canvas.width = w; canvas.height = h;
                            ctx.clearRect(0, 0, w, h);
                            ctx.drawImage(img, 0, 0, w, h);
                            const imageData = ctx.getImageData(0, 0, w, h);
                            const code = jsQR(imageData.data, imageData.width, imageData.height, { inversionAttempts: "attemptBoth" });
                            if (code && code.data) resolve(code.data);
                            else resolve(null);
                        } catch (ex) { reject(ex); }
                    };
                    img.src = reader.result;
                };
                reader.readAsDataURL(file);
            });
        }

    })();
</script>
</body>
</html>
