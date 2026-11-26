<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Quản lý Người dùng (User)</h3>
        <div>
            <a href="<c:url value='/admin/users/add'/>" class="btn btn-primary">+ Thêm User</a>
            <a href="<c:url value='/home'/>" class="btn btn-secondary">Trang chủ</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-success py-2">${message}</div>
    </c:if>

    <form action="<c:url value='/admin/users/searchpaginated'/>" method="get" class="row g-2 mb-3">
        <div class="col-auto">
            <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tìm username hoặc họ tên...">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-outline-primary">Tìm kiếm</button>
        </div>
    </form>

    <c:if test="${userPage.hasContent()}">
        <div class="card shadow-sm">
            <table class="table table-hover mb-0 align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>STT</th>
                        <th>Username</th>
                        <th>Họ tên</th>
                        <th>Email</th>
                        <th>Vai trò</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${userPage.content}" var="u" varStatus="STT">
                        <tr>
                            <td>${STT.index + 1 + (userPage.number * userPage.size)}</td>
                            <td class="fw-semibold">${u.username}</td>
                            <td>${u.fullname}</td>
                            <td>${u.email}</td>
                            <td>
                                <span class="badge ${u.roleId == 1 ? 'bg-danger' : 'bg-info text-dark'}">
                                    ${u.roleId == 1 ? 'Admin' : 'User'}
                                </span>
                            </td>
                            <td>
                                <a href="<c:url value='/admin/users/edit/${u.id}'/>" class="btn btn-sm btn-warning">Sửa</a>
                                <a href="<c:url value='/admin/users/delete/${u.id}'/>" class="btn btn-sm btn-danger"
                                   onclick="return confirm('Xóa người dùng này?')">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>

    <div class="d-flex justify-content-between align-items-center mt-3">
        <form action="<c:url value='/admin/users/searchpaginated'/>" method="get" class="d-flex align-items-center gap-2">
            <input type="hidden" name="keyword" value="${keyword}">
            <label class="small text-muted">Hiển thị:</label>
            <select name="size" class="form-select form-select-sm" style="width: 80px;" onchange="this.form.submit()">
                <option ${userPage.size == 3 ? 'selected' : ''} value="3">3</option>
                <option ${userPage.size == 5 ? 'selected' : ''} value="5">5</option>
                <option ${userPage.size == 10 ? 'selected' : ''} value="10">10</option>
            </select>
        </form>

        <c:if test="${userPage.totalPages > 1}">
            <nav>
                <ul class="pagination pagination-sm mb-0">
                    <c:forEach items="${pageNumbers}" var="pageNumber">
                        <li class="page-item ${pageNumber == userPage.number + 1 ? 'active' : ''}">
                            <a class="page-link"
                               href="<c:url value='/admin/users/searchpaginated?keyword=${keyword}&size=${userPage.size}&page=${pageNumber}'/>">
                                ${pageNumber}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </c:if>
    </div>
</div>
</body>
</html>