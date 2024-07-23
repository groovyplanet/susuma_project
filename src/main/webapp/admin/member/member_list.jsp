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
					<form name="searchForm" action="list.member" method="get">
						<input type="hidden" name="type" value="${type}">
						<input type="hidden" name="sortField" value="${sortField}">
						<input type="hidden" name="sortOrder" value="${sortOrder}">
						<table class="search">
							<tr>
								<th>
									<i class="bi bi-search"></i>
									가입 승인
								</th>
								<td>
									<ul class="check_list">
										<li>
											<input type="radio" name="join_approval" value="all" id="join_approval_all" ${joinApproval == 'all' ? 'checked' : ''}>
											<label for="join_approval_all">전체</label>
										</li>
										<li>
											<input type="radio" name="join_approval" value="Y" id="join_approval_Y" ${joinApproval == 'Y' ? 'checked' : ''}>
											<label for="join_approval_Y">승인</label>
										</li>
										<li>
											<input type="radio" name="join_approval" value="N" id="join_approval_N" ${joinApproval == 'N' ? 'checked' : ''}>
											<label for="join_approval_N">미승인</label>
										</li>
									</ul>
								</td>
							</tr>
							<tr>
								<th>
									<i class="bi bi-search"></i>
									수리 분야(상위)
								</th>
								<td>
									<ul class="check_list">
										<li>
											<input type="radio" name="rootNo" value="all" id="rootNo_all" ${rootNo == 'all' ? 'checked' : ''}>
											<label for="rootNo_all">전체</label>
										</li>
										<c:forEach var="categoryDto" items="${CategoryMainList}">
											<li>
												<input type="radio" name="rootNo" value="${categoryDto.caNo}" id="rootNo_${categoryDto.caNo}" ${rootNo == categoryDto.caNo ? 'checked' : ''}>
												<label for="rootNo_${categoryDto.caNo}">${categoryDto.caName}</label>
											</li>
										</c:forEach>
									</ul>
								</td>
							</tr>
							<c:if test="${rootNo != 'all' }">
								<tr>
									<th>
										<i class="bi bi-search"></i>
										수리 분야(하위)
									</th>
									<td>
										<ul class="check_list">
											<li>
												<input type="radio" name="caNo" value="all" id="caNo_all" ${caNo == 'all' ? 'checked' : ''}>
												<label for="temp2">전체</label>
											</li>
											<c:forEach var="categorySubDto" items="${CategorySubList}">
												<li>
													<input type="radio" name="caNo" value="${categorySubDto.caNo}" id="caNo_${categorySubDto.caNo}" ${caNo == categorySubDto.caNo ? 'checked' : ''}>
													<label for="caNo_${categorySubDto.caNo}">${categorySubDto.caName}</label>
												</li>
											</c:forEach>
										</ul>
									</td>
								</tr>
							</c:if>
						</table>
					</form>
				</div>
			</c:if>
			<div class="table_wrap">
				<table class="list" id="member_list">
					<thead>
						<tr>
							<th>번호${sortStr}</th>
							<th>
								<button class="btn_sort" onclick="sort('name', '${sortField != 'name' ? 'ASC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									이름
									<i class="bi bi-caret-${sortField != 'name' ? 'up' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
							<th>
								<button class="btn_sort" onclick="sort('email', '${sortField != 'email' ? 'ASC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									이메일
									<i class="bi bi-caret-${sortField != 'email' ? 'up' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
							<th>
								<button class="btn_sort" onclick="sort('address', '${sortField != 'address' ? 'ASC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									주소
									<i class="bi bi-caret-${sortField != 'address' ? 'up' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
							<th>
								<button class="btn_sort" onclick="sort('phone_num', '${sortField != 'phone_num' ? 'ASC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									연락처
									<i class="bi bi-caret-${sortField != 'phone_num' ? 'up' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
							<c:if test="${type == 'master' }">
								<th>수리 분야</th>
							</c:if>
							<th>
								<button class="btn_sort" onclick="sort('insert_time', '${sortField != 'insert_time' ? 'DESC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									${type=='user'?'가입 일시':'가입 신청 일시' }
									<i class="bi bi-caret-${sortField != 'insert_time' ? 'down' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
							<c:if test="${type == 'master' }">
								<th>
									<button class="btn_sort" onclick="sort('join_approval_time', '${sortField != 'join_approval_time' ? 'DESC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
										가입 승인 일시
										<i class="bi bi-caret-${sortField != 'join_approval_time' ? 'down' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
									</button>
								</th>
							</c:if>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${list}">
							<tr data-meNo="${dto.meNo}">
								<td>${dto.meNo}</td>
								<td>${dto.name}</td>
								<td>${dto.email}</td>
								<td>${empty dto.address ? '-' : dto.address}${empty dto.addressDetail ? '' : dto.addressDetail}</td>
								<td>${dto.phoneNum}</td>
								<c:if test="${type == 'user' }">
									<td>
										<fmt:formatDate value="${dto.insertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
									</td>
								</c:if>
								<c:if test="${type == 'master' }">
									<td>${dto.caName}</td>
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