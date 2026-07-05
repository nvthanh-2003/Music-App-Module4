<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="currentUri" value="${pageContext.request.requestURI}" />
<div class="d-flex flex-column flex-shrink-0 p-3 text-white bg-dark h-100">
    <a href="${pageContext.request.contextPath}/home" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
        <i class="fa-solid fa-music fa-2x me-2 text-success"></i>
        <span class="fs-4 fw-bold">VibeStream</span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <c:choose>
                <c:when test="${fn:contains(currentUri, '/home')}">
                    <a href="${pageContext.request.contextPath}/home" class="nav-link text-white active">
                        <i class="fa-solid fa-house me-2"></i> Trang Chủ
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/home" class="nav-link text-white">
                        <i class="fa-solid fa-house me-2"></i> Trang Chủ
                    </a>
                </c:otherwise>
            </c:choose>
        </li>
        <li>
            <c:choose>
                <c:when test="${fn:contains(currentUri, '/genres')}">
                    <a href="${pageContext.request.contextPath}/genres" class="nav-link text-white active">
                        <i class="fa-solid fa-compact-disc me-2"></i> Thể Loại
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/genres" class="nav-link text-white">
                        <i class="fa-solid fa-compact-disc me-2"></i> Thể Loại
                    </a>
                </c:otherwise>
            </c:choose>
        </li>
        <li>
            <c:choose>
                <c:when test="${fn:contains(currentUri, '/playlist')}">
                    <a href="${pageContext.request.contextPath}/playlist" class="nav-link text-white active">
                        <i class="fa-solid fa-list me-2"></i> Playlist Của Tôi
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/playlist" class="nav-link text-white">
                        <i class="fa-solid fa-list me-2"></i> Playlist Của Tôi
                    </a>
                </c:otherwise>
            </c:choose>
        </li>
    </ul>

    <c:if test="${not empty genres}">
        <div class="mt-3 p-3 rounded-4" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.06);">
            <div class="d-flex align-items-center justify-content-between mb-3">
                <div class="small text-uppercase fw-bold" style="letter-spacing: 1px; color: #9d4edd;">Bộ lọc nhanh</div>
                <i class="fa-solid fa-filter text-success"></i>
            </div>

            <div class="d-flex flex-wrap gap-2">
                <a href="${pageContext.request.contextPath}/home"
                   class="badge rounded-pill text-decoration-none px-3 py-2 ${empty selectedGenreId ? 'bg-success text-white' : 'genre-chip text-white'}"
                   style="display: inline-flex; align-items: center; gap: 6px;">
                    <i class="fa-solid fa-layer-group"></i> Tất cả
                </a>

                <c:forEach var="genre" items="${genres}">
                    <a href="${pageContext.request.contextPath}/home?genreId=${genre.id}"
                       class="badge rounded-pill text-decoration-none px-3 py-2 ${selectedGenreId == genre.id ? 'bg-success text-white' : 'genre-chip text-white'}"
                       style="display: inline-flex; align-items: center; gap: 6px;">
                        <i class="fa-solid fa-circle-dot"></i> ${genre.name}
                    </a>
                </c:forEach>
            </div>
        </div>
    </c:if>

    <hr>
    <div class="dropdown">
        <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
            <strong>${not empty sessionScope.currentUser ? sessionScope.currentUser.username : 'Khách'}</strong>
        </a>
        <ul class="dropdown-menu dropdown-menu-dark text-small shadow" aria-labelledby="dropdownUser1">
            <c:if test="${sessionScope.currentUser.role == 'ROLE_ADMIN'}">
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin">Quản lý nhạc (Admin)</a></li>
            </c:if>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
        </ul>
    </div>
</div>