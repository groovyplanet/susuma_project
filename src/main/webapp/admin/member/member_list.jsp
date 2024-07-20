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
				<span>${type=='user'?'의뢰인':'수리기사' } 목록</span>
			</div>
			<c:if test="${type == 'master' }">
				<div class="search_wrap">
					<form action="list.member" method="get">
						<table class="search">
							<tr>
								<th>가입 승인 여부</th>
								<td>
									<ul class="check_list">
										<li>
											<input type="checkbox" name="join_approval" value="Y" id="join_approval_Y">
											<label for="join_approval_Y">승인</label>
										</li>
										<li>
											<input type="checkbox" name="join_approval" value="N" id="join_approval_N">
											<label for="join_approval_N">미승인</label>
										</li>
									</ul>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</c:if>
			<div class="table_wrap">
				<table class="list" id="member_list">
					<thead>
						<tr>
							<th>번호</th>
							<th>이름</th>
							<th>이메일</th>
							<th>주소</th>
							<th>연락처</th>
							<c:if test="${type == 'user' }">
								<th>가입 일시</th>
							</c:if>
							<c:if test="${type == 'master' }">
								<th>수리 분야</th>
								<th>가입 신청 일시</th>
								<th>가입 승인 일시</th>
							</c:if>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${list}">
							<tr data-meNo="${dto.meNo}">
								<td>${dto.meNo}</td>
								<td>${dto.name}</td>
								<td>${dto.email}</td>
								<td>${empty dto.address ? '-' : dto.address} ${empty dto.addressDetail ? '' : dto.addressDetail}
								</td>
								<td>${dto.phoneNum}</td>
								<c:if test="${type == 'user' }">
									<td>
										<fmt:formatDate value="${dto.insertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
									</td>
								</c:if>
								<c:if test="${type == 'master' }">
									<td>냉장고</td>
									<td>
										<fmt:formatDate value="${dto.insertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
									</td>
									<td>
										<c:if test="${dto.joinApproval=='Y' }">
											<fmt:formatDate value="${dto.joinApprovalTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
										</c:if>
										<c:if test="${dto.joinApproval=='N' }">
											<button class="btn red">승인</button>
										</c:if>
									</td>
								</c:if>
							</tr>
						</c:forEach>
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