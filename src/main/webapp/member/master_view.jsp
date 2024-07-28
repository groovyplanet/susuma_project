<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.susuma.member.model.MemberDTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
						</div>
						<div class="master-info">
							<c:if test="${dto.reviewCount > 0}">
								<p class="master-stars">
									<i class="bi bi-star-fill gold"></i>
									<strong>${dto.averageScore }</strong>
									<span class="review-count">(${dto.reviewCount })</span>
								</p>
							</c:if>
							<p>
								<c:set var="addressParts" value="${fn:split(dto.address, ' ')}" />
								<i class="bi bi-geo-alt"></i>${addressParts[0]}
								${addressParts[1]} (${dto.maxDistance}km 이내 가능)
							</p>
							<p class="master-category">
								<span>${dto.caRootName }
									<i class="bi bi-chevron-right"></i>${dto.caName }</span>
							</p>
							<p>${dto.shortDescription }</p>
						</div>
						<div class="reserve-button-block">
							<a href="${pageContext.request.contextPath }/member/request.member?meNo=${dto.meNo}" class="new-btn new-reserve" id="reserve-button">예약 신청</a>
							<a class="new-btn new-reserve-contact" id="reserve-contact" onclick="window.open(this.href='message.jsp', '_blank', 'width=440, height=550'); return false;">문의 신청</a>
						</div>
					</div>
				</div>

				<div class="new-detailed_description">
					<div class="new-detailed_descriptiontitle">서비스 상세 설명</div>
					<div class="new-description_details preserve-line-breaks">${dto.description}</div>
				</div>
				<div class="new-service_scheduling">
					<div class="new-service_schedulingtitle">서비스 일정 관리</div>
					<div class="new-schedule_details">
						<div class="preserve-line-breaks">${dto.workHours}</div>
					</div>

				</div>

				<div class="review-list-master">
					<div class="review">
						<div class="tab-review">
							<button id="tab-pic-list" class="tab active">후기</button>
							<button id="tab-review-list" class="tab"></button>
						</div>
						<div class="review-list">
							<div class="pic-review-view item">
								<div class="member-review-pic">
									<img src="${pageContext.request.contextPath }/resources/img/example1.jpeg" alt="">
									<img src="${pageContext.request.contextPath }/resources/img/example2.jpg" alt="">
									<img src="${pageContext.request.contextPath }/resources/img/example3.jpg" alt="">
								</div>
								<span class="sizetype-view">
									<span class="date">24.07.09</span>
									<span class="starreview">★★★★★</span>
									<span class="nickname">김모씨</span>
									<span class="review-oneline">기사님이 깨끗하고 집안이 멋져요</span>
								</span>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>
</body>

</html>