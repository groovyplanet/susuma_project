<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.susuma.member.model.MemberDTO"%>
<%@ include file="../include/head.jsp"%>
</head>

<body class="request-view">
	<%@ include file="../include/header.jsp"%>
	<div id="payModal" class="payModal">
		<div class="modal-content">
			<p>결제 요청 금액을 입력하세요</p>
			<p style="color: red;">결제요청 시 결제 금액 변경은 불가능합니다.</p>
			<input type="number" id="paymoney" placeholder="숫자만 입력하세요">
			<div class="modal-buttons">
				<button class="btn-confirm">입력</button>
			</div>
		</div>
	</div>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb.jsp"%>
			<div class="content repair-detail">
				<div class="info-reserve">
					<div class="member-section">
						<div class="profile-logoimg">
							<img class="profile-logo-sm" src="../resources/img/iconProfileDefault.png" alt="profile-logo-sm">
						</div>
						<div class="infodetail">
							<div class="member-name">
								<strong>마스터님 성함 : </strong> <span>${dto.masterName }</span>
							</div>
							<div class="member-map">
								<strong>위치 : </strong> ${dto.address }
							</div>
							<div class="repair-type">
								<strong>수리 희망 분야 :</strong> [CSS / 백엔드]
							</div>
						</div>
						<div class="repair-status">
							<button class="btn request" id="payButton">결제요청</button>
							<button class="btn completerequest" style="display: none;">수리완료</button>
						</div>
					</div>
					<div class="location-area" style="display: flex; justify-content: space-around; margin-top: 40px;">
						<div id="map" style="width: 500px; height: 400px;"></div>
					</div>

				<form action="reviewForm.member" method="post" id="form-review">
					<div class="review-box-content">
						<div class="detail-content">수리 리뷰 상세</div>
						<div class="review-input">
							<div class="review-rating">
								서비스는 어떠셨나요?
								<div class="stars">★★★★☆</div>
							</div>
							<div class="review-title">
								<label for="title">제목 :</label> <input type="text" id="title" placeholder="후기 제목을 입력해 주세요.">
							</div>
							
							<div class="review-content">
								<label for="content">내용 :</label>
								<textarea id="content" placeholder="후기 내용을 입력해 주세요."></textarea>
							</div>
							<div class="file-attachment">
								파일 첨부 <input type="file" id="file-upload" multiple="">
								<div class="file-list" id="file-list">
									<span class="file-item">수리사진01.png</span> <span class="file-item">수리사진02.png</span> <span class="file-item">수리사진03.png</span> <span class="file-item">수리사진04.png</span>
								</div>
							</div>
							<div class="action-buttons">
								<button class="btn cancel" onclick="cancelReview()">취소</button>
								<button class="btn save" onclick="saveReview()">저장</button>
							</div>
						</div>
					</div>
					</form>
			
	</section>

	<%@ include file="../include/footer.jsp"%>

	<script>
		function showEditForm() {
			document.getElementById('edit-button').style.display = 'none';
			document.getElementById('edit-form').style.display = 'flex';
		}

		function hideEditForm() {
			document.getElementById('edit-form').style.display = 'none';
			document.getElementById('edit-button').style.display = 'block';
		}

		function saveEdit(event) {
			event.preventDefault();
			const input = document.getElementById('repair-details-input');
			if (input.value.trim() !== '') {
				// Save the data, e.g., send to server or update the UI
				console.log('Saved:', input.value);
				hideEditForm();
			}
		}
	</script>
	<!-- 카카오 맵 api -->
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6e324617d728d10d01ca7e36c2a14bf1&libraries=services,clusterer&autoload=false"></script>
	<script>
		// 위도, 경도 변수 세팅 
		var latitude = ${dto.latitude}; // 위도(가로선) -> 높을수록 y좌표 값이 커짐
		var longitude = ${dto.longitude}; // 경도(세로선) -> 높을수록 x좌표 값이 커짐

		kakao.maps
				.load(function() {
					// 지도를 표시할 영역, 중심좌표, 확대 레벨 세팅
					var mapContainer = document.getElementById('map'), mapOption = {
						center : new kakao.maps.LatLng(latitude, longitude),
						level : 4
					};

					// 지도 생성
					var map = new kakao.maps.Map(mapContainer, mapOption);

					// 마커 표시
					var markerPosition = new kakao.maps.LatLng(latitude,
							longitude);
					var marker = new kakao.maps.Marker({
						position : markerPosition
					});
					marker.setMap(map);

					// 컨트롤 추가
					var mapTypeControl = new kakao.maps.MapTypeControl();
					var zoomControl = new kakao.maps.ZoomControl();
					map.addControl(mapTypeControl,
							kakao.maps.ControlPosition.TOPRIGHT);
					map.addControl(zoomControl,
							kakao.maps.ControlPosition.RIGHT);
				});

		document.getElementById('payButton').addEventListener('click',
				function() {
					document.getElementById('payModal').classList.add('show');
				});

		document.querySelector('#payModal .btn-confirm').addEventListener(
				'click',
				function() {
					// Retrieve the value from the input field
					var paymoney = document.getElementById('paymoney').value;

					// Check if paymoney is not empty and is a valid number
					if (paymoney !== "" && !isNaN(paymoney)
							&& parseFloat(paymoney) > 0) {
						alert('결제 요청이 성공적으로 완료되었습니다.');
						document.getElementById('payModal').classList
								.remove('show');
					} else {
						alert('유효한 금액을 입력하세요.');
						document.getElementById('paymoney').setAttribute(
								'style', 'border: 1px solid red;');
					}
				});
		window.onclick = function(event) {
			var modal = document.getElementById('payModal');
			if (event.target == modal) {
				modal.classList.remove("show");
			}
		}
	</script>
	<!-- //api -->

</body>

</html>