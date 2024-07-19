<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb_master.jsp"%>
			<div class="review-detail">
				<div class="info-review">
					<div class="member-section">
						<div class="profile-logoimg">
							<img class="profile-logo-sm" src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="profile-logo-sm">
						</div>
						<div class="infodetail">
							<div class="member-name">
								<strong>의뢰인 성함 :</strong> <span>벨기에재즈퀸서희</span>
							</div>
							<div class="member-map">
								<strong>위치 :</strong> 강남구
							</div>
							<div class="review-type">
								<strong>수리 희망 분야 :</strong> [CSS / 백엔드]
							</div>
						</div>
						<div class="review-status">
							<button class="btn request">수리완료</button>
						</div>
					</div>
					<div class="review-more-content">
						<div class="detail-content">
							수리 내역
							<button class="btn edit">수정</button>
						</div>
					</div>
					<div class="review-box-content">
						<div class="detail-content">수리 리뷰 상세</div>
						<div class="review-input">
							<div class="review-rating">
								서비스는 어떠셨나요?
								<div class="stars">★★★★☆</div>

							</div>
							<label for="title"> 기사님이 불친절했어요. </label> <label for="content"> </label>
							<div class="file-list">
								<span class="file-item">수리사진01.png</span> <span class="file-item">수리사진02.png</span> <span class="file-item">수리사진03.png</span> <span class="file-item">수리사진04.png</span>
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