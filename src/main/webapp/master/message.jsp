<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f0f0f0;
	width: 420px;
	height: 450px;
	overflow: hidden;
}

.chat-container {
	width: 400px;
	max-width: 600px;
	margin: 0 auto;
	border: 1px solid #ccc;
	border-radius: 10px;
	overflow: hidden;
	background-color: #fff;
}

.chat-box {
	height: 400px;
	overflow-y: auto;
	padding: 10px;
	border-bottom: 1px solid #ccc;
	padding-top: 0px;
}

.chat-box .right {
	display: flex;
	justify-content: flex-end;
}

.chat-box .left {
	display: flex;
	justify-content: flex-start;
	align-items: center;
}

.input-group {
	display: flex;
	padding: 10px;
}

#chat-input {
	flex: 1;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	margin-right: 10px;
}

button {
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	background-color: #F49D00;
	color: #fff;
	cursor: pointer;
}

button:hover {
	background-color: #d68b00;
}

.message {
	margin: 10px 0;
	padding: 10px;
	border-radius: 5px;
}

.message.member {
	background-color: #dcf8c6;
	align-self: flex-end;
	max-width: calc(100% - 115px);
}

.message.memberlf {
	background-color: #F49D00;
	color: white;
	max-width: calc(100% - 115px);
	margin-left: 10px;
}

.message.counselor {
	background-color: #fff;
	border: 1px solid #ccc;
	align-self: flex-start;
}

.message.timestamp {
	font-size: 0.3em;
	color: #666;
	position: relative;
	display: block;
}

.message.timestamplf {
	font-size: 0.3em;
	color: #666;
	position: relative;
	display: block;
}

.calender {
	text-align: center;
	font-size: 12px;
	color: #666;
	border-radius: 5px;
	background-color: #eee;
}

.master-name {
	font-size: 14px;
	width: 400px;
	color: white;
}
</style>

</head>

<body>

	<div class="chat-container">
		<div class="master-name" style="background-color: #666; height: 30px; border-radius: 5px; padding: 5px;">
			벨기에재즈퀸서희 <span class="star" style="color: gold;">★4.8</span>
		</div>
		<div class="chat-box" id="chat-box">
			<p class="calender">7/17 (수)</p>
			<div class="left">
				<div class="new-profile-img">
					<img class="#" src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" style="width: 30px; height: 30px;">
				</div>
				<div class="message memberlf">안녕하세요</div>
				<p class="message timestamplf">오후 4시 22분</p>

			</div>

			<div class="right">
				<p class="message timestamp">오후 4시 22분</p>
				<div class="message member">안녕하세요</div>
			</div>


		</div>
		<div class="input-group">
			<input type="text" id="chat-input" placeholder="메시지를 입력하세요">
			<button onclick="sendMessage()">전송</button>
		</div>
	</div>

</body>

</html>