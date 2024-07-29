<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../include/head.jsp"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>






<%
// 이메일 저장 쿠키
Cookie[] arr = request.getCookies();

String email = "";
if (arr != null) {
	for (Cookie c : arr) {
		if (c.getName().equals("saveEmail")) {
	email = c.getValue();
		}
	}
}
%>
<!-- header -->
<header>
	<div class="gnb">
		<div class="logo-area">
			<!-- 로고 -->
			<a href="${pageContext.request.contextPath }/index.jsp">
				<img src="${pageContext.request.contextPath }/resources/img/logo.png" alt="로고">
			</a>
		</div>
		<ul class="menu-area">
			<!-- 메뉴 -->
			<li class="${pageContext.request.servletPath == '/member/introduce.jsp' ? 'active' : ''}">
				<a href="${pageContext.request.contextPath }/member/introduce.jsp">수수마 소개</a>
			</li>
			<li class="${gnb == 'request' ? 'active' : ''}">
				<a href="${pageContext.request.contextPath }/member/masterList.member">수리 예약</a>
			</li>
			<li class="${gnb == 'board' ? 'active' : ''}">
				<a href="${pageContext.request.contextPath }/board/list.board">고객센터</a>
			</li>
		</ul>

		<ul class="login-area">

			<c:choose>
				<c:when test="${sessionScope.meNo == null }">
					<!-- 로그아웃 상태 -->
					<li>
						<button id="btn-login-modal" class="btn btn-login">로그인${loginModal}</button>
					</li>
					<li>
						<a href="${pageContext.request.contextPath }/member/join.member" class="btn btn-join">
							회원가입
							<i class="bi bi-chevron-right"></i>
						</a>
					</li>
				</c:when>
				<c:otherwise>
					<!-- 로그인 상태 -->

					<c:if test="${sessionScope.type ne 'admin' }">
						<li class="li-icon alarm">
							<!-- 알림 아이콘 -->
							<div class="icon-area">
								<button id="btn-alarm-list">
									<img src="${pageContext.request.contextPath }/resources/img/alarm.png" alt="알림">
									<span class="new-mark">1</span>
								</button>
							</div>
							<div id="alram-list" class="alram-list">
								<!-- 알림 목록 -->
								<a href="${pageContext.request.contextPath }/user/reserve_view.jsp" class="alram-item">
									<div class="datetime">2024.07.12 10:41</div>
									<div class="message">홍길동 기사님이 수리 예약을 확정했어요.</div>
									<!-- (의뢰인)수리 예약 승인 -->
								</a>
								<a href="${pageContext.request.contextPath }/master/reserve_manage_view.jsp" class="alram-item">
									<div class="datetime">2024.07.12 10:41</div>
									<div class="message">홍길동님이 수리 예약을 신청했어요.</div>
									<!-- (수리기사)수리 예약 접수 -->
								</a>
								<a href="${pageContext.request.contextPath }/master/review_view.jsp" class="alram-item">
									<div class="datetime">2024.07.12 10:41</div>
									<div class="message">홍길동님이 후기를 작성했어요.</div>
									<!-- (수리기사)후기 등록 -->
								</a>
								<a href="${pageContext.request.contextPath }/board/ask_view.jsp" class="alram-item">
									<div class="datetime">2024.07.12 10:41</div>
									<div class="message">'예약 신청 어떻게 하나요?'에 답변이 등록됐어요.</div>
									<!-- 1:1 문의 -->
								</a>
							</div>
						</li>
						<li class="li-icon chat">
							<!-- 채팅 아이콘 -->
							<div class="icon-area">
								<a href="${pageContext.request.contextPath }/user/message_list.jsp">
									<img src="${pageContext.request.contextPath }/resources/img/message.png" alt="채팅">
									<span class="new-mark">2</span>
								</a>
							</div>
						</li>
					</c:if>
					<li>
						<a href="${pageContext.request.contextPath }/member/logout.member" class="btn">${sessionScope.type eq 'user' ? '의뢰인' : sessionScope.type eq 'master' ? '수리기사' : ''} ${sessionScope.name}님 로그아웃</a>
					</li>
					<c:choose>
						<c:when test="${sessionScope.type eq 'admin' }">
							<li>
								<a href="${pageContext.request.contextPath }/index.html" class="btn btn-temp"> html </a>
							</li>

							<li>
								<a href="${pageContext.request.contextPath }/admin/" class="btn btn-temp"> 관리자 </a>
							</li>
						</c:when>
						<c:otherwise>
							<li>
								<a href="${pageContext.request.contextPath }/member/edit.member" class="btn btn-join">
									마이페이지
									<i class="bi bi-chevron-right"></i>
								</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</ul>

	</div>

	<!-- 로그인 모달 -->
	<div id="login-modal" class="modal ${param.loginModal == 'Y' ? 'show' : ''}">
		<div class="container">
			<div class="logo-area">
				<img src="${pageContext.request.contextPath }/resources/img/logo.png" alt="로고">
			</div>
			<div class="login-form">
				<!-- 로그인 폼 -->
				<form name="loginForm" action="${pageContext.request.contextPath }/member/loginForm.member" method="post">
					<div class="input-area">
						<input type="text" class="input-field" placeholder="이메일을 입력해 주세요." autocomplete="no" name="email" value="<%=email%>">
					</div>
					<div class="input-area">
						<input type="password" class="input-field" placeholder="비밀번호를 입력해 주세요." autocomplete="no" name="pw">
					</div>
					<div class="sub-area">
						<div class="save-area">
							<input type="checkbox" name="saveEmail" value="Y" id="save-email-check" <%=!email.equals("") ? "checked" : ""%>>
							<label for="save-email-check" class="save-email-label">이메일 저장</label>
						</div>
						<a href="#" id="findPwLink">비밀번호 찾기</a> <!-- 비밀번호 찾기 클릭 시 모달 표시 -->
						
					</div>
						<button class="btn btn-login-submit" type="submit">로그인</button>
				</form>
				<a href="${pageContext.request.contextPath }/member/join.member" class="btn btn-join">회원가입</a>
			</div>
						<button class="btn-close-modal">
							<img src="${pageContext.request.contextPath }/resources/img/iconClose.png" alt="닫기 버튼">
						</button>
		</div>
	</div>
	<!-- 비밀번호 찾기 모달3 -->
	<div id="findPwModal" class="modal3">
	    <div class="container3">
	        <div class="find-pw-form">
	            <h2>비밀번호 찾기</h2>
	            <form id="findPwForm" action="sendTempPassword" method="post">
	                <div class="input-area">
	                    <input type="email" class="input-field" placeholder="가입한 이메일 주소를 입력해 주세요." name="findPwEmail" required>
	                </div>
	                <button type="submit" class="btn btn-send-email">이메일 전송하기</button>
	            </form>
	            <button class="btn-close-modal3 findPwCloseBtn">
	                <img src="${pageContext.request.contextPath }/resources/img/iconClose.png" alt="닫기 버튼">
	            </button>
	        </div>
	    </div>
	</div>
	
	<!-- 비밀번호 찾기 모달2 -->	
	<div id="tempPasswordModal" class="modal2">
	    <div class="modal2-content">
	        <span class="close2">&times;</span>
	        <h2>임시 비밀번호 발급</h2>
	        <p id="modal2Message">이메일로 임시 비밀번호를 발송하였습니다.</p>
	        <button id="closeModal2Btn">닫기</button>
	    </div>
	</div>
					
