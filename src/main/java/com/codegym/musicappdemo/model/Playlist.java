package com.codegym.musicappdemo.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Playlist {
    private Long id;
    private Long userId;
    private String name;
}