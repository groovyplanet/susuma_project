<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- sidebar -->
<nav class="sidebar">
	<div class="title">고객센터</div>
	<ul>
		<li>
			<!-- active 클래스 제어 -->
			<a href="${pageContext.request.contextPath }/board/list.board?type=notice" class="${type=='notice'?'active':'' }">공지사항</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath }/board/list.board?type=faq" class="${type=='faq'?'active':'' }">FAQ</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath }/board/list.board?type=ask" class="${type=='ask'?'active':'' }">1:1 문의</a>
		</li>
	</ul>
</nav>
<!-- //sidebar -->