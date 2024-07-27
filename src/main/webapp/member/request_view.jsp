<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<%@ include file="../include/head.jsp"%>
</head>
<style>
.stars {
	display: flex;
	cursor: pointer;
}

.star {
	font-size: 4rem;
	color: lightgray;
}

.star.checked {
	color: gold;
}

.hidden-input {
	display: none;
}
</style>


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
							<c:choose>
								<c:when test="${requestDTO.masterProfilePhotoImg == '' }">
									<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile-logo-sm">
								</c:when>
								<c:otherwise>
									<img src="data:image/png;base64,${requestDTO.masterProfilePhotoImg }" alt="Profile Picture" class="profile-logo-sm">
								</c:otherwise>
							</c:choose>
						</div>
						<div class="infodetail">
							<div class="member-name">
								<strong>마스터님 성함 : </strong>
								<span>
									<a href="masterView.member?meNo=${requestDTO.masterNo }">${requestDTO.masterName }</a>
								</span>
							</div>
							<div class="member-map">
								<strong>위치 : </strong>
								${requestDTO.masterAddress }
							</div>
							<div class="repair-type">
								<strong>수리 희망 분야 :</strong>
								[CSS / 백엔드]
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

					<form action="editForm.review" method="post" id="form-review">
						<input type="hidden" name="reqNo" value="${requestDTO.reqNo}">
						<div class="review-box-content">

							<div class="detail-content">수리 리뷰 상세</div>

							<span style="margin-left: 50px;">${requestDTO.content }</span>

							<div class="review-input">
								<div class="review-rating">
									서비스는 어떠셨나요?
									<div class="stars">
										<span class="star" data-value="1">★</span>
										<span class="star" data-value="2">★</span>
										<span class="star" data-value="3">★</span>
										<span class="star" data-value="4">★</span>
										<span class="star" data-value="5">★</span>
									</div>
									<input type="hidden" id="starScore" name="starScore" value="0">
									<!-- 별점 hidden 필드 추가 -->
									<div class="review-title">
										<label for="title">제목 :</label>
										<input type="text" id="title" name="title" placeholder="후기 제목을 입력해 주세요.">
									</div>
									<div class="review-content">
										<label for="content">내용 :</label>
										<textarea id="content" name="content" placeholder="후기 내용을 입력해 주세요."></textarea>
									</div>
									<div class="file-attachment">
										파일 첨부
										<input type="file" id="file-upload" name="files" multiple>
										<div class="file-list" id="file-list">
											<span class="file-item">수리사진01.png</span>
											<span class="file-item">수리사진02.png</span>
											<span class="file-item">수리사진03.png</span>
											<span class="file-item">수리사진04.png</span>
										</div>
									</div>
									<div class="action-buttons">
										<button type="button" class="btn cancel" onclick="cancelReview()">취소</button>
										<button type="submit" class="btn save" onclick="saveReview()">저장</button>
									</div>
								</div>
							</div>
						</div>
					</form>
	</section>

	<%@ include file="../include/footer.jsp"%>

	<script>
	 // 별점 선택 기능
    document.querySelectorAll('.star').forEach(star => {
        star.addEventListener('click', function() {
            const value = this.getAttribute('data-value');
            document.querySelectorAll('.star').forEach(s => {
                s.classList.remove('checked');
            });
            for (let i = 0; i < value; i++) {
                document.querySelectorAll('.star')[i].classList.add('checked');
            }
            document.getElementById('rating').value = value;
        });
    });
	 
    document.addEventListener('DOMContentLoaded', () => {
        const stars = document.querySelectorAll('.stars .star');
        stars.forEach(star => {
            star.addEventListener('click', () => {
                stars.forEach(s => s.classList.remove('selected'));
                star.classList.add('selected');
                document.getElementById('starScore').value = star.getAttribute('data-value');
            });
        });
    });
	 
 // 파일 업로드 기능 (선택사항, 필요시 구현)
    document.getElementById('file-upload').addEventListener('change', function() {
        const fileList = document.getElementById('file-list');
        fileList.innerHTML = '';
        for (let i = 0; i < this.files.length; i++) {
            const fileItem = document.createElement('span');
            fileItem.classList.add('file-item');
            fileItem.textContent = this.files[i].name;
            fileList.appendChild(fileItem);
        }
    });
	
	
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
		var latitude = ${requestDTO.latitude}; // 위도(가로선) -> 높을수록 y좌표 값이 커짐
		var longitude = ${requestDTO.longitude}; // 경도(세로선) -> 높을수록 x좌표 값이 커짐

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