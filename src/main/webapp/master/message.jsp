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
	font-size: 0.5em;
	color: #666;
	position: relative;
	display: block;
}

.message.timestamplf {
	font-size: 0.5em;
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
<script>
$(document).ready(function() {
        // WebSocket 연결 설정
        const socket = new WebSocket("ws://localhost:8181/Susuma/chat"); // WebSocket 경로 확인 필요

        socket.onopen = function() {
            console.log("WebSocket connection opened.");
        };

        socket.onmessage = function(event) {
            const message = event.data;
            const chatBox = $('#chat-box');
            const timeString = new Date().toLocaleTimeString();
            const messageElement = $('<div>');

            // 메시지의 보내는 사람에 따른 처리
            if (message.includes("master")) { // 메시지에 "master"라는 문자열이 포함되어 있다고 가정
                messageElement.addClass('right');
                messageElement.html(`<p class="message timestamp">${timeString}</p>
                                    <div class="message member">${message.replace("master:", "")}</div>`);
            } else {
                messageElement.addClass('left');
                messageElement.html(`<div class="new-profile-img">
                                        <img class="#" src="${pageContext.request.contextPath}/resources/img/iconProfileDefault.png" style="width: 30px; height: 30px;">
                                    </div>
                                    <div class="message memberlf">${message}</div>
                                    <p class="message timestamplf">${timeString}</p>`);
            }
            chatBox.append(messageElement);
            chatBox.scrollTop(chatBox[0].scrollHeight); // 스크롤을 자동으로 최신 메시지로 이동
        };

        socket.onclose = function() {
            console.log("WebSocket connection closed.");
        };

        socket.onerror = function(error) {
            console.error("WebSocket error: " + error.message);
        };

        function sendMessage() {
            const masterNo = $('#masterNo').val();
            const clientNo = $('#clientNo').val();
            const messageText = $('#chat-input').val();
            const formattedMessage = `${masterNo}:${messageText}`;
            socket.send(formattedMessage);
            $('#chat-input').val('');
        }

        $('#send-button').click(function() {
            sendMessage();
        });

        $('#chat-input').keypress(function(e) {
            if (e.which === 13) { // Enter key
                sendMessage();
            }
        });

        // 주기적으로 메시지 가져오기
        setInterval(fetchMessages, 3000);

        function fetchMessages() {
            $.ajax({
                url: '/Susuma/master/messages', // 서버에서 정의된 실제 URL 확인 필요
                type: 'GET',
                success: function(data) {
                    const chatBox = $('#chat-box');
                    chatBox.empty();
                    data.forEach(message => {
                        const sendTime = new Date(message.sendTime);
                        const timeString = sendTime.toLocaleTimeString();
                        const messageElement = $('<div>');
                        if (message.masterNo === parseInt($('#masterNo').val())) {
                            messageElement.addClass('right');
                            messageElement.html(`<p class="message timestamp">${timeString}</p>
                                                <div class="message member">${message.message}</div>`);
                        } else {
                            messageElement.addClass('left');
                            messageElement.html(`<div class="new-profile-img">
                                                    <img class="#" src="${pageContext.request.contextPath}/resources/img/iconProfileDefault.png" style="width: 30px; height: 30px;">
                                                </div>
                                                <div class="message memberlf">${message.message}</div>
                                                <p class="message timestamplf">${timeString}</p>`);
                        }
                        chatBox.append(messageElement);
                    });
                    chatBox.scrollTop(chatBox[0].scrollHeight); // 스크롤을 자동으로 최신 메시지로 이동
                },
                error: function(xhr, status, error) {
                    console.error('AJAX 요청 실패:', status, error);
                }
            });
        }
    });
</script>


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
            <input type="hidden" id="masterNo" value="1"> <!-- 임시 값 -->
            <input type="hidden" id="clientNo" value="2"> <!-- 임시 값 -->
            <input type="text" id="chat-input" placeholder="메시지를 입력하세요">
            <button id="send-button">전송</button>
        </div>
	</div>

</body>

</html>