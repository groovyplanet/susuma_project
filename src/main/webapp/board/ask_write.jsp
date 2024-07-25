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
						<form name="form-qna-write" method="post" action="${pageContext.request.contextPath }/board/registAskForm.board" class="form-horizontal" target="actionFrame">
							<input type="hidden" name="boNo" value="${dto.boNo }">
							<div class="panel-default">
								<div class="panel-heading"></div>
								<div class="panel-body">
									<div class="form-group">
										<label class="control-label">제목</label>
										<div>
											<input name="title" type="text" id="subject" class="form-control" value="${dto.title }">
										</div>
									</div>

									<div class="form-group">
										<label for="content" class="control-label">내용</label>
										<div>
											<textarea name="content" id="content" class="form-control" cols="50" rows="20"> ${dto.content }</textarea>
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