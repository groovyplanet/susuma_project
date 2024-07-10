<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>

<section>

	<div align="center">
		<h3>회원탈퇴</h3>
		<p>비밀번호를 입력하세요.</p>
	
		<form action="deleteForm.user" method="post" >
			<input type="password" name="pw">
			<input type="submit" value="회원탈퇴">
			<br>
			${msg }
		</form>
	</div>
		
</section>

<%@ include file="../include/footer.jsp" %>    

    