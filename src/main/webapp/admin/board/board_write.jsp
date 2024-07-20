<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<div class="container">
		<%@ include file="../include/snb.jsp"%>
		<div class="content_wrap">
			<div class="title_wrap">
				<span>공지사항 등록</span>
				<a href="list.board?type=${dto.type }" class="btn"> 목록 </a>
			</div>
			<div class="table_wrap">
				<form name="form-qna-write" method="post" action="registForm.board" class="form-horizontal" target="actionFrame">
					<table class="view" id="board_view">
						<tr>
							<th>제목</th>
							<td>
								<input name="subject" type="text" id="subject" class="form-control" value="">
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<textarea name="content" id="content" class="form-control" cols="50" rows="20"></textarea>
							</td>
						</tr>
					</table>
					<p class="text-center">
						<button type="submit" class="event-common-click-back">등록</button>
					</p>
				</form>
			</div>
		</div>
	</div>

</body>

</html>