package com.codegym.musicappdemo.controller;

import com.codegym.musicappdemo.model.User;
import com.codegym.musicappdemo.repository.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(urlPatterns = {"/auth", "/login", "/register", "/logout"})
public class RegisterServlet extends HttpServlet {
    private final UserRepository userRepository = new UserRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String servletPath = request.getServletPath();
        if ("/logout".equals(servletPath)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate(); // Xóa sạch session cũ
            }
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("/register".equals(servletPath)) {
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String servletPath = request.getServletPath();

        // TÁC VỤ 1: XỬ LÝ ĐĂNG NHẬP
        if ("/login".equals(servletPath)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            User user = userRepository.checkLogin(username, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", user);
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                request.setAttribute("error", "Tài khoản hoặc mật khẩu không chính xác!");
                request.setAttribute("username", username);
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        }

        // TÁC VỤ 2: XỬ LÝ ĐĂNG KÝ
        else if ("/register".equals(servletPath)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String confirmPassword = request.getParameter("confirmPassword");

            if (confirmPassword != null && !confirmPassword.equals(password)) {
                request.setAttribute("error", "Mật khẩu nhập lại không khớp!");
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }

            User user = new User(username, password, email, "ROLE_USER");
            boolean isSuccess = userRepository.registerUser(user);

            if (isSuccess) {
                response.sendRedirect(request.getContextPath() + "/login?success=true");
            } else {
                request.setAttribute("error", "Tên tài khoản hoặc email đã tồn tại!");
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            }
        }
    }
}