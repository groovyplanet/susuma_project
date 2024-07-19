<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div id="withdrawModal" class="modal">
			<div class="modal-content">
				<p>전체 출금을 진행하시겠습니까?</p>
				<div class="modal-buttons">
					<button class="btn-confirm">예</button>
					<button class="btn-cancel">아니요</button>
				</div>
			</div>
		</div>
		<div class="container">
			<%@ include file="../include/snb_master.jsp"%>
			<div class="content">
				<div class="account-info">
					<div class="points-section">
						<div class="points-header">
							<span class="points-label">보유 포인트</span>
						</div>
						<div class="points-value">120,000 P</div>
						<button class="btn-withdraw" id="withdrawButton">전체출금</button>

					</div>
					<div class="transaction-history">
						<div class="tab-menu">
							<button id="tab-add" class="tab active">적립 내역</button>
							<button id="tab-pop" class="tab">사용 내역</button>
						</div>
						<div class="transaction-list">
							<div class="transaction-item item">
								<span class="date">24.07.09</span>
								<span class="amount">150,000P</span>
							</div>
							<div class="transaction-pop item" style="display: none;">
								<span class="date">24.07.09</span>
								<span class="amount">-30,000P</span>
							</div>
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
			})

		});

		document.getElementById('withdrawButton').addEventListener(
				'click',
				function() {
					document.getElementById('withdrawModal').classList
							.add('show');
				});

		document.querySelector('#withdrawModal .btn-cancel').addEventListener(
				'click',
				function() {
					document.getElementById('withdrawModal').classList
							.remove('show');
				});

		document.querySelector('#withdrawModal .btn-confirm').addEventListener(
				'click',
				function() {
					// Add your withdraw logic here
					alert('전체 출금이 진행되었습니다.');
					document.getElementById('withdrawModal').classList
							.remove('show');
				});
	</script>

</body>

</html>