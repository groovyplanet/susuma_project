<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../include/head.jsp"%>
</head>

<body class="admin">
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb.jsp"%>
			<div class="content-wrap">
				<div class="table-wrap">
					<table class="table-type-view">
						<tr>
							<th>게시글 번호</th>
							<td>${dto.boNo}</td>
						</tr>
						<tr>
							<th>회원 번호</th>
							<td>${dto.meNo}</td>
						</tr>
						<tr>
							<th>제목</th>
							<td>${dto.title}</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>${dto.content}</td>
						</tr>
						<tr>
							<th>작성 일시</th>
							<td>
								<fmt:formatDate value="${dto.insertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
							</td>
						</tr>
						<tr>
							<th>수정 일시</th>
							<td>
								<fmt:formatDate value="${dto.updateTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
							</td>
						</tr>
						<tr>
							<th>답변</th>
							<td>${dto.answer}</td>
						</tr>
						<tr>
							<th>답변 작성 일시</th>
							<td>
								<fmt:formatDate value="${dto.answerInsertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
							</td>
						</tr>
						<tr>
							<th>답변 수정 일시</th>
							<td>
								<fmt:formatDate value="${dto.answerUpdateTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
							</td>
						</tr>
					</table>
				</div>
				<div>
					<input type="button" value="목록" onclick="location.href='list.board?type=${type}';">
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>

</body>

</html>