<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>VibeStream - Music Experience</title>
    <jsp:include page="/WEB-INF/views/fragments/head.jsp" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body class="bg-dark text-white" style="height: 100vh; overflow: hidden;">

<div class="container-fluid h-100 p-0 m-0">
    <div class="row h-100 g-0">
        <div class="col-md-2 h-100">
            <jsp:include page="/WEB-INF/views/fragments/sidebar.jsp" />
        </div>

        <div class="col-md-10 h-100 d-flex flex-column" style="overflow-y: auto; padding-bottom: 120px;">
            <nav class="navbar navbar-dark bg-dark px-4 py-3 border-bottom border-secondary">
                <form class="d-flex w-50" action="${pageContext.request.contextPath}/home" method="GET">
                    <input class="form-control bg-secondary text-white border-0 me-2"
                           type="search"
                           name="keyword"
                           value="${currentKeyword}"
                           placeholder="Tìm kiếm bài hát, ca sĩ...">
                    <button class="btn btn-outline-success" type="submit">Tìm</button>
                </form>
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