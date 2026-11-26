<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${user.id == null ? 'Thêm' : 'Sửa'} User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5" style="max-width: 500px;">
    <div class="card p-4 shadow-sm">
        <h4 class="mb-3">${user.id == null ? 'Thêm mới' : 'Cập nhật'} Người dùng</h4>
        <form action="<c:url value='/admin/users/saveOrUpdate'/>" method="post">
            <input type="hidden" name="id" value="${user.id}">
            <div class="mb-2">
                <label class="form-label">Username</label>
                <input type="text" name="username" value="${user.username}" class="form-control" required>
            </div>
            <div class="mb-2">
                <label class="form-label">Mật khẩu</label>
                <input type="text" name="password" value="${user.password}" class="form-control" required>
            </div>
            <div class="mb-2">
                <label class="form-label">Họ tên</label>
                <input type="text" name="fullname" value="${user.fullname}" class="form-control" required>
            </div>
            <div class="mb-2">
                <label class="form-label">Email</label>
                <input type="email" name="email" value="${user.email}" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Vai trò</label>
                <select name="roleId" class="form-select">
                    <option value="0" ${user.roleId == 0 ? 'selected' : ''}>User</option>
                    <option value="1" ${user.roleId == 1 ? 'selected' : ''}>Admin</option>
                </select>
            </div>
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary">Lưu lại</button>
                <a href="<c:url value='/admin/users/searchpaginated'/>" class="btn btn-secondary">Quay lại</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>