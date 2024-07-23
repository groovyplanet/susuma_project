<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../include/head.jsp"%>
<style>
/* 버튼 스타일 */
.btn {
	background-color: #F49D00;
	border: 1px solid #F49D00;
	color: white;
	padding: 10px 10px;
	border-radius: 15px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.btn:hover {
	background-color: #D98C00;
}

.btn.approve {
	/* 결제 요청 버튼에 대한 추가 스타일 */
	
}

.btn.complete {
	border: 1px solid #DDD;
	background-color: #fff;
	color: #555;
}

/* 프로필 이미지 스타일 */
.profile-logo-sm {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	margin-right: 10px;
}

.main-section .container .reservation-setting .reserve-schecdule .info {
	padding: 10px;
	background-color: #f9f9f9;
}

/* 예약 스케줄 스타일 */
.reserve-schecdule {
	display: flex;
	align-items: center;
	background-color: #f9f9f9;
	border: 1px solid #e0e0e0;
	border-radius: 10px;
	padding: 20px;
	margin-bottom: 20px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	width: 80%;
	margin-top: 10px;
}

.reserve-schecdule:hover {
	transform: translateY(-5px);
	box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
}

/* 예약 스케줄 정보 스타일 */
.info {
	text-align: left;
	margin-right: 10px;
}

.repair_date, .master_name, .repair_type, .explain {
	margin-bottom: 10px;
}

.master_name {
	font-weight: bold;
}

.address {
	margin-left: 5px;
	color: #666;
}

#payModal {
	display: none;
	background-color: rgba(0, 0, 0, .6);
	position: fixed;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	z-index: 9999;
	align-items: center;
	justify-content: center;
}

#payModal.show {
	display: flex !important;
}

#payModal .modal-content {
	width: 416px;
	padding: 48px 48px 40px;
	border-radius: 16px;
	background-color: #fff;
	box-shadow: 0 16px 25px rgba(0, 0, 0, .1), 0 8px 10px rgba(0, 0, 0, .04);
	position: relative;
	text-align: center;
}

#payModal .modal-content p {
	font-size: 16px;
	color: #333;
	margin-bottom: 20px;
}

#payModal .modal-buttons {
	margin-top: 20px;
}

#payModal .btn-confirm, #payModal .btn-cancel {
	background-color: #f49d00;
	color: #fff;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	margin-left: 5px;
}

#payModal .btn-cancel {
	background-color: #999;
}

#payModal .btn-confirm:hover, #payModal .btn-cancel:hover {
	opacity: 0.8;
}
</style>
</head>

<body>
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
			<%@ include file="../include/snb_user.jsp"%>
			<div class="content reservation-setting">

				<h4 class="reserve-list-title">예약 내역</h4>

				<br>

				<c:forEach var="dto" items="${list }">

					<div class="reserve-schecdule">
						<img class="profile-logo-sm" src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="profile-logo-sm">
						<div class="info">
							<div class="repair_date">${dto.date }</div>
							<div class="master_name">
								김현용
								<span class="address"> 강동구 </span>
							</div>
							<div class="repair_type">[CSS 수리]</div>
							<div class="explain">${dto.content }</div>
						</div>
						<button class="btn approve" id="wait">결제 요청</button>
					</div>
				</c:forEach>

				<!-- 				
				<div class="reserve-schecdule">
					<img class="profile-logo-sm" src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="profile-logo-sm">
					<div class="info">
						<div class="repair_date">2024.07.12</div>
						<div class="master_name">
							한정우 <span class="address"> 광진구 </span>
						</div>
						<div class="repair_type">[CSS 수리]</div>
						<div class="explain">이러쿵 저러쿵 이런거 저런거 도와주세요</div>
					</div>
					<button class="btn complete" id="complete">결제 완료</button>
				</div>
 -->
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