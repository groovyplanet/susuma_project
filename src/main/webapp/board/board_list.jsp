<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/head.jsp"%>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const postLinks = document.querySelectorAll(".content-mix");

    postLinks.forEach(function (link) {
        link.addEventListener("click", function (event) {

            const contentBox = this.closest('.content-box');
            const postContent = contentBox.querySelector(".post-content");
            if (postContent) {
                if (postContent.classList.contains('open')) {
                    postContent.style.maxHeight = postContent.scrollHeight + 'px'; // 콘텐츠의 실제 높이만큼 확장
                    setTimeout(() => {
                        postContent.style.maxHeight = '0'; //maxHeight를 0으로 설정하여 콘텐츠가 부드럽게 접히도록 합니다. 이 지연은 브라우저가 높이 변경을 인식할 시간을 주기 위한 것입니다.
                    }, 10);
                } else {
                    postContent.style.maxHeight = postContent.scrollHeight + 'px'; // maxHeight를 scrollHeight로 설정하여 콘텐츠가 펼쳐지도록 합니다.
                }
                postContent.classList.toggle("open"); // open 클래스 토글
                let chevronDown = contentBox.querySelector(".bi-chevron-down");
                if (chevronDown) {
                    chevronDown.classList.remove("bi-chevron-down");
                    chevronDown.classList.add("bi-chevron-up");
                } else {
                    let chevronUp = contentBox.querySelector(".bi-chevron-up");
                    chevronUp.classList.remove("bi-chevron-up");
                    chevronUp.classList.add("bi-chevron-down");
                }
            }
        });
    });
    document.querySelectorAll('.content-box').forEach(element => {
        element.addEventListener('click', function () {
            window.location.href = this.querySelector('a').href;
        });
    });
});
</script>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb.jsp"%>
			<div class="content-wrap">
				<div class="content-list">
					<c:forEach var="dto" items="${list }">
						<div class="content-box">
							<c:choose>
								<c:when test="${type eq 'notice'}">
									<div class="content-mix">
										<div class="content-num">
											<p>${totalRecords - dto.rn + 1}</p>
										</div>
										<div class="content-title">
											<a href="${pageContext.request.contextPath }/board/noticeView.board?boNo=${dto.boNo}">${dto.title}</a>
											<p>
												<fmt:formatDate value="${dto.insertTime }" pattern="yyyy-MM-dd" />
											</p>
										</div>
									</div>
								</c:when>
								<c:when test="${type eq 'faq'}">
									<div class="content-mix faq">
										<div class="content-title">
											<a href="#" class="post-link">
												<i class="bi bi-quora" style="margin-right: 5px; font-size: 15px; color: #444;"></i>${dto.title }</a>
											<p>
												<fmt:formatDate value="${dto.insertTime }" pattern="yyyy-MM-dd" />
											</p>
										</div>
										<div class="icon-wrap" style="margin-right: 20px;">
											<i class="bi bi-chevron-down"></i>
										</div>
									</div>
									<div class="post-content">
										<span class="inner">${dto.content }</span>
									</div>
								</c:when>
								<c:when test="${type eq 'ask' or type eq 'myask'}">
									<div class="content-mix">
										<div class="content-status-wait">
											<c:choose>
												<c:when test="${dto.answer !=null}">
													<p class="approve">답변 완료</p>
												</c:when>
												<c:otherwise>
													<p>답변 대기</p>
												</c:otherwise>
											</c:choose>
										</div>
										<div class="content-title">
											<a href="${pageContext.request.contextPath }/board/askView.board?boNo=${dto.boNo}">
												<c:if test="${dto.meNo != sessionScope.meNo }">
													<!-- 내가 작성한 게시물이 아닐 경우 자물쇠 아이콘 표시 -->
													<i class="bi bi-lock" style="margin-right: 3px;"></i>
												</c:if>
												${dto.title }
											</a>
											<div>
												<p>
													<fmt:formatDate value="${dto.insertTime }" pattern="yyyy-MM-dd" />
												</p>
												<p>${dto.name }</p>
											</div>
										</div>
									</div>
								</c:when>
							</c:choose>
						</div>
					</c:forEach>
					<c:if test="${type eq 'ask' or type eq 'myask'}">
						<c:if test="${empty list}">
							<div class="content-none-wrap">
								<i class="bi bi-info-circle"></i>
								등록된 문의 내역이 없습니다.
							</div>
						</c:if>
						<div class="content-p-box" style="margin-bottom: 0">
							<div class="content-ask">
								<a href="${pageContext.request.contextPath }/board/askWrite.board">문의하기</a>
							</div>
						</div>
					</c:if>
				</div>
				<div class="pagination">
					<ul>
						<c:if test="${startPage > 1}">
							<li>
								<a href="?type=${type}&page=1&type=${type}" style="margin-right: -10px;">
									<i class="bi bi-chevron-double-left"></i>
								</a>
							</li>
						</c:if>
						<c:if test="${currentPage > 1}">
							<li>
								<a href="?type=${type}&page=${currentPage - 1}&type=${type}">
									<i class="bi bi-chevron-left"></i>
								</a>
							</li>
						</c:if>
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<li>
								<a href="?type=${type}&page=${i}&type=${type}" class="${i == currentPage ? 'active' : ''}">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${currentPage < totalPages}">
							<li>
								<a href="?type=${type}&page=${currentPage + 1}&type=${type}">
									<i class="bi bi-chevron-right"></i>
								</a>
							</li>
						</c:if>
						<c:if test="${endPage < totalPages}">
							<li>
								<a href="?type=${type}&page=${totalPages}&type=${type}" style="margin-left: -10px;">
									<i class="bi bi-chevron-double-right"></i>
								</a>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="../include/footer.jsp"%>

</body>

</html>