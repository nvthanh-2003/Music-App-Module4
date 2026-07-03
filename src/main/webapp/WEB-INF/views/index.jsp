<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2 class="mb-4 fw-bold">Bài Hát Mới Phát Hành</h2>

<div class="row row-cols-2 row-cols-md-4 g-4">
    <c:forEach var="song" items="${songs}">
        <div class="col">
            <div class="card bg-secondary text-white h-100 border-0 p-3 shadow-sm rounded">
                <div class="position-relative project-card-hover">
                    <img src="${song.imgUrl}" class="card-img-top rounded" alt="Cover" style="aspect-ratio: 1/1; object-fit: cover;">
                    <button class="btn btn-success btn-play-now position-absolute bottom-0 end-0 m-2 rounded-circle shadow"
                            data-title="${song.title}"
                            data-artist="${song.artistName}"
                            data-url="${song.fileUrl}"
                            data-img="${song.imgUrl}">
                        <i class="fa-solid fa-play"></i>
                    </button>
                </div>
                <div class="card-body px-0 pt-3 pb-0">
                    <h6 class="card-title text-truncate fw-bold mb-1">${song.title}</h6>
                    <p class="card-text text-muted small">${song.artistName}</p>
                </div>
            </div>
        </div>
    </c:forEach>
</div>