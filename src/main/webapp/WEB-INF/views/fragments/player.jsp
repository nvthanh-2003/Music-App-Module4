<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="bg-black text-white fixed-bottom py-3 px-4 border-top border-secondary">
    <div class="row align-items-center">
        <div class="col-md-3 d-flex align-items-center">
            <img id="player-img" src="https://via.placeholder.com/50" class="rounded me-3" style="width: 50px; height: 50px; object-fit: cover;">
            <div>
                <h6 id="player-title" class="mb-0 text-truncate" style="max-width: 180px;">Chưa chọn bài hát</h6>
                <small id="player-artist" class="text-muted">Ca sĩ</small>
            </div>
        </div>

        <div class="col-md-6 text-center">
            <div class="d-flex justify-content-center align-items-center mb-2">
                <button class="btn btn-link text-white mx-2"><i class="fa-solid fa-backward-step fs-5"></i></button>
                <button id="btn-play-pause" class="btn btn-light rounded-circle mx-3 d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                    <i id="play-icon" class="fa-solid fa-play text-black fs-5"></i>
                </button>
                <button class="btn btn-link text-white mx-2"><i class="fa-solid fa-forward-step fs-5"></i></button>
            </div>
            <div class="d-flex align-items-center justify-content-center">
                <span id="current-time" class="small text-muted me-2">0:00</span>
                <input type="range" id="progress-bar" class="form-range w-70" value="0" min="0" max="100">
                <span id="total-time" class="small text-muted ms-2">0:00</span>
            </div>
            <audio id="main-audio" src=""></audio>
        </div>

        <div class="col-md-3 d-flex justify-content-end align-items-center">
            <i class="fa-solid fa-volume-high me-2"></i>
            <input type="range" id="volume-bar" class="form-range" style="width: 100px;" value="100">
        </div>
    </div>
</div>