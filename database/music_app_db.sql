CREATE DATABASE IF NOT EXISTS music_app_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE music_app_db;

-- Tắt kiểm tra khóa ngoại tạm thời để drop bảng không bị lỗi ràng buộc
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS playlist_song;
DROP TABLE IF EXISTS playlists;
DROP TABLE IF EXISTS songs;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS artists;
DROP TABLE IF EXISTS users;

SET FOREIGN_KEY_CHECKS = 1;

-- ==========================================================================
-- 2. TẠO CẤU TRÚC CÁC BẢNG HỆ THỐNG
-- ==========================================================================

-- Bảng Users (Người dùng & Admin)
CREATE TABLE users (
                       id BIGINT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(50) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL, -- Độ dài 255 để lưu mật khẩu mã hóa BCrypt
                       email VARCHAR(100) NOT NULL UNIQUE,
                       role VARCHAR(20) NOT NULL DEFAULT 'ROLE_USER', -- ROLE_USER hoặc ROLE_ADMIN
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng Genres (Thể loại nhạc)
CREATE TABLE genres (
                        id BIGINT AUTO_INCREMENT PRIMARY KEY,
                        name VARCHAR(100) NOT NULL UNIQUE,
                        description TEXT
);

-- Bảng Artists (Ca sĩ / Nhạc sĩ)
CREATE TABLE artists (
                         id BIGINT AUTO_INCREMENT PRIMARY KEY,
                         name VARCHAR(100) NOT NULL,
                         bio TEXT,
                         img_url VARCHAR(555) -- Đường dẫn ảnh đại diện ca sĩ
);

-- Bảng Songs (Bài hát - Đã tối ưu cấu trúc ràng buộc)
CREATE TABLE songs (
                       id BIGINT AUTO_INCREMENT PRIMARY KEY,
                       title VARCHAR(150) NOT NULL,
                       artist_id BIGINT,
                       genre_id BIGINT,
                       file_url VARCHAR(555) NOT NULL, -- Đường dẫn file .mp3 cục bộ hoặc URL trực tiếp
                       img_url VARCHAR(555),           -- Ảnh bìa bài hát
                       view_count INT DEFAULT 0,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       CONSTRAINT fk_song_artist FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE SET NULL,
                       CONSTRAINT fk_song_genre FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE SET NULL
);

-- Bảng Playlists (Danh sách phát cá nhân)
CREATE TABLE playlists (
                           id BIGINT AUTO_INCREMENT PRIMARY KEY,
                           user_id BIGINT NOT NULL,
                           name VARCHAR(100) NOT NULL,
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           CONSTRAINT fk_playlist_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Bảng trung gian Playlist_Song (Quan hệ Many-to-Many)
CREATE TABLE playlist_song (
                               playlist_id BIGINT NOT NULL,
                               song_id BIGINT NOT NULL,
                               PRIMARY KEY (playlist_id, song_id),
                               CONSTRAINT fk_ps_playlist FOREIGN KEY (playlist_id) REFERENCES playlists(id) ON DELETE CASCADE,
                               CONSTRAINT fk_ps_song FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE
);

-- ==========================================================================
-- 3. CHÈN DỮ LIỆU MẪU CHUẨN (FIX CỐ ĐỊNH ID)
-- ==========================================================================

-- Chèn tài khoản mẫu
INSERT INTO users (id, username, password, email, role) VALUES
                                                            (1, 'admin', 'admin123', 'admin@musicapp.com', 'ROLE_ADMIN'),
                                                            (2, 'thanhngo', 'thanh123', 'thanh@gmail.com', 'ROLE_USER');

-- Chèn thể loại nhạc
INSERT INTO genres (id, name, description) VALUES
                                               (1, 'Future Bass', 'nhạc điện tử (EDM) hiện đại pha trộn các yếu tố truyền thống'),
                                               (2, 'Rap', 'Rap tâm sự / Lullaby (nhạc hát ru) với giai điệu sâu lắng, ca từ'),
                                               (3, 'Rap-Nhạc trẻ', 'Giai điệu trầm buồn, kết hợp phong cách đọc rap tự sự');

-- Chèn ca sĩ
INSERT INTO artists (id, name, bio, img_url) VALUES
                                                 (1, 'Masew', 'nhạc sĩ và nhà sản xuất âm nhạc nổi tiếng', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGjulGlp50xmpBqglz0pQ1Phke3XDUDCGPwsaj3dQENQ&s=10'),
                                                 (2, 'B Ray', 'Rapper với flow đa dạng và ca từ mang tính châm biếm sâu sắc', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4bE3wNVfBil1mCAIv5_6W9W40MeAvRs3QJmQyWF0NTA&s=10'),
                                                 (3, 'B Ray', 'Rapper với flow đa dạng và ca từ mang tính châm biếm sâu sắc', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4bE3wNVfBil1mCAIv5_6W9W40MeAvRs3QJmQyWF0NTA&s=10');

-- Chèn bài hát mẫu chỉ định SẴN ID và ĐƯỜNG DẪN CỤC BỘ (Không lo bị lệch ID khi chạy lại)
INSERT INTO songs (id, title, artist_id, genre_id, file_url, img_url, view_count) VALUES
                                                                                      (1, 'Túy Âm', 1, 1, 'static/audio/tuy-am.mp3', 'https://i1.sndcdn.com/artworks-000239838225-avadfn-t500x500.jpg', 1500),
                                                                                      (2, 'Cho Con', 2, 2, 'static/audio/cho-con.mp3', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3H8zUWjmSHTZ6HOcaGsgE97Eao3fuCT3OepmExHMpBINSUnElqHwgAQSC4nXuVZFv3i2dOI-GnZVIEMOqmlHEG2R3qf0dC3wwnzDuiVjhjg&s=10', 2300),
                                                                                      (3, 'Cao Ốc 20', 3, 3, 'static/audio/cao-oc-20.mp3', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlFOTq2Qw4nSdUeXcMp1FPlLVDJKneDliXxsVCMLZVeRK7RDGuczwByy__GtwtGAqH7HUqu2jnONW7zo22lVEarIFjmcSZrZXl3Kr-1TLy&s=10', 950);
