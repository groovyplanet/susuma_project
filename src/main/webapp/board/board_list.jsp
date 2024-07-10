<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
	
	
<%@ include file="../include/header.jsp" %>

<div class="container">
		<h3>게시판</h3>

		<table class="table table-bordered">
			<thead>
				<tr>
					<th>제목</th>
				</tr>
			</thead>
		
			<tbody>
				<c:forEach var="dto" items="${list }">
				<tr>
					<td>
						${dto.title }</a>
					</td>
				</tr>
				</c:forEach>

			</tbody>
		
		</table>
	</div>

<%@ include file="../include/footer.jsp" %>




