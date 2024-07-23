<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
			<li class="${pageContext.request.servletPath == '/member/master_list.jsp' ? 'active' : ''}">
				<a href="${pageContext.request.contextPath }/member/masterList.member">수리 예약</a>
			</li>
			<li class="${pageContext.request.servletPath == '/board/board_list.jsp' ? 'active' : ''}">
				<a href="${pageContext.request.contextPath }/board/list.board">고객센터</a>
			</li>
		</ul>

		<ul class="login-area">

			<c:choose>
				<c:when test="${sessionScope.email == null }">
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
					<li>
						<a href="${pageContext.request.contextPath }/member/logout.member" class="btn">${sessionScope.type eq 'user'?'의뢰인' : '수리기사'} ${sessionScope.name}님 로그아웃</a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath }/member/mypage.member" class="btn btn-join">
							마이페이지
							<i class="bi bi-chevron-right"></i>
						</a>
					</li>
				</c:otherwise>
			</c:choose>
			<li>
				<a href="${pageContext.request.contextPath }/index.html" class="btn btn-temp"> html </a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath }/admin/" class="btn btn-temp"> 관리자 </a>
			</li>
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
						<a href="${pageContext.request.contextPath }/member/find_info.member">비밀번호 찾기</a>
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
	<!-- //로그인 모달 -->

</header>
<!-- //header -->