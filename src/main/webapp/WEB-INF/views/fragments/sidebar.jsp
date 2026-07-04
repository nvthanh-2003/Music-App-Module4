<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="d-flex flex-column flex-shrink-0 p-3 text-white bg-dark h-100">
    <a href="${pageContext.request.contextPath}/home" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
        <i class="fa-solid fa-music fa-2x me-2 text-success"></i>
        <span class="fs-4 fw-bold">VibeStream</span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/home" class="nav-link text-white active">
                <i class="fa-solid fa-house me-2"></i> Trang Chủ
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/genres" class="nav-link text-white">
                <i class="fa-solid fa-compact-disc me-2"></i> Thể Loại
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/playlist" class="nav-link text-white">
                <i class="fa-solid fa-list me-2"></i> Playlist Của Tôi
            </a>
        </li>
    </ul>
    <hr>
    <div class="dropdown">
        <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
            <strong>${not empty sessionScope.currentUser ? sessionScope.currentUser.username : 'Khách'}</strong>
        </a>
        <ul class="dropdown-menu dropdown-menu-dark text-small shadow" aria-labelledby="dropdownUser1">
            <c:if class="${sessionScope.currentUser.role == 'ROLE_ADMIN'}">
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin">Quản lý nhạc (Admin)</a></li>
            </c:if>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
        </ul>
    </div>
</div>