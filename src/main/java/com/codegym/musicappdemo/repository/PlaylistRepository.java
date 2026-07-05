package com.codegym.musicappdemo.repository;

import com.codegym.musicappdemo.model.Playlist;
import com.codegym.musicappdemo.model.Song;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PlaylistRepository implements IPlaylistRepository {
    private String url = "jdbc:mysql://localhost:3306/music_app_db";
    private String user = "root";
    private String pass = "123456";

    protected Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(url, user, pass);
    }

    @Override
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
    public List<Song> findSongsInPlaylist(Long playlistId) {
        List<Song> songs = new ArrayList<>();
        String query = "SELECT s.*, a.name AS artist_name FROM songs s " +
                "JOIN playlist_song ps ON s.id = ps.song_id " +
                "LEFT JOIN artists a ON s.artist_id = a.id " +
                "WHERE ps.playlist_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setLong(1, playlistId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Song s = new Song();
                    s.setId(rs.getLong("id"));
                    s.setTitle(rs.getString("title"));
                    s.setImgUrl(rs.getString("img_url"));
                    s.setFileUrl(rs.getString("file_url"));
                    s.setArtistName(rs.getString("artist_name"));

                    songs.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return songs;
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
    public List<Playlist> findPlaylistsByUserId(long userId) {
        List<Playlist> playlists = new ArrayList<>();
        String query = "SELECT id, user_id, name FROM playlists WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setLong(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Playlist playlist = new Playlist();
                    playlist.setId(rs.getLong("id"));
                    playlist.setUserId(rs.getLong("user_id"));
                    playlist.setName(rs.getString("name"));
                    playlists.add(playlist);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return playlists;
    }
}