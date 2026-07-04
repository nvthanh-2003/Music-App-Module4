<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* Container tổng thể màu tím đêm ZingMP3 */
    .mp3-playlist-container {
        background: linear-gradient(180deg, #170f23 0%, #100a19 100%);
        min-height: 100vh;
        color: #fff;
    }

    /* Định dạng hàng ngang cho từng playlist */
    .mp3-row-item {
        background-color: rgba(255, 255, 255, 0.04);
        border: 1px solid rgba(255, 255, 255, 0.08);
        border-radius: 12px;
        transition: all 0.2s ease-in-out;
        padding: 14px 24px;
    }

    /* Hover nhích nhẹ sang phải và sáng bừng lên */
    .mp3-row-item:hover {
        background-color: rgba(255, 255, 255, 0.09);
        border-color: rgba(123, 44, 191, 0.4);
        transform: translateX(6px);
    }

    /* Thiết kế ảnh đại diện nhỏ bo tròn phát sáng nhẹ */
    .mp3-thumb-small {
        width: 52px;
        height: 52px;
        background: linear-gradient(135deg, #9d4edd 0%, #3a0ca3 100%);
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 4px 14px rgba(157, 78, 221, 0.4);
    }

    .mp3-actions {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .btn-circle-play {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background-color: #2fbc61 !important;
        color: #fff !important;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border: none;
        box-shadow: 0 4px 12px rgba(47, 188, 97, 0.4);
        transition: all 0.2s;
    }

    .btn-circle-play:hover {
        background-color: #249c4f !important;
        transform: scale(1.1);
    }

    .btn-action-edit {
        color: #bda6ff !important;
        font-size: 1.2rem;
        transition: color 0.2s, transform 0.2s;
    }

    .btn-action-edit:hover {
        color: #e0aaff !important;
        transform: scale(1.15);
    }

    .btn-action-delete {
        color: #ff6b6b !important; /* Màu đỏ neon sáng cực kỳ dễ thấy */
        font-size: 1.2rem;
        transition: color 0.2s, transform 0.2s;
    }

    .btn-action-delete:hover {
        color: #ff8787 !important;
        transform: scale(1.15);
    }
</style>

<div class="p-4 mp3-playlist-container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="text-white fw-bold mb-1">Playlist Của Tôi</h2>
            <p class="small" style="color: #a0a0a0;">Danh sách phát cá nhân</p>
        </div>
        <a href="${pageContext.request.contextPath}/playlist?action=create"
           class="btn btn-success rounded-pill px-4 fw-bold shadow">
            <i class="bi bi-plus-lg me-1"></i> Tạo playlist mới
        </a>
    </div>

    <div class="d-flex flex-column gap-3">
        <c:forEach var="p" items="${playlists}">
            <div class="d-flex align-items-center justify-content-between mp3-row-item">

                <div class="d-flex align-items-center flex-grow-1" style="min-width: 0;">
                    <div class="mp3-thumb-small me-3 flex-shrink-0">
                        <i class="bi bi-music-note-list text-white fs-4"></i>
                    </div>
                    <div class="text-truncate">
                        <h5 class="text-white fw-bold mb-1 text-truncate" title="${p.name}">${p.name}</h5>
                        <span class="small" style="color: #b3a7c2;">Playlist • Bạn tạo</span>
                    </div>
                </div>

                <div class="d-none d-md-block px-3 small" style="width: 150px; color: #8d8599;">
                    Cá nhân
                </div>

                <div class="mp3-actions flex-shrink-0">
                    <a href="${pageContext.request.contextPath}/playlist?id=${p.id}" class="btn-circle-play"
                       title="Nghe ngay">
                        <i class="bi bi-play-fill fs-4"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/playlist?action=edit&id=${p.id}"
                       class="btn-action-edit text-decoration-none px-1" title="Sửa tên">
                        <i class="bi bi-pencil-square"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/playlist?action=delete&id=${p.id}"
                       class="btn-action-delete text-decoration-none px-1"
                       onclick="return confirm('Bạn có chắc muốn xóa playlist này không?');" title="Xóa">
                        <i class="bi bi-trash3"></i>
                    </a>
                </div>

            </div>
        </c:forEach>
    </div>
</div>