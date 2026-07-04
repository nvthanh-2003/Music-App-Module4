package com.codegym.musicappdemo.repository;

import com.codegym.musicappdemo.model.Playlist;
import com.codegym.musicappdemo.model.Song;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PlaylistRepository implements IPlaylistRepository {
    private String url = "jdbc:mysql://localhost:3306/music_app_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF-8";
    private String user = "root";
    private String pass = "1234";

    protected Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(url, user, pass);
    }

    public boolean addSongToPlaylist(long playlistId, long songId) {
        String query = "INSERT INTO playlist_song (playlist_id, song_id) VALUES (?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setLong(1, playlistId);
            ps.setLong(2, songId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // --- THÊM VÀO ĐÂY: HÀM GỠ BÀI HÁT KHỎI PLAYLIST ---
    @Override
    public void deleteSongFromPlaylist(long playlistId, long songId) {
        String query = "DELETE FROM playlist_song WHERE playlist_id = ? AND song_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setLong(1, playlistId);
            ps.setLong(2, songId);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Playlist> findPlaylistsByUserId(Long userId) {
        List<Playlist> list = new ArrayList<>();
        String query = "SELECT * FROM playlists WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Playlist(
                        rs.getLong("id"),
                        rs.getLong("user_id"),
                        rs.getString("name")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void save(Playlist playlist) {
        String query = "INSERT INTO playlists (user_id, name) VALUES (?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setLong(1, playlist.getUserId());
            ps.setString(2, playlist.getName());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteById(Long playlistId) {
        String query = "DELETE FROM playlists WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setLong(1, playlistId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Playlist findById(Long playlistId) {
        String query = "SELECT * FROM playlists WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setLong(1, playlistId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Playlist p = new Playlist();
                    p.setId(rs.getLong("id"));
                    p.setName(rs.getString("name"));
                    p.setUserId(rs.getLong("user_id"));
                    return p;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void update(Playlist playlist) {
        String query = "UPDATE playlists SET name = ? WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, playlist.getName());
            ps.setLong(2, playlist.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Song> findSongsInPlaylist(Long playlistId) {
        List<Song> songs = new ArrayList<>();
        String query = "SELECT s.*, a.name AS artist_name, g.name AS genre_name FROM songs s " +
                "JOIN playlist_song ps ON s.id = ps.song_id " +
                "LEFT JOIN artists a ON s.artist_id = a.id " +
            "LEFT JOIN genres g ON s.genre_id = g.id " +
                "WHERE ps.playlist_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setLong(1, playlistId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Song s = new Song();
                s.setId(rs.getLong("id"));
                s.setTitle(rs.getString("title"));
                s.setImgUrl(rs.getString("img_url"));
                s.setFileUrl(rs.getString("file_url"));
                s.setArtistName(rs.getString("artist_name"));
                s.setGenreName(rs.getString("genre_name"));

                songs.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return songs;
    }
}