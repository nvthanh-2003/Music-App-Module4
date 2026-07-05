<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .genres-hero {
        background: radial-gradient(circle at top left, rgba(157, 78, 221, 0.22), transparent 45%),
                    linear-gradient(135deg, rgba(17, 12, 28, 0.96), rgba(10, 10, 16, 0.96));
        border: 1px solid rgba(255, 255, 255, 0.06);
        border-radius: 28px;
    }

    .genre-card {
        background: linear-gradient(180deg, rgba(255, 255, 255, 0.07), rgba(255, 255, 255, 0.03));
        border: 1px solid rgba(255, 255, 255, 0.08);
        border-radius: 22px;
        transition: transform 0.25s ease, box-shadow 0.25s ease, border-color 0.25s ease;
        min-height: 100%;
    }

    .genre-card:hover {
        transform: translateY(-6px);
        border-color: rgba(47, 188, 97, 0.38);
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.22);
    }

    .genre-icon {
        width: 58px;
        height: 58px;
        border-radius: 18px;
        background: linear-gradient(135deg, rgba(157, 78, 221, 0.45), rgba(47, 188, 97, 0.28));
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border: 1px solid rgba(255, 255, 255, 0.08);
    }
</style>

<div class="genres-hero p-4 p-md-5 mb-4">
    <div class="row align-items-center g-4">
        <div class="col-md-8">
            <div class="text-uppercase small fw-bold mb-2" style="color:#9d4edd; letter-spacing: 1px;">Khám phá theo thể loại</div>
            <h2 class="fw-bold mb-3">Chọn một vibe và đi sâu vào bộ sưu tập phù hợp.</h2>
            <p class="mb-0 text-muted">Trang thể loại này giúp người nghe đi thẳng đến cảm xúc muốn tìm: chill, pop, indie, hoặc bất kỳ phong cách nào bạn mở rộng sau này.</p>
        </div>
        <div class="col-md-4 text-md-end">
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light rounded-pill px-4 py-2">
                <i class="fa-solid fa-arrow-left me-2"></i>Quay lại trang chủ
            </a>
        </div>
    </div>
</div>

<div class="row row-cols-1 row-cols-md-2 row-cols-xl-3 g-4">
    <c:forEach var="genre" items="${genres}">
        <div class="col">
            <a href="${pageContext.request.contextPath}/genres?id=${genre.id}" class="text-decoration-none text-white">
                <div class="genre-card p-4 h-100">
                    <div class="d-flex align-items-start justify-content-between gap-3">
                        <div class="d-flex align-items-center gap-3">
                            <div class="genre-icon">
                                <i class="fa-solid fa-compact-disc fs-4 text-white"></i>
                            </div>
                            <div>
                                <h5 class="fw-bold mb-1">${genre.name}</h5>
                                <div class="small text-muted">${genre.songCount} bài hát</div>
                            </div>
                        </div>
                        <span class="badge rounded-pill genre-chip">Hot</span>
                    </div>

                    <p class="text-muted mt-3 mb-0" style="min-height: 48px;">${genre.description}</p>

                    <div class="d-flex align-items-center justify-content-between mt-4 pt-3 border-top border-secondary border-opacity-25">
                        <span class="small text-muted">Mở để nghe ngay</span>
                        <span class="fw-bold text-success">Khám phá</span>
                    </div>
                </div>
            </a>
        </div>
    </c:forEach>
</div>