<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
<style>
.main-section .container .content {
	padding: 30px 50px;
}

.chatlist-container {
	max-width: 300px;
	margin: 20px auto;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.chatlist {
	overflow-y: auto;
	max-height: 400px;
}

.chatroom {
	display: flex;
	padding: 15px;
	border-bottom: 1px solid #ccc;
	cursor: pointer;
	transition: background-color 0.3s;
}

.chatroom:hover {
	background-color: #f2f2f2;
}

.new-mark.active {
	position: absolute;
	width: 14px;
	height: 14px;
	background: #ff5b16;
	border-radius: 100%;
	font-size: 10px;
	color: white;
	text-align: center;
	font-weight: 100;
	line-height: 14px;
}

.chatroom-profile img {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	object-fit: cover;
}

.chatroom-info {
	flex: 1;
	margin-left: 10px;
}

.chatroom-name {
	font-weight: bold;
}

.last-message {
	color: #666;
}

.chatroom-time {
	font-size: 12px;
	color: #999;
}
</style>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb_master.jsp"%>
			<div class="content">
				<h4 style="border-bottom: 1px solid #eee; display: flex; justify-content: center; padding: 20px;">문의 내역</h4>
				<div class="chatlist">
					<div class="chatroom">
						<div class="chatroom-profile">
							<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Image">
						</div>
						<div class="chatroom-info">
							<div class="chatroom-name">
								<span id="mastername"><strong>김현용</strong></span>님<span class="new-mark active">N</span>
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
								<span id="mastername"><strong>조예원</strong></span>님
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
								<span id="mastername"><strong>박서희</strong></span>님
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