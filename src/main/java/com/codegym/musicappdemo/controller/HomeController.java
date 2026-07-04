package com.codegym.musicappdemo.controller;

import com.codegym.musicappdemo.repository.GenreRepository;
import com.codegym.musicappdemo.repository.SongRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "HomeController", value = "/home")
public class HomeController extends HttpServlet {
    private final SongRepository songRepository = new SongRepository();
    private final GenreRepository genreRepository = new GenreRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String genreIdStr = request.getParameter("genreId");
        Long genreId = null;

        if (genreIdStr != null && !genreIdStr.trim().isEmpty()) {
            try {
                genreId = Long.parseLong(genreIdStr.trim());
            } catch (NumberFormatException e) {
                genreId = null;
            }
        }

        request.setAttribute("genres", genreRepository.findAllGenres());
        request.setAttribute("selectedGenreId", genreId);

        // Lấy dữ liệu thật từ MySQL thông qua Repository, có lọc theo thể loại nếu người dùng chọn
        if (genreId == null) {
            request.setAttribute("songs", songRepository.getAllSongs());
        } else {
            request.setAttribute("songs", genreRepository.findSongsByGenreId(genreId));
        }

        // Đẩy view con vào khung Layout chính
        request.setAttribute("view", "/WEB-INF/views/index.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
    }
}