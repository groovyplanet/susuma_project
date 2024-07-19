<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container main-only">
			<div class="main-area find-info">
				<div class="title">비밀번호 찾기</div>
				<div class="find-info-form">
					<form action="#" id="form-find-info">
						<div class="title-sub">가입한 이메일 주소를 입력해주세요</div>
						<input type="email" class="input-field" placeholder="이메일을 입력해주세요." autocomplete="no" name="email" id="email" required>
						<div class="title-sub2">가입하신 이메일 주소를 입력해주시면 임시 비밀번호를 발급해드립니다.</div>
						<button class="btn-submit">임시 비밀번호 발급</button>
					</form>
					<!-- modal -->
					<div id="find-info-complete-modal" class="modal find-info">
						<div class="container">
							<div class="modal-title">임시 비밀번호 발송 완료</div>
							<div class="find-info-content">
								<p>귀하의 이메일로 임시 비밀번호를 발급해드렸습니다.</p>
								<p>로그인 후 비밀번호를 변경해주세요.</p>
							</div>
							<a href="${pageContext.request.contextPath }/" class="btn-enter">확인</a>
							<button type="button" class="btn-close-modal">
								<img src="${pageContext.request.contextPath }/resources/img/iconClose.png" alt="닫기 버튼">
							</button>
						</div>
					</div>
					<!-- //modal -->
					<!-- modal -->
					<div id="find-info-error-modal" class="modal find-info">
						<div class="container">
							<div class="modal-title">일치하는 이메일이 없습니다.</div>
							<div class="find-info-content">
								<p>입력하신 이메일로 가입한 회원 정보가 없습니다.</p>
								<p>이메일을 다시 입력해주세요.</p>
							</div>
							<button type="button" onclick="this.closest('.modal').classList.remove('show');" class="btn-enter">확인</button>
							<button type="button" class="btn-close-modal">
								<img src="${pageContext.request.contextPath }/resources/img/iconClose.png" alt="닫기 버튼">
							</button>
						</div>
					</div>
					<!-- //modal -->
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>

</body>

</html>