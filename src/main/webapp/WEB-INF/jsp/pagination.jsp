<!--
pagingUrl - base url
pageNumber - current page number
totalPages - total pages
-->

<c:if test="${totalPages > 1}">
    <nav aria-label="...">
        <ul class="pagination">

            <!-- Pradzia -->
            <c:if test="${pageNumber <= 1}">
                <li class="page-item disabled"><span class="page-link">Previous</span></li>
            </c:if>
            <c:if test="${pageNumber > 1}">
                <li class="page-item"><a class="page-link" href="${pagingUrl}?page=${pageNumber - 1}">Previous</a></li>
            </c:if>

            <!-- Vidurys -->
            <c:choose>
                <c:when test="${totalPages <= 10}">
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <c:if test="${i == pageNumber}">
                            <li class="page-item active"><span class="page-link">${pageNumber}</span></li>
                        </c:if>
                        <c:if test="${i != pageNumber}">
                            <li class="page-item"><a class="page-link" href="${pagingUrl}?page=${i}">${i}</a></li>
                        </c:if>
                    </c:forEach>
                </c:when>

                <c:when test="${pageNumber < 5}">
                    <c:forEach var="i" begin="1" end="${pageNumber + 1}">
                        <c:if test="${i == pageNumber}">
                            <li class="page-item active"><span class="page-link">${pageNumber}</span></li>
                        </c:if>
                        <c:if test="${i != pageNumber}">
                            <li class="page-item"><a class="page-link" href="${pagingUrl}?page=${i}">${i}</a></li>
                        </c:if>
                    </c:forEach>
                    <li class="page-item disabled"><span class="page-link">...</span></li>
                    <li class="page-item"><a class="page-link" href="${pagingUrl}?page=${totalPages}">${totalPages}</a></li>
                </c:when>

                <c:when test="${pageNumber > totalPages - 4}">

                </c:when>

                <c:otherwise>
                    <li class="page-item"><a class="page-link" href="${pagingUrl}?page=1">1</a></li>
                    <li class="page-item disabled"><span class="page-link">...</span></li>

                    <li class="page-item"><a class="page-link" href="${pagingUrl}?page=${pageNumber - 1}">${pageNumber - 1}</a></li>
                    <li class="page-item active"><span class="page-link">${pageNumber}</span></li>
                    <li class="page-item"><a class="page-link" href="${pagingUrl}?page=${pageNumber + 1}">${pageNumber + 1}</a></li>

                    <li class="page-item disabled"><span class="page-link">...</span></li>
                    <li class="page-item"><a class="page-link" href="${pagingUrl}?page=${totalPages}">${totalPages}</a></li>
                </c:otherwise>
            </c:choose>


            <!-- Galas -->
            <c:if test="${pageNumber >= totalPages}">
                <li class="page-item disabled"><span class="page-link">Next</span></li>
            </c:if>
            <c:if test="${pageNumber < totalPages}">
                <li class="page-item"><a class="page-link" href="${pagingUrl}?page=${pageNumber + 1}">Next</a></li>
            </c:if>

        </ul>
    </nav>
</c:if>