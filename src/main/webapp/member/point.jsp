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
         $("#tab-add, #tab-pop").click(function() {
             if (!$(this).hasClass("active")) {
                 $(".item").toggle();
                 $(".tab").toggleClass("active");
             }
         });

         // 출금 모달
         document.getElementById('withdrawButton').addEventListener('click', function() {
             document.getElementById('withdrawModal').classList.add('show');
         });

         document.querySelector('#withdrawModal .btn-cancel').addEventListener('click', function() {
             document.getElementById('withdrawModal').classList.remove('show');
         });

         document.querySelector('#withdrawModal .btn-confirm').addEventListener('click', function() {
             $.ajax({
                 url: 'withdrawPoints', // 요청을 처리할 URL
                 type: 'POST',
                 data: { points: 1000 }, // 출금할 포인트 (여기서는 예시로 1000을 사용)
                 success: function(response) {
                     if (response.status === 'success') {
                         alert(response.message);
                         location.reload(); // 페이지를 새로고침하여 포인트를 업데이트합니다.
                     }
                 },
                 error: function() {
                     alert('출금에 실패했습니다.');
                 }
             });
             document.getElementById('withdrawModal').classList.remove('show');
         });

         // 충전 모달
         document.getElementById('chargeButton').addEventListener('click', function() {
             document.getElementById('chargeModal').classList.add('show');
         });

         document.querySelector('#chargeModal .btn-cancel').addEventListener('click', function() {
             document.getElementById('chargeModal').classList.remove('show');
         });

         document.querySelector('#chargeModal .btn-confirm').addEventListener('click', function() {
             const amount = document.getElementById('chargeAmount').value;
             $.ajax({
                 url: 'chargePoints', // 요청을 처리할 URL
                 type: 'POST',
                 data: { points: amount },
                 success: function(response) {
                     if (response.status === 'success') {
                         alert(response.message);
                         location.reload(); // 페이지를 새로고침하여 포인트를 업데이트합니다.
                     }
                 },
                 error: function() {
                     alert('충전에 실패했습니다.');
                 }
             });
             document.getElementById('chargeModal').classList.remove('show');
         });
     });
 </script>
	<style>
	

	</style>
</body>
</html>
