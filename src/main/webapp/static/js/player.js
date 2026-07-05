document.addEventListener("DOMContentLoaded", function () {
    // 1. Khởi tạo các thành phần Audio Player ở Footer
    const audio = document.getElementById("main-audio");
    const playBtn = document.getElementById("btn-play-pause");
    const playIcon = document.getElementById("play-icon");
    const progressBar = document.getElementById("progress-bar");
    const volumeBar = document.getElementById("volume-bar");

    // Đọc chính xác các ID hiển thị thông tin bài hát đang phát ở footer
    const pTitle = document.getElementById("player-title");
    const pArtist = document.getElementById("player-artist");
    const pImg = document.getElementById("player-img");

    const currentTimeSpan = document.getElementById("current-time");
    const totalTimeSpan = document.getElementById("total-time");

    // Hàm thực hiện gán bài hát và chạy nhạc
    function playSong(element) {
        const title = element.getAttribute("data-title");
        const artist = element.getAttribute("data-artist");
        const url = element.getAttribute("data-url");
        const img = element.getAttribute("data-img");

        if (pTitle) pTitle.innerText = title;
        if (pArtist) pArtist.innerText = artist;
        if (pImg) pImg.src = img;

        if (audio && url) {
            audio.src = url;
            audio.load(); // Nạp bài hát mới vào luồng

            audio.play()
                .then(() => {
                    if (playIcon) playIcon.className = "fa-solid fa-pause text-black fs-5";
                })
                .catch(error => {
                    console.error("Lỗi luồng phát nhạc: ", error);
                    alert("Không thể giải mã file nhạc này. Vui lòng đảm bảo cột file_url trong cơ sở dữ liệu là một đường dẫn trực tiếp tới file âm thanh (Ví dụ có đuôi kết thúc bằng .mp3)!");
                });
        }
    }

    // 2. Click vào nút Play màu xanh trên ảnh đại diện
    document.querySelectorAll(".btn-play-now").forEach(button => {
        button.addEventListener("click", function (e) {
            e.stopPropagation(); // Không cho sự kiện lan ra ngoài hàng tr
            playSong(this);
        });
    });

    // 3. Click vào bất cứ đâu trên hàng dòng bài hát tr (Trừ nút xóa)
    document.querySelectorAll(".container-song-row").forEach(row => {
        row.addEventListener("click", function (e) {
            if (e.target.closest(".btn-delete-custom") || e.target.closest("a")) {
                return; // Nếu bấm nút xóa thì dừng lại không phát nhạc
            }
            const targetBtn = this.querySelector(".btn-play-now");
            if (targetBtn) {
                playSong(targetBtn);
            }
        });
    });

    // 4. Sự kiện bấm nút điều khiển Play/Pause tổng dưới thanh Player
    if (playBtn) {
        playBtn.addEventListener("click", function () {
            if (!audio || !audio.src) return;
            if (audio.paused) {
                audio.play();
                if (playIcon) playIcon.className = "fa-solid fa-pause text-black fs-5";
            } else {
                audio.pause();
                if (playIcon) playIcon.className = "fa-solid fa-play text-black fs-5";
            }
        });
    }

    // 5. Cập nhật thanh thời gian chạy nhạc
    if (audio) {
        audio.addEventListener("timeupdate", function () {
            if (audio.duration && progressBar) {
                const pct = (audio.currentTime / audio.duration) * 100;
                progressBar.value = pct;
                if (currentTimeSpan) currentTimeSpan.innerText = formatTime(audio.currentTime);
                if (totalTimeSpan) totalTimeSpan.innerText = formatTime(audio.duration);
            }
        });
    }

    if (progressBar) {
        progressBar.addEventListener("input", function () {
            if (audio && audio.duration) {
                audio.currentTime = (progressBar.value / 100) * audio.duration;
            }
        });
    }

    if (volumeBar) {
        volumeBar.addEventListener("input", function () {
            if (audio) audio.volume = volumeBar.value / 100;
        });
    }

    function formatTime(secs) {
        if (isNaN(secs)) return "0:00";
        let min = Math.floor(secs / 60);
        let sec = Math.floor(secs % 60);
        if (sec < 10) sec = "0" + sec;
        return min + ":" + sec;
    }

    document.querySelectorAll(".btn-delete-custom").forEach(button => {
        button.addEventListener("click", function (e) {
            e.stopPropagation(); // Ngăn chặn tuyệt đối việc kích hoạt phát nhạc khi bấm nút xóa

            const songId = this.getAttribute("data-id");
            const songTitle = this.getAttribute("data-title");

            if (!songId) {
                alert("Không tìm thấy ID của bài hát này!");
                return;
            }

            // Hiển thị hộp thoại xác nhận xóa cho an toàn
            if (confirm(`Bạn có chắc chắn muốn xóa bài hát "${songTitle}" khỏi danh sách không?`)) {

                window.location.href = `delete-song?id=${songId}`;
            }
        });
    });
});