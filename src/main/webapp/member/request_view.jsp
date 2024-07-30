<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<%@ include file="../include/head.jsp"%>
</head>

<body class="request request-view">
	<%@ include file="../include/header.jsp"%>
	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb.jsp"%>
			<div class="content repair-detail">
				<%-- 현재날짜와 수리예약일 비교 (ex.2024. 9. 13(금) 19:00) --%>
				<jsp:useBean id="now" class="java.util.Date" />
				<fmt:formatDate value="${now}" pattern="yyyy. M. d" var="nowDate" />
				<fmt:formatDate value="${now}" pattern="HH:00" var="nowTime" />
				<fmt:parseDate value="${fn:substringBefore(requestDTO.requestDate, '(') }" pattern="yyyy. M. d" var="requestDateParse" />
				<fmt:formatDate value="${requestDateParse}" pattern="yyyy. M. d" var="requestDateFmt" />
				<fmt:parseDate value="${requestDTO.requestTime }" pattern="HH:00" var="requestTimeParse" />
				<fmt:formatDate value="${requestTimeParse}" pattern="HH:00" var="requestTimeFmt" />
				<div class="info-reserve">
					<c:choose>
						<%-- 의뢰인 --%>
						<c:when test="${sessionScope.type eq 'user'}">
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
									<div class="repair_date">
										<span>
											<i class="bi bi-calendar-check" style="margin-right: 4px;"></i>${requestDTO.requestDate }</span>
										<span>${requestDTO.requestTime }</span>
									</div>
									<div class="master_name">
										${requestDTO.masterName } 수리기사님
										<c:set var="addressParts" value="${fn:split(requestDTO.masterAddress, ' ')}" />
										<span class="address">
											<i class="bi bi-geo-alt"></i>
											<span>${addressParts[0]}</span>
											<span>${addressParts[1]}</span>
										</span>
									</div>
									<div class="repair_type">
										<p class="master-category">
											<span>${requestDTO.caRootName }
												<i class="bi bi-chevron-right"></i>${requestDTO.caName }</span>
										</p>
									</div>
								</div>
								<div class="repair-status">
									<c:choose>
										<c:when test="${requestDTO.status eq 'requested'}">
											<button type="button" class="btn">예약 승인 대기</button>
										</c:when>
										<c:when test="${requestDTO.status eq 'approved'}">
											<c:choose>
												<c:when test="${requestDateFmt > nowDate or (requestDateFmt == nowDate and requestTimeFmt > nowTime)}">
													<!-- 예약일이 미래 -->
													<button type="button" class="btn">예약 완료</button>
												</c:when>
												<c:otherwise>
													<!-- 예약일이 과거 -->
													<button type="button" class="btn">수리 중</button>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:when test="${requestDTO.status eq 'paywait'}">
											<button type="button" class="btn submit pay" data-reqno="${requestDTO.reqNo}" data-payamount='${requestDTO.payAmount}'>결제하기</button>
										</c:when>
										<c:when test="${requestDTO.status eq 'paid'}">
											<button type="button" class="btn complete">결제 완료</button>
										</c:when>
										<c:when test="${requestDTO.status eq 'cancel'}">
											<button type="button" class="btn complete">예약 취소</button>
										</c:when>
									</c:choose>
								</div>
							</div>
							<c:if test="${requestDTO.status eq 'approved' or requestDTO.status eq 'paywait' or requestDTO.status eq 'paid'}">
								<div class="content-wrap">
									<div class="title">수리기사 연락처</div>
									<div class="content-pay">
										<i class="bi bi-telephone"></i>
										${requestDTO.masterPhoneNum }
									</div>
								</div>
							</c:if>
							<c:if test="${requestDTO.status eq 'paid'}">
								<div class="content-wrap">
									<div class="title">결제 정보</div>
									<div class="content-pay">
										<i class="bi bi-clock-history"></i>
										<fmt:formatDate value="${requestDTO.paidTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
										<strong>
											<fmt:formatNumber value="${requestDTO.payAmount}" type="number" groupingUsed="true" maxFractionDigits="0" />
											P
										</strong>
										결제
									</div>
								</div>
							</c:if>
							<div class="content-wrap">
								<div class="title">수리 요청 내용</div>
								<div class="content">${requestDTO.content }</div>
							</div>
							<c:if test="${requestDTO.status eq 'paid'}">
								<c:choose>
									<c:when test="${reviewDTO != null }">
										<div class="content-wrap">
											<div class="title">리뷰 내용</div>
											<div class="star-score">
												<c:forEach var="i" begin="1" end="5">
													<c:choose>
														<c:when test="${i <= reviewDTO.starScore}">
															<i class="bi bi-star-fill"></i>
														</c:when>
														<c:otherwise>
															<i class="bi bi-star"></i>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</div>
											<div class="content">${reviewDTO.content }</div>
										</div>
									</c:when>
									<c:otherwise>
										<form action="editForm.review" method="post" id="form-review">
											<input type="hidden" name="reqNo" value="${requestDTO.reqNo}">
											<div class="content-wrap">
												<div class="title">리뷰 작성</div>
												<div class="review-input">
													<div class="review-rating">
														서비스는 어떠셨나요?
														<div class="stars">
															<span class="star" data-value="1">
																<i class="bi bi-star-fill"></i>
															</span>
															<span class="star" data-value="2">
																<i class="bi bi-star-fill"></i>
															</span>
															<span class="star" data-value="3">
																<i class="bi bi-star-fill"></i>
															</span>
															<span class="star" data-value="4">
																<i class="bi bi-star-fill"></i>
															</span>
															<span class="star" data-value="5">
																<i class="bi bi-star-fill"></i>
															</span>
														</div>
														<input type="hidden" id="starScore" name="starScore" value="0">
														<!-- 별점 hidden 필드 추가 -->
														<div class="review-content">
															<textarea id="content" name="content" placeholder="후기 내용을 입력해 주세요." required></textarea>
														</div>
														<!-- <div class="file-attachment">
														파일 첨부
														<input type="file" id="file-upload" name="files" multiple>
														<div class="file-list" id="file-list">
															<span class="file-item">수리사진01.png</span>
															<span class="file-item">수리사진02.png</span>
															<span class="file-item">수리사진03.png</span>
															<span class="file-item">수리사진04.png</span>
														</div>
													</div> -->
														<div class="action-buttons">
															<button type="submit" class="btn save" onclick="saveReview()">리뷰 등록</button>
														</div>
													</div>
												</div>
											</div>
										</form>
									</c:otherwise>
								</c:choose>
							</c:if>
						</c:when>
						<%-- 수리기사 --%>
						<c:otherwise>
							<div class="member-section">
								<div class="profile-logoimg">
									<c:choose>
										<c:when test="${requestDTO.clientProfilePhotoImg == '' }">
											<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile-logo-sm">
										</c:when>
										<c:otherwise>
											<img src="data:image/png;base64,${requestDTO.clientProfilePhotoImg }" alt="Profile Picture" class="profile-logo-sm">
										</c:otherwise>
									</c:choose>
								</div>
								<div class="infodetail">
									<div class="repair_date">
										<span>
											<i class="bi bi-calendar-check" style="margin-right: 4px;"></i>${requestDTO.requestDate }</span>
										<span>${requestDTO.requestTime }</span>
									</div>
									<div class="master_name">${requestDTO.clientName }<span> </span>
										의뢰인
									</div>
									<div class="member-map">
										<i class="bi bi-geo-alt"></i>
										<span>${requestDTO.clientAddress }</span>
										<span> </span>
										<span>${requestDTO.clientAddressDetail }</span>
									</div>
								</div>
								<div class="repair-status">
									<c:choose>
										<c:when test="${requestDTO.status eq 'requested'}">
											<button type="button" class="btn submit approve" data-reqno="${requestDTO.reqNo}">예약 승인</button>
										</c:when>
										<c:when test="${requestDTO.status eq 'approved'}">
											<c:choose>
												<c:when test="${requestDateFmt > nowDate or (requestDateFmt == nowDate and requestTimeFmt > nowTime)}">
													<!-- 예약일이 미래 -->
													<button type="button" class="btn">예약 완료</button>
												</c:when>
												<c:otherwise>
													<!-- 예약일이 과거 -->
													<button type="button" class="btn submit pay-request" data-reqno="${requestDTO.reqNo}">결제 요청</button>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:when test="${requestDTO.status eq 'paywait'}">
											<button type="button" class="btn">결제 대기</button>
										</c:when>
										<c:when test="${requestDTO.status eq 'paid'}">
											<button type="button" class="btn complete">결제 완료</button>
										</c:when>
										<c:when test="${requestDTO.status eq 'cancel'}">
											<button type="button" class="btn complete">예약 취소</button>
										</c:when>
									</c:choose>
								</div>
							</div>
							<div class="location-area" style="display: flex; justify-content: space-around; margin-top: 15px;">
								<div id="map" style="width: 700px; height: 400px;"></div>
							</div>
							<div class="content-wrap">
								<div class="title">의뢰인 연락처</div>
								<div class="content-pay">
									<i class="bi bi-telephone"></i>
									${requestDTO.masterPhoneNum }
								</div>
							</div>
							<c:if test="${requestDTO.status eq 'paid'}">
								<div class="content-wrap">
									<div class="title">결제 정보</div>
									<div class="content-pay">
										<i class="bi bi-clock-history"></i>
										<fmt:formatDate value="${requestDTO.paidTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
										<strong>
											<fmt:formatNumber value="${requestDTO.payAmount}" type="number" groupingUsed="true" maxFractionDigits="0" />
											P
										</strong>
										결제
									</div>
								</div>
							</c:if>
							<div class="content-wrap">
								<div class="title">수리 요청 내용</div>
								<div class="content">${requestDTO.content }</div>
							</div>
							<c:if test="${requestDTO.status eq 'paid' and reviewDTO != null }">
								<div class="content-wrap">
									<div class="title">리뷰 내용</div>
									<div class="star-score">
										<c:forEach var="i" begin="1" end="5">
											<c:choose>
												<c:when test="${i <= reviewDTO.starScore}">
													<i class="bi bi-star-fill"></i>
												</c:when>
												<c:otherwise>
													<i class="bi bi-star"></i>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</div>
									<div class="content">${reviewDTO.content }</div>
								</div>
							</c:if>
						</c:otherwise>
					</c:choose>

				</div>
			</div>
		</div>
	</section>

	<!-- modal -->
	<div id="request-approve-modal" class="modal request">
		<div class="container">
			<div class="modal-title">예약 승인</div>
			<div class="pay-content">
				<p>승인 버튼 클릭 시 예약이 확정됩니다.</p>
			</div>
			<button class="btn-enter">승인</button>
			<button type="button" class="btn-close-modal">
				<img src="${pageContext.request.contextPath }/resources/img/iconClose.png" alt="닫기 버튼">
			</button>
		</div>
	</div>
	<div id="request-pay-request-modal" class="modal request">
		<div class="container">
			<div class="modal-title">결제 요청</div>
			<div class="pay-content">
				<p>결제 요청 금액을 입력하세요</p>
				<input type="text" id="paymoney" class="input-money" placeholder="숫자만 입력하세요">
			</div>
			<button class="btn-enter">완료</button>
			<button type="button" class="btn-close-modal">
				<img src="${pageContext.request.contextPath }/resources/img/iconClose.png" alt="닫기 버튼">
			</button>
		</div>
	</div>
	<div id="request-pay-modal" class="modal request">
		<div class="container">
			<div class="modal-title">수리 금액 결제</div>
			<div class="pay-content">
				<p>
					결제 하실 금액은
					<strong id="amount"> 10,000P </strong>
					입니다.
				</p>
			</div>
			<button class="btn-enter">결제</button>
			<button type="button" class="btn-close-modal">
				<img src="${pageContext.request.contextPath }/resources/img/iconClose.png" alt="닫기 버튼">
			</button>
		</div>
	</div>
	<!-- //modal -->

	<%@ include file="../include/footer.jsp"%>

	<script>

	$('#paymoney').on('input', function() { // 금액 입력 시 ',원' 추가
		var input = $(this).val();
		var numericValue = input.replace(/[^\d]/g, '');
		var formattedValue = new Intl.NumberFormat().format(numericValue) + ' P';
		$(this).val(formattedValue);
	});

	$(".request").on("click", ".approve", function() { // 수리기사 : 예약 승인

		var button = $(this);
		var reqNo = button.data('reqno');

		$('#request-approve-modal').attr('class', ' modal request show');
		$('#request-approve-modal .btn-enter').data('reqNo', reqNo);

	})

	// 예약 승인 완료 버튼 클릭 시
	$('#request-approve-modal .btn-enter').on('click', function(event) {
		event.preventDefault();
		var reqNo = $(this).data('reqNo');

		$.ajax({
			url : 'approveAjax.request',
			type : 'POST',
			data : {
				reqNo : reqNo,
				status : 'approved'
			},
			success : function(data) {
				if ($.trim(data) === 'Success') {
					$('button[data-reqno="' + reqNo + '"]').text('예약 완료').removeClass('submit approve');
					$('#request-approve-modal').removeClass('show');
					alert('승인되었습니다.');
				} else {
					alert('결제 처리 실패');
				}
			},
			error : function(xhr, status, error) {
				console.error('서버 오류: ' + xhr.status);
			}
		});
	});

	$(".request").on("click", ".pay-request", function() { // 수리기사 : 결제 요청

		var button = $(this);
		var reqNo = button.data('reqno');
		$('#paymoney').val("");

		$('#request-pay-request-modal').attr('class', ' modal request show');
		$('#request-pay-request-modal .btn-enter').data('reqNo', reqNo);

	})

	// 결제 요청 완료 버튼 클릭 시
	$('#request-pay-request-modal .btn-enter').on('click', function(event) {
		event.preventDefault();
		var reqNo = $(this).data('reqNo');

		$.ajax({
			url : 'payRequestAjax.request',
			type : 'POST',
			data : {
				reqNo : reqNo,
				status : 'paywait',
				payAmount : $('#paymoney').val().replace(/[^\d]/g, '')
			},
			success : function(data) {
				if ($.trim(data) === 'Success') {
					$('button[data-reqno="' + reqNo + '"]').text('결제 대기').removeClass('submit pay-request');
					$('#request-pay-request-modal').removeClass('show');
					alert('결제 요청되었습니다.');
				} else {
					alert('결제 요청 실패');
				}
			},
			error : function(xhr, status, error) {
				console.error('서버 오류: ' + xhr.status);
			}
		});
	});
	$(".request").on("click", ".pay", function() { // 의뢰인 : 결제하기

		var button = $(this);
		var reqNo = button.data('reqno');

		// 금액 모달창에 띄우기
		var payAmount = button.data('payamount'); // 소문자로만 가져올 수 있음
		var amountNumber = parseInt(payAmount, 10);
		var formattedAmount = amountNumber.toLocaleString('en-US') + 'P';
		$('#amount').text(formattedAmount);
		$('#request-pay-modal').attr('class', ' modal request show');
		$('#request-pay-modal .btn-enter').data('reqNo', reqNo);

	})

	// 결제 완료 버튼 클릭 시
	$('#request-pay-modal .btn-enter').on('click', function(event) {
		event.preventDefault();
		var reqNo = $(this).data('reqNo');
		
		$.ajax({
			url : 'payAjax.request',
			type : 'POST',
			data : {
				reqNo : reqNo,
				status : 'paid',
				payAmount : $('#amount').text().replace(/[^\d]/g, '')
			},
			success : function(data) {
				if ($.trim(data) === 'Success') {
					$('button[data-reqno="' + reqNo + '"]').replaceWith("<a href='view.request?reqNo="+reqNo+"' class='btn link'>후기 작성</a>");
					$('#request-pay-modal').removeClass('show');
					alert('결제가 완료되었습니다.');
				} else {
					alert($.trim(data));
					$('#request-pay-modal').removeClass('show');
				}
			},
			error : function(xhr, status, error) {
				console.error('서버 오류: ' + xhr.status);
			}
		});
	});
	
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
	var latitude = ${ requestDTO.latitude }; // 위도(가로선) -> 높을수록 y좌표 값이 커짐
	var longitude = ${ requestDTO.longitude }; // 경도(세로선) -> 높을수록 x좌표 값이 커짐

	kakao.maps.load(function () {
	    // 지도를 표시할 영역, 중심좌표, 확대 레벨 세팅
	    var mapContainer = document.getElementById('map');
	    if (mapContainer) {

	        // 지도 옵션 설정
	        var mapOption = {
	            center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
	            level: 4 // 지도의 확대 레벨
	        };

	        // 지도 생성
	        var map = new kakao.maps.Map(mapContainer, mapOption);

	        // 마커 표시
	        var markerPosition = new kakao.maps.LatLng(latitude,
	            longitude);
	        var marker = new kakao.maps.Marker({
	            position: markerPosition
	        });
	        marker.setMap(map);

	        // 컨트롤 추가
	        var mapTypeControl = new kakao.maps.MapTypeControl();
	        var zoomControl = new kakao.maps.ZoomControl();
	        map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	        map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	    }
	});

	document.getElementById('payButton').addEventListener('click', function () {
	    document.getElementById('payModal').classList.add('show');
	});

	document.querySelector('#payModal .btn-confirm').addEventListener('click', function () {
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
	window.onclick = function (event) {
	    var modal = document.getElementById('payModal');
	    if (event.target == modal) {
	        modal.classList.remove("show");
	    }
	}
	</script>
	<!-- //api -->

</body>

</html>