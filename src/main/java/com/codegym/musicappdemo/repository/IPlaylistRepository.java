package com.codegym.musicappdemo.repository;

import com.codegym.musicappdemo.model.Playlist;
import com.codegym.musicappdemo.model.Song;

import java.util.List;

public interface IPlaylistRepository {
    List<Playlist> findPlaylistsByUserId(Long userId);

    List<Song> findSongsInPlaylist(Long playlistId);

    void save(Playlist playlist);

    void deleteById(Long playlistId);

    Playlist findById(Long playlistId);

    void update(Playlist playlist);

    void deleteSongFromPlaylist(long playlistId, long songId);
}