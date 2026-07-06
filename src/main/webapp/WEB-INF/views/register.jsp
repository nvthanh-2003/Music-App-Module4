<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VibeStream - Đăng Ký Tài Khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #121212;
            color: #ffffff;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card-register {
            background-color: #181818;
            border: 1px solid #282828;
            border-radius: 12px;
            width: 420px;
            padding: 35px;
        }
        .form-control {
            background-color: #242424 !important;
            border: 1px solid #3A3A3A !important;
            color: #ffffff !important;
        }
        .form-control:focus {
            border-color: #1db954 !important;
            box-shadow: 0 0 0 0.25rem rgba(29, 185, 84, 0.25) !important;
        }
        .btn-success {
            background-color: #1db954;
            border: none;
            transition: all 0.2s ease;
        }
        .btn-success:hover {
            background-color: #1ed760;
            transform: scale(1.02);
        }
        .text-success-custom {
            color: #1db954;
        }
        a {
            color: #1db954;
            text-decoration: none;
        }
        a:hover {
            color: #1ed760;
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="card-register shadow-lg">
    <div class="text-center mb-4">
        <h2 class="fw-bold text-success-custom mb-1"><i class="fa-solid fa-music me-2"></i>VibeStream</h2>
        <p class="text-white-50 small">Tạo tài khoản miễn phí để trải nghiệm âm nhạc</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger d-flex align-items-center py-2" role="alert">
            <i class="fa-solid fa-triangle-exclamation me-2 small"></i>
            <div class="small">${error}</div>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="mb-3">
            <label class="form-label text-white-50 small fw-semibold">Tên tài khoản</label>
            <div class="input-group">
                <span class="input-group-text bg-dark border-secondary text-white-50"><i class="fa-solid fa-user small"></i></span>
                <input type="text" name="username" class="form-control" value="${username}" placeholder="Nhập tên đăng nhập..." required autocomplete="off">
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label text-white-50 small fw-semibold">Địa chỉ Email</label>
            <div class="input-group">
                <span class="input-group-text bg-dark border-secondary text-white-50"><i class="fa-solid fa-envelope small"></i></span>
                <input type="email" name="email" class="form-control" value="${email}" placeholder="example@gmail.com" required>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label text-white-50 small fw-semibold">Mật khẩu</label>
            <div class="input-group">
                <span class="input-group-text bg-dark border-secondary text-white-50"><i class="fa-solid fa-lock small"></i></span>
                <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu..." required>
            </div>
        </div>

        <div class="mb-4">
            <label class="form-label text-white-50 small fw-semibold">Xác nhận mật khẩu</label>
            <div class="input-group">
                <span class="input-group-text bg-dark border-secondary text-white-50"><i class="fa-solid fa-shield-halved small"></i></span>
                <input type="password" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu..." required>
            </div>
        </div>

        <button type="submit" class="btn btn-success w-100 fw-bold py-2.5 mb-3">ĐĂNG KÝ</button>
    </form>

    <div class="text-center mt-3">
        <p class="text-white-50 small mb-0">Bạn đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập tại đây</a></p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>