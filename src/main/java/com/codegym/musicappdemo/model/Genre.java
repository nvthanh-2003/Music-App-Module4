package com.codegym.musicappdemo.model;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Genre {
    private Long id;
    private String name;
    private String description;
    private Integer songCount;

    public Genre(Long id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }

    public Genre(Long id, String name, String description, Integer songCount) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.songCount = songCount;
    }
}