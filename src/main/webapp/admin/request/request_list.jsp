<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<div class="container">
		<%@ include file="../include/snb.jsp"%>
		<div class="content_wrap">
			<div class="title_wrap">
				<span>수리 예약 목록</span>
			</div>
			<form name="searchForm" action="list.request" method="get">
				<input type="hidden" name="sortField" value="${sortField}">
				<input type="hidden" name="sortOrder" value="${sortOrder}">
				<input type="hidden" name="page" value="1">
				<div class="search_wrap">
					<table class="search">
						<tr>
							<th style="width: 85px;">
								<i class="bi bi-search"></i>
								상태
							</th>
							<td>
								<ul class="check_list">
									<li>
										<input type="radio" name="status" value="all" id="status-all" ${status == 'all' ? 'checked' : ''}>
										<label for="status-all">전체(${cntDTO.allCnt })</label>
									</li>
									<li>
										<input type="radio" name="status" value="requested" id="status-requested" ${status == 'requested' ? 'checked' : ''}>
										<label for="status-requested">예약 승인 대기(${cntDTO.requestedCnt })</label>
									</li>
									<li>
										<input type="radio" name="status" value="approved" id="status-approved" ${status == 'approved' ? 'checked' : ''}>
										<label for="status-approved">예약 완료(${cntDTO.approvedCnt })</label>
									</li>
									<li>
										<input type="radio" name="status" value="paywait" id="status-paywait" ${status == 'paywait' ? 'checked' : ''}>
										<label for="status-paywait">결제 대기(${cntDTO.paywaitCnt })</label>
									</li>
									<li>
										<input type="radio" name="status" value="paid" id="status-paid" ${status == 'paid' ? 'checked' : ''}>
										<label for="status-paid">결제 완료(${cntDTO.paidCnt })</label>
									</li>
									<li>
										<input type="radio" name="status" value="cancel" id="status-cancel" ${status == 'cancel' ? 'checked' : ''}>
										<label for="status-cancel">취소(${cntDTO.cancelCnt })</label>
									</li>
								</ul>
							</td>
						</tr>
					</table>
				</div>
			</form>
			<div class="table_wrap">
				<table class="list" id="request_list">
					<thead>
						<tr>
							<th class="wp5">번호</th>
							<th class="wp7">
								<button class="btn_sort" onclick="sort('MM.NAME', '${sortField != 'MM.NAME' ? 'ASC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									의뢰인
									<i class="bi bi-caret-${sortField != 'MM.NAME' ? 'up' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
							<th class="wp7">
								<button class="btn_sort" onclick="sort('MC.NAME', '${sortField != 'MC.NAME' ? 'ASC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									수리기사
									<i class="bi bi-caret-${sortField != 'MC.NAME' ? 'up' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
							<th class="wp17">수리 분야</th>
							<th class="wp11">
								<button class="btn_sort" onclick="sort('R.REQUEST_DATE', '${sortField != 'R.REQUEST_DATE' ? 'ASC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									예약일시
									<i class="bi bi-caret-${sortField != 'R.REQUEST_DATE' ? 'up' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
							<th class="wp8">
								<button class="btn_sort" onclick="sort('R.STATUS', '${sortField != 'R.STATUS' ? 'ASC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									예약상태
									<i class="bi bi-caret-${sortField != 'R.STATUS' ? 'up' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
							<th>수리요청내용</th>
							<th class="wp7">
								<button class="btn_sort" onclick="sort('R.PAY_AMOUNT', '${sortField != 'R.PAY_AMOUNT' ? 'ASC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									수리금액
									<i class="bi bi-caret-${sortField != 'R.PAY_AMOUNT' ? 'up' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
							<th class="wp8">
								<button class="btn_sort" onclick="sort('RE.STAR_SCORE', '${sortField != 'RE.STAR_SCORE' ? 'ASC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									후기
									<i class="bi bi-caret-${sortField != 'RE.STAR_SCORE' ? 'up' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
							<th class="wp13">
								<button class="btn_sort" onclick="sort('R.INSERT_TIME', '${sortField != 'R.INSERT_TIME' ? 'DESC' : (sortOrder=='DESC'? 'ASC' : 'DESC')}')">
									요청일시
									<i class="bi bi-caret-${sortField != 'R.INSERT_TIME' ? 'down' : (sortOrder=='DESC'? 'down-fill' : 'up-fill')}"></i>
								</button>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${list}">
							<tr data-reqNo="${dto.reqNo}">
								<td>${totalRecords - dto.rn + 1}</td>
								<td>
									<div style="display: inline-flex; align-items: center; gap: 5px;">
										<c:choose>
											<c:when test="${dto.clientProfilePhotoImg == '' }">
												<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile">
											</c:when>
											<c:otherwise>
												<img src="data:image/png;base64,${dto.clientProfilePhotoImg }" alt="Profile Picture" class="profile">
											</c:otherwise>
										</c:choose>
										${dto.clientName }
									</div>
								</td>
								<td>
									<div style="display: inline-flex; align-items: center; gap: 5px;">
										<c:choose>
											<c:when test="${dto.masterProfilePhotoImg == '' }">
												<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile">
											</c:when>
											<c:otherwise>
												<img src="data:image/png;base64,${dto.masterProfilePhotoImg }" alt="Profile Picture" class="profile">
											</c:otherwise>
										</c:choose>
										${dto.masterName }
									</div>
								</td>
								<td>
									<span class="master-category">
										${dto.caRootName}
										<i class="bi bi-chevron-right"></i>${dto.caName}</span>
								</td>
								<td>
									<i class="bi bi-clock"></i>
									${dto.requestDate}
									<span></span>${dto.requestTime}</td>
								<td>
									<c:choose>
										<c:when test="${dto.status == 'requested'}">
											<span class="request-status red">예약 승인 대기</span>
										</c:when>
										<c:when test="${dto.status == 'approved'}">
											<span class="request-status green">예약 완료</span>
										</c:when>
										<c:when test="${dto.status == 'paywait'}">
											<span class="request-status purple">예약 완료</span>
										</c:when>
										<c:when test="${dto.status == 'paid'}">
											<span class="request-status orange">결제 완료</span>
										</c:when>
										<c:when test="${dto.status == 'cancel'}">
											<span class="request-status gray">취소</span>
										</c:when>
									</c:choose>
								</td>
								<td>
									<span class="ellipsis">
										<c:out value="${fn:substring(dto.content, 0, 30)}" />
									</span>
								</td>
								<td>
									<c:choose>
										<c:when test="${dto.payAmount != null}">
											<fmt:formatNumber value="${dto.payAmount}" type="number" groupingUsed="true" maxFractionDigits="0" />원
										</c:when>
										<c:otherwise>-</c:otherwise>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${dto.reviewCnt>0 }">
											<span class="star-score">
												<c:forEach var="i" begin="1" end="5">
													<c:choose>
														<c:when test="${i <= dto.starScore}">
															<i class="bi bi-star-fill"></i>
														</c:when>
														<c:otherwise>
															<i class="bi bi-star"></i>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</span>
										</c:when>
										<c:otherwise>
										-
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<fmt:formatDate value="${dto.insertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
								</td>
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