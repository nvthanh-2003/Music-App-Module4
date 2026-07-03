document.addEventListener("DOMContentLoaded", function () {
    const audio = document.getElementById("main-audio");
    const playBtn = document.getElementById("btn-play-pause");
    const playIcon = document.getElementById("play-icon");
    const progressBar = document.getElementById("progress-bar");
    const volumeBar = document.getElementById("volume-bar");

    const pTitle = document.getElementById("player-title");
    const pArtist = document.getElementById("player-artist");
    const pImg = document.getElementById("player-img");

    const currentTimeSpan = document.getElementById("current-time");
    const totalTimeSpan = document.getElementById("total-time");

    // Lắng nghe sự kiện click nút Play trên từng bài hát
    document.querySelectorAll(".btn-play-now").forEach(button => {
        button.addEventListener("click", function () {
            const title = this.getAttribute("data-title");
            const artist = this.getAttribute("data-artist");
            const url = this.getAttribute("data-url");
            const img = this.getAttribute("data-img");

            pTitle.innerText = title;
            pArtist.innerText = artist;
            pImg.src = img;
            audio.src = url;

            audio.play();
            playIcon.className = "fa-solid fa-pause text-black fs-5";
        });
    });

    // Bật/tạm dừng nhạc tại thanh Player điều khiển dưới cùng
    playBtn.addEventListener("click", function () {
        if (!audio.src) return;
        if (audio.paused) {
            audio.play();
            playIcon.className = "fa-solid fa-pause text-black fs-5";
        } else {
            audio.pause();
            playIcon.className = "fa-solid fa-play text-black fs-5";
        }
    });

    // Cập nhật thanh tiến trình chạy theo thời gian bài hát
    audio.addEventListener("timeupdate", function () {
        if (audio.duration) {
            const pct = (audio.currentTime / audio.duration) * 100;
            progressBar.value = pct;
            currentTimeSpan.innerText = formatTime(audio.currentTime);
            totalTimeSpan.innerText = formatTime(audio.duration);
        }
    });

    progressBar.addEventListener("input", function () {
        if (audio.duration) {
            audio.currentTime = (progressBar.value / 100) * audio.duration;
        }
    });

    volumeBar.addEventListener("input", function () {
        audio.volume = volumeBar.value / 100;
    });

    function formatTime(secs) {
        let min = Math.floor(secs / 60);
        let sec = Math.floor(secs % 60);
        if (sec < 10) sec = "0" + sec;
        return min + ":" + sec;
    }
});