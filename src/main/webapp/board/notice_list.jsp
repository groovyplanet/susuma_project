<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb_board.jsp"%>
			<div class="content-list">
			<c:forEach var="dto" items="${list }">
				<div class="content-box">
					<div class="content-mix">
	
						<div class="content-num">
							<p>${dto.boNo}</p>
						</div>
						<div class="content-title">
							<a href="${pageContext.request.contextPath }/board/notice_view.jsp">${dto.title}</a>
							<p><fmt:formatDate value="${dto.insertTime }" pattern="yyyy-MM-dd"/></p>
						</div>
					</div>
				</div>
				</c:forEach>
				
				<div class="content-p-box">
					<div class="content-page left">
						<a href="#">이전</a>
					</div>
					<div class="content-page">
						<a href="#">1</a>
					</div>
					<div class="content-page">
						<a href="#">2</a>
					</div>
					<div class="content-page right">
						<a href="#">다음</a>
					</div>
				</div>

			</div>
		</div>


	</section>
	<%@ include file="../include/footer.jsp"%>

</body>

</html>