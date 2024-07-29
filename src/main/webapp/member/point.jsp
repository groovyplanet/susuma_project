<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../include/head.jsp"%>
</head>



<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<!-- 출금 모달 -->
		<div id="withdrawModal" class="modal">
			<div class="modal-content">
				<p>전체 출금을 진행하시겠습니까?</p>
				<div class="modal-buttons">
					<button class="btn-confirm">예</button>
					<button class="btn-cancel">아니요</button>
				</div>
			</div>
		</div>
		<!-- 충전 모달 -->
		<div id="chargeModal" class="modal">
			<div class="modal-content">
				<p>충전할 금액을 입력하세요</p>
				<input type="text" id="chargeAmount" min="0" placeholder="숫자만 입력하세요">
				<div class="modal-buttons">
					<button class="btn-confirm" id="confirmCharge">충전</button>
					<button class="btn-cancel" id="cancelCharge">취소</button>

				</div>
			</div>
		</div>

		<div class="container">
			<%@ include file="../include/snb.jsp"%>
			<div class="content">
				<div class="account-info">
					<div class="points-section">
						<div class="points-header">
							<span class="points-label">보유 포인트</span>
						</div>
						<div class="points-value"><fmt:formatNumber value="${points}" type="number" groupingUsed="true" maxFractionDigits="0" />P</div>
						<button class="btn-withdraw" id="withdrawButton">전체출금</button>
						<button class="btn-charge" id="chargeButton">충전하기</button>
					</div>
					<div class="transaction-history">
						<div class="tab-menu">
							<button id="tab-add" class="tab active">적립 내역</button>
							<button id="tab-pop" class="tab">사용 내역</button>
						</div>
						<div class="transaction-list">
							<c:forEach var="plus" items="${plus}">
								<div class="transaction-item item">
									<span class="date">
										<fmt:formatDate value="${plus.insertTime}" pattern="yyyy-MM-dd HH:mm:ss" />
									</span>
									<span class="amount">
										<fmt:formatNumber value="${plus.point}" type="number" groupingUsed="true" maxFractionDigits="0" />
										P
										<span class="status">충전 완료</span>
									</span>

								</div>
							</c:forEach>
							<c:forEach var="minus" items="${minus}">
								<div class="transaction-pop item" style="display: none;">
									<span class="date">
										<fmt:formatDate value="${minus.insertTime}" pattern="yyyy-MM-dd HH:mm:ss" />
									</span>
									<span class="spamount">
										${minus.point<0 ? '' : '-' }
										<fmt:formatNumber value="${minus.point}" type="number" groupingUsed="true" maxFractionDigits="0" />
										P
										<span class="spstatus">${minus.point<0 ? '출금 완료' : '결제 완료' }</span>
									</span>
								</div>
							</c:forEach>
						
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>
	<script>

	/*
	$(document).ready(function () {
	    $('.amount').each(function () {
	        var input = $(this).text();
	        var numericValue = input.replace(/[^\d]/g, '');
	        var formattedValue = new Intl.NumberFormat().format(numericValue) + ' 원';
	        $(this).html(formattedValue + ' <span class="status">' + $(this).find('.status').text() + '</span>');
	    });
	    $('.spamount').each(function () {
	        // .status 클래스를 제외한 .amount의 텍스트만 처리
	        var amountText = $(this).clone().children('.spstatus').remove().end().text();
	        var numericValue = '-' + amountText.replace(/[^\d]/g, '');
	        var formattedValue = new Intl.NumberFormat().format(numericValue) + ' 원';
	
	        // .status 클래스를 다시 추가하여 상태 메시지와 함께 포맷된 값으로 텍스트 설정
	        $(this).html(formattedValue + ' <span class="spstatus">' + $(this).find('.spstatus').text() + '</span>');
	    });
	
	
	
	    $('.wdamount').each(function () {

	        // .status 클래스를 제외한 .amount의 텍스트만 처리
	        var amountText = $(this).clone().children('.wdstatus').remove().end().text();
	        var numericValue = '-' + amountText.replace(/[^\d]/g, '');
	        var formattedValue = new Intl.NumberFormat().format(numericValue) + ' 원';

	        // .status 클래스를 다시 추가하여 상태 메시지와 함께 포맷된 값으로 텍스트 설정
	        $(this).html(formattedValue + ' <span class="wdstatus">' + $(this).find('.wdstatus').text() + '</span>');
	    });
	
	    // .points-value 클래스에 대해 포맷 적용
	    $('.points-value').each(function () {
	        var input = $(this).text();
	        var numericValue = '+' + input.replace(/[^\d]/g, '');
	        var formattedValue = new Intl.NumberFormat().format(numericValue) + ' 원';
	        $(this).text(formattedValue);
	    });
	});
	*/

	
	$('#chargeAmount').on('input', function() { // 금액 입력 시 ',원' 추가
		var input = $(this).val();
		var numericValue = input.replace(/[^\d]/g, '');
		var formattedValue = new Intl.NumberFormat().format(numericValue) + ' P';
		$(this).val(formattedValue);
	});
	
	
	$(document).ready(function() {
	    // 탭 전환 처리
	    $("#tab-add, #tab-pop").click(function() {
	        if (!$(this).hasClass("active")) {
	            $(".item").toggle();
	            $(".tab").toggleClass("active");
	        }
	    });

	    // 출금 모달 열기
	    document.getElementById('withdrawButton').addEventListener('click', function() {
	        document.getElementById('withdrawModal').classList.add('show');
	    });

	    // 출금 모달 닫기
	    document.querySelector('#withdrawModal .btn-cancel').addEventListener('click', function() {
	        document.getElementById('withdrawModal').classList.remove('show');
	    });

	 // 출금 모달에서 확인 버튼 클릭 시
	    document.querySelector('#withdrawModal .btn-confirm').addEventListener('click', function() {
	        fetch('/Susuma/member/withdrawPoints.member', { // 절대 경로 사용
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/x-www-form-urlencoded',
	            },
	            body: new URLSearchParams({ points: 'ALL' }), // 'ALL'을 사용하여 전체 출금을 의미
	        })
	        .then(response => response.json()) // 응답을 JSON으로 파싱
	        .then(data => {
	            if (data.status === 'success') {
	                alert(data.message);
	                location.reload(); // 페이지를 새로고침하여 포인트를 업데이트합니다.
	            } else {
	                alert(data.message); // 실패 메시지 표시
	            }
	        })
	        .catch(error => {
	            alert('출금에 실패했습니다.');
	            console.error('Error:', error);
	        });

	        // 모달 닫기
	        document.getElementById('withdrawModal').classList.remove('show');
	    });
	 

	    // 충전 모달 열기
	    document.getElementById('chargeButton').addEventListener('click', function() {
	        document.getElementById('chargeModal').classList.add('show');
	    });

	    // 충전 모달 닫기
	    document.querySelector('#chargeModal .btn-cancel').addEventListener('click', function() {
	        document.getElementById('chargeModal').classList.remove('show');
	    });

	    // 충전 모달에서 확인 버튼 클릭 시
	    document.querySelector('#chargeModal .btn-confirm').addEventListener('click', function() {
	    
	        const amount = $('#chargeAmount').val().replace(/[^\d]/g, '');
	        
	        if (amount <= 0) {
	            alert('충전 금액은 0보다 커야 합니다.');
	            return;
	        }

	        fetch('/Susuma/member/chargePoints.member', { // 절대 경로 사용
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/x-www-form-urlencoded',
	            },
	            body: new URLSearchParams({ points: amount }), // 충전할 포인트
	            
	        })
	        .then(response => response.json()) // 응답을 JSON으로 파싱
	        .then(data => {
	            if (data.status === 'success') {
	                alert(data.message);
	                location.reload(); // 페이지를 새로고침하여 포인트를 업데이트합니다.
	            } else {
	                alert(data.message); // 실패 메시지 표시
	            }
	        })
	        .catch(error => {
	            alert('충전에 실패했습니다.');
	            console.error('Error:', error);
	        });

	        // 모달 닫기
	        document.getElementById('chargeModal').classList.remove('show');
	    });
	});
	
	
	
	
	
	</script>


</body>
</html>
