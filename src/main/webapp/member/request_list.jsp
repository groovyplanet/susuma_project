<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ include file="../include/head.jsp"%>
</head>

<body class="request-list">
	<%@ include file="../include/header.jsp"%>

	<div id="payModal" class="payModal">
		<form id="form-payrequest">
			<div class="modal-content">
				<p>결제 금액을 확인하시고 ,</p>
				<p>결제 버튼을 누르시면 결제가 완료됩니다.</p>
				<p style="color: red;">결제요청 시 결제 금액 환불은 불가합니다.</p>
				<div>
					결제 하실 금액은
					<span id="usermoney">
						<strong> 10,000원 </strong>
						입니다.
					</span>
				</div>
				<div class="modal-buttons">
					<button class="btn-confirm">결제</button>
				</div>
			</div>
		</form>
	</div>
	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb.jsp"%>
			<div class="content reservation-setting">

				<h4 class="reserve-list-title">예약 내역</h4>
				<br>
				<c:forEach var="dto" items="${list }">
					<div class="reserve-schecdule">
						<c:choose>
							<c:when test="${sessionScope.type eq 'user'}">
								<!-- 의뢰인 -->
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
										<span>${dto.requestDate }</span>
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
									<c:when test="${dto.payStatus == 'N'}">
										<button type="button" class="btn approve pay-request" data-reqno="${dto.reqNo}">결제 요청</button>
									</c:when>
									<c:otherwise>
										<button class="btn complete" disabled>결제 완료</button>
									</c:otherwise>
								</c:choose>
								<!-- <button class="btn complete" id="complete">결제 완료</button> -->
							</c:when>
							<c:otherwise>
								<!-- 수리기사 -->
							</c:otherwise>
						</c:choose>
					</div>
				</c:forEach>
				<button class="repair-more">더보기</button>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>
	<script>
	document.querySelectorAll('.pay-request').forEach(function(button) {
	    button.addEventListener('click', function() {
	    	
	        // 결제 요청 버튼을 클릭하면 결제 모달을 표시
	        document.getElementById('payModal').classList.add('show');

	        // 모달에서 확인 버튼 클릭 이벤트
	        document.querySelector('#payModal .btn-confirm').addEventListener('click', function() {
	        	event.preventDefault()
	            var reqNo = button.getAttribute('data-reqno');

	            // FormData 객체를 사용하여 폼 데이터를 생성
	            var formData = new FormData();
	            formData.append('reqNo', reqNo);
	            formData.append('payStatus', 'Y');
	            

	            
	            // fetch API를 사용하여 서버에 결제 상태를 업데이트
	            fetch('payAjax.request', { // 절대 경로 사용
	                method: 'POST',
	                headers: {
	                	"Content-type" : "application/x-www-form-urlencoded"
	                },
	                body: 'reqNo=' + reqNo + "&payStatus=Y"
	            })
	            .then(response => {
	                if (response.ok) {
	                    return response.text(); // 서버 응답을 텍스트로 반환
	                } else {
	                    throw new Error('서버 오류: ' + response.status);
	                }
	            })
	            .then(data => {
	            	console.log(data)
	                // 서버 응답이 'Success'이면 버튼을 업데이트
	                if (data.trim() === 'Success') {
	                    button.textContent = '결제 완료';
	                    button.classList.remove('approve');
	                    button.classList.add('complete');
	                    button.classList.remove('pay-request');
	                    button.disabled = true;

	                    // 결제 모달을 숨김
	                    document.getElementById('payModal').classList.remove('show');
	                    alert('결제가 완료되었습니다.');
	                } else {
	                    throw new Error('결제 처리 실패');
	                }
	            })
	           
	        }, { once: true }); // 추가된 { once: true } 옵션은 이벤트 리스너가 한 번만 실행되도록 합니다.
	    });
	});
	</script>


</body>

</html>