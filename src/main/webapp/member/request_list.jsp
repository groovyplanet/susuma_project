<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ include file="../include/head.jsp"%>
</head>

<body class="request request-list">
	<%@ include file="../include/header.jsp"%>
	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb.jsp"%>
			<div id="request-list-wrap" class="content reservation-setting">
				<h4 class="reserve-list-title">예약 내역</h4>
				<div class="search-wrap">
					<form id="searchForm" action="list.request" method="get">
						<input type="radio" name="status" value="all" id="status-all" ${status == 'all' ? 'checked' : ''}>
						<label for="status-all" class="checked">전체(${cntDTO.allCnt })</label>
						<input type="radio" name="status" value="requested" id="status-requested" ${status == 'requested' ? 'checked' : ''}>
						<label for="status-requested" class="checked">예약 승인 대기(${cntDTO.requestedCnt })</label>
						<input type="radio" name="status" value="approved" id="status-approved" ${status == 'approved' ? 'checked' : ''}>
						<label for="status-approved" class="checked">예약 완료(${cntDTO.approvedCnt })</label>
						<input type="radio" name="status" value="paywait" id="status-paywait" ${status == 'paywait' ? 'checked' : ''}>
						<label for="status-paywait" class="checked">결제 대기(${cntDTO.paywaitCnt })</label>
						<input type="radio" name="status" value="paid" id="status-paid" ${status == 'paid' ? 'checked' : ''}>
						<label for="status-paid" class="checked">결제 완료(${cntDTO.paidCnt })</label>
						<input type="radio" name="status" value="cancel" id="status-cancel" ${status == 'cancel' ? 'checked' : ''}>
						<label for="status-cancel" class="checked">취소(${cntDTO.cancelCnt })</label>
					</form>
				</div>
				<c:forEach var="dto" items="${list }">
					<%-- 현재날짜와 수리예약일 비교 (ex.2024. 9. 13(금) 19:00) --%>
					<jsp:useBean id="now" class="java.util.Date" />
					<fmt:formatDate value="${now}" pattern="yyyy. M. d" var="nowDate" />
					<fmt:formatDate value="${now}" pattern="HH:00" var="nowTime" />
					<fmt:parseDate value="${fn:substringBefore(dto.requestDate, '(') }" pattern="yyyy. M. d" var="requestDateParse" />
					<fmt:formatDate value="${requestDateParse}" pattern="yyyy. M. d" var="requestDateFmt" />
					<fmt:parseDate value="${dto.requestTime }" pattern="HH:00" var="requestTimeParse" />
					<fmt:formatDate value="${requestTimeParse}" pattern="HH:00" var="requestTimeFmt" />
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
										<c:choose>
											<c:when test="${dto.daysDiff < 0}">
												<span class="days-diff">D${dto.daysDiff}</span>
											</c:when>
											<c:when test="${dto.daysDiff == 0}">
												<span class="days-diff">D-Day</span>
											</c:when>
										</c:choose>
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
									<div class="explain">
										<c:out value="${fn:substring(dto.content, 0, 55)}" />
									</div>
								</a>
								<c:choose>
									<c:when test="${dto.status eq 'requested'}">
										<button type="button" class="btn">예약 승인 대기</button>
									</c:when>
									<c:when test="${dto.status eq 'approved'}">
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
									<c:when test="${dto.status eq 'paywait'}">
										<button type="button" class="btn submit pay" data-reqno="${dto.reqNo}" data-payamount='${dto.payAmount}'>결제하기</button>
									</c:when>
									<c:when test="${dto.status eq 'paid'}">
										<c:choose>
											<c:when test="${dto.reviewCnt == 0}">
												<a href="view.request?reqNo=${dto.reqNo }" class="btn submit">후기 작성</a>
											</c:when>
											<c:otherwise>
												<button type="button" class="btn complete">결제 완료</button>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:when test="${dto.status eq 'cancel'}">
										<button type="button" class="btn complete">예약 취소</button>
									</c:when>
								</c:choose>
							</c:when>
							<%-- 수리기사 --%>
							<c:otherwise>
								<c:choose>
									<c:when test="${dto.clientProfilePhotoImg == '' }">
										<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile-photo">
									</c:when>
									<c:otherwise>
										<img src="data:image/png;base64,${dto.clientProfilePhotoImg }" alt="Profile Picture" class="profile-photo">
									</c:otherwise>
								</c:choose>
								<a href="${pageContext.request.contextPath }/member/view.request?reqNo=${dto.reqNo }" class="info">
									<div class="repair_date">
										<span>
											<i class="bi bi-calendar-check" style="margin-right: 4px;"></i>${dto.requestDate }</span>
										<span>${dto.requestTime }</span>
										<c:choose>
											<c:when test="${dto.daysDiff < 0}">
												<span class="days-diff">D${dto.daysDiff}</span>
											</c:when>
											<c:when test="${dto.daysDiff == 0}">
												<span class="days-diff">D-Day</span>
											</c:when>
										</c:choose>
									</div>
									<div class="master_name">
										${dto.clientName } 의뢰인
										<span class="address">
											<i class="bi bi-geo-alt"></i>
											<span>${dto.clientAddress }</span>
											<span> </span>
											<span>${dto.clientAddressDetail }</span>
										</span>
									</div>
									<div class="explain">
										<c:out value="${fn:substring(dto.content, 0, 55)}" />
									</div>
								</a>
								<c:choose>
									<c:when test="${dto.status eq 'requested'}">
										<button type="button" class="btn submit approve" data-reqno="${dto.reqNo}">예약 승인</button>
									</c:when>
									<c:when test="${dto.status eq 'approved'}">
										<c:choose>
											<c:when test="${requestDateFmt > nowDate or (requestDateFmt == nowDate and requestTimeFmt > nowTime)}">
												<!-- 예약일이 미래 -->
												<button type="button" class="btn">예약 완료</button>
											</c:when>
											<c:otherwise>
												<!-- 예약일이 과거 -->
												<button type="button" class="btn submit pay-request" data-reqno="${dto.reqNo}">결제 요청</button>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:when test="${dto.status eq 'paywait'}">
										<button type="button" class="btn">결제 대기</button>
									</c:when>
									<c:when test="${dto.status eq 'paid'}">
										<button type="button" class="btn complete">결제 완료</button>
									</c:when>
									<c:when test="${dto.status eq 'cancel'}">
										<button type="button" class="btn complete">예약 취소</button>
									</c:when>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</div>
				</c:forEach>
				<button id="btn-more" class="btn-request-summary-more" style="${totalRecords > recordsPerPage ? '' : 'display:none'}">
					더보기
					<i class="bi bi-chevron-down"></i>
				</button>
			</div>
		</div>
	</section>
	<!-- modal -->
	<div id="request-list-approve-modal" class="modal request">
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
	<div id="request-list-pay-request-modal" class="modal request">
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
	<div id="request-list-pay-modal" class="modal request">
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
		let currentPage = 1;
		const endPage = ${endPage};

		$('#btn-more').on('click', function() {
			loadMoreRequests(currentPage + 1);
		});
		

		function loadMoreRequests(page) {
		    fetch('getRequestsAjax.request?page=' + page+'&status='+$("input[type=radio][name='status']:checked").val())
	        .then(response => response.text())
	        .then(html => {
	            // 서버에서 반환된 HTML 조각을 DOM에 삽입
	            $('#btn-more').before(html);
	            
				// 페이지 카운터 증가
				currentPage = page;

				// 만약 더 가져올 페이지가 없다면 버튼 숨김 처리
				if (currentPage >= endPage) {
					$('#btn-more').hide();
				}
	        })
	        .catch(error => console.error('Error fetching requests:', error));
		}
		

		$("input[type=radio][name='status']").on('change', function() {
			$("#searchForm").submit();
		});

		$('#paymoney').on('input', function() { // 금액 입력 시 ',원' 추가
			var input = $(this).val();
			var numericValue = input.replace(/[^\d]/g, '');
			var formattedValue = new Intl.NumberFormat().format(numericValue) + ' P';
			$(this).val(formattedValue);
		});

		$(".request-list").on("click", ".approve", function() { // 수리기사 : 예약 승인

			var button = $(this);
			var reqNo = button.data('reqno');

			$('#request-list-approve-modal').attr('class', ' modal request show');
			$('#request-list-approve-modal .btn-enter').data('reqNo', reqNo);

		})

		// 예약 승인 완료 버튼 클릭 시
		$('#request-list-approve-modal .btn-enter').on('click', function(event) {
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
						$('#request-list-approve-modal').removeClass('show');
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

		$(".request-list").on("click", ".pay-request", function() { // 수리기사 : 결제 요청

			var button = $(this);
			var reqNo = button.data('reqno');
			$('#paymoney').val("");

			$('#request-list-pay-request-modal').attr('class', ' modal request show');
			$('#request-list-pay-request-modal .btn-enter').data('reqNo', reqNo);

		})

		// 결제 요청 완료 버튼 클릭 시
		$('#request-list-pay-request-modal .btn-enter').on('click', function(event) {
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
						$('#request-list-pay-request-modal').removeClass('show');
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
		$(".request-list").on("click", ".pay", function() { // 의뢰인 : 결제하기

			var button = $(this);
			var reqNo = button.data('reqno');

			// 금액 모달창에 띄우기
			var payAmount = button.data('payamount'); // 소문자로만 가져올 수 있음
			var amountNumber = parseInt(payAmount, 10);
			var formattedAmount = amountNumber.toLocaleString('en-US') + 'P';
			$('#amount').text(formattedAmount);
			$('#request-list-pay-modal').attr('class', ' modal request show');
			$('#request-list-pay-modal .btn-enter').data('reqNo', reqNo);

		})

		// 결제 완료 버튼 클릭 시
		$('#request-list-pay-modal .btn-enter').on('click', function(event) {
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
						$('button[data-reqno="' + reqNo + '"]').replaceWith("<a href='view.request?reqNo="+reqNo+"' class='btn submit'>후기 작성</a>");
						$('#request-list-pay-modal').removeClass('show');
						alert('결제가 완료되었습니다.');
					} else {
						alert($.trim(data));
						$('#request-list-pay-modal').removeClass('show');
					}
				},
				error : function(xhr, status, error) {
					console.error('서버 오류: ' + xhr.status);
				}
			});
		});
	</script>


</body>

</html>