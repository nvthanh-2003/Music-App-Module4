-- 1. Tạo Database
CREATE DATABASE IF NOT EXISTS music_app_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE music_app_db;

DROP TABLE IF EXISTS playlist_song;
DROP TABLE IF EXISTS playlists;
DROP TABLE IF EXISTS songs;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS artists;
DROP TABLE IF EXISTS users;

-- 3. Bảng Users (Người dùng & Admin)
CREATE TABLE users (
                       id BIGINT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(50) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL, -- Độ dài 255 để sau này lưu mật khẩu mã hóa BCrypt
                       email VARCHAR(100) NOT NULL UNIQUE,
                       role VARCHAR(20) NOT NULL DEFAULT 'ROLE_USER', -- ROLE_USER hoặc ROLE_ADMIN
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Bảng Genres (Thể loại nhạc)
CREATE TABLE genres (
                        id BIGINT AUTO_INCREMENT PRIMARY KEY,
                        name VARCHAR(100) NOT NULL UNIQUE,
                        description TEXT
);

-- 5. Bảng Artists (Ca sĩ / Nhạc sĩ)
CREATE TABLE artists (
                         id BIGINT AUTO_INCREMENT PRIMARY KEY,
                         name VARCHAR(100) NOT NULL,
                         bio TEXT,
                         img_url VARCHAR(555) -- Đường dẫn ảnh đại diện ca sĩ
);

-- 6. Bảng Songs (Bài hát)
CREATE TABLE songs (
                       id BIGINT AUTO_INCREMENT PRIMARY KEY,
                       title VARCHAR(150) NOT NULL,
                       artist_id BIGINT,
                       genre_id BIGINT,
                       file_url VARCHAR(555) NOT NULL, -- Đường dẫn file .mp3 (Link URL hoặc đường dẫn cục bộ)
                       img_url VARCHAR(555),           -- Ảnh bìa bài hát (Album Art)
                       view_count INT DEFAULT 0,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       CONSTRAINT fk_song_artist FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE SET NULL,
                       CONSTRAINT fk_song_genre FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE SET NULL
);

-- 7. Bảng Playlists (Danh sách phát cá nhân)
CREATE TABLE playlists (
                           id BIGINT AUTO_INCREMENT PRIMARY KEY,
                           user_id BIGINT NOT NULL,
                           name VARCHAR(100) NOT NULL,
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           CONSTRAINT fk_playlist_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 8. Bảng trung gian Playlist_Song (Quan hệ Many-to-Many giữa Playlist và Song)
CREATE TABLE playlist_song (
                               playlist_id BIGINT NOT NULL,
                               song_id BIGINT NOT NULL,
                               PRIMARY KEY (playlist_id, song_id),
                               CONSTRAINT fk_ps_playlist FOREIGN KEY (playlist_id) REFERENCES playlists(id) ON DELETE CASCADE,
                               CONSTRAINT fk_ps_song FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE
);


USE music_app_db;

-- Chèn tài khoản mẫu (Mật khẩu dưới đây là text thô, phục vụ test session/cookie trước)
INSERT INTO users (username, password, email, role) VALUES
                                                        ('admin', 'admin123', 'admin@musicapp.com', 'ROLE_ADMIN'),
                                                        ('thanhngo', 'thanh123', 'thanh@gmail.com', 'ROLE_USER');

-- Chèn thể loại nhạc
INSERT INTO genres (name, description) VALUES
                                           ('V-Pop', 'Nhạc trẻ Pop Việt Nam cực hot'),
                                           ('Lofi', 'Nhạc lofi chill nhẹ nhàng học bài'),
                                           ('Indie', 'Âm nhạc độc lập thuần khiết');

-- Chèn ca sĩ
INSERT INTO artists (name, bio, img_url) VALUES
                                             ('Sơn Tùng M-TP', 'Ca sĩ, nhạc sĩ hàng đầu Việt Nam', 'https://example.com/sontung.jpg'),
                                             ('Đen Vâu', 'Rapper mang đậm chất đời và triết lý', 'https://example.com/denvau.jpg'),
                                             ('Vũ', 'Hoàng tử indie Việt với những bản tình ca da diết', 'https://example.com/vu.jpg');

-- Chèn bài hát mẫu (Sử dụng link nhạc giả lập hoặc link thật nếu các bạn có)
INSERT INTO songs (title, artist_id, genre_id, file_url, img_url, view_count) VALUES
                                                                                  ('Chúng Ta Của Tương Lai', 1, 1, 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3', 'https://example.com/cover1.jpg', 1500),
                                                                                  ('Nấu Ăn Cho Em', 2, 3, 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3', 'https://example.com/cover2.jpg', 2300),
                                                                                  ('Lạ Lùng', 3, 3, 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3', 'https://example.com/cover3.jpg', 950);