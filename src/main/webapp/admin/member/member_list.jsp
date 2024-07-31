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
				<div class="btn_wrap">
					<a href="write.member?type=${type }" class="btn">
						<i class="bi bi-plus-circle"></i>
						추가
					</a>
				</div>
			</div>
			<form name="searchForm" action="list.member" method="get">
				<input type="hidden" name="type" value="${type}">
				<input type="hidden" name="sortField" value="${sortField}">
				<input type="hidden" name="sortOrder" value="${sortOrder}">
				<input type="hidden" name="page" value="1">
				<c:if test="${type == 'master' }">
					<div class="search_wrap">
						<table class="search">
							<tr>
								<th>
									<i class="bi bi-search"></i>
									가입 승인
								</th>
								<td>
									<ul class="check_list">
										<li>
											<input type="radio" name="joinApproval" value="all" id="joinApproval_all" ${joinApproval == 'all' ? 'checked' : ''}>
											<label for="joinApproval_all">전체</label>
										</li>
										<li>
											<input type="radio" name="joinApproval" value="Y" id="joinApproval_Y" ${joinApproval == 'Y' ? 'checked' : ''}>
											<label for="joinApproval_Y">승인</label>
										</li>
										<li>
											<input type="radio" name="joinApproval" value="N" id="joinApproval_N" ${joinApproval == 'N' ? 'checked' : ''}>
											<label for="joinApproval_N">미승인</label>
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
												<label for="caNo_all">전체</label>
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
					</div>
				</c:if>
			</form>
			<div class="table_wrap">
				<table class="list" id="member_list">
					<thead>
						<tr>
							<th class="wp4">번호</th>
							<th class="wp4">프로필</th>
							<th class="${type == 'master' ? 'wp5' : 'wp7' }">
								<button class="btn_sort" onclick="sort('name', '${sortField != 'name' ? 'ASC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									이름
									<i class="bi bi-caret-${sortField != 'name' ? 'up' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
							<th class="${type == 'master' ? 'wp5' : 'wp7' }">
								<button class="btn_sort" onclick="sort('point', '${sortField != 'point' ? 'ASC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									포인트
									<i class="bi bi-caret-${sortField != 'point' ? 'up' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
							<th>
								<button class="btn_sort" onclick="sort('email', '${sortField != 'email' ? 'ASC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									이메일
									<i class="bi bi-caret-${sortField != 'email' ? 'up' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
							<c:if test="${type == 'master' }">
								<th>별점</th>
								<th class="wp17">수리 분야</th>
							</c:if>
							<th class="${type == 'master' ? 'wp15' : 'wp25' }">
								<button class="btn_sort" onclick="sort('address', '${sortField != 'address' ? 'ASC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									주소
									<i class="bi bi-caret-${sortField != 'address' ? 'up' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
							<th class="${type == 'master' ? 'wp9' : 'wp12' }">
								<button class="btn_sort" onclick="sort('phone_num', '${sortField != 'phone_num' ? 'ASC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									연락처
									<i class="bi bi-caret-${sortField != 'phone_num' ? 'up' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
							<th class="${type == 'master' ? 'wp12' : 'wp16' }">
								<button class="btn_sort" onclick="sort('insert_time', '${sortField != 'insert_time' ? 'DESC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									${type=='user'?'가입 일시':'가입 신청 일시' }
									<i class="bi bi-caret-${sortField != 'insert_time' ? 'down' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
							<c:if test="${type == 'master' }">
								<th class="wp12">
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
								<td>${totalRecords - dto.rn + 1}</td>
								<td style="display: flex;">
									<c:choose>
										<c:when test="${dto.profilePhotoImg == '' }">
											<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile">
										</c:when>
										<c:otherwise>
											<img src="data:image/png;base64,${dto.profilePhotoImg }" alt="Profile Picture" class="profile">
										</c:otherwise>
									</c:choose>
								</td>
								<td>${dto.name}</td>
								<td>
									<fmt:formatNumber value="${dto.point}" type="number" groupingUsed="true" maxFractionDigits="0" />
									P
								</td>
								<td>
									<i class="bi bi-envelope"></i>
									${dto.email}
								</td>
								<c:if test="${type == 'master' }">
									<td>
										<c:choose>
											<c:when test="${dto.reviewCount > 0}">
												<span class="master-stars">
													<i class="bi bi-star-fill gold"></i>
													<strong>${dto.averageScore }</strong>
													<span class="review-count">(${dto.reviewCount })</span>
												</span>
											</c:when>
											<c:otherwise>
												<span>-</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<span class="master-category">
											${dto.caRootName}
											<i class="bi bi-chevron-right"></i>${dto.caName}</span>
									</td>
								</c:if>
								<td>
									<i class="bi bi-geo-alt"></i>
									${empty dto.address ? '-' : dto.address}
									<span></span>${empty dto.addressDetail ? '' : dto.addressDetail}
								</td>
								<td>
									<i class="bi bi-telephone"></i>
									${dto.phoneNum}
								</td>
								<c:if test="${type == 'user' }">
									<td>
										<fmt:formatDate value="${dto.insertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
									</td>
								</c:if>
								<c:if test="${type == 'master' }">
									<td>
										<fmt:formatDate value="${dto.insertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
									</td>
									<td>
										<c:if test="${dto.joinApproval=='Y' }">
											<c:choose>
												<c:when test="${empty dto.joinApprovalTime}">
											        -
											    </c:when>
												<c:otherwise>
													<fmt:formatDate value="${dto.joinApprovalTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
												</c:otherwise>
											</c:choose>
										</c:if>
										<c:if test="${dto.joinApproval=='N' }">
											<a href="approve.member?meNo=${dto.meNo }&type=${dto.type}" class="btn" onclick="return confirm('가입을 승인하시겠습니까?')">승인</a>
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
					<c:if test="${startPage > 1}">
						<li>
							<a href="#" onClick="goPage('1')" style="margin-right: -10px;">
								<i class="bi bi-chevron-double-left"></i>
							</a>
						</li>
					</c:if>
					<c:if test="${currentPage > 1}">
						<li>
							<a href="#" onClick="goPage('${currentPage - 1}')">
								<i class="bi bi-chevron-left"></i>
							</a>
						</li>
					</c:if>
					<c:forEach var="i" begin="${startPage}" end="${endPage}">
						<li>
							<a href="#" onClick="goPage('${i}')" class="${i == currentPage ? 'active' : ''}">${i}</a>
						</li>
					</c:forEach>
					<c:if test="${currentPage < totalPages}">
						<li>
							<a href="#" onClick="goPage('${currentPage + 1}')">
								<i class="bi bi-chevron-right"></i>
							</a>
						</li>
					</c:if>
					<c:if test="${endPage < totalPages}">
						<li>
							<a href="#" onClick="goPage('${totalPages}')" style="margin-left: -10px;">
								<i class="bi bi-chevron-double-right"></i>
							</a>
						</li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>

</body>

</html>