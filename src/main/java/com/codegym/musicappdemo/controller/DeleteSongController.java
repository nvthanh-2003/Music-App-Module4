package com.codegym.musicappdemo.controller;

import com.codegym.musicappdemo.repository.SongRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DeleteSongController", value = "/delete-song")
public class DeleteSongController extends HttpServlet {
    private final SongRepository songRepository = new SongRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            long id = Long.parseLong(request.getParameter("id"));
            songRepository.deleteSong(id);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        // Sau khi xóa xong, redirect (chuyển hướng) về lại trang chủ để cập nhật danh sách mới
        response.sendRedirect(request.getContextPath() + "/home");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}