<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="fw-bold m-0">Danh Sách Bài Hát</h2>
</div>

<div class="table-responsive">
    <table class="table table-dark table-hover align-middle custom-song-table">
        <thead>
        <tr class="text-muted border-secondary">
            <th style="width: 5%">#</th>
            <th style="width: 50%">Tiêu đề</th>
            <th style="width: 30%">Ca sĩ</th>
            <th style="width: 15%" class="text-end">Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <%-- SỬA CHỮ nud THÀNH test Ở ĐÂY --%>
            <c:when test="${not empty songs}">
                <c:forEach var="song" items="${songs}" varStatus="status">
                    <%-- 1. Sửa data-url ở thẻ tr --%>
                    <tr class="container-song-row" data-url="${pageContext.request.contextPath}/${song.fileUrl}">
                        <td class="align-middle text-center">${status.index + 1}</td>
                        <td class="align-middle">
                            <div class="d-flex align-items-center">
                                <div class="position-relative me-3 project-card-hover" style="width: 50px; height: 50px;">
                                    <img src="${song.imgUrl}" class="rounded w-100 h-100" style="object-fit: cover;" alt="Cover">

                                        <%-- 2. Sửa data-url ở nút button phát nhạc nhanh --%>
                                    <button type="button" class="btn btn-success btn-play-now position-absolute top-50 start-50 translate-middle rounded-circle p-0 d-flex align-items-center justify-content-center"
                                            style="width: 30px; height: 30px; opacity: 0;"
                                            data-title="${song.title}"
                                            data-artist="${song.artistName}"
                                            data-url="${pageContext.request.contextPath}/${song.fileUrl}"
                                            data-img="${song.imgUrl}">
                                        <i class="fa-solid fa-play fa-sm text-black"></i>
                                    </button>
                                </div>
                                <span class="fw-semibold text-white">${song.title}</span>
                            </div>
                        </td>
                        <td class="align-middle text-white-50">${song.artistName}</td>
                        <td class="align-middle text-center">
                            <button class="btn btn-sm btn-delete-custom rounded-circle" data-id="${song.id}" data-title="${song.title}">
                                <i class="fa-solid fa-trash-can"></i>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="4" class="text-center text-muted py-4">
                        Không có dữ liệu bài hát trong hệ thống hoặc lỗi kết nối Database.
                    </td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</div>