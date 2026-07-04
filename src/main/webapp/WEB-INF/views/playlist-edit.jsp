<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .mp3-edit-container {
        background: linear-gradient(180deg, #170f23 0%, #100a19 100%);
        min-height: 100vh;
        color: #fff;
    }

    .mp3-form-box {
        background: rgba(255, 255, 255, 0.03);
        border: 1px solid rgba(255, 255, 255, 0.05);
        border-radius: 16px;
        backdrop-filter: blur(10px);
    }

    .mp3-input-dark {
        background-color: rgba(255, 255, 255, 0.05) !important;
        border: 1px solid rgba(255, 255, 255, 0.1) !important;
        color: #fff !important;
        border-radius: 10px !important;
    }

    .mp3-input-dark:focus {
        border-color: #7b2cbf !important;
        box-shadow: 0 0 10px rgba(123, 44, 191, 0.3) !important;
    }

    .btn-back-mp3 {
        color: #a0a0a0;
        transition: color 0.2s;
    }

    .btn-back-mp3:hover {
        color: #7b2cbf;
    }
</style>

<div class="p-4 mp3-edit-container">
    <div class="mb-4">
        <a href="${pageContext.request.contextPath}/playlist"
           class="btn-back-mp3 text-decoration-none fw-semibold small">
            <i class="bi bi-chevron-left me-1"></i> HỦY VÀ QUAY LẠI
        </a>
    </div>

    <div class="row justify-content-start mt-2">
        <div class="col-md-6">
            <div class="p-4 mp3-form-box shadow">
                <h3 class="text-white fw-bold mb-4">Chỉnh Sửa Playlist</h3>

                <form action="${pageContext.request.contextPath}/playlist" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="playlistId" value="${playlist.id}">

                    <div class="mb-4">
                        <label for="playlistName" class="form-label small fw-bold text-uppercase"
                               style="color: #8d8599; letter-spacing: 0.5px;">
                            Tên danh sách phát mới
                        </label>
                        <input type="text" class="form-control form-control-lg mp3-input-dark shadow-none"
                               id="playlistName" name="playlistName" value="${playlist.name}" required max="100">
                    </div>

                    <button type="submit" class="btn btn-primary rounded-pill px-4 py-2 fw-bold shadow"
                            style="background-color: #7b2cbf; border: none;">
                        <i class="bi bi-save me-1"></i> Cập Nhật
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>