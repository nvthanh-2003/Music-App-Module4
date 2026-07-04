package com.codegym.musicappdemo.repository;

import com.codegym.musicappdemo.model.Song;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SongRepository {
    private final String dbUrl = "jdbc:mysql://localhost:3306/music_app_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF-8";
    private final String dbUser = "root";
    private final String dbPass = "1234";

    public List<Song> getAllSongs() {
        List<Song> songs = new ArrayList<>();

        // Lấy thêm tên thể loại để hiển thị badge trong UI
        String query = "SELECT s.*, a.name AS artist_name, g.name AS genre_name " +
                "FROM songs s " +
            "LEFT JOIN artists a ON s.artist_id = a.id " +
            "LEFT JOIN genres g ON s.genre_id = g.id";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                 PreparedStatement ps = conn.prepareStatement(query);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    songs.add(new Song(
                            rs.getLong("id"),
                            rs.getString("title"),
                            rs.getString("artist_name"),
                            rs.getString("genre_name"),
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

    public List<Song> searchSongs(String keyword) {
        List<Song> songs = new ArrayList<>();
        // Dùng LIKE để tìm kiếm gần đúng và dùng JOIN để tìm được cả theo tên ca sĩ / thể loại
        String query = "SELECT s.*, a.name AS artist_name, g.name AS genre_name FROM songs s " +
                "LEFT JOIN artists a ON s.artist_id = a.id " +
            "LEFT JOIN genres g ON s.genre_id = g.id " +
            "WHERE s.title LIKE ? OR a.name LIKE ? OR g.name LIKE ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                 PreparedStatement ps = conn.prepareStatement(query)) {

                ps.setString(1, "%" + keyword + "%");
                ps.setString(2, "%" + keyword + "%");
                ps.setString(3, "%" + keyword + "%");
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    songs.add(new Song(
                            rs.getLong("id"),
                            rs.getString("title"),
                            rs.getString("artist_name"),
                            rs.getString("genre_name"),
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