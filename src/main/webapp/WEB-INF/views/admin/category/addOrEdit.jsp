<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${category.id == null ? 'Thêm' : 'Sửa'} Category</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5" style="max-width: 500px;">
    <div class="card p-4 shadow-sm">
        <h4 class="mb-3">${category.id == null ? 'Thêm mới' : 'Cập nhật'} Danh mục</h4>
        <form action="<c:url value='/admin/categories/saveOrUpdate'/>" method="post">
            <input type="hidden" name="id" value="${category.id}">
            <div class="mb-3">
                <label class="form-label">Tên danh mục</label>
                <input type="text" name="name" value="${category.name}" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Link / Tên hình ảnh</label>
                <input type="text" name="images" value="${category.images}" class="form-control">
            </div>
            <div class="mb-3">
                <label class="form-label">Trạng thái</label>
                <select name="status" class="form-select">
                    <option value="1" ${category.status == 1 ? 'selected' : ''}>Hoạt động</option>
                    <option value="0" ${category.status == 0 ? 'selected' : ''}>Khóa</option>
                </select>
            </div>
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary">Lưu lại</button>
                <a href="<c:url value='/admin/categories/searchpaginated'/>" class="btn btn-secondary">Quay lại</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>