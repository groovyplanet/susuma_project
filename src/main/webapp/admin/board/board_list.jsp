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
					<table class="table-type-list">
						<thead>
							<tr>
								<th>게시글번호</th>
								<th>회원번호</th>
								<th>제목</th>
								<th>작성 일시</th>
								<th>수정 일시</th>
								<th>답변 작성 일시</th>
								<th>답변 수정 일시</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="dto" items="${list}">
								<tr data-boNo="${dto.boNo}">
									<td>${dto.boNo}</td>
									<td>${dto.meNo}</td>
									<td>${dto.title}</td>
									<td>
										<fmt:formatDate value="${dto.insertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
									</td>
									<td>
										<fmt:formatDate value="${dto.updateTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
									</td>
									<td>
										<fmt:formatDate value="${dto.answerInsertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
									</td>
									<td>
										<fmt:formatDate value="${dto.answerUpdateTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>
	<script>
		var table = document.querySelector("table");
		table.onclick = function(e) {
			if (e.target.tagName != "TD")
				return;
			location.href = "view.board?boNo="
					+ e.target.closest("tr").dataset.bono // HTML 표준에 따라 data-* 속성의 이름은 소문자로 변환
					+ "&type=${type}";
		}
	</script>

</body>

</html>