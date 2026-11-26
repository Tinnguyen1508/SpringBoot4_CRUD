package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;

import jakarta.servlet.http.HttpSession;


@Controller
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    // --- ĐĂNG KÝ ---
    @GetMapping("/register")
    public String showRegisterForm() {
        return "auth/register";
    }

    @PostMapping("/register")
    public String processRegister(@ModelAttribute User user, Model model) {
        if (userRepository.existsByUsername(user.getUsername())) {
            model.addAttribute("error", "Tên đăng nhập đã tồn tại!");
            return "auth/register";
        }
        if (userRepository.existsByEmail(user.getEmail())) {
            model.addAttribute("error", "Email này đã được sử dụng!");
            return "auth/register";
        }
        userRepository.save(user);
        model.addAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
        return "auth/login";
    }

    // --- ĐĂNG NHẬP ---
    @GetMapping({ "/", "/login" })
    public String showLoginForm() {
        return "auth/login";
    }

    @PostMapping("/login")
    public String processLogin(@RequestParam String username,
                               @RequestParam String password,
                               HttpSession session,
                               Model model) {
        User user = userRepository.findByUsername(username).orElse(null);
        if (user != null && user.getPassword().equals(password)) {
            session.setAttribute("account", user);
            return "redirect:/home";
        }
        model.addAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
        return "auth/login";
    }

    // --- TRANG CHỦ SAU KHI LOGIN ---
    @GetMapping("/home")
    public String home(HttpSession session) {
        if (session.getAttribute("account") == null) {
            return "redirect:/login";
        }
        return "web/home";
    }

    // --- ĐĂNG XUẤT ---
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}