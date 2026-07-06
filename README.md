# 🎵 VibeStream - Music Streaming Web Application

**VibeStream** là một ứng dụng phát nhạc trực tuyến được xây dựng trên nền tảng Java Web (JSP / Servlet / JDBC thuần) kết hợp cơ sở dữ liệu MySQL. Dự án sở hữu giao diện Dark Mode hiện đại lấy cảm hứng từ Spotify, hỗ trợ phân quyền người dùng và tích hợp các tính năng tương tác nhạc thời gian thực mượt mà.

---

## ✨ Tính Năng Nổi Bật

### 🔐 Xác Thực & Phân Quyền (`Auth & Role-based Access`)
* **Đăng ký & Đăng nhập:** Hệ thống xử lý tập trung, quản lý trạng thái qua `Session`.
* **Phân quyền (RBAC):** * **ROLE_USER:** Tìm kiếm bài hát, nghe nhạc trực tuyến qua trình phát nhạc thông minh.
    * **ROLE_ADMIN:** Quản trị hệ thống, thêm bài hát (upload trực tiếp file từ máy), xóa bài hát khỏi nền tảng.

### 🎧 Trình Phát Nhạc & Tương Tác (`Music Player`)
* **Phát nhạc nhanh:** Click phát nhạc trực tiếp ngay khi hover vào dòng bài hát trên danh sách.
* **Upload File thông minh:** Admin tải nhạc (`.mp3`) và ảnh bìa (`.png`, `.jpg`) trực tiếp lên server. Hệ thống tự động mã hóa tên file bằng `UUID` để tránh trùng lặp và lỗi font tiếng Việt.
* **Tìm kiếm thông minh (Search):** Tìm kiếm bài hát gần đúng dựa theo tên bài hát, ca sĩ hoặc thể loại.

---

## 🛠️ Công Nghệ Sử Dụng

* **Backend:** Java Servlet, JSP, JSTL, JDBC (MySQL Connector/J).
* **Database:** MySQL Server.
* **Frontend:** HTML5, CSS3 (Custom Dark Theme), JavaScript (Fetch API / Web Audio UI), Bootstrap 5, FontAwesome 6.
* **Server / Build Tool:** Apache Tomcat (v9.0 hoặc v10.x), Maven / Gradle.

---

## 📂 Cấu Trúc Thư Mục Dự Án (MVC Pattern)

```text
com.codegym.musicappdemo/
├── controller/          # Nơi chứa các Servlet xử lý Request (Auth, Songs, Admin)
├── model/               # Các lớp thực thể đối tượng (User, Song, Artist, Genre)
└── repository/          # Tầng tương tác trực tiếp với DB qua JDBC thuần

webapp/
├── WEB-INF/
│   └── views/           # Chứa các file giao diện an toàn (.jsp) tránh truy cập lén
└── static/              # Tài nguyên tĩnh của hệ thống
    ├── audio/           # Nơi lưu trữ các file nhạc .mp3 được Admin upload lên
    ├── img/             # Nơi lưu trữ ảnh bìa bài hát
    └── css/js/          # File định dạng và mã xử lý trình phát nhạc

🚀 Hướng Dẫn Cài Đặt & Chạy Dự Án
1. Chuẩn bị môi trường
Cài đặt JDK 11 hoặc JDK 17.

Cài đặt MySQL Server và một IDE bất kỳ (IntelliJ IDEA / Eclipse / VS Code).

Cài đặt Apache Tomcat Server (phù hợp với phiên bản jakarta hoặc javax trong dự án).
