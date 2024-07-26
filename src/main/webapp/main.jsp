<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="include/head.jsp"%>
<style>
.technician {
	border: 1px solid #ddd;
	margin: 10px;
	padding: 20px;
	width: 300px;
	text-align: center;
	transition: transform 0.3s ease-in-out;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	background-color: #fff;
}

.technician:hover {
	transform: translateY(-5px);
	box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
}

.technician img {
	width: 100px;
	height: 100px;
	border-radius: 50%;
	margin-bottom: 10px;
}
</style>
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

							<a href="${pageContext.request.contextPath }/member/masterList.member"> <img src="${pageContext.request.contextPath }/resources/img/repair.png" alt="가전제품"> 가전제품
							</a> <a href="${pageContext.request.contextPath }/member/masterList.member"> <img src="${pageContext.request.contextPath }/resources/img/door.png" alt="문"> 문/창문
							</a> <a href="${pageContext.request.contextPath }/member/masterList.member"> <img src="${pageContext.request.contextPath }/resources/img/susudo.png" alt="수도"> 수도/보일러/전기
							</a> <a href="${pageContext.request.contextPath }/member/masterList.member"> <img src="${pageContext.request.contextPath }/resources/img/fusu.png" alt="가구"> 가구
							</a> <a href="${pageContext.request.contextPath }/member/masterList.member"> <img src="${pageContext.request.contextPath }/resources/img/etcrepair.png" alt="수리"> 기타 설치/수리
							</a>
						</div>
					</div>
				</div>
				<!-- //main-service -->


				<!-- [2] main-master -->
				<div class="main-master-intro">
					<h3>마법의 실력을가진 마스터님들</h3>
				</div>
				<div class="main-master-kim">
					<c:forEach var="dto" items="${list}">
						<c:set var="addressParts" value="${fn:split(dto.address, ' ')}" />
						<a class="technician" style="text-decoration: none; color: black;" href="${pageContext.request.contextPath }/user/master_view.jsp"> <img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="홍길동">
							<h3>${dto.name }</h3>
							<p>별점:★${dto.averageScore } (${dto.reviewCount })</p>
							<p>지역: ${addressParts[0]} ${addressParts[1]} (${dto.maxDistance}km 이내 가능)</p>
							<p>${dto.shortDescription }</p>
						</a>
					</c:forEach>

				</div>
				<!-- //main-master -->

				<!-- [3] main-review -->
				<div class="main-review-text">
					<h3>마스터님들 자랑</h3>
				</div>
				<div class="main-review-kim">
					<a href="${pageContext.request.contextPath }/user/master_view.jsp" class="main-review-box">
						<div class="main-review-head">
							<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="">
							<div class="main-review-head-text">
								<p>예원 초</p>
								<span>코딩마스터</span>
							</div>
						</div>
						<div class="main-review-foot">
							<div class="main-review-score">
								<ul>
									<li>★</li>
									<li>★</li>
									<li>★</li>
									<li>★</li>
									<li>★</li> 5.0
								</ul>
							</div>
							<div class="main-review-foot-text">
								<p>코딩관련으로 여러가지 사이트나 홈페이지들을 알아보다가 마스터님을 알게 됐는데, 친절하게 상담해주시고 요구사항들을 잘 들어주셔서 선택하게 됐습니다. 마스터님께서 요구사항들을 잘 들어주시고 여러가지 기능들을 잘 추가해주셔서...</p>
								<div class="main-review-user-name">한** 고객님의 후기</div>
							</div>
						</div>
					</a> <a href="${pageContext.request.contextPath }/user/master_view.jsp" class="main-review-box">
						<div class="main-review-head">
							<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="">
							<div class="main-review-head-text">
								<p>예원 초</p>
								<span>코딩마스터</span>
							</div>
						</div>
						<div class="main-review-foot">
							<div class="main-review-score">
								<ul>
									<li>★</li>
									<li>★</li>
									<li>★</li>
									<li>★</li>
									<li>★</li> 5.0
								</ul>
							</div>
							<div class="main-review-foot-text">
								<p>코딩관련으로 여러가지 사이트나 홈페이지들을 알아보다가 마스터님을 알게 됐는데, 친절하게 상담해주시고 요구사항들을 잘 들어주셔서 선택하게 됐습니다. 마스터님께서 요구사항들을 잘 들어주시고 여러가지 기능들을 잘 추가해주셔서...</p>
								<div class="main-review-user-name">한** 고객님의 후기</div>
							</div>
						</div>
					</a> <a href="${pageContext.request.contextPath }/user/master_view.jsp" class="main-review-box">
						<div class="main-review-head">
							<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="">
							<div class="main-review-head-text">
								<p>예원 초</p>
								<span>코딩마스터</span>
							</div>
						</div>
						<div class="main-review-foot">
							<div class="main-review-score">
								<ul>
									<li>★</li>
									<li>★</li>
									<li>★</li>
									<li>★</li>
									<li>★</li> 5.0
								</ul>
							</div>
							<div class="main-review-foot-text">
								<p>코딩관련으로 여러가지 사이트나 홈페이지들을 알아보다가 마스터님을 알게 됐는데, 친절하게 상담해주시고 요구사항들을 잘 들어주셔서 선택하게 됐습니다. 마스터님께서 요구사항들을 잘 들어주시고 여러가지 기능들을 잘 추가해주셔서...</p>
								<div class="main-review-user-name">한** 고객님의 후기</div>
							</div>
						</div>
					</a>
				</div>
				<!-- //main-review -->
			</div>
		</div>
	</section>

	<%@ include file="include/footer.jsp"%>

</body>

</html>