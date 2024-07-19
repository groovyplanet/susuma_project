<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb_master.jsp"%>

			<div class="content reservation-detail">
				<div class="info-reserve">
					<div class="member-section">
						<div class="profile-logoimg">
							<img class="profile-logo-sm" src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="profile-logo-sm">
						</div>
						<div class="infodetail">
							<div class="member-name">
								<strong>의뢰인 성함 : </strong> <span>벨기에재즈퀸서희</span>

							</div>
							<div class="member-map">
								<strong>위치 : </strong> 강남구
							</div>
							<div class="repair-type">
								<strong>수리 희망 분야 :</strong> [CSS / 백엔드]
							</div>
						</div>

						<div class="reserve-status">
							<button class="btn request">예약수락</button>
						</div>
					</div>
					<div class="reserve-more-content">
						<div class="detail-content">이런거 저런거 신경좀 써주세요</div>

					</div>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>

</body>

</html>