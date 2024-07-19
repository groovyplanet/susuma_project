<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb_board.jsp"%>
			<div class="content content-ask-kim">
				<div class="content-case">


					<div class="content-title-box">
						<div class="content-title">
							<h3>제목이 빠밤제목이 빠밤제목이 빠밤</h3>
						</div>
						<div class="content-sd">

							<div class="content-status-ok">
								<p>답변 완료</p>
							</div>
							<div class="content-date">
								<p>2024-07-15</p>
							</div>
						</div>
						<div class="content-controll">
							<a href="#">수정</a>
							<a href="#">삭제</a>
						</div>
					</div>
					<div class="content-detail-box">
						<div class="content-detail">
							<div class="content-detail-my">

								<p>아니이이 글쎄 이것 보세요ㅛㅛㅛㅛㅛ</p>
								<p>제가 글쎄 화가 나요 안나요?</p>

							</div>
						</div>
						<div class="content-detail">
							<div class="content-detail-answer">
								<h3>답변 내용</h3>
								<p>엄머나 세상에 그러셧구나</p>
								<p>근데요?</p>
								<p>제가 뭐 할게없는데?</p>
								<p>나가세요</p>
							</div>
						</div>


					</div>

					<div class="content-move-list">


						<a href="${pageContext.request.contextPath }/board/notice_list.jsp" class="wpqkf">목록보기</a>

					</div>
				</div>
			</div>
		</div>
	</section>


	<%@ include file="../include/footer.jsp"%>

</body>

</html>