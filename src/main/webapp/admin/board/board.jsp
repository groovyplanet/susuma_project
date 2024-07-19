<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>

</head>

<body>

	<%@ include file="../include/header.jsp"%>

    <section class="main-section">
        <div class="container">
            <nav class="sidebar">
                <ul>
                    <li><a href="${pageContext.request.contextPath }/admin/user/user.jsp">회원관리</a></li>
                    <li><a href="${pageContext.request.contextPath }/admin/review/review.jsp">후기관리</a></li>
                    <li><div class="title">공지사항</div></li>
                    <li><a href="${pageContext.request.contextPath }/admin/faq/faq.jsp">FAQ</a></li>
                    <li><a href="${pageContext.request.contextPath }/admin/inquiry/inquiry.jsp">1:1문의</a></li>
                </ul>
            </nav>
            <div class="content-list">
                <div class="content-box">
                    <div class="content-mix">

                        <div class="content-num">
                            <p>10</p>
                        </div>
                        <div class="content-title">
                            <a href="${pageContext.request.contextPath }/admin/board/board_upate.jsp">수수마 포인트 이용안내 입니다</a>
                            <p>2024-07-15</p>
                        </div>
                        <div class="content-delete">
                            <a href="#" class="delete">삭제하기</a>
                        </div>
                    </div>
                </div>
                <div class="content-box">
                    <div class="content-mix">

                        <div class="content-num">
                            <p>9</p>
                        </div>
                        <div class="content-title">
                            <a href="${pageContext.request.contextPath }/admin/board/notice_view.jsp">수수마 포인트 이용안내 입니다</a>
                            <p>2024-07-15</p>
                        </div>
                        <div class="content-delete">
                            <a href="#" class="delete">삭제하기</a>
                        </div>
                    </div>
                </div>
                <div class="content-box">
                    <div class="content-mix">

                        <div class="content-num">
                            <p>8</p>
                        </div>
                        <div class="content-title">
                            <a href="${pageContext.request.contextPath }/admin/board/notice_view.jsp">수수마 포인트 이용안내 입니다</a>
                            <p>2024-07-15</p>
                        </div>
                        <div class="content-delete">
                            <a href="#" class="delete">삭제하기</a>
                        </div>
                    </div>
                </div>
                <div class="content-box">
                    <div class="content-mix">

                        <div class="content-num">
                            <p>7</p>
                        </div>
                        <div class="content-title">
                            <a href="${pageContext.request.contextPath }/admin/board/notice_view.jsp">수수마 포인트 이용안내 입니다</a>
                            <p>2024-05-15</p>
                        </div>
                        <div class="content-delete">
                            <a href="#" class="delete">삭제하기</a>
                        </div>
                    </div>
                </div>
                <div class="content-box">
                    <div class="content-mix">

                        <div class="content-num">
                            <p>6</p>
                        </div>
                        <div class="content-title">
                            <a href="${pageContext.request.contextPath }/admin/board/notice_view.jsp">수수마 포인트 이용안내 입니다</a>
                            <p>2024-07-15</p>
                        </div>
                        <div class="content-delete">
                            <a href="#" class="delete">삭제하기</a>
                        </div>
                    </div>
                </div>
                <div class="content-box">
                    <div class="content-mix">

                        <div class="content-num">
                            <p>5</p>
                        </div>
                        <div class="content-title">
                            <a href="${pageContext.request.contextPath }/admin/board/notice_view.jsp">수수마 포인트 이용안내 입니다</a>
                            <p>2024-07-15</p>
                        </div>
                        <div class="content-delete">
                            <a href="#" class="delete">삭제하기</a>
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
                        <a href="${pageContext.request.contextPath }/admin/board/board_view.jsp">등록하기</a>
                    </div>
                </div>
               
            </div>
            

        </div>
    </section>
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <p>정말 삭제하시겠습니까?</p>
            <button id="confirmDelete">확인</button>
            <button id="cancelDelete">취소</button>
        </div>
    </div>
   
	<%@ include file="../include/footer.jsp"%>
	
    <script>
        // 모달 관련 변수들
        var modal = document.getElementById("myModal");
        var btn = document.querySelector(".delete");
        var span = document.getElementsByClassName("close")[0];
        var confirmDelete = document.getElementById("confirmDelete");
        var cancelDelete = document.getElementById("cancelDelete");

        // 삭제하기 버튼 클릭 시 모달 열기
        btn.onclick = function(event) {
            event.preventDefault();
            modal.style.display = "block";
        }

        // 닫기 버튼 클릭 시 모달 닫기
        span.onclick = function() {
            modal.style.display = "none";
        }

        // 취소 버튼 클릭 시 모달 닫기
        cancelDelete.onclick = function() {
            modal.style.display = "none";
        }

        // 확인 버튼 클릭 시 삭제 로직 실행
        confirmDelete.onclick = function() {
            // 여기에 삭제 로직 추가
            console.log("삭제 확인됨");
            modal.style.display = "none";
        }

        // 모달 외부 클릭 시 모달 닫기
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
     </script>

</body>

</html>