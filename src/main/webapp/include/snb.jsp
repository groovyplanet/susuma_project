<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- sidebar -->
<nav class="sidebar">
	<div class="title">마이페이지</div>
	<ul>
		<li>
			<!-- active 클래스 제어 -->
			<a href="${pageContext.request.contextPath }/member/edit.member" class="${pageContext.request.servletPath == '/member/profile_edit.jsp' ? 'active' : ''}">회원정보 수정</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath }/member/list.request" class="${pageContext.request.servletPath == '/member/request_list.jsp' or pageContext.request.servletPath == '/member/request_view.jsp' ? 'active' : ''}">예약 내역</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath }/member/list.review" class="${pageContext.request.servletPath == '/member/review_list.jsp' ? 'active' : ''}">후기 내역</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath }/member/message_list.jsp" class="${pageContext.request.servletPath == '/member/message_list.jsp' ? 'active' : ''}">문의 내역</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath }/board/list.board?type=ask" class="${type=='ask'?'active':'' }">1:1 문의</a>
		</li>

		<li>
			<a href="${pageContext.request.contextPath }/member/point.member" class="${pageContext.request.servletPath == '/member/point.jsp' ? 'active' : ''}">포인트</a>
		</li>

	</ul>
</nav>
<!-- //sidebar -->