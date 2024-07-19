<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>
	
    <section class="main-section">
        <div class="container">
			<%@ include file="../include/snb_master.jsp"%>
            <div class="review-setting">
                <h4 class="review-set-title">회원이 작성한 수리 후기</h4><br>

                <a href="review_view.jsp">
                    <div class="review-schedule">
                        <img class="profile-logo-sm" src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="profile-logo-sm">
                    </a>

                    <div class="info">
                        <a href="review_view.jsp">
                            <div class="review_date">
                                2024.07.02
                            </div>
                            <div class="name">
                                김현용 수리기사님
                                <span class="address">
                                    서울시 강동구
                                </span>
                            </div>
                            <div class="review_type">
                                컴퓨터 수리
                            </div>
                        </a>
                    </div>
                </div>

                <a href="review_view.jsp">
                    <div class="review-schedule">
                        <img class="profile-logo-sm" src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="profile-logo-sm">
                    </a>

                    <div class="info">
                        <a href="review_view.jsp">
                            <div class="review_date">
                                2024.06.31
                            </div>
                            <div class="name">
                                조예원 수리기사님
                                <span class="address">
                                    경기도 시흥시 신천동
                                </span>
                            </div>
                            <div class="review_type">
                                도배장판 수리
                            </div>
                        </a>
                    </div>
                </div>
                
                <a href="review_view.jsp">
                    <div class="review-schedule">
                        <img class="profile-logo-sm" src="../resources/img/iconProfileDefault.png" alt="profile-logo-sm">
                    </a>

                    <div class="info">
                        <a href="review_view.jsp">
                            <div class="review_date">
                                2024.06.02
                            </div>
                            <div class="name">
                                한정우 수리기사님
                                <span class="address">
                                    건대입구
                                </span>
                            </div>
                            <div class="review_type">
                                가구 수리
                            </div>
                        </a>
                    </div>
                </div>

                <button class="review-more">더보기</button>
            </div>
        </div>
    </div>


        
    </section>

	<%@ include file="../include/footer.jsp"%>

</body>

</html>