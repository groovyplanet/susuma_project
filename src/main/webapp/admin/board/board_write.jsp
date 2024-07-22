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
			<form name="writeForm" method="post" action="registForm.board">
				<div class="title_wrap">
					<span>${type=='notice'?'공지사항':type=='faq'?'FAQ':'1:1 문의' } 등록</span>
					<div class="btn_wrap">
						<a href="list.board?type=${type }" class="btn black">
							<i class="bi bi-list-ul"></i>
							목록
						</a>
						<button type="submit" class="btn">
							<i class="bi bi-check-lg"></i>
							등록
						</button>
					</div>
				</div>
				<div class="table_wrap">
					<input type="hidden" name="me_no" value="1">
					<input type="hidden" name="type" value="${type}">
					<table class="view write" id="board_view">
						<tr>
							<th>제목</th>
							<td>
								<input name="title" type="text" value="" required>
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<textarea name="content" required></textarea>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</div>

</body>

</html>