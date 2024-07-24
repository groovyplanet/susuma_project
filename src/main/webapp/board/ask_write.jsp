<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb_board.jsp"%>
			<div class="content">
				<div class="edit-form">
					<div class="widget-location">
						<div class="wrap">
							<h4 class="ask-write-title">1:1 문의</h4>
						</div>
					</div>
					<div id="qna-write" class="section">
						<form name="form-qna-write" method="post" action="${pageContext.request.contextPath }/board/ask/regist.board" class="form-horizontal" target="actionFrame">
							<div class="panel-default">
								<div class="panel-heading"></div>
								<div class="panel-body">
									<div class="form-group">
										<label class="control-label">제목</label>

										<div>
											<input name="subject" type="text" id="subject" class="form-control" value="">
										</div>
									</div>
									<div class="form-group">
										<label class="control-label">관련 신청서</label>
										<div>
											<a href="/mypage/select/popup/1" class="event-click-select">선택하기</a>
											<span class="text-success event-set-data-cart"></span>
										</div>
									</div>
									<div class="form-group">
										<label for="content" class="control-label">내용</label>
										<div>
											<textarea name="content" id="content" class="form-control" cols="50" rows="20"></textarea>
										</div>
									</div>
									<div class="form-group">
										<label for="file" class="control-label">파일 첨부</label>
										<div>
											<input name="file[]" type="file">
										</div>
									</div>
								</div>
							</div>
							<p class="text-center">
								<button type="button" class="event-common-click-back">뒤로</button>
								<button type="submit" class="event-common-click-submit">저장하기</button>
							</p>
						</form>
					</div>
				</div>
			</div>
		</div>


	</section>



	<%@ include file="../include/footer.jsp"%>

</body>

</html>