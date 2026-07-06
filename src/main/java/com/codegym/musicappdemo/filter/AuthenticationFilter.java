package com.codegym.musicappdemo.filter;

import com.codegym.musicappdemo.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/delete-song", "/admin/*"})
public class AuthenticationFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // Lấy thông tin user đăng nhập từ session
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        // Nếu chưa đăng nhập -> Đá ra trang login
        if (currentUser == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }

        // Nếu cố tình truy cập chức năng xóa nhạc nhưng không phải ADMIN
        if (httpRequest.getRequestURI().contains("/delete-song")) {
            if (!"ROLE_ADMIN".equals(currentUser.getRole())) {
                // Trả về lỗi 403 Forbidden hoặc đá về trang chủ thông báo lỗi
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền thực hiện thao tác này!");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}