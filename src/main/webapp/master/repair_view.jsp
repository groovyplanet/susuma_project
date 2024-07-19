<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
<style>
#payModal {
	display: none;
	background-color: rgba(0, 0, 0, .6);
	position: fixed;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	z-index: 9999;
	align-items: center;
	justify-content: center;
}

#payModal.show {
	display: flex !important;
}

#payModal .modal-content {
	width: 416px;
	padding: 48px 48px 40px;
	border-radius: 16px;
	background-color: #fff;
	box-shadow: 0 16px 25px rgba(0, 0, 0, .1), 0 8px 10px rgba(0, 0, 0, .04);
	position: relative;
	text-align: center;
}

#payModal .modal-content p {
	font-size: 16px;
	color: #333;
	margin-bottom: 20px;
}

#payModal .modal-buttons {
	margin-top: 20px;
}

#payModal .btn-confirm, #payModal .btn-cancel {
	background-color: #f49d00;
	color: #fff;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	margin-left: 5px;
}

#payModal .btn-cancel {
	background-color: #999;
}

#payModal .btn-confirm:hover, #payModal .btn-cancel:hover {
	opacity: 0.8;
}

input[type=number]::-webkit-outer-spin-button, input[type=number]::-webkit-inner-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}
</style>
</head>

<body>
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
			<%@ include file="../include/snb_master.jsp"%>
			<div class="content repair-detail">
				<div class="info-reserve">
					<div class="member-section">
						<div class="profile-logoimg">
							<img class="profile-logo-sm" src="../resources/img/iconProfileDefault.png" alt="profile-logo-sm">
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
						<div class="repair-status">
							<button class="btn request" id="payButton">결제요청</button>
							<button class="btn completerequest" style="display: none;">수리완료</button>
						</div>
					</div>
					<div class="location-area" style="display: flex; justify-content: space-around; margin-top: 40px;">
						<div id="map" style="width: 500px; height: 400px;"></div>
					</div>


					<div class="review-box-content">
						<div class="detail-content">수리 리뷰 상세</div>
						<div class="review-input">
							<div class="review-rating">
								서비스는 어떠셨나요?
								<div class="stars">★★★★☆</div>

							</div>
							<label for="title"> 기사님이 불친절했어요. </label> <label for="content">
								<div class="file-list">
									<span class="file-item"><img src="/resources/img/example1.jpeg" alt="" style="width: 100px; height: 100px;"></span> <span class="file-item"><img src="/resources/img/example2.jpg" alt="" style="width: 100px; height: 100px;"></span> <span class="file-item"><img src="/resources/img/example3.jpg" alt="" style="width: 100px; height: 100px;"></span>

								</div>
							</label>


						</div>
					</div>
				</div>
			</div>
		</div>

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
		var latitude = 37.4996310406531; // 위도(가로선) -> 높을수록 y좌표 값이 커짐
		var longitude = 127.030473092157; // 경도(세로선) -> 높을수록 x좌표 값이 커짐

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