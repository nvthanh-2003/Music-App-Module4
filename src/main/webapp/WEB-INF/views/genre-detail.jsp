<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .genre-detail-hero {
        background: linear-gradient(135deg, rgba(157, 78, 221, 0.18), rgba(47, 188, 97, 0.08));
        border: 1px solid rgba(255, 255, 255, 0.06);
        border-radius: 28px;
    }

    .genre-song-card {
        background: rgba(255, 255, 255, 0.04);
        border: 1px solid rgba(255, 255, 255, 0.07);
        border-radius: 18px;
        transition: transform 0.2s ease, background 0.2s ease, border-color 0.2s ease;
    }

    .genre-song-card:hover {
        transform: translateY(-3px);
        background: rgba(255, 255, 255, 0.07);
        border-color: rgba(47, 188, 97, 0.35);
    }
</style>

<div class="genre-detail-hero p-4 p-md-5 mb-4 d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3">
    <div>
        <div class="text-uppercase small fw-bold mb-2" style="color:#9d4edd; letter-spacing: 1px;">Thể loại</div>
        <h2 class="fw-bold mb-2">${genre.name}</h2>
        <p class="mb-0 text-muted">${genre.description}</p>
    </div>
    <div class="text-md-end">
        <div class="fs-3 fw-bold text-white">${genre.songCount}</div>
        <div class="small text-muted">bài hát trong thể loại này</div>
    </div>
</div>

<div class="d-flex align-items-center mb-3">
    <h5 class="text-white fw-bold mb-0">Danh sách bài hát</h5>
    <div class="ms-2 border-bottom flex-grow-1" style="border-color: rgba(255,255,255,0.06) !important;"></div>
</div>

<div class="row row-cols-1 row-cols-md-2 row-cols-xl-3 g-4">
    <c:forEach var="song" items="${songs}">
        <div class="col">
            <div class="genre-song-card p-3 h-100">
                <div class="d-flex gap-3 align-items-center">
                    <img src="${not empty song.imgUrl ? song.imgUrl : 'https://placehold.co/90x90/222/fff?text=Music'}"
                         alt="${song.title}" class="rounded-4 flex-shrink-0" style="width: 90px; height: 90px; object-fit: cover;">
                    <div class="flex-grow-1 min-w-0">
                        <h6 class="fw-bold text-white mb-1 text-truncate">${song.title}</h6>
                        <div class="small text-muted text-truncate mb-2">${song.artistName}</div>
                        <c:if test="${not empty song.genreName}">
                            <span class="badge rounded-pill genre-chip">${song.genreName}</span>
                        </c:if>
                    </div>
                </div>

                <div class="d-flex align-items-center justify-content-between mt-3 pt-3 border-top border-secondary border-opacity-25">
                    <span class="small text-muted">Nghe ngay trong player</span>
                    <button class="btn btn-success btn-sm rounded-pill btn-play-now"
                            data-title="${song.title}"
                            data-artist="${song.artistName}"
                            data-url="${song.fileUrl}"
                            data-img="${song.imgUrl}">
                        <i class="fa-solid fa-play me-1"></i>Phát
                    </button>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<c:if test="${empty songs}">
    <div class="text-center py-5 mt-4 section-card">
        <i class="fa-solid fa-music display-6 d-block mb-3 text-muted"></i>
        <div class="text-muted">Hiện chưa có bài hát nào trong thể loại này.</div>
    </div>
</c:if>