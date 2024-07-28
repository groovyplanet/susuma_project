<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
            <input type="number" id="chargeAmount" min="0">
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
						<div class="points-value">${points}P</div>
						<button class="btn-withdraw" id="withdrawButton">전체출금</button>
						<button class="btn-charge" id="chargeButton">충전하기</button>
					</div>
					<div class="transaction-history">
						<div class="tab-menu">
							<button id="tab-add" class="tab active">적립 내역</button>
							<button id="tab-pop" class="tab">사용 내역</button>
						</div>
						<div class="transaction-list">
							<c:forEach var="earning" items="${earnings}">
								<div class="transaction-item item">
									<span class="date">
										<fmt:formatDate value="${earning.insertTime}" pattern="yy.MM.dd" />
									</span>
									<span class="amount">${earning.point}P</span>
								</div>
							</c:forEach>
							<c:forEach var="spending" items="${spendings}">
								<div class="transaction-pop item" style="display: none;">
									<span class="date">
										<fmt:formatDate value="${spending.insertTime}" pattern="yy.MM.dd" />
									</span>
									<span class="amount">-${spending.point}P</span>
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
	        const amount = document.getElementById('chargeAmount').value;
	        
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


	<style>
	

	</style>
</body>
</html>