<style>
.modal2 {
    display: none; /* 기본적으로 숨김 */
    position: fixed;
    z-index: 1; /* 위에 나타나게 */
    left: 0;
    top: 0;
    width: 80%; 
    height: 60%; 
    overflow: auto; /* 스크롤 가능 */
    background-color: rgb(0,0,0); /* 검정 배경 */
    background-color: rgba(0,0,0,0.4); /* 배경색 투명도 */
}

.modal2-content {
    background-color: #fefefe;
    margin: 15% auto; /* 위에서 15% 내려오고 중앙 정렬 */
    padding: 20px;
    border: 1px solid #888;
    width: 80%; /* 너비 */
}

.close2 {
    color: #aaa;
    float: right; /* 오른쪽 정렬 */
    font-size: 28px;
    font-weight: bold;
}

.close2:hover,
.close2:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}
</style>

<style>
.modal3 {
    display: none; 
    position: fixed;
    z-index: 1; 
    left: 0;
    top: 0;
    width: 100%; 
    height: 100%; 
    overflow: auto;
    background-color: rgba(0,0,0,0.4);
}

.container3 {
    background-color: #fefefe;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
}

.btn-close-modal3 {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.btn-close-modal3:hover,
.btn-close-modal3:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}
</style>


<script>
        var modal2 = document.getElementById("tempPasswordModal");
        var findPwModal = document.getElementById("findPwModal");

        var findPwLink = document.getElementById("findPwLink");
        var closeBtn = document.getElementsByClassName("close2")[0];
        var findPwCloseBtn = document.getElementsByClassName("findPwCloseBtn")[0];

        findPwLink.onclick = function(event) {
            event.preventDefault();
            findPwModal.style.display = "block";
        }

        closeBtn.onclick = function() {
            modal2.style.display = "none";
        }

        findPwCloseBtn.onclick = function() {
            findPwModal.style.display = "none";
        }

        window.onclick = function(event) {
            if (event.target == modal2) {
                modal2.style.display = "none";
            } else if (event.target == findPwModal) {
                findPwModal.style.display = "none";
            }
        }

    </script>
					
		<!-- 비밀번호 찾기 -->
		<%
	    String userEmail = request.getParameter("email"); // 사용자 입력 이메일
	
	    if (userEmail != null && !userEmail.isEmpty()) {
	        String tempPassword = generateTemporaryPassword(); // 임시 비밀번호 생성
	        boolean emailSent = false;
	        boolean userExists = false;
	
	        try {
	            // 데이터베이스 연결 설정
	            String dbURL = "jdbc:oracle:thin:@172.30.1.23:1521:xe"; // 데이터베이스 URL
	            String dbUser = "SSM"; // 데이터베이스 사용자 이름
	            String dbPassword = "SSM"; // 데이터베이스 비밀번호
	            
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);
	
	            // 이메일이 존재하는지 확인
	            String sql = "SELECT EMAIL FROM MEMBER WHERE EMAIL = ?";
	            PreparedStatement statement = connection.prepareStatement(sql);
	            statement.setString(1, userEmail);
	            ResultSet resultSet = statement.executeQuery();
	
	            if (resultSet.next()) {
	                userExists = true;
	                emailSent = sendTemporaryPassword(userEmail, tempPassword); // 임시 비밀번호 이메일 발송
	
	                if (emailSent) {
	                    // 임시 비밀번호를 데이터베이스에 업데이트
	                    String updateSql = "UPDATE MEMBER SET PW = ? WHERE EMAIL = ?";
	                    PreparedStatement updateStatement = connection.prepareStatement(updateSql);
	                    updateStatement.setString(1, tempPassword);
	                    updateStatement.setString(2, userEmail);
	                    updateStatement.executeUpdate();
	                }
	            }
	
	            resultSet.close();
	            statement.close();
	            connection.close();
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	
	        if (userExists) {
	            if (emailSent) {
	                out.println("임시 비밀번호가 이메일로 발송되었습니다.");
	            } else {
	                out.println("이메일 발송에 실패했습니다.");
	            }
	        } else {
	            out.println("입력한 이메일 주소가 존재하지 않습니다.");
	        }
	    } 
	%>
	
	
	<%! 
	    // 임시 비밀번호 생성 메서드
	    String generateTemporaryPassword() {
	        return "a1b2c3d4"; // 임시 비밀번호 예시
	    }
	
	    // 이메일 발송 메서드
	    boolean sendTemporaryPassword(String toEmail, String tempPassword) {
	        // 이메일 발송 설정
	        String host = "smtp.naver.com";
	        String port = "995";
	        String username = "tjgml2435@naver.com";
	        String password = "kosaf12639!"; // 네이버 계정 비밀번호
	
	        Properties props = new Properties();
	        props.put("mail.smtp.auth", "true");
	        props.put("mail.smtp.starttls.enable", "true");
	        props.put("mail.smtp.host", host);
	        props.put("mail.smtp.port", port);
	
	        Session session = Session.getInstance(props, new Authenticator() {
	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(username, password);
	            }
	        });
	
	        try {
	            Message message = new MimeMessage(session);
	            message.setFrom(new InternetAddress(username));
	            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
	            message.setSubject("비밀번호 재설정 안내");
	            message.setText("안녕하세요,\n\n회원님의 임시 비밀번호는 다음과 같습니다: " + tempPassword + "\n\n이 임시 비밀번호로 로그인 후 비밀번호를 변경해주시기 바랍니다.");
	
	            Transport.send(message);
	            return true;
	        } catch (MessagingException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }
	%>
		


</header>
<!-- //header -->