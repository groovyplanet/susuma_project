<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb.jsp"%>
			<div class="content content-ask-kim">
				<div class="content-case">


					<div class="content-title-box">
						<div class="content-title">
							<h3>${dto.title}</h3>
						</div>
						<div class="content-sd">

							<div class="content-status-ok">
								<c:choose>
									<c:when test="${dto.answer !=null}">
										<p class="approve">답변 완료</p>
									</c:when>
									<c:otherwise>
										<p>답변 대기</p>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="content-date">
								<p>
									<fmt:formatDate value="${dto.insertTime }" pattern="yyyy-MM-dd" />
								</p>
							</div>
						</div>
						<c:if test="${dto.answer ==null}">
							<!-- 답변 대기 상태일 때만 수정/삭제 가능 -->
							<div class="content-controll">
								<a href="${pageContext.request.contextPath }/board/askModify.board?boNo=${dto.boNo}">수정</a>
								<a href="${pageContext.request.contextPath }/board/askDelete.board?boNo=${dto.boNo}">삭제</a>
							</div>
						</c:if>
					</div>
					<div class="content-detail-box">
						<div class="content-detail">
							<div class="content-detail-my">
								<p class="preserve-line-breaks">${dto.content }</p>
							</div>
							<c:if test="${dto.answer != null}">
								<div class="content-detail-answer">
									<div class="title">답변 내용</div>
									<p class="preserve-line-breaks">${dto.answer }</p>
								</div>
							</c:if>
						</div>
					</div>

					<div class="content-move-list">
						<a href="${pageContext.request.contextPath }/board/list.board?type=ask" class="wpqkf">목록보기</a>
					</div>
				</div>
			</div>
		</div>
	</section>


	<%@ include file="../include/footer.jsp"%>

</body>

</html>