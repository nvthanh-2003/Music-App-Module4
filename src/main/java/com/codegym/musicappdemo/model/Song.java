package com.codegym.musicappdemo.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Song {
    private Long id;
    private String title;
    private String artistName;
    private String imgUrl;
    private String fileUrl;

    public void setId(Long id) {
        this.id = id;
    }

    public void setId(int id) {
        this.id = (long) id;
    }
}