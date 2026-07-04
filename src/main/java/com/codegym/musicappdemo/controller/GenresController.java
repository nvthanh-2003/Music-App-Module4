package com.codegym.musicappdemo.controller;

import com.codegym.musicappdemo.model.Genre;
import com.codegym.musicappdemo.repository.GenreRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "GenresController", value = "/genres")
public class GenresController extends HttpServlet {
    private final GenreRepository genreRepository = new GenreRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String genreIdStr = request.getParameter("id");

        if (genreIdStr == null || genreIdStr.trim().isEmpty()) {
            List<Genre> genres = genreRepository.findAllGenres();
            request.setAttribute("genres", genres);
            request.setAttribute("view", "/WEB-INF/views/genres-list.jsp");
        } else {
            try {
                Long genreId = Long.parseLong(genreIdStr);
                Genre genre = genreRepository.findById(genreId);

                if (genre == null) {
                    response.sendRedirect(request.getContextPath() + "/genres");
                    return;
                }

                request.setAttribute("genre", genre);
                request.setAttribute("songs", genreRepository.findSongsByGenreId(genreId));
                request.setAttribute("view", "/WEB-INF/views/genre-detail.jsp");
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/genres");
                return;
            }
        }

        request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
    }
}