<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../include/head.jsp"%>
</head>

<body class="request-list">
	<%@ include file="../include/header.jsp"%>

	<div id="payModal" class="payModal">
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
	</div>
	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb.jsp"%>
			<div class="content reservation-setting">

				<h4 class="reserve-list-title">예약 내역</h4>
				<br>
				<c:forEach var="dto" items="${list }">
					<div class="reserve-schecdule">
						<img class="profile-logo-sm" src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="profile-logo-sm">
						<a href="${pageContext.request.contextPath }/member/requestView.request?reqNo=${dto.reqNo }" class="info">
							<div class="repair_date">${dto.requestDate }</div>
							<div class="master_name">
								${dto.masterName }
								<span class="address"> ${dto.address } </span>
							</div>
							<div class="repair_type">[CSS 수리]</div>
							<div class="explain">${dto.content }</div>
						</a>
						<button class="btn approve" id="wait">결제 요청</button>
						<!-- <button class="btn complete" id="complete">결제 완료</button> -->
					</div>
				</c:forEach>
				<button class="repair-more">더보기</button>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>
	<script>
		document.getElementById('wait').addEventListener('click', function() {
			document.getElementById('payModal').classList.add('show');
		});

		document.querySelector('#payModal .btn-confirm').addEventListener(
				'click',
				function() {
					var requestButton = document.getElementById('wait');
					requestButton.textContent = '결제 완료';
					requestButton.classList.remove('approve');
					requestButton.classList.add('complete');
					requestButton.id = 'complete';

					document.getElementById('payModal').classList
							.remove('show');
					alert('결제가 완료되었습니다.');

				});
	</script>


</body>

</html>