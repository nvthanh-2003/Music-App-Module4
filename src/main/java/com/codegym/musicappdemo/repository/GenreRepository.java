package com.codegym.musicappdemo.repository;

import com.codegym.musicappdemo.model.Genre;
import com.codegym.musicappdemo.model.Song;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GenreRepository {
    private final String dbUrl = "jdbc:mysql://localhost:3306/music_app_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF-8";
    private final String dbUser = "root";
    private final String dbPass = "1234";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(dbUrl, dbUser, dbPass);
    }

    public List<Genre> findAllGenres() {
        List<Genre> genres = new ArrayList<>();
        String query = "SELECT g.id, g.name, g.description, COUNT(s.id) AS song_count " +
                "FROM genres g " +
                "LEFT JOIN songs s ON s.genre_id = g.id " +
                "GROUP BY g.id, g.name, g.description " +
                "ORDER BY g.name";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                genres.add(new Genre(
                        rs.getLong("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getInt("song_count")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return genres;
    }

    public Genre findById(Long genreId) {
        String query = "SELECT g.id, g.name, g.description, COUNT(s.id) AS song_count " +
                "FROM genres g " +
                "LEFT JOIN songs s ON s.genre_id = g.id " +
                "WHERE g.id = ? " +
                "GROUP BY g.id, g.name, g.description";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setLong(1, genreId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Genre(
                            rs.getLong("id"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getInt("song_count")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Song> findSongsByGenreId(Long genreId) {
        List<Song> songs = new ArrayList<>();
        String query = "SELECT s.id, s.title, s.file_url, s.img_url, g.name AS genre_name, a.name AS artist_name " +
                "FROM songs s " +
                "LEFT JOIN artists a ON s.artist_id = a.id " +
                "LEFT JOIN genres g ON s.genre_id = g.id " +
                "WHERE s.genre_id = ? " +
                "ORDER BY s.created_at DESC, s.title";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setLong(1, genreId);

            try (ResultSet rs = ps.executeQuery()) {
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return songs;
    }
}