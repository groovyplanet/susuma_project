<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<nav class="sidebar">
				<ul>
					<li>
						<a href="../main/main.html">메인</a>
					</li>
					<li>
						<a href="../myinformation/myinformation.html">내 정보 관리</a>
					</li>
					<li>
						<a href="../user/user.html">회원관리</a>
					</li>
					<li>
						<a href="../review/review.html">후기관리</a>
					</li>
					<div class="title">공지사항</div>
					<li>
						<a href="../faq/faq.html">FAQ</a>
					</li>
					<li>
						<a href="../inquiry/inquiry.html">1:1문의</a>
					</li>
				</ul>
			</nav>
			<div class="content">
				<div class="edit-form">
					<div class="widget-location">
						<div class="wrap">
							<h4 class="ask-write-title">공지사항 등록</h4>
						</div>
					</div>
					<div id="qna-write" class="section">
						<form name="form-qna-write" method="post" action="/board/ask_list.html" class="form-horizontal" target="actionFrame">
							<div class="panel-default">
								<div class="panel-heading"></div>
								<div class="panel-body">
									<div class="form-group">
										<label class="control-label">제목</label>

										<div>
											<input name="subject" type="text" id="subject" class="form-control" value="">
										</div>
									</div>
									<!-- <div class="form-group">
                                        <label class="control-label">관련 신청서</label>
                                        <div>
                                            <a href="/mypage/select/popup/1" class="event-click-select">선택하기</a>
                                            <span class="text-success event-set-data-cart"></span>
                                        </div>
                                    </div> -->
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
								<button type="submit" class="event-common-click-submit">등록하기</button>
							</p>
						</form>
					</div>
				</div>
			</div>

		</div>
	</section>

	<!-- footer -->
	<footer>
		<div class="container">
			<div class="copyright-area">
				<p>(주) 수수마 | 대표: 차은우 | 서울특별시 강남구 반포동 112-119 | 대표전화: 02-1234-5678</p>
				<p>사업자등록번호: 123-45-67890 | 통신판매업신고번호: 제1234-5678호 | 개인정보보호책임자: 수수마</p>
			</div>
			<span>Copyright 2024 SUSUMA© All rights reserved.</span>
		</div>
		</div>
	</footer>
	<!-- //footer -->

</body>

</html>