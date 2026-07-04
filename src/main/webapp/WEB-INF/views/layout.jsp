<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VibeStream - Music App</title>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body class="bg-dark text-white" style="height: 100vh; overflow: hidden;">

<div class="container-fluid h-100 p-0 m-0">
    <div class="row h-100 g-0">
        <div class="col-md-2 h-100">
            <jsp:include page="/WEB-INF/views/fragments/sidebar.jsp" />
        </div>

        <div class="col-md-10 h-100 d-flex flex-column" style="overflow-y: auto; padding-bottom: 100px;">
            <nav class="navbar navbar-dark bg-dark px-4 py-3 border-bottom border-secondary gap-3 flex-wrap">
                <form class="d-flex flex-grow-1" action="${pageContext.request.contextPath}/search" method="GET" style="min-width: 280px; max-width: 720px;">
                    <input class="form-control bg-secondary text-white border-0 me-2" type="search" name="keyword" placeholder="Tìm kiếm bài hát, ca sĩ...">
                    <button class="btn btn-outline-success" type="submit">Tìm</button>
                </form>

                <c:if test="${not empty genres}">
                    <div class="dropdown">
                        <button class="btn btn-outline-light dropdown-toggle rounded-pill px-3" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fa-solid fa-filter me-2"></i>Lọc thể loại
                        </button>
                        <div class="dropdown-menu dropdown-menu-end dropdown-menu-dark p-2 shadow genre-filter-menu" style="min-width: 260px; max-height: 320px; overflow-y: auto; background-color: #1d1727; border: 1px solid rgba(255,255,255,0.08);">
                            <a class="dropdown-item rounded-3 py-2 ${empty selectedGenreId ? 'active' : ''}" href="${pageContext.request.contextPath}/home">
                                Tất cả thể loại
                            </a>
                            <div class="dropdown-divider my-2" style="border-color: rgba(255,255,255,0.08);"></div>
                            <c:forEach var="genre" items="${genres}">
                                <a class="dropdown-item rounded-3 py-2 d-flex align-items-center justify-content-between ${selectedGenreId == genre.id ? 'active' : ''}"
                                   href="${pageContext.request.contextPath}/home?genreId=${genre.id}">
                                    <span class="text-truncate me-2">${genre.name}</span>
                                    <span class="badge rounded-pill" style="background: rgba(47,188,97,0.14); color: #aef0c0;">${genre.songCount}</span>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </nav>

            <div class="p-4">
                <jsp:include page="${requestScope.view}" />
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/fragments/player.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/player.js"></script>
</body>
</html>