<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>

<section>
	<div align="center">
		<h3>${sessionScope.user_name }회원(${sessionScope.user_id }) 님의 회원정보를 관리합니다.</h3>
		
		<a href="modify.user">회원정보 관리</a>
		<a href="delete.user">회원탈퇴(화면으로)</a>
		
 		
	</div>

</section>











<%@ include file="../include/footer.jsp" %>
    