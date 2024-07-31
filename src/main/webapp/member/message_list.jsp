<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container message-list">
			<%@ include file="../include/snb.jsp"%>
			<div class="content">
				<c:if test="${empty list}">
					<div class="content-none-wrap">
						<i class="bi bi-info-circle"></i>
						아직 채팅 내역이 없습니다.
					</div>
				</c:if>
				<div class="chatlist">
					<c:forEach var="dto" items="${list }">
						<a class="chatroom" onclick="openMessage(${dto.sendMeNo == meNo ? dto.getMeNo : dto.sendMeNo}); return false;">
							<div class="chatroom-profile">
								<c:choose>
									<c:when test="${dto.sendType==type}">
										<c:choose>
											<c:when test="${dto.getProfilePhotoImg == '' }">
												<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture">
											</c:when>
											<c:otherwise>
												<img src="data:image/png;base64,${dto.getProfilePhotoImg }" alt="Profile Picture" class="profile-photo">
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${dto.sendProfilePhotoImg == '' }">
												<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture">
											</c:when>
											<c:otherwise>
												<img src="data:image/png;base64,${dto.sendProfilePhotoImg }" alt="Profile Picture" class="profile-photo">
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="chatroom-info">
								<div class="chatroom-name">
									<span id="mastername">
										<strong>${dto.sendType==type ? dto.getName : dto.sendName }</strong>
									</span>
									${type=='user' ? '수리기사님' : '의뢰인' }
									<c:if test="${dto.notReadCnt > 0}">
										<span class="new-mark active">${dto.notReadCnt }</span>
									</c:if>
								</div>
								<div class="last-message">${dto.message }</div>
							</div>
							<div class="chatroom-time">
								<fmt:formatDate value="${dto.sendTime}" pattern="yy.MM.dd. a h:mm" />
							</div>
						</a>
					</c:forEach>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>
	<script>
		function openMessage(meNo) {
			var url = 'form.message?user='+meNo;
			var name = '_blank';
			var width = 440;
			var height = 550;
			var left = (window.screen.width - width) / 2;
			var top = (window.screen.height - height - 200) / 2;
			window.open(url, name, "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top);
		}
	</script>
</body>

</html>