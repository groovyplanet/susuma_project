<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb_board.jsp"%>
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
											<a href="${pageContext.request.contextPath }/board/notice_view.jsp">${dto.title}</a>
											<p>
												<fmt:formatDate value="${dto.insertTime }" pattern="yyyy-MM-dd" />
											</p>
										</div>
									</div>
								</c:when>
								<c:when test="${type eq 'faq'}">
									<div class="content-mix faq">
										<div class="content-title">
											<a href="#" class="post-link">${dto.title }</a>
											<p>
												<fmt:formatDate value="${dto.insertTime }" pattern="yyyy-MM-dd" />
											</p>
										</div>
										<div class="icon-wrap" style="margin-right: 20px;">
											<i class="bi bi-chevron-down"></i>
										</div>
									</div>
									<div class="post-content">
										<span>${dto.content }</span>
									</div>
								</c:when>
								<c:when test="${type eq 'ask'}">
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
											<a href="${pageContext.request.contextPath }/board/ask_view.jsp">${dto.title }</a>
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
					<c:if test="${type eq 'ask'}">
						<div class="content-p-box" style="margin-bottom: 0">
							<div class="content-ask">
								<a href="${pageContext.request.contextPath }/board/ask_write.jsp">문의하기</a>
							</div>
						</div>
					</c:if>
				</div>
				<div class="pagination">
					<ul>
						<c:if test="${startPage > 1}">
							<li>
								<a href="?type=${type}&page=1" style="margin-right: -10px;">
									<i class="bi bi-chevron-double-left"></i>
								</a>
							</li>
						</c:if>
						<c:if test="${currentPage > 1}">
							<li>
								<a href="?type=${type}&page=${currentPage - 1}">
									<i class="bi bi-chevron-left"></i>
								</a>
							</li>
						</c:if>
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<li>
								<a href="?type=${type}&page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${currentPage < totalPages}">
							<li>
								<a href="?type=${type}&page=${currentPage + 1}">
									<i class="bi bi-chevron-right"></i>
								</a>
							</li>
						</c:if>
						<c:if test="${endPage < totalPages}">
							<li>
								<a href="?type=${type}&page=${totalPages}" style="margin-left: -10px;">
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