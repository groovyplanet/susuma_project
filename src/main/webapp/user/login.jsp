<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>

<section>
	
	<div align="center">
		<h3>로그인</h3>
		<hr/>
		
		<form action="loginForm.user" method="post">
			
			<input type="text" name="id" placeholder="아이디"><br/>
			<input type="password" name="pw" placeholder="비밀번호"><br/>
			
			<br/>
			<input type="submit" value="로그인">
			<a href="join.user">회원가입</a>
			
		</form>

	
	</div>
	
	
</section>

<%@ include file="../include/footer.jsp" %>