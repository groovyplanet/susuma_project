<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb.jsp"%>
			<div class="content exit">
				<div class="join-form exit-form">
					<div class="title">회원탈퇴</div>
					<form action="exitForm.member" method="post" id="form-exit">
						<div class="desc-area">
							<p>회원 탈퇴 시 아래 사항을 숙지하시기 바랍니다.</p>
							<p class="mt15">1. 회원 탈퇴 시 고객님의 정보는 전자상거래 등에서의 소비자 보호에 관한 법률에 의거한 고객정보 보호정책에 따라 관리 됩니다.</p>
							<p>2. 탈퇴 시 고객님께서 보유하셨던 적립금은 모두 삭제 됩니다.</p>
							<p>3. 회원 탈퇴 후 3개월간 재가입이 불가능합니다. 회원 탈퇴 시 이용 중이던 서비스 제공 및 이용료 결제가 중단됩니다.</p>
							<p></p>
							<p class="mt25">현재 비밀번호를 입력해주세요</p>
						</div>
						<div class="input-area">
							<input type="password" class="input-field" placeholder="비밀번호를 입력해주세요." autocomplete="no" name="pw" id="pw" required>
							<p class="caption-error">비밀번호가 일치하지 않습니다.</p>
							<!-- 비밀번호가 일치하지 않을 경우 input-area에 class error 추가 -->
						</div>
						<div class="btn-area">
							<input type="submit" class="btn-submit" value="회원탈퇴">
							<a href="${pageContext.request.contextPath }/" class="btn-submit cancel">취소</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>

</body>

</html>