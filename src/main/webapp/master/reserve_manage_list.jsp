<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<div id="reserve-approve-btn" class="modal">
		<div class="modal-content" style="text-align: center;">
			<p>예약을 승인하시겠습니까?</p>
			<div class="modal-buttons">
				<button class="approve-confirm">예</button>
				<button class="approve-cancel">아니요</button>
			</div>
		</div>
	</div>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb_master.jsp"%>
			<div class="content reservation-setting">

				<h4 class="reserve-list-title">예약 관리</h4>
				<br>

				<div class="reserve-schecdule">
					<button class="btn approve" id="approve-button">승인 대기</button>
					<img class="profile-logo-sm" src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="profile-logo-sm">
					<div class="info">
						<div class="repair_date">2024.07.12</div>
						<div class="name">
							박서희 <span class="address"> 강남구 </span>
						</div>
						<div class="repair_type">전체 수리 시급</div>
					</div>
				</div>
				<div class="reserve-schecdule">
					<button class="btn complete">승인 완료</button>
					<img class="profile-logo-sm" src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="profile-logo-sm">
					<div class="info">
						<div class="repair_date">2024.07.12</div>
						<div class="name">
							박서희 <span class="address"> 강남구 </span>
						</div>
						<div class="repair_type">전체 수리 시급</div>
					</div>
				</div>
				<div class="reserve-schecdule">
					<button class="btn complete">승인 완료</button>
					<img class="profile-logo-sm" src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="profile-logo-sm">
					<div class="info">
						<div class="repair_date">2024.07.12</div>
						<div class="name">
							박서희 <span class="address"> 강남구 </span>
						</div>
						<div class="repair_type">전체 수리 시급</div>
					</div>
				</div>
				<div class="reserve-schecdule">
					<button class="btn pending" id="pending-button">결제 대기</button>
					<img class="profile-logo-sm" src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="profile-logo-sm">
					<div class="info">
						<div class="repair_date">2024.07.12</div>
						<div class="name">
							박서희 <span class="address"> 강남구 </span>
						</div>
						<div class="repair_type">전체 수리 시급</div>
					</div>
				</div>
				<div class="reserve-schecdule">
					<button class="btn complete">승인 완료</button>
					<img class="profile-logo-sm" src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="profile-logo-sm">
					<div class="info">
						<div class="repair_date">2024.07.12</div>
						<div class="name">
							박서희 <span class="address"> 강남구 </span>
						</div>
						<div class="repair_type">전체 수리 시급</div>
					</div>
				</div>
				<button class="reserve-more">더보기</button>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>
	<script>
		document.getElementById('approve-button').addEventListener(
				'click',
				function() {
					document.getElementById('reserve-approve-btn').classList
							.add('show');
				});

		document
				.querySelector('#reserve-approve-btn .approve-cancel')
				.addEventListener(
						'click',
						function() {
							document.getElementById('reserve-approve-btn').classList
									.remove('show');
						});

		document
				.querySelector('#reserve-approve-btn .approve-confirm')
				.addEventListener(
						'click',
						function() {
							// Add your withdraw logic here
							alert('승인이 완료되었습니다.');
							document.getElementById('reserve-approve-btn').classList
									.remove('show');
						});

		document.querySelector('#pending-button').addEventListener('click',
				function() {
					// Add your withdraw logic here
					alert('현재 고객님의 결제를 기다리고 있습니다. 잠시만 기다려주세요 !');

				});
	</script>


</body>

</html>