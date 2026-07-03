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
        String query = "SELECT * FROM songs";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                 PreparedStatement ps = conn.prepareStatement(query);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    songs.add(new Song(
                            rs.getInt("id"),
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