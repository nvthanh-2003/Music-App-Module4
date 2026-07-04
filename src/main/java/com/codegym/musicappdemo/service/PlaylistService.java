package com.codegym.musicappdemo.service;

import com.codegym.musicappdemo.model.Playlist;
import com.codegym.musicappdemo.model.Song;
import com.codegym.musicappdemo.repository.PlaylistRepository;

import java.util.List;

public class PlaylistService {

    private PlaylistRepository playlistRepository = new PlaylistRepository();


    public String addSongToPlaylistBusiness(String playlistIdStr, String songIdStr, long currentUserId) {

        // 1. Kiểm tra dữ liệu có bị trống/null không (Trường hợp hack URL phá hoại)
        if (playlistIdStr == null || playlistIdStr.trim().isEmpty() ||
                songIdStr == null || songIdStr.trim().isEmpty()) {
            return "Mã định danh playlist hoặc bài hát không được để trống!";
        }

        long playlistId;
        long songId;

        // 2. Kiểm tra ID có phải là số hợp lệ không (Đề phòng người dùng cố tình gõ chữ lên URL như: ?songId=abc)
        try {
            playlistId = Long.parseLong(playlistIdStr.trim());
            songId = Long.parseLong(songIdStr.trim());
        } catch (NumberFormatException e) {
            return "Mã định danh hệ thống (ID) phải là số nguyên hợp lệ!";
        }

        // 3. Kiểm tra giá trị số của ID (ID tự tăng trong DB luôn phải lớn hơn 0)
        if (playlistId <= 0 || songId <= 0) {
            return "Mã số định danh không hợp lệ (phải là số dương lớn hơn 0)!";
        }

        // 4. Kiểm tra Playlist có tồn tại thực tế trong DB không
        Playlist playlist = playlistRepository.findById(playlistId);
        if (playlist == null) {
            return "Playlist này không tồn tại trên hệ thống hoặc đã bị xóa trước đó!";
        }

        // 5. Kiểm tra bảo mật (Phân quyền): Ngăn chặn User A đổi ID trên URL để nhét nhạc vào Playlist của User B
        if (playlist.getUserId() != currentUserId) {
            return "Tài khoản của bạn không có quyền chỉnh sửa playlist cá nhân này!";
        }

        // 6. Kiểm tra danh sách nhạc hiện tại trong Playlist để check trùng và check giới hạn số lượng
        List<Song> currentSongs = playlistRepository.findSongsInPlaylist(playlistId);

        if (currentSongs != null) {
            // Nghiệp vụ A: Kiểm tra trùng lặp bài hát (Không cho phép một bài xuất hiện nhiều lần trong 1 list)
            for (Song song : currentSongs) {
                if (song.getId() == songId) {
                    return "Bài hát '" + song.getTitle() + "' đã có sẵn trong playlist này rồi!";
                }
            }

            // Nghiệp vụ B: Giới hạn số lượng bài hát tối đa (Tránh spam nghẽn băng thông UI)
            if (currentSongs.size() >= 100) {
                return "Playlist đã đạt giới hạn tối đa (100 bài). Vui lòng gỡ bớt nhạc trước khi thêm bài mới!";
            }
        }

        boolean isSuccess = playlistRepository.addSongToPlaylist(playlistId, songId);
        if (isSuccess) {
            return "THANH_CONG";
        } else {
            return "Lỗi hệ thống: Không thể lưu liên kết vào cơ sở dữ liệu. Vui lòng thử lại sau!";
        }
    }

    public String removeSongFromPlaylistBusiness(String playlistIdStr, String songIdStr, long currentUserId) {

        // 1. Kiểm tra rỗng/null
        if (playlistIdStr == null || playlistIdStr.trim().isEmpty() ||
                songIdStr == null || songIdStr.trim().isEmpty()) {
            return "Mã định danh dữ liệu không được để trống!";
        }

        long playlistId;
        long songId;

        // 2. Kiểm tra định dạng số hợp lệ
        try {
            playlistId = Long.parseLong(playlistIdStr.trim());
            songId = Long.parseLong(songIdStr.trim());
        } catch (NumberFormatException e) {
            return "Mã định danh hệ thống (ID) phải là số hợp lệ!";
        }

        // 3. Kiểm tra số dương lớn hơn 0
        if (playlistId <= 0 || songId <= 0) {
            return "Mã số định danh không hợp lệ!";
        }

        // 4. Kiểm tra Playlist có tồn tại không
        Playlist playlist = playlistRepository.findById(playlistId);
        if (playlist == null) {
            return "Playlist không tồn tại trên hệ thống!";
        }

        // 5. Kiểm tra phân quyền: Chỉ chủ sở hữu mới được xóa nhạc khỏi Playlist của mình
        if (playlist.getUserId() != currentUserId) {
            return "Bạn không có quyền gỡ bài hát khỏi playlist của người khác!";
        }

        // 6. Thực thi xóa liên kết trong DB
        playlistRepository.deleteSongFromPlaylist(playlistId, songId);
        return "THANH_CONG";
    }

    public String validatePlaylistName(String playlistName) {
        // 1. Kiểm tra rỗng hoặc chỉ chứa khoảng trắng
        if (playlistName == null || playlistName.trim().isEmpty()) {
            return "Tên playlist không được phép để trống!";
        }

        String nameTrimmed = playlistName.trim();

        // 2. Kiểm tra độ dài ký tự tối thiểu
        if (nameTrimmed.length() < 2) {
            return "Tên playlist quá ngắn (yêu cầu tối thiểu từ 2 ký tự trở lên)!";
        }

        // 3. Kiểm tra độ dài ký tự tối đa (Tránh làm vỡ layout giao diện ZingMP3 hoặc tràn bộ đệm DB)
        if (nameTrimmed.length() > 50) {
            return "Tên playlist quá dài (chỉ cho phép tối đa 50 ký tự)!";
        }

        // 4. Chống phá hoại bằng ký tự đặc biệt lạ / XSS Injection (Chỉ cho phép chữ Tiếng Việt, số, khoảng trắng, dấu gạch ngang, gạch dưới và ngoặc đơn)
        String regex = "^[a-zA-Z0-9ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỨỬỮỰỲÝỴÝỳýỵỷỹ\\s\\-_()]+$";
        if (!nameTrimmed.matches(regex)) {
            return "Tên playlist không được chứa các ký tự đặc biệt lạ (như <, >, @, #, $, %, ...)!";
        }

        return "VALID";
    }
}