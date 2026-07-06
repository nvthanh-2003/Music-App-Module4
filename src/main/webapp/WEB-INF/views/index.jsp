<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="fw-bold m-0"><i class="fa-solid fa-music text-success me-2"></i>Danh Sách Bài Hát</h2>

    <%-- Đưa nút Thêm bài hát ra ngoài bảng để giao diện chuẩn chỉnh --%>
    <c:if test="${sessionScope.currentUser.role eq 'ROLE_ADMIN'}">
        <a href="${pageContext.request.contextPath}/add-song" class="btn btn-success fw-bold rounded-pill px-4 shadow-sm transition-all">
            <i class="fa-solid fa-plus me-2"></i>Thêm bài hát mới
        </a>
    </c:if>
</div>

<c:if test="${param.addSuccess eq 'true'}">
    <div class="alert alert-success alert-dismissible fade show py-2 px-3 small border-0 mb-4 text-white" style="background-color: #1ed760;" role="alert">
        <i class="fa-solid fa-circle-check me-2"></i> Thêm bài hát mới thành công!
        <button type="button" class="btn-close btn-close-white py-2" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<div class="table-responsive">
    <table class="table table-dark table-hover align-middle custom-song-table">
        <thead>
        <tr class="text-muted border-secondary text-uppercase small" style="letter-spacing: 1px;">
            <th style="width: 8%" class="text-center">#</th>
            <th style="width: 52%">Tiêu đề</th>
            <th style="width: 30%">Ca sĩ</th>
            <th style="width: 10%" class="text-center">Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty songs}">
                <c:forEach var="song" items="${songs}" varStatus="status">
                    <tr class="container-song-row" data-url="${pageContext.request.contextPath}/${song.fileUrl}" style="cursor: pointer;">
                        <td class="align-middle text-center text-white-50 fw-semibold">${status.index + 1}</td>

                        <td class="align-middle">
                            <div class="d-flex align-items-center">
                                <div class="position-relative me-3 project-card-hover rounded overflow-hidden shadow" style="width: 48/px; height: 48px; min-width: 48px;">
                                    <img src="${song.imgUrl}" class="w-100 h-100" style="object-fit: cover;" alt="Cover">

                                    <button type="button" class="btn btn-success btn-play-now position-absolute top-50 start-50 translate-middle rounded-circle p-0 d-flex align-items-center justify-content-center shadow"
                                            style="width: 32px; height: 32px; opacity: 0; transition: all 0.2s ease;"
                                            data-title="${song.title}"
                                            data-artist="${song.artistName}"
                                            data-url="${pageContext.request.contextPath}/${song.fileUrl}"
                                            data-img="${song.imgUrl}">
                                        <i class="fa-solid fa-play text-black" style="font-size: 12px; margin-left: 2px;"></i>
                                    </button>
                                </div>
                                <div>
                                    <span class="fw-semibold text-white d-block song-title-text">${song.title}</span>
                                </div>
                            </div>
                        </td>

                        <td class="align-middle text-white-50 text-truncate" style="max-width: 200px;">${song.artistName}</td>

                        <td class="align-middle text-center">
                            <c:choose>
                                <c:when test="${sessionScope.currentUser.role eq 'ROLE_ADMIN'}">
                                    <button type="button"
                                            class="btn btn-sm btn-outline-danger btn-delete-custom rounded-circle d-inline-flex align-items-center justify-content-center p-0"
                                            style="width: 32px; height: 32px; transition: all 0.2s;"
                                            data-id="${song.id}"
                                            data-title="${song.title}"
                                            title="Xóa bài hát">
                                        <i class="fa-solid fa-trash-can" style="font-size: 13px;"></i>
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-white-50 opacity-25"><i class="fa-solid fa-lock" style="font-size: 12px;"></i></span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="4" class="text-center text-muted py-5">
                        <i class="fa-solid fa-compact-disc fa-spin fa-2x mb-3 d-block text-secondary"></i>
                        Không có dữ liệu bài hát trong hệ thống hoặc lỗi kết nối Database.
                    </td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</div>