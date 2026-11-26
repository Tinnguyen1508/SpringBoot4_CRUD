<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center vh-100">
    <div class="card p-4 shadow-sm" style="width: 400px;">
        <h4 class="text-center mb-3">Đăng nhập</h4>
        <c:if test="${not empty message}"><div class="alert alert-success py-2">${message}</div></c:if>
        <c:if test="${not empty error}"><div class="alert alert-danger py-2">${error}</div></c:if>
        <form action="<c:url value='/login'/>" method="post">
            <div class="mb-3"><label>Username</label><input type="text" name="username" class="form-control" required></div>
            <div class="mb-3"><label>Mật khẩu</label><input type="password" name="password" class="form-control" required></div>
            <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
        </form>
        <div class="text-center mt-3"><a href="<c:url value='/register'/>">Chưa có tài khoản? Đăng ký ngay</a></div>
    </div>
</body>
</html>