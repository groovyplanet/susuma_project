<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
<style>
.main-section .container .content {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 1500px;
	padding: 30px 50px;
	margin-top: 40px;
}

.member-section {
	display: flex;
	align-items: center;
	background-color: #f9f9f9;
	border: 1px solid #e0e0e0;
	border-radius: 10px;
	padding: 20px;
	margin-bottom: 20px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	width: 80%;
	margin-top: 10px;
}

.profile-logoimg {
	flex-shrink: 0;
	margin-right: 20px;
}

.profile-logo-sm {
	width: 80px;
	height: 80px;
	border-radius: 50%;
	border: 2px solid #ddd;
}

.infodetail {
	flex-grow: 1;
}

.infodetail strong {
	display: inline-block;
	width: 120px;
	font-weight: 600;
	color: #333;
}

.infodetail span {
	font-size: 16px;
	color: #555;
}

.review-status {
	margin-left: 20px;
}

.btn.request {
	display: inline-block;
	height: 34px;
	padding: 0 20px;
	border: 1px solid #DDD;
	border-radius: 13px;
	background-color: #fff;
	color: #555;
	font-size: 12px;
	font-weight: 500;
	letter-spacing: -0.5px;
	line-height: 32px;
}
</style>

</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb.jsp"%>
			<div class="content">
				<h4 style="border-bottom: 1px solid black;">후기 내역</h4>
				<c:forEach var="dto" items="${list }">
					<div class="member-section">
						<div class="profile-logoimg">
							<img class="profile-logo-sm" src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="profile-logo-sm">
						</div>
						<div class="infodetail">
							<a href="review_view.jsp" style="text-decoration: none;">
								<div class="member-name">
									<strong>마스터 성함 :</strong>
									${dto.masterName }
									<span></span>
								</div>
								<div class="member-map">
									<strong>위치 :</strong>
									${dto.address }
								</div>
								<div class="review-type">
									<strong>별점 :</strong>
									<span id="starview" style="color: gold;">
							
										<c:forEach var="i" begin="1" end="5">
											<c:choose>
												<c:when test="${i <= dto.starScore}">
                ★
            </c:when>
												<c:otherwise>
                ☆
            </c:otherwise>
											</c:choose>
										</c:forEach>

									</span>
								</div>
							</a>
						</div>
						<div class="review-status">
							<button class="btn request">수리완료</button>
						</div>
					</div>
				</c:forEach>
				<button class="review-more">더보기</button>
			</div>
		</div>
	</section>


	<%@ include file="../include/footer.jsp"%>

</body>

</html>