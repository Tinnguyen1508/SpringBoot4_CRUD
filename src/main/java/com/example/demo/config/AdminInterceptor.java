package com.example.demo.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import com.example.demo.entity.User;

@Component
public class AdminInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        // Chưa đăng nhập -> đá về trang login
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        // Không phải Admin (roleId != 1) -> đá về trang home
        if (user.getRoleId() == null || user.getRoleId() != 1) {
            response.sendRedirect(request.getContextPath() + "/home");
            return false;
        }
        return true;
    }
}