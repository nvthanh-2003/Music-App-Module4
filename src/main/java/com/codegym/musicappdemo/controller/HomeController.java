package com.codegym.musicappdemo.controller;

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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy dữ liệu thật từ MySQL thông qua Repository
        request.setAttribute("songs", songRepository.getAllSongs());

        // Đẩy view con vào khung Layout chính
        request.setAttribute("view", "/WEB-INF/views/index.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layout.jsp").forward(request, response);
    }
}