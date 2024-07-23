<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- sidebar -->
<nav class="sidebar">
	<div class="title">마이페이지</div>
	<ul>
		<li>
			<!-- active 클래스 제어 -->
			<a href="${pageContext.request.contextPath }/member/profileEdit.member" class="active">회원정보 수정</a>
		</li>
		<c:choose>
			<c:when test="${sessionScope.type eq 'user'}">
				<li>
					<a href="${pageContext.request.contextPath }/user/list.request">예약 내역</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/member/list.review">후기 내역</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/user/message_list.jsp">문의 내역</a>
				</li>
			</c:when>
			<c:otherwise>
				<li>
					<a href="${pageContext.request.contextPath }/master/reserve_manage_list.jsp">예약 관리</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/master/repair_list.jsp">수리 내역</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/member/list.review">후기 내역</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/master/message_list.jsp">문의 내역</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath }/master/point.jsp">포인트</a>
				</li>
			</c:otherwise>
		</c:choose>

	</ul>
</nav>
<!-- //sidebar -->