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
				<span>수리 예약 상세</span>
				<div class="btn_wrap">
					<a href="list.request" class="btn black">
						<i class="bi bi-list-ul"></i>
						목록
					</a>
					<a href="delete.request?reqNo=${requestDTO.reqNo }" class="btn" onclick="return confirm('정말로 예약 정보를 삭제하시겠습니까?')">
						<i class="bi bi-trash3"></i>
						삭제
					</a>
				</div>
			</div>
			<div class="table_wrap">
				<table class="view request" id="member_view">
					<tr>
						<th>상태</th>
						<td>
							<c:choose>
								<c:when test="${requestDTO.status == 'requested'}">
									<span class="request-status red">예약 승인 대기</span>
								</c:when>
								<c:when test="${requestDTO.status == 'approved'}">
									<span class="request-status green">예약 완료</span>
								</c:when>
								<c:when test="${requestDTO.status == 'paywait'}">
									<span class="request-status purple">예약 완료</span>
								</c:when>
								<c:when test="${requestDTO.status == 'paid'}">
									<span class="request-status orange">결제 완료</span>
								</c:when>
								<c:when test="${requestDTO.status == 'cancel'}">
									<span class="request-status gray">취소</span>
								</c:when>
							</c:choose>
						</td>
						<th>수리분야</th>
						<td>
							<span class="master-category">
								${requestDTO.caRootName}
								<i class="bi bi-chevron-right"></i>${requestDTO.caName}</span>
						</td>
					</tr>
					<tr>
						<th>의뢰인 회원 번호</th>
						<td>${requestDTO.clientNo}</td>
						<th>수리기사 회원 번호</th>
						<td>${requestDTO.masterNo}</td>
					</tr>
					<tr>
						<th>의뢰인</th>
						<td>
							<div style="display: inline-flex; align-items: center; gap: 10px;">
								<c:choose>
									<c:when test="${requestDTO.clientProfilePhotoImg == '' }">
										<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile">
									</c:when>
									<c:otherwise>
										<img src="data:image/png;base64,${requestDTO.clientProfilePhotoImg }" alt="Profile Picture" class="profile">
									</c:otherwise>
								</c:choose>
								${requestDTO.clientName }
							</div>
						</td>
						<th>수리기사</th>
						<td>
							<div style="display: inline-flex; align-items: center; gap: 10px;">
								<c:choose>
									<c:when test="${requestDTO.masterProfilePhotoImg == '' }">
										<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile">
									</c:when>
									<c:otherwise>
										<img src="data:image/png;base64,${requestDTO.masterProfilePhotoImg }" alt="Profile Picture" class="profile">
									</c:otherwise>
								</c:choose>
								${requestDTO.masterName }
							</div>
						</td>
					</tr>
					<tr>
						<th>의뢰인 연락처</th>
						<td>${requestDTO.clientPhoneNum }</td>
						<th>수리기사 연락처</th>
						<td>${requestDTO.masterPhoneNum }</td>
					</tr>
					<tr>
						<th>예약일시</th>
						<td style="display: block;">
							${requestDTO.requestDate}
							<span></span>
							${requestDTO.requestTime}
						</td>
						<th>주소</th>
						<td style="display: block;">
							${empty requestDTO.clientAddress ? '-' : requestDTO.clientAddress}
							<span> </span>
							${empty requestDTO.clientAddressDetail ? '' : requestDTO.clientAddressDetail}
						</td>
					</tr>
					<tr>
						<th>위도</th>
						<td>${requestDTO.latitude}</td>
						<th>경도</th>
						<td>${requestDTO.longitude}</td>
					</tr>
					<tr>
						<th>수리 요청 내용</th>
						<td>
							<div class="preserve-line-breaks">${requestDTO.content}</div>
						</td>
						<th>요청 일시</th>
						<td>
							<fmt:formatDate value="${requestDTO.insertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초" />
						</td>
					</tr>
					<c:if test="${requestDTO.status eq 'paid'}">
						<tr>
							<th>결제 금액</th>
							<td>
								<fmt:formatNumber value="${requestDTO.payAmount}" type="number" groupingUsed="true" maxFractionDigits="0" />
								P
							</td>
							<th>결제 시간</th>
							<td>
								<fmt:formatDate value="${requestDTO.paidTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
							</td>
						</tr>
					</c:if>
					<c:if test="${requestDTO.status eq 'paid' and reviewDTO != null }">
						<tr>
							<th>등록된 리뷰</th>
							<td style="flex-direction: column;">
								<div class="star-score">
									<c:forEach var="i" begin="1" end="5">
										<c:choose>
											<c:when test="${i <= reviewDTO.starScore}">
												<i class="bi bi-star-fill"></i>
											</c:when>
											<c:otherwise>
												<i class="bi bi-star"></i>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</div>
								<div class="preserve-line-breaks">${reviewDTO.content}</div>
							</td>
							<th>리뷰 작성 시간</th>
							<td>
								<fmt:formatDate value="${reviewDTO.insertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
							</td>
						</tr>
					</c:if>
				</table>
			</div>
		</div>
	</div>

</body>

</html>
