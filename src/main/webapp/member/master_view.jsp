<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.susuma.member.model.MemberDTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<div class="content master-view">
				<div class="new-edit-form">
					<div class="new-profile-img">
						<c:choose>
							<c:when test="${dto.profilePhotoImg == '' }">
								<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile">
							</c:when>
							<c:otherwise>
								<img src="data:image/png;base64,${dto.profilePhotoImg }" alt="Profile Picture" class="profile">
							</c:otherwise>
						</c:choose>
					</div>
					<div class="new-master-section">
						<div class="new-master-name">
							<c:out value="${dto.name}" />
							수리기사
						</div>
						<div class="master-info">
							<c:if test="${dto.reviewCount > 0}">
								<p class="master-stars">
									<i class="bi bi-star-fill gold"></i>
									<strong>${dto.averageScore }</strong>
									<span class="review-count">(후기${dto.reviewCount })</span>
								</p>
							</c:if>
							<p style="margin: 3px 0;">
								<c:set var="addressParts" value="${fn:split(dto.address, ' ')}" />
								<i class="bi bi-geo-alt"></i>${addressParts[0]}
								${addressParts[1]} (${dto.maxDistance}km 이내 가능)
							</p>
							<p class="master-category">
								<span>${dto.caRootName }
									<i class="bi bi-chevron-right"></i>${dto.caName }</span>
							</p>
							<p style="margin: 3px 0 0;">${dto.shortDescription }</p>
						</div>
						<div class="reserve-button-block">
							<a href="${pageContext.request.contextPath }/member/request.member?meNo=${dto.meNo}" class="new-btn new-reserve" id="reserve-button">예약 신청</a>
							<a class="new-btn new-reserve-contact" onclick="openMessage(${dto.meNo}); return false;">
								<i class="bi bi-chat-dots" style="font-size: 15px;"></i>
								채팅
							</a>
						</div>
					</div>
				</div>

				<div class="new-detailed_description">
					<div class="new-detailed_descriptiontitle" style="font-size: 19px; margin-left:20px">서비스 상세 설명</div>
					<div class="new-description_details preserve-line-breaks" style="margin: 0 0 0 20px;">${dto.description}</div>
				</div>
				<div class="new-service_scheduling">
					<div class="new-service_schedulingtitle" style="font-size: 19px; margin-left:20px">근무요일 및 시간</div>
					<div class="new-schedule_details" style="margin: 0 0 0 21px;">
						<div class="preserve-line-breaks">${dto.workHours}</div>
					</div>

				</div>

				<div class="review-list-master">
					<div class="review">
						<div class="tab-review">
							<button id="tab-pic-list" class="tab active">후기</button>

						</div>
						<div class="review-list">
							<c:forEach var="dto" items="${list2}">
								<div class="pic-review-view item">
									<c:set var="firstChar" value="${fn:substring(dto.clientName, 0, 1)}" />
									<c:set var="maskedName" value="${firstChar}" />
									<c:forEach var="i" begin="1" end="${fn:length(dto.clientName) - 1}">
										<c:set var="maskedName" value="${maskedName}*" />
									</c:forEach>
									<span class="sizetype-view-wrap">
										<span class="sizetype-view">



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


												</ul>
											</div>
											<span class="review-oneline">${dto.content }</span>
										</span>
										<div class="right-content">

											<span class="nickname">${maskedName }고객님의 후기</span>
											<span class="date">
												<fmt:formatDate value="${dto.insertTime}" pattern="yy년 MM월 dd일" />
											</span>
										</div>
									</span>

								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>
	<script>
		function openMessage(meNo) {
			if('${meNo}' == '') {
				alert('로그인이 필요한 서비스 입니다.');
				return false;
			}
			var url = 'form.message?user='+meNo;
			var name = '_blank';
			var width = 440;
			var height = 550;
			var left = (window.screen.width - width) / 2;
			var top = (window.screen.height - height - 200) / 2;
			window.open(url, name, "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top);
		}
	</script>
</body>

</html>