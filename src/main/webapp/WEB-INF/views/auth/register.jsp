<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng ký</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center vh-100">
    <div class="card p-4 shadow-sm" style="width: 400px;">
        <h4 class="text-center mb-3">Đăng ký tài khoản</h4>
        <c:if test="${not empty error}"><div class="alert alert-danger py-2">${error}</div></c:if>
        <form action="<c:url value='/register'/>" method="post">
            <div class="mb-2"><label>Họ tên</label><input type="text" name="fullname" class="form-control" required></div>
            <div class="mb-2"><label>Username</label><input type="text" name="username" class="form-control" required></div>
            <div class="mb-2"><label>Email</label><input type="email" name="email" class="form-control" required></div>
            <div class="mb-2"><label>Mật khẩu</label><input type="password" name="password" class="form-control" required></div>
            <div class="mb-3">
                <label>Vai trò</label>
                <select name="roleId" class="form-select">
                    <option value="0">User</option>
                    <option value="1">Admin</option>
                </select>
            </div>
            <button type="submit" class="btn btn-success w-100">Đăng ký</button>
        </form>
        <div class="text-center mt-3"><a href="<c:url value='/login'/>">Đã có tài khoản? Đăng nhập</a></div>
    </div>
</body>
</html>