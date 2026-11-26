<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Category</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Quản lý Danh mục (Category)</h3>
        <div>
            <a href="<c:url value='/admin/categories/add'/>" class="btn btn-primary">+ Thêm danh mục</a>
            <a href="<c:url value='/home'/>" class="btn btn-secondary">Trang chủ</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-success py-2">${message}</div>
    </c:if>

    <!-- Form Tìm kiếm -->
    <form action="<c:url value='/admin/categories/searchpaginated'/>" method="get" class="row g-2 mb-3">
        <div class="col-auto">
            <input type="text" name="name" value="${name}" class="form-control" placeholder="Nhập từ khóa để tìm...">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-outline-primary">Tìm kiếm</button>
        </div>
    </form>

    <c:if test="${!categoryPage.hasContent()}">
        <div class="alert alert-warning">Không tìm thấy danh mục nào!</div>
    </c:if>

    <c:if test="${categoryPage.hasContent()}">
        <div class="card shadow-sm">
            <table class="table table-hover mb-0 align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>STT</th>
                        <th>Hình ảnh</th>
                        <th>Tên danh mục</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${categoryPage.content}" var="cate" varStatus="STT">
                        <tr>
                            <td>${STT.index + 1 + (categoryPage.number * categoryPage.size)}</td>
                            <td>${cate.images}</td>
                            <td class="fw-semibold">${cate.name}</td>
                            <td>
                                <span class="badge ${cate.status == 1 ? 'bg-success' : 'bg-secondary'}">
                                    ${cate.status == 1 ? 'Hoạt động' : 'Khóa'}
                                </span>
                            </td>
                            <td>
                                <a href="<c:url value='/admin/categories/edit/${cate.id}'/>" class="btn btn-sm btn-warning">Sửa</a>
                                <a href="<c:url value='/admin/categories/delete/${cate.id}'/>" class="btn btn-sm btn-danger"
                                   onclick="return confirm('Xóa danh mục này?')">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>

    <!-- Chọn Page Size & Thanh Phân trang -->
    <div class="d-flex justify-content-between align-items-center mt-3">
        <form action="<c:url value='/admin/categories/searchpaginated'/>" method="get" class="d-flex align-items-center gap-2">
            <input type="hidden" name="name" value="${name}">
            <label class="small text-muted">Hiển thị:</label>
            <select name="size" class="form-select form-select-sm" style="width: 80px;" onchange="this.form.submit()">
                <option ${categoryPage.size == 3 ? 'selected' : ''} value="3">3</option>
                <option ${categoryPage.size == 5 ? 'selected' : ''} value="5">5</option>
                <option ${categoryPage.size == 10 ? 'selected' : ''} value="10">10</option>
            </select>
        </form>

        <c:if test="${categoryPage.totalPages > 1}">
            <nav>
                <ul class="pagination pagination-sm mb-0">
                    <c:forEach items="${pageNumbers}" var="pageNumber">
                        <li class="page-item ${pageNumber == categoryPage.number + 1 ? 'active' : ''}">
                            <a class="page-link"
                               href="<c:url value='/admin/categories/searchpaginated?name=${name}&size=${categoryPage.size}&page=${pageNumber}'/>">
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