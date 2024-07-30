<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

				<c:forEach var="dto" items="${list }">
					<jsp:useBean id="now" class="java.util.Date" />
					<fmt:formatDate value="${now}" pattern="yyyy. M. d" var="nowDate" />
					<fmt:formatDate value="${now}" pattern="HH:00" var="nowTime" />
					<fmt:parseDate value="${dto.sendTime}" pattern="yyyy-MM-dd HH:mm:ss" var="sendTimeParse" />
					<fmt:formatDate value="${sendTimeParse}" pattern="yyyy. M. d" var="sendDateFmt" />
					<fmt:formatDate value="${sendTimeParse}" pattern="yyyy. M. d (E)" var="sendDateFmtDisplay" />

					<c:choose>
						<c:when test="${dto.getMeNo == meNo }">
							<div class="left">
								<div class="new-profile-img">
									<c:choose>
										<c:when test="${dto.sendProfilePhotoImg == '' }">
											<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture">
										</c:when>
										<c:otherwise>
											<img src="data:image/png;base64,${dto.sendProfilePhotoImg }" alt="Profile Picture">
										</c:otherwise>
									</c:choose>
								</div>
								<div class="message memberlf">${dto.message }</div>
								<p class="message timestamp">
									<fmt:formatDate value="${dto.sendTime}" pattern="a h:mm" />
								</p>
							</div>
						</c:when>
						<c:otherwise>
							<div class="right">
								<p class="message timestamp">
									${dto.read=='Y' ? '<span style="margin-right:4px;">읽음</span>' : '' }
									<fmt:formatDate value="${dto.sendTime}" pattern="a h:mm" />
								</p>
								<div class="message member">${dto.message }</div>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>