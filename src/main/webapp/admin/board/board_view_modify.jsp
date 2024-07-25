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
			<form action="replyWriteForm.board?type=${type }&boNo=${dto.boNo}" method="post">
				<div class="title_wrap">
					<span>${dto.type=='notice'?'공지사항':dto.type=='faq'?'FAQ':'1:1 문의' } 답변 작성</span>
					<div class="btn_wrap">
						<a href="list.board?type=${dto.type }" class="btn black">
							<i class="bi bi-list-ul"></i>
							목록
						</a>
						<button type="submit" class="btn">

							<i class="bi bi-pencil-square"></i>
							완료

						</button>

						<a href="delete.board?boNo=${dto.boNo }&type=${dto.type}" class="btn" onclick="return confirm('정말로 삭제하시겠습니까?')">
							<i class="bi bi-trash3"></i>
							삭제
						</a>
					</div>
				</div>
				<div class="table_wrap">
					<table class="view write" id="board_view">
						<tr>
							<th class="wp13">게시글 번호</th>
							<td class="wp37">${dto.boNo}</td>
							<th class="wp13">회원 번호</th>
							<td>${dto.meNo}</td>
						</tr>
						<tr>
							<th>제목</th>
							<td colspan="3">${dto.title}</td>
						</tr>
						<tr>
							<th>내용</th>
							<td colspan="3">${dto.content}</td>
						</tr>
						<tr>
							<th>작성 일시</th>
							<td>
								<fmt:formatDate value="${dto.insertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
							</td>
							<th>수정 일시</th>
							<td>
								<fmt:formatDate value="${dto.updateTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
							</td>
						</tr>
						<c:if test="${dto.type == 'ask' }">
							<tr>
								<th>답변</th>
								<td colspan="3">
									<textarea name="answer" required>${dto.answer }</textarea>
								</td>
							</tr>
							<tr>
								<th>답변 작성 일시</th>
								<td>
									<fmt:formatDate value="${dto.answerInsertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
								</td>
								<th>답변 수정 일시</th>
								<td>
									<fmt:formatDate value="${dto.answerUpdateTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
								</td>
							</tr>
						</c:if>
					</table>
				</div>
			</form>
		</div>
	</div>

</body>

</html>