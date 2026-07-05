package com.codegym.musicappdemo.controller;

import com.codegym.musicappdemo.model.Song;
import com.codegym.musicappdemo.repository.SongRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeController", value = "/home")
public class HomeController extends HttpServlet {
    private final SongRepository songRepository = new SongRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Nhận từ khóa tìm kiếm từ thanh search (nếu có)
        String keyword = request.getParameter("keyword");
        List<Song> resultSongs;

        if (keyword != null && !keyword.trim().isEmpty()) {
            resultSongs = songRepository.searchSongsByName(keyword.trim());
            request.setAttribute("currentKeyword", keyword);
        } else {
            resultSongs = songRepository.getAllSongs();
        }

        // Đẩy danh sách bài hát sang index.jsp
        request.setAttribute("songs", resultSongs);

        // Nhúng nội dung vào Master Layout
        request.setAttribute("view", "/WEB-INF/views/index.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}