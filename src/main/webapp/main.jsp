<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ include file="include/head.jsp"%>

</head>

<body>
	<%@ include file="include/header.jsp"%>

	<section class="main-section">
		<div class="main-title-picture-1900">
			<img src="${pageContext.request.contextPath }/resources/img/title.jpg" alt="" style="justify-content: center; display: flex;">
		</div>
		<div class="container-kim">
			<div class="main-area">

				<!-- [1] main-service -->
				<div class="main-service">
					<div class="main-text-kim">
						<h3>마법같은 수리 서비스를 단 한 곳에서</h3>
					</div>
					<div class="main-imgbox-kim">
						<div class="main-img-kim">

							<a href="${pageContext.request.contextPath }/member/masterList.member?rootNo=1">
								<img src="${pageContext.request.contextPath }/resources/img/gajeon.jpg" alt="가전제품">
								가전제품
							</a>
							<a href="${pageContext.request.contextPath }/member/masterList.member?rootNo=2">
								<img src="${pageContext.request.contextPath }/resources/img/door.png" alt="문">
								문/창문
							</a>
							<a href="${pageContext.request.contextPath }/member/masterList.member?rootNo=3">
								<img src="${pageContext.request.contextPath }/resources/img/sudo.png" alt="수도">
								수도/보일러/전기
							</a>
							<a href="${pageContext.request.contextPath }/member/masterList.member?rootNo=4">
								<img src="${pageContext.request.contextPath }/resources/img/gagu.png" alt="가구">
								가구
							</a>
							<a href="${pageContext.request.contextPath }/member/masterList.member?rootNo=5">
								<img src="${pageContext.request.contextPath }/resources/img/etc.png" alt="수리">
								기타 설치/수리
							</a>
						</div>
					</div>
				</div>
				<!-- //main-service -->


				<!-- [2] main-master -->
				<div class="main-master-intro">
					<h3>마법의 실력을 가진 마스터님들</h3>
				</div>
				<div class="main-master-kim">
					<c:forEach var="dto" items="${list}">
						<c:set var="addressParts" value="${fn:split(dto.address, ' ')}" />
						<a class="technician" style="text-decoration: none; color: black;" href="${pageContext.request.contextPath }/member/masterView.member?meNo=${dto.meNo }">
							<c:choose>
								<c:when test="${dto.profilePhotoImg == '' }">
									<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile">
								</c:when>
								<c:otherwise>
									<img src="data:image/png;base64,${dto.profilePhotoImg }" alt="Profile Picture" class="profile">
								</c:otherwise>
							</c:choose>
							<h3>${dto.name }</h3>
							<div class="master-info">
								<p class="master-stars">
									<i class="bi bi-star-fill gold"></i>
									<strong>${dto.averageScore }</strong>
									<span class="review-count">(후기${dto.reviewCount })</span>
								</p>
								<p>
									<i class="bi bi-geo-alt"></i>${addressParts[0]}
									${addressParts[1]} (${dto.maxDistance}km 이내 가능)
								</p>
								<p>
									<span class="master-category">
										<span>${dto.caRootName }
											<i class="bi bi-chevron-right"></i>${dto.caName }</span>
									</span>
								</p>
								<p>${dto.shortDescription }</p>
							</div>
						</a>
					</c:forEach>

				</div>
				<!-- //main-master -->

				<!-- [3] main-review -->
				<div class="main-review-text">
					<h3>마스터님들 자랑</h3>
				</div>
				<div class="main-review-kim">
					<c:forEach var="dto" items="${list2}">
						<c:set var="firstChar" value="${fn:substring(dto.clientName, 0, 1)}" />
						<c:set var="maskedName" value="${firstChar}" />
						<c:forEach var="i" begin="1" end="${fn:length(dto.clientName) - 1}">
							<c:set var="maskedName" value="${maskedName}*" />
						</c:forEach>
						<a href="#" class="main-review-box">
							<div class="main-review-head">
								<c:choose>
									<c:when test="${dto.profilePhotoImg == '' }">
										<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile">
									</c:when>
									<c:otherwise>
										<img src="data:image/png;base64,${dto.profilePhotoImg }" alt="Profile Picture" class="profile">
									</c:otherwise>
								</c:choose>
								<div class="main-review-head-text">
									<p>${dto.masterName }</p>
									<!-- 	<span>코딩마스터</span> -->
								</div>
							</div>
							<div class="main-review-foot">
								<div class="main-review-score">
									<ul>
										<li>
											<strong></strong>
											<span id="starview" style="color: gold;">

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
										</li>

										${dto.starScore }
									</ul>
								</div>
								<div class="main-review-foot-text">
									<p>${dto.content }</p>
									<div class="main-review-user-name">${maskedName}고객님의후기</div>
								</div>
							</div>
						</a>
					</c:forEach>
				</div>
				<!-- //main-review -->
				
			</div>
		</div>
	</section>
	

	<%@ include file="include/footer.jsp"%>


</body>
</html>


