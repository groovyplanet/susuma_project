<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- snb -->
<nav class="sidebar">


	<ul>
		<li>
			<a href="${pageContext.request.contextPath }/admin/member/list.member" class="${snbCurrent=='member'?'active':'' }">회원관리</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath }/admin/board/list.board?type=notice" class="${snbCurrent=='notice'?'active':'' }">공지사항</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath }/admin/board/list.board?type=faq" class="${snbCurrent=='faq'?'active':'' }">FAQ</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath }/admin/board/list.board?type=ask" class="${snbCurrent=='ask'?'active':'' }">1:1문의</a>
		</li>
	</ul>
</nav>
<!-- //snb -->