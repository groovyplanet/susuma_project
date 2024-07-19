<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- sidebar -->
<nav class="sidebar">
	<div class="title">고객센터</div>
	<ul>
		<li>
			<!-- active 클래스 제어 -->
			<a href="${pageContext.request.contextPath }/board/notice_list.jsp" class="active">공지사항</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath }/board/faq.jsp">FAQ</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath }/board/ask_list.jsp">1:1 문의</a>
		</li>
	</ul>
</nav>
<!-- //sidebar -->