<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-dark bg-dark px-4">
        <span class="navbar-brand">Spring Boot 4 CRUD</span>
        <div class="text-white">
            Xin chào, <strong>${sessionScope.account.fullname}</strong>
            <a href="<c:url value='/logout'/>" class="btn btn-outline-light btn-sm ms-3">Đăng xuất</a>
        </div>
    </nav>
    <div class="container mt-4">
        <div class="alert alert-info">Đăng nhập thành công! Bạn đã sẵn sàng phát triển tiếp chức năng Admin CRUD Category & User.</div>
    </div>
	<div class="container mt-4">
	    <div class="alert alert-info">Đăng nhập thành công!</div>
				<c:if test="${sessionScope.account.roleId == 1}">
	    <div class="d-flex gap-3">
	        <a href="<c:url value='/admin/categories/searchpaginated'/>" class="btn btn-primary">
	            Quản lý Category (CRUD + Phân trang)
	        </a>
	        <a href="<c:url value='/admin/users/searchpaginated'/>" class="btn btn-success">
	            Quản lý User (CRUD + Phân trang)
	        </a>
	    </div>
				</c:if>
	</div>	

</body>
</html>