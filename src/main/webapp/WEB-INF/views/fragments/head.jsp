<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/custom.css">

<div class="p-3 text-white-50">
    <c:choose>
        <c:when test="${not empty sessionScope.currentUser}">
            Chào, <span class="text-white fw-bold">${sessionScope.currentUser.username}</span>
            <span class="badge bg-secondary ms-1">${sessionScope.currentUser.role}</span>
            <br>
            <a href="logout" class="text-danger small text-decoration-none">Đăng xuất</a>
        </c:when>
        <c:otherwise>
            <a href="login" class="text-success text-decoration-none">Đăng nhập</a>
        </c:otherwise>
    </c:choose>
</div>