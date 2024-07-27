<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ include file="../include/head.jsp"%>
</head>

<body class="request-list">
	<%@ include file="../include/header.jsp"%>
	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb.jsp"%>
			<div id="request-list-wrap" class="content reservation-setting">
				<h4 class="reserve-list-title">예약 내역</h4>
				<br>
				<c:forEach var="dto" items="${list }">
					<%-- 현재날짜와 수리예약일 비교 (ex.2024. 9. 13(금) 19:00) --%>
					<jsp:useBean id="now" class="java.util.Date" />
					<fmt:formatDate value="${now}" pattern="yyyy. M. d" var="nowDate" />
					<fmt:parseDate value="${fn:substringBefore(dto.requestDate, '(') }" pattern="yyyy. M. d" var="requestDateParse" />
					<fmt:formatDate value="${requestDateParse}" pattern="yyyy. M. d" var="requestDateFmt" />
					<div class="request-summary">
						<c:choose>
							<%-- 의뢰인 --%>
							<c:when test="${sessionScope.type eq 'user'}">
								<c:choose>
									<c:when test="${dto.masterProfilePhotoImg == '' }">
										<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile-photo">
									</c:when>
									<c:otherwise>
										<img src="data:image/png;base64,${dto.masterProfilePhotoImg }" alt="Profile Picture" class="profile-photo">
									</c:otherwise>
								</c:choose>
								<a href="${pageContext.request.contextPath }/member/view.request?reqNo=${dto.reqNo }" class="info">
									<div class="repair_date">
										<span>
											<i class="bi bi-calendar-check" style="margin-right: 4px;"></i>${dto.requestDate }</span>
										<span>${dto.requestTime }</span>
									</div>
									<div class="master_name">
										${dto.masterName } 수리기사님
										<c:set var="addressParts" value="${fn:split(dto.masterAddress, ' ')}" />
										<span class="address">
											<i class="bi bi-geo-alt"></i>
											<span>${addressParts[0]}</span>
											<span>${addressParts[1]}</span>
										</span>
									</div>
									<div class="repair_type">
										<p class="master-category">
											<span>${dto.caRootName }
												<i class="bi bi-chevron-right"></i>${dto.caName }</span>
										</p>
									</div>
									<div class="explain">${dto.content }</div>
								</a>
								<c:choose>
									<c:when test="${dto.status eq 'requested'}">
										<button type="button" class="btn">예약 승인 대기</button>
									</c:when>
									<c:when test="${dto.status eq 'approved'}">
										<c:choose>
											<c:when test="${requestDateFmt >= nowDate}">
												<!-- 예약일이 미래 -->
												<button type="button" class="btn">예약 완료</button>
											</c:when>
											<c:otherwise>
												<!-- 예약일이 과거 -->
												<button type="button" class="btn complete">수리 완료</button>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:when test="${dto.status eq 'paywait'}">
										<button type="button" class="btn submit pay-request" data-reqno="${dto.reqNo}" data-payamount='${dto.payAmount}'>결제하기</button>
									</c:when>
									<c:when test="${dto.status eq 'paid'}">
										<button type="button" class="btn complete">결제 완료</button>
									</c:when>
									<c:when test="${dto.status eq 'cancel'}">
										<button type="button" class="btn complete">예약 취소</button>
									</c:when>
								</c:choose>
							</c:when>
							<%-- 수리기사 --%>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</div>
				</c:forEach>
				<button class="btn-request-summary-more" onclick="loadMoreRequests(2)">더보기</button>
				<div id="moreListContainer">
					<!-- 더보기 버튼 클릭시 ajax로 가져온 jsp 파일의 html 코드를 임시로 담을 공간 -->
				</div>
			</div>
		</div>
	</section>
	<!-- modal -->
	<div id="request-list-pay-modal" class="modal request-list">
		<div class="container">
			<div class="modal-title">수리 금액 결제</div>
			<div class="pay-content">
				<p>
					결제 하실 금액은
					<strong id="amount"> 10,000원 </strong>
					입니다.
				</p>
				<p style="color: red;">결제요청 시 결제 금액 환불은 불가합니다.</p>
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
	function loadMoreRequests(page) {
	    fetch('getRequestsAjax.request?page=' + page)
	        .then(response => response.text())
	        .then(html => {
	            // 서버에서 반환된 HTML 조각을 DOM에 삽입
	            const moreListContainer = document.querySelector('#moreListContainer');
	            moreListContainer.innerHTML = html;
	            document.querySelector('#request-list-wrap').appendChild(moreListContainer.firstChild);
	        })
	        .catch(error => console.error('Error fetching requests:', error));
	}

	$(".request-list").on("click", ".pay-request", function () { //.box에 click, a태그한테 위임

	    var button = $(this);
        
        // 금액 모달창에 띄우기
        var payAmount = button.data('payamount'); // 소문자로만 가져올 수 있음
        console.log(payAmount);
        var amountNumber = parseInt(payAmount, 10);
        console.log(amountNumber);
        var formattedAmount = amountNumber.toLocaleString('en-US') + '원';
        console.log(formattedAmount);
        $('#amount').text(formattedAmount);
	    $('#request-list-pay-modal').addClass('show');
	    
		// 결제 완료 버튼 클릭 시
	    $('#request-list-pay-modal .btn-enter').one('click', function (event) {
	        event.preventDefault();

	        // AJAX 요청을 통해 서버에 결제 상태 업데이트
	        $.ajax({
	            url: 'payAjax.request', // 절대 경로 사용
	            type: 'POST',
	            data: {
	                reqNo: button.data('reqno'),
	                payStatus: 'Y'
	            },
	            success: function (data) {
	                console.log(data);
	                // 서버 응답이 'Success'이면 버튼을 업데이트
	                if ($.trim(data) === 'Success') {
	                    button.text('결제 완료');
	                    button.removeClass('approve').addClass('complete');
	                    button.removeClass('pay-request').prop('disabled', true);

	                    // 결제 모달을 숨김
	                    $('#request-list-pay-modal').removeClass('show');
	                    alert('결제가 완료되었습니다.');
	                } else {
	                    alert('결제 처리 실패');
	                }
	            },
	            error: function (xhr, status, error) {
	                console.error('서버 오류: ' + xhr.status);
	                alert('결제 처리 중 오류가 발생했습니다.');
	            }
	        });
	    });

	})

	</script>


</body>

</html>