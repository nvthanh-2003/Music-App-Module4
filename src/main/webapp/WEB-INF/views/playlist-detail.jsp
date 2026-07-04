<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* Nền gradient tím huyền bí của ZingMP3 */
    .mp3-detail-container {
        background: linear-gradient(180deg, #170f23 0%, #100a19 100%);
        min-height: 100vh;
        color: #fff;
        font-family: 'Inter', sans-serif;
    }

    /* Thẻ bọc Header Playlist kính mờ */
    .playlist-header-box {
        background: rgba(255, 255, 255, 0.02);
        border: 1px solid rgba(255, 255, 255, 0.05);
        border-radius: 20px;
        backdrop-filter: blur(15px);
    }

    /* Icon Playlist phát sáng */
    .mp3-playlist-icon {
        width: 100px;
        height: 100px;
        background: linear-gradient(135deg, #9d4edd 0%, #3a0ca3 100%);
        border-radius: 16px;
        box-shadow: 0 8px 32px rgba(157, 78, 221, 0.3);
    }

    /* Thanh tìm kiếm thêm nhạc dời lên trên rực rỡ */
    .mp3-search-top-box {
        background: rgba(255, 255, 255, 0.03);
        border: 1px solid rgba(255, 255, 255, 0.06);
        border-radius: 16px;
    }

    .mp3-search-input {
        background-color: rgba(255, 255, 255, 0.05) !important;
        border: 1px solid rgba(255, 255, 255, 0.1) !important;
        color: #fff !important;
        border-radius: 30px !important;
        padding-left: 20px;
    }

    .mp3-search-input:focus {
        border-color: #9d4edd !important;
        box-shadow: 0 0 12px rgba(157, 78, 221, 0.4) !important;
    }

    .btn-search-purple {
        background: linear-gradient(135deg, #7b2cbf 0%, #5a189a 100%);
        border: none;
        border-radius: 30px;
        transition: transform 0.2s;
    }

    .btn-search-purple:hover {
        transform: scale(1.05);
    }

    /* Khối nút bấm chức năng (Phát/Ngẫu nhiên) */
    .btn-mp3-primary {
        background-color: #7b2cbf;
        border: none;
        transition: all 0.2s;
    }

    .btn-mp3-primary:hover {
        background-color: #9d4edd;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(157, 78, 221, 0.4);
    }

    .btn-mp3-outline {
        background-color: rgba(255, 255, 255, 0.05);
        border: 1px solid rgba(255, 255, 255, 0.1);
        color: #fff;
        transition: all 0.2s;
    }

    .btn-mp3-outline:hover {
        background-color: rgba(255, 255, 255, 0.12);
        border-color: rgba(255, 255, 255, 0.3);
        color: #fff;
    }

    /* Thiết kế hàng danh sách bài hát dày dặn xịn mịn */
    .mp3-track-card-row {
        background: rgba(255, 255, 255, 0.02);
        border: 1px solid rgba(255, 255, 255, 0.04);
        border-radius: 12px;
        padding: 16px 24px;
        transition: all 0.25s ease-in-out;
    }

    .mp3-track-card-row:hover {
        background: rgba(255, 255, 255, 0.07);
        border-color: rgba(157, 78, 221, 0.3);
        transform: scale(1.008);
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
    }

    /* Thumbnail bài hát */
    .track-thumb-large {
        width: 48px;
        height: 48px;
        border-radius: 6px;
        object-fit: cover;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
    }

    /* Nút quay lại nhỏ gọn */
    .btn-back-mp3 {
        color: #b3a7c2;
        transition: color 0.2s;
    }

    .btn-back-mp3:hover {
        color: #9d4edd;
    }

    #mp3-toast-container {
        position: fixed;
        top: 30px;
        right: 30px;
        z-index: 9999;
    }

    .mp3-toast {
        background: rgba(47, 34, 69, 0.95);
        border: 1px solid #7b2cbf;
        color: #fff;
        padding: 16px 24px;
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        display: flex;
        align-items: center;
        gap: 12px;
        min-width: 320px;
        transform: translateX(120%);
        transition: transform 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        backdrop-filter: blur(10px);
    }

    .mp3-toast.show {
        transform: translateX(0);
    }

    .mp3-toast-icon {
        font-size: 1.4rem;
    }

    /* Tinh chỉnh bổ sung style cho Dropdown Item mượt mà */
    .dropdown-menu-dark .dropdown-item {
        color: #b3a7c2 !important;
        transition: all 0.2s;
    }
    .dropdown-menu-dark .dropdown-item:hover {
        background-color: rgba(255, 255, 255, 0.05) !important;
        color: #fff !important;
    }
    .dropdown-menu-dark .dropdown-item.text-danger:hover {
        background-color: rgba(255, 107, 107, 0.1) !important;
        color: #ff6b6b !important;
    }
</style>

<div id="mp3-toast-container">
    <div id="customToast" class="mp3-toast">
        <span id="toastIcon" class="mp3-toast-icon"></span>
        <div>
            <strong class="d-block text-white-50 small text-uppercase" style="letter-spacing: 1px;">VibeStream Player</strong>
            <span id="toastMessage" class="small fw-semibold"></span>
        </div>
    </div>
</div>

<div class="p-4 mp3-detail-container">
    <div class="mb-4">
        <a href="${pageContext.request.contextPath}/playlist"
           class="btn-back-mp3 text-decoration-none fw-semibold small">
            <i class="bi bi-chevron-left me-1"></i> QUAY LẠI PLAYLIST
        </a>
    </div>

    <div class="p-4 mb-4 mp3-search-top-box shadow-sm">
        <div class="row align-items-center">
            <div class="col-lg-4 mb-2 mb-lg-0">
                <h5 class="text-white fw-bold mb-0">
                    <i class="bi bi-plus-circle-fill me-2" style="color: #9d4edd;"></i>Thêm Nhạc Vào Playlist
                </h5>
                <span class="text-muted small">Tìm kiếm bài hát từ hệ thống VibeStream</span>
            </div>
            <div class="col-lg-8">
                <form action="${pageContext.request.contextPath}/playlist" method="get" class="d-flex gap-2">
                    <input type="hidden" name="id" value="${playlistId}">

                    <input type="text" name="searchSong" class="form-control mp3-search-input shadow-none"
                           placeholder="Nhập tên bài hát, ca sĩ, nhạc sĩ muốn tìm kiếm..." value="${param.searchSong}">
                    <button type="submit" class="btn btn-primary btn-search-purple px-4 fw-bold text-white flex-shrink-0">
                        <i class="bi bi-search me-1"></i> Tìm Kiếm
                    </button>
                </form>
            </div>
        </div>

        <c:if test="${not empty param.searchSong}">
            <div class="mt-4 p-3 rounded-3" style="background: rgba(0, 0, 0, 0.2); border: 1px solid rgba(255,255,255,0.05);">
                <div class="text-uppercase small fw-bold mb-3" style="color: #9d4edd; letter-spacing: 0.5px;">
                    Kết quả tìm kiếm cho: "${param.searchSong}"
                </div>

                <div class="d-flex flex-column gap-2">
                    <c:choose>
                        <c:when test="${not empty foundSongs}">
                            <c:forEach var="fSong" items="${foundSongs}">
                                <div class="d-flex align-items-center justify-content-between p-2 rounded-3 mp3-track-card-row" style="padding: 10px 20px !important;">
                                    <div class="d-flex align-items-center">
                                        <img src="${not empty fSong.imgUrl ? fSong.imgUrl : 'https://placehold.co/40x40/282828/ffffff?text=Music'}" class="rounded me-3" style="width: 40px; height: 40px;" alt="">
                                        <div>
                                            <h6 class="mb-0 text-white small fw-bold">${fSong.title}</h6>
                                            <span class="text-muted" style="font-size: 0.75rem;">${fSong.artistName}</span>
                                        </div>
                                    </div>
                                    <button class="btn btn-sm btn-outline-light rounded-pill px-3" style="font-size: 0.8rem; border-color: rgba(255,255,255,0.2);"
                                            onclick="addSongToPlaylist('${fSong.id}', '${fSong.title}')">
                                        <i class="bi bi-plus-lg me-1"></i> Thêm vào playlist
                                    </button>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-4 rounded-3" style="background: rgba(255, 255, 255, 0.01); border: 1px dashed rgba(255,255,255,0.1);">
                                <i class="bi bi-search-heart display-6 d-block mb-2 text-muted"></i>
                                <span class="small text-muted">Không tìm thấy bài hát nào khớp với từ khóa của bạn trong hệ thống VibeStream.</span>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:if>
    </div>

    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between p-4 mb-4 playlist-header-box shadow-sm gap-4">
        <div class="d-flex align-items-center">
            <div class="mp3-playlist-icon d-flex align-items-center justify-content-center me-4 flex-shrink-0">
                <i class="bi bi-music-note-beamed text-white display-5"></i>
            </div>
            <div>
                <span class="text-uppercase small fw-bold" style="color: #ff007f; letter-spacing: 1.5px;">Playlist Cá Nhân</span>
                <h2 class="text-white fw-bold mb-1 mt-1">Chi Tiết Bài Hát</h2>
                <p class="mb-0 small" style="color: #b3a7c2;">Giai điệu được tùy chỉnh bởi riêng bạn</p>
            </div>
        </div>

        <div class="d-flex flex-wrap gap-3">
            <button class="btn btn-mp3-primary rounded-pill px-4 py-2.5 fw-bold text-white shadow"
                    onclick="togglePlayAll()">
                <i class="bi bi-play-circle-fill me-2 fs-5"></i><span id="lblPlayText">Phát tất cả</span>
            </button>
            <button class="btn btn-mp3-outline rounded-pill px-4 py-2.5 fw-bold shadow" onclick="playRandom()">
                <i class="bi bi-shuffle me-2"></i>Phát ngẫu nhiên
            </button>
        </div>
    </div>

    <div class="mb-3 d-flex align-items-center">
        <h5 class="text-white fw-bold mb-0">Danh Sách Phát Hiện Tại</h5>
        <div class="ms-2 border-bottom flex-grow-1" style="border-color: rgba(255,255,255,0.06) !important;"></div>
    </div>

    <div class="d-flex flex-column gap-3 mb-5">
        <c:choose>
            <c:when test="${not empty songs}">
                <c:forEach var="song" varStatus="status" items="${songs}">
                    <div class="d-flex align-items-center justify-content-between mp3-track-card-row">

                        <div class="d-flex align-items-center flex-grow-1" style="min-width: 0;">
                            <span class="fw-bold me-4 text-center text-muted" style="width: 24px; font-size: 1.1rem;">
                                    ${status.count}
                            </span>
                            <img src="${not empty song.imgUrl ? song.imgUrl : 'https://placehold.co/48x48/282828/ffffff?text=Music'}"
                                 class="track-thumb-large me-3 flex-shrink-0" alt="Song thumb">
                            <div class="text-truncate">
                                <h6 class="fw-bold text-white mb-1 text-truncate">${song.title}</h6>
                                <p class="mb-0 small text-truncate" style="color: #b3a7c2;">${song.artistName}</p>
                                <c:if test="${not empty song.genreName}">
                                    <span class="badge rounded-pill mt-1" style="background: rgba(157, 78, 221, 0.16); color: #d9c8ff; border: 1px solid rgba(157, 78, 221, 0.28); font-size: 0.68rem;">
                                        ${song.genreName}
                                    </span>
                                </c:if>
                            </div>
                        </div>

                        <div class="d-none d-md-block px-3 text-center" style="width: 120px;">
                            <span class="badge border border-info text-info px-2 py-1"
                                  style="font-size: 0.65rem; background: rgba(0, 242, 254, 0.05);">LOSSLESS</span>
                        </div>

                        <div class="d-flex align-items-center gap-3 flex-shrink-0 ms-3">
                            <button class="btn p-0 border-0 text-white-50 shadow-none" style="font-size: 1.3rem;"
                                    onclick="playSingleSong('${song.title}', this)">
                                <i id="play-icon-${status.count}" class="bi bi-play-fill song-play-btn-track" style="color: #2fbc61;"></i>
                            </button>

                            <div class="dropdown">
                                <button class="btn p-0 border-0 text-white-50 shadow-none" style="font-size: 1.1rem;"
                                        type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-three-dots"></i>
                                </button>

                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-dark shadow"
                                    style="background-color: #231b2e; border: 1px solid rgba(255,255,255,0.08); border-radius: 10px; padding: 6px;">
                                    <li>
                                        <a class="dropdown-item py-2 small fw-semibold" href="#"
                                           onclick="showMp3Toast('Đã thêm bài vào danh sách chờ phát!', 'bi-plus-square', '#00f2fe'); return false;">
                                            <i class="bi bi-list-play me-2 text-info"></i> Thêm vào danh sách chờ
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item py-2 small fw-semibold" href="#"
                                           onclick="showMp3Toast('Đang tải bài hát này xuống thiết bị...', 'bi-download', '#2fbc61'); return false;">
                                            <i class="bi bi-download me-2 text-success"></i> Tải bài hát xuống
                                        </a>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider" style="border-color: rgba(255,255,255,0.08);">
                                    </li>
                                    <li>
                                        <button type="button" class="dropdown-item py-2 small fw-semibold text-danger border-0 bg-transparent w-100 text-start"
                                                onclick="confirmDeleteSong('${song.title}', '${playlistId}', '${song.id}')">
                                            <i class="bi bi-trash3 me-2"></i> Xóa khỏi Playlist
                                        </button>
                                    </li>
                                </ul>
                            </div>
                        </div>

                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5 playlist-header-box">
                    <i class="bi bi-disc-fill display-3 d-block mb-3" style="color: rgba(255,255,255,0.15);"></i>
                    <span class="fs-6 text-muted">Playlist này chưa có bài hát nào. Hãy tìm nhạc bên trên để thêm nhé!</span>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg" style="background-color: #1d1727; color: #eee; border-radius: 16px;">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title d-flex align-items-center" style="font-weight: 600; color: #ff6b6b; font-size: 1.15rem;">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> Gỡ bài hát khỏi Playlist
                </h5>
                <button type="button" class="btn-close btn-close-white shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body py-3" style="color: #b3a7c2; font-size: 0.9rem; line-height: 1.5;">
                Bạn có chắc chắn muốn gỡ bài hát <span id="deleteSongTitle" class="text-white fw-bold"></span> ra khỏi danh sách phát hiện tại không? Hành động này không thể hoàn tác.
            </div>
            <div class="modal-footer border-0 pt-0">
                <button type="button" class="btn px-3 py-2 border-0 text-white-50 shadow-none small fw-bold" data-bs-dismiss="modal" style="background-color: #2b213a; border-radius: 20px; font-size: 0.8rem;">
                    Hủy bỏ
                </button>
                <button type="button" id="btnConfirmDeleteExecute" class="btn px-3 py-2 shadow-none text-white border-0 small fw-bold" style="background-color: #ff6b6b; border-radius: 20px; font-size: 0.8rem;">
                    Đồng ý gỡ
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    let isPlaying = false;
    let toastTimeout;

    // Biến toàn cục để theo dõi bài hát đơn lẻ đang được phát tích cực
    let currentPlayingTitle = null;

    // Biến lưu tạm địa chỉ URL sẽ điều hướng đi khi người dùng nhấn xác nhận xóa nhạc
    let pendingDeleteUrl = "";

    // --- TỰ ĐỘNG CHẠY KHI TRANG TẢI XONG (BẮT LỖI TỪ CONTROLLER BẮN VỀ) ---
    window.addEventListener('DOMContentLoaded', (event) => {
        // Hứng thuộc tính "businessError" được Controller đẩy ra request (nếu có)
        const errorFromBackend = "${businessError}";
        if (errorFromBackend && errorFromBackend.trim() !== "" && errorFromBackend !== "\${businessError}") {
            // Hiển thị Toast cảnh báo màu đỏ với icon tam giác chấm than rực rỡ
            showMp3Toast(errorFromBackend, "bi-exclamation-triangle-fill", "#ff6b6b");
        }
    });

    // ĐÃ BỔ SUNG: Kích hoạt hiện Modal xóa nhạc phong cách Dark Mode và nạp thông tin động
    function confirmDeleteSong(songTitle, playlistId, songId) {
        document.getElementById('deleteSongTitle').innerText = " \"" + songTitle + "\" ";

        // Tạo đường dẫn xóa nhạc truyền về controller của ông
        pendingDeleteUrl = "${pageContext.request.contextPath}/playlist?action=removeSong&id=" + playlistId + "&songId=" + songId;

        // Bật Modal Bootstrap 5
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
        deleteModal.show();
    }

    // ĐÃ BỔ SUNG: Lắng nghe hành động click chốt hạ nút "Đồng ý gỡ" trên Modal
    document.getElementById('btnConfirmDeleteExecute').addEventListener('click', function() {
        if (pendingDeleteUrl !== "") {
            showMp3Toast("Đang tiến hành gỡ bài hát khỏi danh sách...", "bi-trash-fill", "#ff6b6b");

            // Chờ hiệu ứng Toast hiện lên mượt mà rồi mới reload trang qua href
            setTimeout(() => {
                window.location.href = pendingDeleteUrl;
            }, 600);
        }
    });

    function showMp3Toast(message, iconClass, iconColor) {
        const toast = document.getElementById('customToast');
        const toastMsg = document.getElementById('toastMessage');
        const toastIcon = document.getElementById('toastIcon');

        toastMsg.innerText = message;
        toastIcon.className = "bi " + iconClass;
        toastIcon.style.color = iconColor;

        toast.classList.remove('show');
        clearTimeout(toastTimeout);

        setTimeout(() => {
            toast.classList.add('show');
        }, 50);

        toastTimeout = setTimeout(() => {
            toast.classList.remove('show');
        }, 3500);
    }

    function togglePlayAll() {
        isPlaying = !isPlaying;
        const btnText = document.getElementById('lblPlayText');

        // Reset toàn bộ các icon bài hát đơn lẻ về mặc định khi bấm nút phát tổng
        const allSongIcons = document.querySelectorAll('.song-play-btn-track');
        allSongIcons.forEach(icon => {
            icon.classList.remove('bi-pause-fill');
            icon.classList.add('bi-play-fill');
            icon.style.color = '#2fbc61';
        });
        currentPlayingTitle = null; // Clear trạng thái bài đơn lẻ

        if (isPlaying) {
            btnText.innerHTML = "Tạm dừng";
            showMp3Toast("Đang phát toàn bộ danh sách nhạc tuần tự!", "bi-play-circle-fill", "#2fbc61");
        } else {
            btnText.innerHTML = "Phát tất cả";
            showMp3Toast("Đã tạm dừng danh sách phát.", "bi-pause-circle-fill", "#ff6b6b");
        }
    }

    function playRandom() {
        showMp3Toast("Đã kích hoạt chế độ phát ngẫu nhiên (Shuffle Mode) chuẩn ZingMP3!", "bi-shuffle", "#9d4edd");
    }

    // Xử lý chuyển đổi icon Play/Pause cho từng bài hát đơn lẻ linh hoạt
    function playSingleSong(songTitle, buttonElement) {
        const targetIcon = buttonElement.querySelector('i');

        // TRƯỜNG HỢP 1: Bài này đang phát -> Người dùng nhấn vào để TẠM DỪNG
        if (currentPlayingTitle === songTitle) {
            targetIcon.classList.remove('bi-pause-fill');
            targetIcon.classList.add('bi-play-fill');
            targetIcon.style.color = '#2fbc61';

            currentPlayingTitle = null;
            showMp3Toast("Đã tạm dừng bài hát: " + songTitle, "bi-pause-circle-fill", "#ff6b6b");
            return;
        }

        // TRƯỜNG HỢP 2: Người dùng muốn PHÁT một bài hát mới
        const allSongIcons = document.querySelectorAll('.song-play-btn-track');
        allSongIcons.forEach(icon => {
            icon.classList.remove('bi-pause-fill');
            icon.classList.add('bi-play-fill');
            icon.style.color = '#2fbc61';
        });

        targetIcon.classList.remove('bi-play-fill');
        targetIcon.classList.add('bi-pause-fill');
        targetIcon.style.color = '#00f2fe';

        currentPlayingTitle = songTitle;

        isPlaying = false;
        const btnText = document.getElementById('lblPlayText');
        if(btnText) btnText.innerHTML = "Phát tất cả";

        showMp3Toast("Đang phát bài hát: " + songTitle, "bi-music-note-beamed", "#00f2fe");
    }

    function addSongToPlaylist(songId, songTitle) {
        showMp3Toast("Đang thêm bài '" + songTitle + "' vào playlist...", "bi-check-circle-fill", "#2fbc61");

        setTimeout(() => {
            window.location.href = "${pageContext.request.contextPath}/playlist?action=addSong&id=${playlistId}&songId=" + songId;
        }, 800);
    }
</script>