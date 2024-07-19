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
								<th>회원번호</th>
								<th>이메일</th>
								<th>주소</th>
								<th>연락처</th>
								<th>회원 타입</th>
								<th>수리기사 가입 승인 여부</th>
								<th>가입 일시</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="dto" items="${list}">
								<tr data-meNo="${dto.meNo}">
									<td>${dto.meNo}</td>
									<td>${dto.email}</td>
									<td>${dto.address}</td>
									<td>${dto.phoneNum}</td>
									<td>${dto.type}</td>
									<td>${dto.joinApproval}</td>
									<td>
										<fmt:formatDate value="${dto.insertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
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
			location.href = "view.member?meNo="
					+ e.target.closest("tr").dataset.meno; // HTML 표준에 따라 data-* 속성의 이름은 소문자로 변환
		}
	</script>

</body>

</html>