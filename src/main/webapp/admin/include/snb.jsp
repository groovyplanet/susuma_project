<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- snb -->
<ul class="snb">
	<li>
		<a href="${pageContext.request.contextPath }/admin/member/list.member?type=user" class="${type=='user'?'active':'' }">의뢰인</a>
	</li>
	<li>
		<a href="${pageContext.request.contextPath }/admin/member/list.member?type=master" class="${type=='master'?'active':'' }">수리기사</a>
	</li>
	<li>
		<a href="${pageContext.request.contextPath }/admin/board/list.board?type=notice" class="${type=='notice'?'active':'' }">공지사항</a>
	</li>
	<li>
		<a href="${pageContext.request.contextPath }/admin/board/list.board?type=faq" class="${type=='faq'?'active':'' }">FAQ</a>
	</li>
	<li>
		<a href="${pageContext.request.contextPath }/admin/board/list.board?type=ask" class="${type=='ask'?'active':'' }">1:1 문의</a>
	</li>
</ul>
<!-- //snb -->