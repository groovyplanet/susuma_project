<%@ page import="java.sql.*, java.util.Random" %>
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
					<form action="findPwForm.member" id="form-find-info">
						<div class="title-sub">가입한 이메일 주소를 입력해주세요</div>
						<input type="email" class="input-field" placeholder="이메일을 입력해주세요." autocomplete="no" name="email" id="email" required>
						<div class="title-sub2">가입하신 이메일 주소를 입력해주시면 임시 비밀번호를 발급해드립니다.</div>
						<button type="submit" class="btn-submit">임시 비밀번호 발급</button>
					</form>
					
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>

</body>

</html>