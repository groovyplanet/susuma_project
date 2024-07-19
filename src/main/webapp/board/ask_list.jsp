<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb_board.jsp"%>
			<div class="content-list">
				<div class="content-box">
					<div class="content-mix">

						<div class="content-status-wait">
							<!-- <button class="btn complete" id="approve-button">답변 대기</button> -->
							<p>답변 대기</p>
						</div>
						<div class="content-title">
							<a href="${pageContext.request.contextPath }/board/ask_view.html">수수마 포인트 이용안내 입니다</a>
							<div>
								<p>2024-07-15</p>
								<p>조예원</p>
							</div>
						</div>
					</div>
				</div>
				<div class="content-box">
					<div class="content-mix">

						<div class="content-status-ok">
							<!-- <button class="btn complete">답변 완료</button> -->
							<p>답변 완료</p>
						</div>
						<div class="content-title">
							<a href="${pageContext.request.contextPath }/board/ask_view.html">수수마 포인트 이용안내 입니다</a>
							<div>
								<p>2024-07-15</p>
								<p>한정우</p>
							</div>
						</div>
					</div>
				</div>
				<div class="content-box">
					<div class="content-mix">

						<div class="content-status-ok">
							<!-- <button class="btn complete">답변 완료</button> -->
							<p>답변 완료</p>
						</div>
						<div class="content-title">
							<a href="${pageContext.request.contextPath }/board/ask_view.html">수수마 포인트 이용안내 입니다</a>
							<div>
								<p>2024-07-15</p>
								<p>김현용</p>
							</div>
						</div>
					</div>
				</div>
				<div class="content-box">
					<div class="content-mix">

						<div class="content-status-ok">
							<!-- <button class="btn complete">답변 완료</button> -->
							<p>답변 완료</p>
						</div>
						<div class="content-title">
							<a href="${pageContext.request.contextPath }/board/ask_view.html">수수마 포인트 이용안내 입니다</a>
							<div>
								<p>2024-07-15</p>
								<p>조예원</p>
							</div>
						</div>
					</div>
				</div>
				<div class="content-box">
					<div class="content-mix">

						<div class="content-status-ok">
							<!-- <button class="btn complete">답변 완료</button> -->
							<p>답변 완료</p>
						</div>
						<div class="content-title">
							<a href="${pageContext.request.contextPath }/board/ask_view.html">수수마 포인트 이용안내 입니다</a>
							<div>
								<p>2024-07-15</p>
								<p>조예원</p>
							</div>
						</div>
					</div>
				</div>
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
					<div class="content-ask">
						<a href="${pageContext.request.contextPath }/board/ask_write.html">문의하기</a>
					</div>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>

</body>

</html>