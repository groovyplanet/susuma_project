<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb.jsp"%>
			<div class="content status">
				<div class="status-body">
					<div class="status-section">
						<button class="reserve-app">예약신청</button>
						<div class="content-text">
							<p>
								0
								<br>
								예약신청
							</p>
						</div>
					</div>
					<div class="status-section">
						<button class="reserve-complete">예약완료</button>
						<div class="content-text">
							<p>
								0
								<br>
								예약완료
							</p>
						</div>
					</div>
					<div class="status-section">
						<button class="reserve-list">수리완료</button>
						<div class="content-text">
							<p>
								0
								<br>
								수리완료
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="../include/footer.jsp"%>

</body>

</html>