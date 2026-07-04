<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .home-hero {
        background: linear-gradient(135deg, rgba(157, 78, 221, 0.18), rgba(47, 188, 97, 0.08));
        border: 1px solid rgba(255, 255, 255, 0.06);
        border-radius: 24px;
    }

    .genre-pill {
        background: rgba(157, 78, 221, 0.16);
        color: #d9c8ff;
        border: 1px solid rgba(157, 78, 221, 0.35);
        font-size: 0.75rem;
    }

    .music-card {
        background: linear-gradient(180deg, rgba(255, 255, 255, 0.08), rgba(255, 255, 255, 0.04));
        border: 1px solid rgba(255, 255, 255, 0.06);
        transition: transform 0.25s ease, border-color 0.25s ease, box-shadow 0.25s ease;
    }

    .music-card:hover {
        transform: translateY(-6px);
        border-color: rgba(47, 188, 97, 0.4);
        box-shadow: 0 18px 40px rgba(0, 0, 0, 0.22);
    }
</style>

<div class="home-hero p-4 mb-4 d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3">
    <div>
        <div class="text-uppercase small fw-bold mb-2" style="color:#9d4edd; letter-spacing: 1px;">Khám phá âm nhạc</div>
        <h2 class="fw-bold mb-2">Bài hát mới phát hành</h2>
        <p class="mb-0 text-muted">Nghe nhanh, mở playlist, và duyệt theo thể loại chỉ trong vài nhấp chuột.</p>
    </div>
    <a href="${pageContext.request.contextPath}/genres" class="btn btn-success rounded-pill px-4 fw-bold shadow-sm">
        <i class="fa-solid fa-compact-disc me-2"></i>Khám phá thể loại
    </a>
</div>

<c:if test="${not empty selectedGenreId}">
    <div class="mb-3 text-muted small">
        Đang lọc theo thể loại: <span class="text-white fw-semibold">
        <c:forEach var="genre" items="${genres}">
            <c:if test="${selectedGenreId == genre.id}">${genre.name}</c:if>
        </c:forEach>
        </span>
    </div>
</c:if>

<div class="row row-cols-2 row-cols-md-4 g-4">
    <c:forEach var="song" items="${songs}">
        <div class="col">
            <div class="card music-card text-white h-100 border-0 p-3 shadow-sm rounded-4">
                <div class="position-relative project-card-hover">
                    <img src="${song.imgUrl}" class="card-img-top rounded" alt="Cover" style="aspect-ratio: 1/1; object-fit: cover;">
                    <button class="btn btn-success btn-play-now position-absolute bottom-0 end-0 m-2 rounded-circle shadow"
                            data-title="${song.title}"
                            data-artist="${song.artistName}"
                            data-url="${song.fileUrl}"
                            data-img="${song.imgUrl}">
                        <i class="fa-solid fa-play"></i>
                    </button>
                </div>
                <div class="card-body px-0 pt-3 pb-0">
                    <h6 class="card-title text-truncate fw-bold mb-1">${song.title}</h6>
                    <p class="card-text text-muted small">${song.artistName}</p>
                    <c:if test="${not empty song.genreName}">
                        <span class="badge rounded-pill genre-pill">${song.genreName}</span>
                    </c:if>
                </div>
            </div>
        </div>
    </c:forEach>
</div>