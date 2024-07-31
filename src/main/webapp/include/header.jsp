<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
						<c:if test="${newAlertCount>0 }">
							<li class="li-icon alarm">
								<!-- 알림 아이콘 -->
								<div class="icon-area">
									<button id="btn-alarm-list">
										<img src="${pageContext.request.contextPath }/resources/img/alarm.png" alt="알림">
										<span class="new-mark">${newAlertCount }</span>
									</button>
								</div>
								<!-- 알림 목록 -->
								<div id="alram-list" class="alram-list">
									<c:forEach var="alertDTO" items="${alertList }">
										<a href="${pageContext.request.contextPath }/member/view.request?reqNo=${alertDTO.reqNo }" onclick="deleteAndGoAlert(this, '${alertDTO.alNo }')" class="alram-item">
											<div class="datetime">
												<fmt:formatDate value="${alertDTO.sendTime}" pattern="yy.MM.dd. a h:mm" />
											</div>
											<div class="message">${alertDTO.message}</div>
										</a>
									</c:forEach>
								</div>
							</li>
						</c:if>
						<li class="li-icon chat">
							<!-- 채팅 아이콘 -->
							<div class="icon-area">
								<a href="${pageContext.request.contextPath }/member/list.message">
									<img src="${pageContext.request.contextPath }/resources/img/message.png" alt="채팅">
									<c:if test="${unreadMsgCount>0 }">
										<span class="new-mark">${unreadMsgCount }</span>
									</c:if>
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
						<a href="${pageContext.request.contextPath }/member/findPw.member">비밀번호 찾기</a>
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