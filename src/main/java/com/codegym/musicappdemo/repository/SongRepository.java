package com.codegym.musicappdemo.repository;

import com.codegym.musicappdemo.model.Song;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SongRepository {
    private final String dbUrl = "jdbc:mysql://localhost:3306/music_app_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private final String dbUser = "root";
    private final String dbPass = "123456";

    public List<Song> getAllSongs() {
        List<Song> songs = new ArrayList<>();
        String query = "SELECT s.id, s.title, s.img_url, s.file_url, a.name AS artist_name " +
                "FROM songs s " +
                "LEFT JOIN artists a ON s.artist_id = a.id";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                 PreparedStatement ps = conn.prepareStatement(query);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    songs.add(new Song(
                            rs.getLong("id"),
                            rs.getString("title"),
                            rs.getString("artist_name") != null ? rs.getString("artist_name") : "Ẩn danh",
                            rs.getString("img_url"),
                            rs.getString("file_url")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return songs;
    }

    public boolean deleteSong(long id) {
        String query = "DELETE FROM songs WHERE id = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                 PreparedStatement ps = conn.prepareStatement(query)) {

                ps.setLong(1, id);
                int rowsAffected = ps.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Song> searchSongsByName(String name) {
        List<Song> songs = new ArrayList<>();
        String query = "SELECT s.id, s.title, s.img_url, s.file_url, a.name AS artist_name " +
                "FROM songs s " +
                "LEFT JOIN artists a ON s.artist_id = a.id " +
                "WHERE s.title LIKE ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                 PreparedStatement ps = conn.prepareStatement(query)) {

                ps.setString(1, "%" + name + "%");

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        songs.add(new Song(
                                rs.getLong("id"),
                                rs.getString("title"),
                                rs.getString("artist_name") != null ? rs.getString("artist_name") : "Ẩn danh",
                                rs.getString("img_url"),
                                rs.getString("file_url")
                        ));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return songs;
    }

    public List<Song> searchSongs(String keyword) {
        List<Song> songs = new ArrayList<>();
        // Dùng LIKE để tìm kiếm gần đúng và dùng JOIN để tìm được cả theo tên ca sĩ
        String query = "SELECT s.*, a.name AS artist_name FROM songs s " +
                "LEFT JOIN artists a ON s.artist_id = a.id " +
                "WHERE s.title LIKE ? OR a.name LIKE ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                 PreparedStatement ps = conn.prepareStatement(query)) {

                ps.setString(1, "%" + keyword + "%");
                ps.setString(2, "%" + keyword + "%");
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    songs.add(new Song(
                            rs.getLong("id"),
                            rs.getString("title"),
                            rs.getString("artist_name"),
                            rs.getString("img_url"),
                            rs.getString("file_url")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return songs;
    }
}