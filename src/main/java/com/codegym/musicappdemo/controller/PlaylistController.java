package com.codegym.musicappdemo.controller;

import com.codegym.musicappdemo.model.Playlist;
import com.codegym.musicappdemo.model.Song;
import com.codegym.musicappdemo.repository.IPlaylistRepository;
import com.codegym.musicappdemo.repository.PlaylistRepository;
import com.codegym.musicappdemo.repository.SongRepository;
import com.codegym.musicappdemo.service.PlaylistService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "PlaylistController", value = "/playlist")
public class PlaylistController extends HttpServlet {
    private IPlaylistRepository playlistRepository = new PlaylistRepository();
    private SongRepository songRepository = new SongRepository();

    private PlaylistService playlistService = new PlaylistService();
    private final long userId = 2L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String playlistIdStr = request.getParameter("id");

        // 1. Xử lý xóa playlist
        if ("delete".equals(action) && playlistIdStr != null) {
            try {
                long playlistId = Long.parseLong(playlistIdStr);
                playlistRepository.deleteById(playlistId);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/playlist");
            return;
        }

        // 2. Xử lý mở giao diện sửa playlist
        if ("edit".equals(action) && playlistIdStr != null) {
            try {
                long playlistId = Long.parseLong(playlistIdStr);
                Playlist currentPlaylist = playlistRepository.findById(playlistId);
                request.setAttribute("playlist", currentPlaylist);
                request.setAttribute("view", "/WEB-INF/views/playlist-edit.jsp");
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/playlist");
                return;
            }
        }

        // 3. Xử lý nghiệp vụ: THÊM BÀI HÁT VÀO PLAYLIST
        else if ("addSong".equals(action)) {
            String songIdStr = request.getParameter("songId");

            // Gọi tầng Service để thực hiện toàn bộ chặng check lỗi (Trùng bài, ID bậy, Hack quyền...)
            String result = playlistService.addSongToPlaylistBusiness(playlistIdStr, songIdStr, userId);

            if ("THANH_CONG".equals(result)) {
                response.sendRedirect(request.getContextPath() + "/playlist?id=" + playlistIdStr);
                return;
            } else {
                request.getSession().setAttribute("errorMessage", result);
                response.sendRedirect(request.getContextPath() + "/playlist?id=" + playlistIdStr);
                return;
            }
        }

        // Xử lý nghiệp vụ: GỠ BÀI HÁT KHỎI PLAYLIST
        else if ("removeSong".equals(action)) {
            String songIdStr = request.getParameter("songId");

            // Gọi Service kiểm tra quyền hạn và thực thi xóa
            String result = playlistService.removeSongFromPlaylistBusiness(playlistIdStr, songIdStr, userId);

            if ("THANH_CONG".equals(result)) {
                // Nếu thành công, chuyển hướng lại trang chi tiết playlist
                response.sendRedirect(request.getContextPath() + "/playlist?id=" + playlistIdStr);
                return;
            } else {
                // Nếu dính lỗi bảo mật/ID bậy, nhét thông báo lỗi vào Session để đẩy lên giao diện Toast cảnh báo
                request.getSession().setAttribute("errorMessage", result);
                response.sendRedirect(request.getContextPath() + "/playlist?id=" + playlistIdStr);
                return;
            }
        }

        // 4. Điều hướng mở giao diện tạo mới playlist
        else if ("create".equals(action)) {
            request.setAttribute("view", "/WEB-INF/views/playlist-create.jsp");
        }

        // 5. Nếu không truyền ID => Hiển thị danh sách toàn bộ Playlist cá nhân
        else if (playlistIdStr == null || playlistIdStr.trim().isEmpty()) {
            List<Playlist> playlists = playlistRepository.findPlaylistsByUserId(userId);
            request.setAttribute("playlists", playlists);
            request.setAttribute("view", "/WEB-INF/views/playlist-list.jsp");
        }

        // 6. Trường hợp cuối: Xem chi tiết playlist hiện có VÀ xử lý Tìm kiếm nhạc trong list
        else {
            try {
                long playlistId = Long.parseLong(playlistIdStr);

                // Lấy danh sách nhạc hiện tại đang có trong list (Đã nạp file_url từ Repository)
                List<Song> songs = playlistRepository.findSongsInPlaylist(playlistId);
                request.setAttribute("songs", songs);
                request.setAttribute("playlistId", playlistId);

                // Kiểm tra xem session có thông báo lỗi từ đợt hành động trước truyền sang không
                String errorMsg = (String) request.getSession().getAttribute("errorMessage");
                if (errorMsg != null) {
                    request.setAttribute("businessError", errorMsg);
                    request.getSession().removeAttribute("errorMessage");
                }

                // Kiểm tra và xử lý thanh tìm kiếm bài hát từ hệ thống để thêm vào playlist
                String searchSong = request.getParameter("searchSong");
                if (searchSong != null && !searchSong.trim().isEmpty()) {
                    List<Song> foundSongs = songRepository.searchSongs(searchSong.trim());
                    request.setAttribute("foundSongs", foundSongs);
                }

                request.setAttribute("view", "/WEB-INF/views/playlist-detail.jsp");
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/playlist");
                return;
            }
        }

        request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String playlistName = request.getParameter("playlistName");

        // Sử dụng hàm validate tên từ PlaylistService
        String validateResult = playlistService.validatePlaylistName(playlistName);

        if ("update".equals(action)) {
            String playlistIdStr = request.getParameter("playlistId");

            // Nếu tên hợp lệ mới tiến hành cập nhật dữ liệu
            if ("VALID".equals(validateResult) && playlistIdStr != null) {
                Playlist playlist = new Playlist();
                playlist.setId(Long.parseLong(playlistIdStr));
                playlist.setName(playlistName.trim());
                playlistRepository.update(playlist);
            } else if (!"VALID".equals(validateResult)) {
                // Đẩy thông báo lỗi nếu tên quá dài, quá ngắn hoặc chứa kí tự lạ
                request.getSession().setAttribute("errorMessage", validateResult);
            }
        } else {
            // Trường hợp: Tạo mới một Playlist
            if ("VALID".equals(validateResult)) {
                Playlist newPlaylist = new Playlist();
                newPlaylist.setUserId(userId);
                newPlaylist.setName(playlistName.trim());
                playlistRepository.save(newPlaylist);
            } else {
                request.getSession().setAttribute("errorMessage", validateResult);
            }
        }
        response.sendRedirect(request.getContextPath() + "/playlist");
    }
}