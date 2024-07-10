<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%@ include file="../include/header.jsp" %>

<div align="center" class="div_center">

	<h3>게시글 내용 보기</h3>
	<hr>
	<table border="1" width="500">
		<tr>
			<td width="20%">글번호</td>
			<td width="30%">${dto.bno }</td>
			
			<td width="20%">조회수</td>
			<td width="30%">${dto.hit }</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>${dto.writer }</td>
			
			<td>작성일</td>
			<td>${dto.regdate }</td>
		</tr>
		
		<tr>
			<td width="20%">글제목</td>
			<td colspan="3">${dto.title }</td>
		</tr>
		<tr>
			<td width="20%">글내용</td>
			<td colspan="3" height="120px">${dto.content }</td>
		</tr>
		
		<tr>
			<td colspan="4" align="center">
				<input type="button" value="목록" onclick="location.href='list.board';">&nbsp;&nbsp;
				<c:if test="${dto.writer == sessionScope.user_id }">
				<input type="button" value="수정" onclick="location.href='modify.board?bno=${dto.bno}&writer=${dto.writer }';" >&nbsp;&nbsp;
				<input type="button" value="삭제" onclick="location.href='delete.board?bno=${dto.bno}&writer=${dto.writer }';" >&nbsp;&nbsp;
				</c:if>
				<!-- 삭제는 원래, post방식으로 처리해야합니다.. -->
			</td>
		</tr>
	</table>
</div>

<%@ include file="../include/footer.jsp" %>
