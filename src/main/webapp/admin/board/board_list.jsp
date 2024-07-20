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
				<span>${type=='notice'?'공지사항':type=='faq'?'FAQ':'1:1 문의' } 목록</span>
				<a href="write.board?type=${type }" class="btn"> 등록 </a>
			</div>
			<div class="table_wrap">
				<table class="list" id="board_list">
					<thead>
						<tr>
							<th>게시글번호</th>
							<th>회원번호</th>
							<th>제목</th>
							<th>작성 일시</th>
							<th>수정 일시</th>
							<c:if test="${type == 'ask' }">
								<th>답변 작성 일시</th>
								<th>답변 수정 일시</th>
							</c:if>
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
								<c:if test="${type == 'ask' }">
									<td>
										<fmt:formatDate value="${dto.answerInsertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
									</td>
									<td>
										<fmt:formatDate value="${dto.answerUpdateTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
									</td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
					</tbody>
				</table>
			</div>
			<div class="pagination">
				<ul>
					<li>
						<a href="#">
							<i class="bi bi-chevron-left"></i>
						</a>
					</li>
					<li>
						<a href="#" class="active">1</a>
					</li>
					<li>
						<a href="#">2</a>
					</li>
					<li>
						<a href="#">3</a>
					</li>
					<li>
						<a href="#">4</a>
					</li>
					<li>
						<a href="#">5</a>
					</li>
					<li>
						<a href="#">
							<i class="bi bi-chevron-right"></i>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>

</body>

</html>