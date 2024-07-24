<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container message-list">
			<%@ include file="../include/snb.jsp"%>
			<div class="content">
				<h4 style="border-bottom: 1px solid #eee; display: flex; justify-content: center; padding: 20px;">문의 내역</h4>
				<div class="chatlist">
					<div class="chatroom">
						<div class="chatroom-profile">
							<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Image">
						</div>
						<div class="chatroom-info">
							<div class="chatroom-name">
								<span id="mastername">
									<strong>김현용</strong>
								</span>
								마스터님
								<span class="new-mark active">N</span>
							</div>
							<div class="last-message">안녕하세요!</div>
						</div>
						<div class="chatroom-time">10:00 AM</div>
					</div>
					<div class="chatroom">
						<div class="chatroom-profile">
							<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Image">
						</div>
						<div class="chatroom-info">
							<div class="chatroom-name">
								<span id="mastername">
									<strong>조예원</strong>
								</span>
								마스터님
							</div>
							<div class="last-message">반갑습니다!</div>
						</div>
						<div class="chatroom-time">2024.07.16</div>
					</div>
					<div class="chatroom">
						<div class="chatroom-profile">
							<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Image">
						</div>
						<div class="chatroom-info">
							<div class="chatroom-name">
								<span id="mastername">
									<strong>박서희</strong>
								</span>
								마스터님
							</div>
							<div class="last-message">저 오늘은 포리 밥 줘야해서..</div>
						</div>
						<div class="chatroom-time">2024.07.15</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>

</body>

</html>