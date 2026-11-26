package com.example.demo.controller;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;

@Controller
@RequestMapping("/admin/users")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    // 1. Danh sách + Tìm kiếm + Phân trang
    @RequestMapping({ "", "/searchpaginated" })
    public String search(ModelMap model,
                         @RequestParam(name = "keyword", required = false) String keyword,
                         @RequestParam("page") Optional<Integer> page,
                         @RequestParam("size") Optional<Integer> size) {
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("username"));
        Page<User> resultPage;

        if (StringUtils.hasText(keyword)) {
            resultPage = userRepository.findByUsernameContainingOrFullnameContaining(keyword, keyword, pageable);
            model.addAttribute("keyword", keyword);
        } else {
            resultPage = userRepository.findAll(pageable);
        }

        int totalPages = resultPage.getTotalPages();
        if (totalPages > 0) {
            int start = Math.max(1, currentPage - 2);
            int end = Math.min(currentPage + 2, totalPages);
            List<Integer> pageNumbers = IntStream.rangeClosed(start, end)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }

        model.addAttribute("userPage", resultPage);
        return "admin/user/list";
    }

    // 2. Form Thêm mới
    @GetMapping("/add")
    public String add(ModelMap model) {
        model.addAttribute("user", new User());
        return "admin/user/addOrEdit";
    }

    // 3. Form Chỉnh sửa
    @GetMapping("/edit/{id}")
    public String edit(ModelMap model, @PathVariable("id") Integer id) {
        Optional<User> opt = userRepository.findById(id);
        if (opt.isPresent()) {
            model.addAttribute("user", opt.get());
            return "admin/user/addOrEdit";
        }
        return "redirect:/admin/users/searchpaginated";
    }

    // 4. Lưu (Thêm hoặc Cập nhật)
    @PostMapping("/saveOrUpdate")
    public String saveOrUpdate(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        userRepository.save(user);
        redirectAttributes.addFlashAttribute("message", "Lưu người dùng thành công!");
        return "redirect:/admin/users/searchpaginated";
    }

    // 5. Xóa
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        userRepository.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Xóa người dùng thành công!");
        return "redirect:/admin/users/searchpaginated";
    }
}