package com.codegym.musicappdemo.model;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Song {
    private Long id;
    private String title;
    private String artistName;
    private String genreName;
    private String imgUrl;
    private String fileUrl;

    public Song(Long id, String title, String artistName, String imgUrl, String fileUrl) {
        this.id = id;
        this.title = title;
        this.artistName = artistName;
        this.imgUrl = imgUrl;
        this.fileUrl = fileUrl;
    }

    public Song(Long id, String title, String artistName, String genreName, String imgUrl, String fileUrl) {
        this.id = id;
        this.title = title;
        this.artistName = artistName;
        this.genreName = genreName;
        this.imgUrl = imgUrl;
        this.fileUrl = fileUrl;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setId(int id) {
        this.id = (long) id;
    }
}