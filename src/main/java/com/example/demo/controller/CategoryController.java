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

import com.example.demo.entity.Category;
import com.example.demo.repository.CategoryRepository;

@Controller
@RequestMapping("/admin/categories")
public class CategoryController {

    @Autowired
    private CategoryRepository categoryRepository;

    // 1. Danh sách + Tìm kiếm + Phân trang
    @RequestMapping({ "", "/searchpaginated" })
    public String search(ModelMap model,
                         @RequestParam(name = "name", required = false) String name,
                         @RequestParam("page") Optional<Integer> page,
                         @RequestParam("size") Optional<Integer> size) {
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
        Page<Category> resultPage;

        if (StringUtils.hasText(name)) {
            resultPage = categoryRepository.findByNameContaining(name, pageable);
            model.addAttribute("name", name);
        } else {
            resultPage = categoryRepository.findAll(pageable);
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

        model.addAttribute("categoryPage", resultPage);
        return "admin/category/list";
    }

    // 2. Form Thêm mới
    @GetMapping("/add")
    public String add(ModelMap model) {
        model.addAttribute("category", new Category());
        return "admin/category/addOrEdit";
    }

    // 3. Form Chỉnh sửa
    @GetMapping("/edit/{id}")
    public String edit(ModelMap model, @PathVariable("id") Integer id) {
        Optional<Category> opt = categoryRepository.findById(id);
        if (opt.isPresent()) {
            model.addAttribute("category", opt.get());
            return "admin/category/addOrEdit";
        }
        return "redirect:/admin/categories/searchpaginated";
    }

    // 4. Lưu (Thêm hoặc Cập nhật)
    @PostMapping("/saveOrUpdate")
    public String saveOrUpdate(@ModelAttribute Category category, RedirectAttributes redirectAttributes) {
        categoryRepository.save(category);
        redirectAttributes.addFlashAttribute("message", "Lưu danh mục thành công!");
        return "redirect:/admin/categories/searchpaginated";
    }

    // 5. Xóa
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        categoryRepository.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Xóa danh mục thành công!");
        return "redirect:/admin/categories/searchpaginated";
    }
}