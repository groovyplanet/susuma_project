<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
<script>

function sendMessage() {
       const chatInput = document.getElementById('chat-input');
       const message = chatInput.value;

       fetch('../master/messages', {
           method: 'POST',
           headers: {
               'Content-Type': 'application/json'
           },
           body: JSON.stringify({
               sendMeNo: 2,
               getMeNo: 3,
               message: message
           })
       }).then(response => {
           if (response.ok) {
               chatInput.value = '';
               getMessages();
           }
       });
}

function getMessages() {
	fetch('../master/messages')
       .then(response => response.json())
       .then(data => {
           const chatBox = document.getElementById('chat-box');
           data.forEach(dto => {
        	   console.log(dto);
               const messageDiv = document.createElement('div');
               messageDiv.classList.add('message');
               messageDiv.textContent = dto.message;
               chatBox.appendChild(messageDiv);
           });
       });
}
document.addEventListener("DOMContentLoaded", function () {

	// 3초마다 폴링
	setInterval(getMessages, 3000);

	$('#chat-input').keypress(function(e) {
		if (e.which === 13) { // Enter key
			sendMessage();
		}
	});

}); /* DOMContentLoaded */
</script>
</head>

<body class="message">

	<div class="chat-container">
		<div class="master-name" style="background-color: #666; height: 30px; border-radius: 5px; padding: 5px;">
			벨기에재즈퀸서희
			<span class="star" style="color: gold;">★4.8</span>
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
			<input type="hidden" id="masterNo" value="1">
			<!-- 임시 값 -->
			<input type="hidden" id="clientNo" value="2">
			<!-- 임시 값 -->
			<input type="text" id="chat-input" placeholder="메시지를 입력하세요">
			<button id="send-button" onclick="sendMessage()">전송</button>
		</div>
	</div>

</body>

</html>