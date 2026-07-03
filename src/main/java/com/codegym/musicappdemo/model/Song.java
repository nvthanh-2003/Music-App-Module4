package com.codegym.musicappdemo.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Song {
    private int id;
    private String title;
    private String artistName;
    private String imgUrl;
    private String fileUrl;

}