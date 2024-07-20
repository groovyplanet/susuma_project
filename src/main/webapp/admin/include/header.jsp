<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- header -->
<header>
	<div class="gnb">
		<div class="logo-area">
			<!-- 로고 -->
			<a href="${pageContext.request.contextPath }/admin/">
				<img src="${pageContext.request.contextPath }/resources/img/logo.png" alt="로고">
			</a>
		</div>
		<ul class="login-area">
			<li>
				<a href="${pageContext.request.contextPath }/" class="btn btn-join">
					사용자
					<i class="bi bi-chevron-right"></i>
				</a>
			</li>
			<li>
				<a href="#" class="btn">관리자 로그아웃</a>
			</li>
		</ul>
	</div>


</header>
<!-- //header -->