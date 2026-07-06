package com.codegym.musicappdemo.controller;

import com.codegym.musicappdemo.model.Song;
import com.codegym.musicappdemo.model.User;
import com.codegym.musicappdemo.repository.SongRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/add-song")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 50,       // Tối đa 50MB cho một file nhạc
        maxRequestSize = 1024 * 1024 * 100    // Tổng dung lượng request tối đa 100MB
)
public class AddSongServlet extends HttpServlet {
    private final SongRepository songRepository = new SongRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null || !"ROLE_ADMIN".equals(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền!");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/add-song.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null || !"ROLE_ADMIN".equals(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Thao tác không hợp lệ!");
            return;
        }

        try {
            String title = request.getParameter("title");
            long artistId = Long.parseLong(request.getParameter("artistId"));
            long genreId = Long.parseLong(request.getParameter("genreId"));

            // Đường dẫn vật lý đến thư mục static trên Tomcat Server
            String appPath = request.getServletContext().getRealPath("");
            String audioDirPath = appPath + "static" + File.separator + "audio";
            String imgDirPath = appPath + "static" + File.separator + "img";

            // Tạo thư mục nếu chưa tồn tại
            File audioDir = new File(audioDirPath);
            if (!audioDir.exists()) audioDir.mkdirs();
            File imgDir = new File(imgDirPath);
            if (!imgDir.exists()) imgDir.mkdirs();

            // 1. Xử lý upload file Audio (.mp3)
            Part audioPart = request.getPart("audioFile");
            String audioFileName = getSubmittedFileName(audioPart);
            // Đổi tên file bằng UUID để tránh lỗi trùng tên file, mất dấu tiếng Việt
            String uniqueAudioName = UUID.randomUUID().toString() + "_" + audioFileName;
            audioPart.write(audioDirPath + File.separator + uniqueAudioName);
            String fileUrl = "static/audio/" + uniqueAudioName; // Đường dẫn lưu vào DB

            // 2. Xử lý upload file Ảnh bìa
            Part imgPart = request.getPart("imgFile");
            String imgFileName = getSubmittedFileName(imgPart);
            String imgUrl = "static/img/default-cover.jpg"; // Mặc định nếu không up ảnh

            if (imgFileName != null && !imgFileName.isEmpty()) {
                String uniqueImgName = UUID.randomUUID().toString() + "_" + imgFileName;
                imgPart.write(imgDirPath + File.separator + uniqueImgName);
                imgUrl = "static/img/" + uniqueImgName; // Đường dẫn lưu vào DB
            }

            // Tiến hành lưu thông tin vào database
            Song newSong = new Song(0L, title, "", imgUrl, fileUrl);
            boolean isSuccess = songRepository.addSong(newSong, artistId, genreId);

            if (isSuccess) {
                response.sendRedirect(request.getContextPath() + "/home?addSuccess=true");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi lưu vào database!");
                request.getRequestDispatcher("/WEB-INF/views/add-song.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi tải file lên hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/add-song.jsp").forward(request, response);
        }
    }

    // Hàm bổ trợ lấy tên file gốc từ Part Header
    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1);
            }
        }
        return null;
    }
}