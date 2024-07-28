<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- header -->
<header>
	<div class="logo_wrap">
		<a href="${pageContext.request.contextPath }/">
			<img src="${pageContext.request.contextPath }/resources/img/logo.png" alt="로고">
		</a>
		<p class="arrow_box">사이트로 이동</p>
	</div>
	<ul class="btn_wrap">
		<li>
			<a href="${pageContext.request.contextPath }/member/logout.member" class="btn">
				관리자 로그아웃
				<i class="bi bi-chevron-right"></i>
			</a>
		</li>
	</ul>
</header>
<!-- //header -->