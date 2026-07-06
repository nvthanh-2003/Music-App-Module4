<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>VibeStream - Tải Bài Hát Lên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #121212; color: #ffffff; min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .card-custom { background-color: #181818; border: 1px solid #282828; border-radius: 12px; width: 500px; padding: 35px; }
        .form-control, .form-select { background-color: #242424 !important; border: 1px solid #3A3A3A !important; color: #ffffff !important; }
        .form-control:focus, .form-select:focus { border-color: #1db954 !important; box-shadow: 0 0 0 0.25rem rgba(29, 185, 84, 0.25) !important; }
        .btn-success { background-color: #1db954; border: none; }
        .btn-success:hover { background-color: #1ed760; }
    </style>
</head>
<body>
<div class="card-custom shadow-lg">
    <h3 class="text-center text-success fw-bold mb-4"><i class="fa-solid fa-cloud-arrow-up me-2"></i>Tải Bài Hát Lên</h3>

    <c:if test="${not empty error}">
        <div class="alert alert-danger py-2 small">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/add-song" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label class="form-label text-white-50 small">Tiêu đề bài hát</label>
            <input type="text" name="title" class="form-control" placeholder="Nhập tên bài hát..." required>
        </div>

        <div class="row mb-3">
            <div class="col">
                <label class="form-label text-white-50 small">Ca sĩ</label>
                <select name="artistId" class="form-select" required>
                    <option value="1">Sơn Tùng M-TP</option>
                    <option value="2">Đen Vâu</option>
                    <option value="3">Vũ</option>
                </select>
            </div>
            <div class="col">
                <label class="form-label text-white-50 small">Thể loại</label>
                <select name="genreId" class="form-select" required>
                    <option value="1">V-Pop</option>
                    <option value="2">Lofi</option>
                    <option value="3">Indie</option>
                </select>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label text-white-50 small">Chọn file nhạc từ máy (.mp3)</label>
            <input type="file" name="audioFile" class="form-control" accept="audio/mpeg, audio/mp3" required>
        </div>

        <div class="mb-4">
            <label class="form-label text-white-50 small">Chọn ảnh bìa bài hát (.png, .jpg)</label>
            <input type="file" name="imgFile" class="form-control" accept="image/*">
        </div>

        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary w-50 py-2">Hủy bỏ</a>
            <button type="submit" class="btn btn-success w-50 py-2 fw-bold">Tải Lên Hệ Thống</button>
        </div>
    </form>
</div>
</body>
</html>