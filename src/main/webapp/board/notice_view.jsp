<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb_board.jsp"%>
			<div class="content">
				<div class="content-case">


					<div class="content-title-box">
						<div class="content-title">
							<h3>제목이 빠밤제목이 빠밤제목이 빠밤</h3>
						</div>
						<div class="content-date">
							<p>2024-07-15</p>
						</div>
					</div>
					<div class="content-detail-box">
						<div class="content-detail">
							<h3>제목다시보기</h3>
						</div>
						<div class="content-detail">
							<p>이 편지는 영국에서 최초로 시작되어 일년에 한바퀴를 돌면서 받는 사람에게 행운을 주었고 지금은 당신에게로 옮겨진 이 편지는 4일 안에 당신 곁을 떠나야 합니다. 이 편지를 포함해서 7통을 행운이 필요한 사람에게 보내 주셔야 합니다. 복사를 해도 좋습니다. 혹 미신이라 하실지 모르지만 사실입니다. 영국에서 HGXWCH이라는 사람은 1930년에 이 편지를 받았습니다. 그는 비서에게 복사해서 보내라고 했습니다. 며칠 뒤에 복권이 당첨되어 20억을 받았습니다. 어떤 이는 이 편지를 받았으나 96시간 이내 자신의 손에서 떠나야 한다는 사실을 잊었습니다. 그는 곧 사직되었습니다. 나중에야 이 사실을 알고 7통의 편지를 보냈는데 다시 좋은 직장을 얻었습니다. 미국의 케네디 대통령은 이 편지를 받았지만 그냥 버렸습니다. 결국 9일 후 그는 암살당했습니다. 기억해 주세요. 이 편지를 보내면 7년의 행운이 있을 것이고 그렇지 않으면 3년의 불행이 있을 것입니다. 그리고 이
								편지를 버리거나 낙서를 해서는 절대로 안됩니다. 7통입니다. 이 편지를 받은 사람은 행운이 깃들 것입니다. 힘들겠지만 좋은 게 좋다고 생각하세요. 7년의 행운을 빌면서...</p>
						</div>

					</div>
					<div class="content-move-box">
						<div class="content-back">
							<div class="figure">▲</div>
							<div class="content-back-back">이전글</div>
							<div class="content-back-title">
								<a href="#">오늘 점심에 수박나올 예정 굳</a>
							</div>
						</div>
						<div class="content-next">
							<div class="figure">▼</div>
							<div class="content-next-next">다음글</div>
							<div class="content-next-title">
								<a href="#">집에 가고싶은사람 쏴리질러~</a>
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