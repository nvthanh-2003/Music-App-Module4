<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>VibeStream - Đăng Nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #121212; color: #ffffff; height: 100vh; display: flex; align-items: center; justify-content: center; }
        .card-login { background-color: #181818; border: 1px solid #282828; border-radius: 8px; width: 400px; padding: 30px; }
        .btn-success { background-color: #1db954; border: none; }
        .btn-success:hover { background-color: #1ed760; }
    </style>
</head>
<body>
<div class="card-login shadow-lg">
    <h3 class="text-center mb-4 text-success fw-bold">VibeStream</h3>
    <h5 class="text-center mb-4">Đăng nhập để nghe nhạc</h5>

    <c:if test="${not empty error}">
        <div class="alert alert-danger py-2 fs-6">${error}</div>
    </c:if>
    <c:if test="${param.success eq 'true'}">
        <div class="alert alert-success py-2 fs-6">Đăng ký thành công! Hãy đăng nhập.</div>
    </c:if>

    <form action="login" method="post">
        <div class="mb-3">
            <label class="form-label text-white-50">Tên tài khoản</label>
            <input type="text" name="username" class="form-control bg-dark text-white border-secondary" required>
        </div>
        <div class="mb-3">
            <label class="form-label text-white-50">Mật khẩu</label>
            <input type="password" name="password" class="form-control bg-dark text-white border-secondary" required>
        </div>
        <button type="submit" class="btn btn-success w-100 fw-semibold mt-2 py-2">Đăng Nhập</button>
    </form>
    <p class="text-center text-white-50 mt-4 mb-0 small">Chưa có tài khoản? <a href="register" class="text-success text-decoration-none">Đăng ký ngay</a></p>
</div>
</body>
</html>