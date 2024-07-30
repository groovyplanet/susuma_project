<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ include file="../include/head.jsp"%>
</head>

<body class="message">
	<div class="chat-container">
		<input type="hidden" name="getMeNo" value="${getMeNo }">
		<div class="user-info">
			<a href="/Susuma/member/view.request?reqNo=80" class="info" target="_blank">
				<div class="name">
					${userDTO.name} ${userDTO.type=='master' ? '수리기사님' : '의뢰인' }
					<c:set var="addressParts" value="${fn:split(userDTO.address, ' ')}" />
					<span class="address">
						<i class="bi bi-geo-alt"></i>
						<span>${addressParts[0]}</span>
						<span>${addressParts[1]}</span>
					</span>
				</div>
				<c:if test="${userDTO.type=='master'}">
					<div class="repair_type">
						<p class="master-category">
							<span>
								${userDTO.caRootName }
								<i class="bi bi-chevron-right"></i>
								${userDTO.caName }
							</span>
						</p>
					</div>
				</c:if>
			</a>
		</div>
		<div class="chat-inner">
			<div class="chat-box" id="chat-box">

				<!-- 이전 날짜와 다를 때만 출력 -->
				<c:set var="date" value="" scope="page" />

				<c:forEach var="dto" items="${list }">
					<jsp:useBean id="now" class="java.util.Date" />
					<fmt:formatDate value="${now}" pattern="yyyy. M. d" var="nowDate" />
					<fmt:formatDate value="${now}" pattern="HH:00" var="nowTime" />
					<fmt:parseDate value="${dto.sendTime}" pattern="yyyy-MM-dd HH:mm:ss" var="sendTimeParse" />
					<fmt:formatDate value="${sendTimeParse}" pattern="yyyy. M. d" var="sendDateFmt" />
					<fmt:formatDate value="${sendTimeParse}" pattern="yyyy. M. d (E)" var="sendDateFmtDisplay" />

					<!-- 이전 날짜와 다를 때만 출력 -->
					<c:if test="${sendDateFmt ne date}">
						<p class="calender">${sendDateFmtDisplay}</p>
						<c:set var="date" value="${sendDateFmt}" scope="page" />
					</c:if>

					<c:choose>
						<c:when test="${dto.getMeNo == meNo }">
							<div class="left">
								<div class="new-profile-img">
									<c:choose>
										<c:when test="${dto.sendProfilePhotoImg == '' }">
											<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture">
										</c:when>
										<c:otherwise>
											<img src="data:image/png;base64,${dto.sendProfilePhotoImg }" alt="Profile Picture">
										</c:otherwise>
									</c:choose>
								</div>
								<div class="message memberlf">${dto.message }</div>
								<p class="message timestamp">
									<fmt:formatDate value="${dto.sendTime}" pattern="a h:mm" />
								</p>
							</div>
						</c:when>
						<c:otherwise>
							<div class="right">
								<p class="message timestamp">
									${dto.read=='Y' ? '<span style="margin-right:4px;">읽음</span>' : '' }
									<fmt:formatDate value="${dto.sendTime}" pattern="a h:mm" />
								</p>
								<div class="message member">${dto.message }</div>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
			<div class="input-group">
				<input type="hidden" id="masterNo" value="1">
				<!-- 임시 값 -->
				<input type="hidden" id="clientNo" value="2">
				<!-- 임시 값 -->
				<input type="text" id="chat-input" placeholder="메시지를 입력하세요">
				<button type="button" id="send-button" onclick="sendMessage()">전송</button>
			</div>
		</div>
	</div>
	<script>
	/* div 추가, db에 저장 */
	function sendMessage() {
		
		// 입력 필드와 채팅 박스 가져오기
        const inputField = document.getElementById('chat-input');
        const chatBox = document.getElementById('chat-box');

        // 입력된 메시지 가져오기
        const messageText = inputField.value.trim();
        if (messageText === '') {
            return;
        }

        // 현재 시간 가져오기
        const now = new Date();
        const hours = now.getHours();
        const minutes = now.getMinutes();

        // 12시간제로 변환
        const period = hours >= 12 ? "오후 " : "오전 ";
        const formattedHours = hours % 12 || 12; // 12시간제로 변환, 0시를 12시로 표시
        const formattedMinutes = minutes < 10 ? "0"+minutes : minutes; // 2자리 분 표시
        const formattedTime = period + formattedHours + ':' + formattedMinutes;
        
        // 새 메시지와 타임스탬프 HTML 생성
        let messageHTML = '<div class="right">';
        messageHTML += '<p class="message timestamp">'+formattedTime+'</p>';
        messageHTML += '<div class="message member">'+messageText+'</div>';
        messageHTML += '</div>';

        // 채팅 박스에 메시지 추가
        chatBox.innerHTML += messageHTML;

        // 스크롤을 최하단으로 이동
	    prepareScroll();

        // 입력 필드 비우기
        inputField.value = '';
        
        // ajax로 db에 저장
	    fetch('send.message', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/json'
	        },
	        body: JSON.stringify({
	            getMeNo: document.querySelector('input[name="getMeNo"]').value,
	            message: messageText
	        })
	    }).then(response => {
	        if (response.ok) {
	        	console.log("send 성공");
	            //chatInput.value = '';
	            //getMessages();
	        }
	    });
	}
	
	/* 안 본 메시지 가져오기 */
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

	// 준비 함수, 약간의 시간을 두어 scroll 함수를 호출하기
	function prepareScroll() {
	    window.setTimeout(scrollUl, 50);
	}

	// 최하단으로 스크롤
	function scrollUl() {
	    let chatUl = document.querySelector('.chat-box');
	    chatUl.scrollTop = chatUl.scrollHeight;
	}
	document.addEventListener("DOMContentLoaded", function () {

	    prepareScroll();
	    
	    // 3초마다 폴링
	    //setInterval(getMessages, 3000);

	    $('#chat-input').keypress(function (e) {
	        if (e.which === 13) { // Enter key
	            sendMessage();
	        }
	    });

	}); /* DOMContentLoaded */
</script>
</body>

</html>