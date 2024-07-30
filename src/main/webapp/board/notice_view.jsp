<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb.jsp"%>
			<div class="content">
				<div class="content-case">

					<div class="content-title-box">
						<div class="content-title">
							<h3>${dto.title}</h3>
						</div>
						<div class="content-date">
							<p>
								<fmt:formatDate value="${dto.insertTime }" pattern="yyyy-MM-dd" />
							</p>
						</div>
					</div>
					<div class="content-detail-box">
						<div class="content-detail">
							<p>${dto.content }</p>
						</div>

					</div>
					<div class="content-move-box">
					<c:if test="${sidedto.last != 9999 }">
						<div class="content-back">
							<div class="figure">
								<i class="bi bi-chevron-up"></i>
							</div>
							<div class="content-back-back">이전글</div>
							<div class="content-back-title">
								<a href="${pageContext.request.contextPath }/board/noticeView.board?boNo=${sidedto.last}">${sidedto.lastTitle }</a>
							</div>
						</div>
						</c:if>
						<c:if test="${sidedto.next != 9999 }">
						<div class="content-next">
							<div class="figure">
								<i class="bi bi-chevron-down"></i>
							</div>
							<div class="content-next-next">다음글</div>
							<div class="content-next-title">
								<a href="${pageContext.request.contextPath }/board/noticeView.board?boNo=${sidedto.next}">${sidedto.nextTitle}</a>
							</div>
						</div>
						</c:if>
					</div>
					<div class="content-move-list">


						<a href="${pageContext.request.contextPath }/board/list.board?type=notice" class="wpqkf">목록보기</a>

					</div>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>

</body>

</html>