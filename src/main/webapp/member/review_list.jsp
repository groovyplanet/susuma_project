<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ include file="../include/head.jsp"%>
</head>

<body class="request request-list review-list">
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb.jsp"%>
			<div class="content">
				<h4 style="border-bottom: 1px solid black;">후기 내역</h4>
				<c:forEach var="dto" items="${list }">
					<div class="member-section">
						<c:choose>
							<%-- 의뢰인 --%>
							<c:when test="${sessionScope.type eq 'user'}">
								<c:choose>
									<c:when test="${dto.masterProfilePhotoImg == '' }">
										<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile-photo">
									</c:when>
									<c:otherwise>
										<img src="data:image/png;base64,${dto.masterProfilePhotoImg }" alt="Profile Picture" class="profile-photo">
									</c:otherwise>
								</c:choose>
								<a href="${pageContext.request.contextPath }/member/view.request?reqNo=${dto.reqNo }" class="info">
									<div class="repair_date">
										<span>
											<i class="bi bi-calendar-check" style="margin-right: 4px;"></i>${dto.requestDate }</span>
										<span>${dto.requestTime }</span>
									</div>
									<div class="master_name">
										${dto.masterName } 수리기사님
										<c:set var="addressParts" value="${fn:split(dto.masterAddress, ' ')}" />
										<span class="address">
											<i class="bi bi-geo-alt"></i>
											<span>${addressParts[0]}</span>
											<span>${addressParts[1]}</span>
										</span>
									</div>
									<div class="repair_type">
										<p class="master-category">
											<span>${dto.caRootName }
												<i class="bi bi-chevron-right"></i>${dto.caName }</span>
										</p>
									</div>
									<div class="explain">
										<span id="starview" class="star-score">
											<c:forEach var="i" begin="1" end="5">
												<c:choose>
													<c:when test="${i <= dto.starScore}">
														<i class="bi bi-star-fill"></i>
													</c:when>
													<c:otherwise>
														<i class="bi bi-star"></i>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</span>
										<span>
											<c:out value="${fn:substring(dto.content, 0, 45)}" />
										</span>
									</div>
								</a>
							</c:when>
							<%-- 수리기사 --%>
							<c:otherwise>
								<c:choose>
									<c:when test="${dto.clientProfilePhotoImg == '' }">
										<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile-photo">
									</c:when>
									<c:otherwise>
										<img src="data:image/png;base64,${dto.clientProfilePhotoImg }" alt="Profile Picture" class="profile-photo">
									</c:otherwise>
								</c:choose>
								<a href="${pageContext.request.contextPath }/member/view.request?reqNo=${dto.reqNo }" class="info">
									<div class="repair_date">
										<span>
											<i class="bi bi-calendar-check" style="margin-right: 4px;"></i>${dto.requestDate }</span>
										<span>${dto.requestTime }</span>
									</div>
									<div class="master_name">
										${dto.clientName } 의뢰인
										<span class="address">
											<i class="bi bi-geo-alt"></i>
											<span>${dto.clientAddress }</span>
											<span> </span>
											<span>${dto.clientAddressDetail }</span>
										</span>
									</div>
									<div class="explain">
										<span id="starview" class="star-score">
											<c:forEach var="i" begin="1" end="5">
												<c:choose>
													<c:when test="${i <= dto.starScore}">
														<i class="bi bi-star-fill"></i>
													</c:when>
													<c:otherwise>
														<i class="bi bi-star"></i>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</span>
										<span>
											<c:out value="${fn:substring(dto.content, 0, 45)}" />
										</span>
									</div>
								</a>
							</c:otherwise>
						</c:choose>
					</div>
				</c:forEach>
				<button id="btn-more" class="btn-request-summary-more" style="${totalRecords > recordsPerPage ? '' : 'display:none'}">
					더보기
					<i class="bi bi-chevron-down"></i>
				</button>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>
	<script>
		let currentPage = 1;
		const endPage = ${endPage};

		$('#btn-more').on('click', function() {
			loadMoreRequests(currentPage + 1);
		});
		
		function loadMoreRequests(page) {
		    fetch('getReviewsAjax.review?page=' + page)
	        .then(response => response.text())
	        .then(html => {
	            $('#btn-more').before(html);
				currentPage = page;
				if (currentPage >= endPage) {
					$('#btn-more').hide();
				}
	        })
	        .catch(error => console.error('Error fetching requests:', error));
		}
	</script>

</body>

</html>