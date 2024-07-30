<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

				<c:forEach var="dto" items="${list }">
					<%-- 현재날짜와 수리예약일 비교 (ex.2024. 9. 13(금) 19:00) --%>
					<jsp:useBean id="now" class="java.util.Date" />
					<fmt:formatDate value="${now}" pattern="yyyy. M. d" var="nowDate" />
					<fmt:formatDate value="${now}" pattern="HH:00" var="nowTime" />
					<fmt:parseDate value="${fn:substringBefore(dto.requestDate, '(') }" pattern="yyyy. M. d" var="requestDateParse" />
					<fmt:formatDate value="${requestDateParse}" pattern="yyyy. M. d" var="requestDateFmt" />
					<fmt:parseDate value="${dto.requestTime }" pattern="HH:00" var="requestTimeParse" />
					<fmt:formatDate value="${requestTimeParse}" pattern="HH:00" var="requestTimeFmt" />
					<div class="request-summary">
						<c:choose>
							<%-- 의뢰인 --%>
							<c:when test="${sessionScope.type eq 'user'}">
								<c:choose>
									<c:when test="${dto.masterProfilePhotoImg == '' }">
										<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile-photo">
									</c:when>
									<c:otherwise>
										<img src="data:image/png;base64,${dto.masterProfilePhotoImg }" alt="Profile Picture" class="profile-photo">
									</c:otherwise>
								</c:choose>
								<a href="${pageContext.request.contextPath }/member/view.request?reqNo=${dto.reqNo }" class="info">
									<div class="repair_date">
										<span>
											<i class="bi bi-calendar-check" style="margin-right: 4px;"></i>${dto.requestDate }</span>
										<span>${dto.requestTime }</span>
										<c:choose>
											<c:when test="${dto.daysDiff < 0}">
												<span class="days-diff">D${dto.daysDiff}</span>
											</c:when>
											<c:when test="${dto.daysDiff == 0}">
												<span class="days-diff">D-Day</span>
											</c:when>
										</c:choose>
									</div>
									<div class="master_name">
										${dto.masterName } 수리기사님
										<c:set var="addressParts" value="${fn:split(dto.masterAddress, ' ')}" />
										<span class="address">
											<i class="bi bi-geo-alt"></i>
											<span>${addressParts[0]}</span>
											<span>${addressParts[1]}</span>
										</span>
									</div>
									<div class="repair_type">
										<p class="master-category">
											<span>${dto.caRootName }
												<i class="bi bi-chevron-right"></i>${dto.caName }</span>
										</p>
									</div>
									<div class="explain">
										<c:out value="${fn:substring(dto.content, 0, 55)}" />
									</div>
								</a>
								<c:choose>
									<c:when test="${dto.status eq 'requested'}">
										<button type="button" class="btn">예약 승인 대기</button>
									</c:when>
									<c:when test="${dto.status eq 'approved'}">
										<c:choose>
											<c:when test="${requestDateFmt > nowDate or (requestDateFmt == nowDate and requestTimeFmt > nowTime)}">
												<!-- 예약일이 미래 -->
												<button type="button" class="btn">예약 완료</button>
											</c:when>
											<c:otherwise>
												<!-- 예약일이 과거 -->
												<button type="button" class="btn">수리 중</button>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:when test="${dto.status eq 'paywait'}">
										<button type="button" class="btn submit pay" data-reqno="${dto.reqNo}" data-payamount='${dto.payAmount}'>결제하기</button>
									</c:when>
									<c:when test="${dto.status eq 'paid'}">
										<c:choose>
											<c:when test="${dto.reviewCnt == 0}">
												<a href="view.request?reqNo=${dto.reqNo }" class="btn submit">후기 작성</a>
											</c:when>
											<c:otherwise>
												<button type="button" class="btn complete">결제 완료</button>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:when test="${dto.status eq 'cancel'}">
										<button type="button" class="btn complete">예약 취소</button>
									</c:when>
								</c:choose>
							</c:when>
							<%-- 수리기사 --%>
							<c:otherwise>
								<c:choose>
									<c:when test="${dto.clientProfilePhotoImg == '' }">
										<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile-photo">
									</c:when>
									<c:otherwise>
										<img src="data:image/png;base64,${dto.clientProfilePhotoImg }" alt="Profile Picture" class="profile-photo">
									</c:otherwise>
								</c:choose>
								<a href="${pageContext.request.contextPath }/member/view.request?reqNo=${dto.reqNo }" class="info">
									<div class="repair_date">
										<span>
											<i class="bi bi-calendar-check" style="margin-right: 4px;"></i>${dto.requestDate }</span>
										<span>${dto.requestTime }</span>
										<c:choose>
											<c:when test="${dto.daysDiff < 0}">
												<span class="days-diff">D${dto.daysDiff}</span>
											</c:when>
											<c:when test="${dto.daysDiff == 0}">
												<span class="days-diff">D-Day</span>
											</c:when>
										</c:choose>
									</div>
									<div class="master_name">
										${dto.clientName } 의뢰인
										<span class="address">
											<i class="bi bi-geo-alt"></i>
											<span>${dto.clientAddress }</span>
											<span> </span>
											<span>${dto.clientAddressDetail }</span>
										</span>
									</div>
									<div class="explain">
										<c:out value="${fn:substring(dto.content, 0, 55)}" />
									</div>
								</a>
								<c:choose>
									<c:when test="${dto.status eq 'requested'}">
										<button type="button" class="btn submit approve" data-reqno="${dto.reqNo}">예약 승인</button>
									</c:when>
									<c:when test="${dto.status eq 'approved'}">
										<c:choose>
											<c:when test="${requestDateFmt > nowDate or (requestDateFmt == nowDate and requestTimeFmt > nowTime)}">
												<!-- 예약일이 미래 -->
												<button type="button" class="btn">예약 완료</button>
											</c:when>
											<c:otherwise>
												<!-- 예약일이 과거 -->
												<button type="button" class="btn submit pay-request" data-reqno="${dto.reqNo}">결제 요청</button>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:when test="${dto.status eq 'paywait'}">
										<button type="button" class="btn">결제 대기</button>
									</c:when>
									<c:when test="${dto.status eq 'paid'}">
										<button type="button" class="btn complete">결제 완료</button>
									</c:when>
									<c:when test="${dto.status eq 'cancel'}">
										<button type="button" class="btn complete">예약 취소</button>
									</c:when>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</div>
				</c:forEach>