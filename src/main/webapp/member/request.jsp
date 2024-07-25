<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.susuma.member.model.MemberDTO"%>
<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container main-only">
			<div class="main-area request">
				<div class="title">수리 예약</div>
				<div class="join-form request-form">
					<!-- ajax로 처리 -->
					<form method="post" id="form-request">
					<input type="hidden" name="masterNo" value="${dto.meNo }">
						<div class="info-area">
							<div class="title-main">수리기사 정보</div>
							<div class="master-info-area">
								<div class="img-profile-area">
									<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="프로필 이미지">
								</div>
								<div class="text-area">
									<p class="master-name">
										${dto.name }
										<span class="master-stars">
											<i class="bi bi-star-fill"></i>
											4.5
											<span class="review-count">(114)</span>
										</span>
									</p>
									<p class="master-location">
										<i class="bi bi-geo-alt"></i>
										${dto.address} (10km 이내 이동 가능)
									</p>
									<p class="master-category">
										<span>에어컨 수리</span>
										<span>냉장고 수리</span>
									</p>
									<!-- 분야 -->
									<!-- <p class="master-desc">믿고 맡겨주시면 최선을 다해 수리해드리겠습니다. 믿고 맡겨주시면 최선을 다해 수리해드리겠습니다.</p>-->
									<!--한 줄 소개 -->
								</div>
							</div>
							<div class="calendar-wrap">
								<label>
									<i class="bi bi-stopwatch"></i>
									근무 가능 일시
								</label>
								<div id="master-work-hours-list"></div>
							</div>
						</div>
						<div class="info-area">
							<div class="title-main" id="date-wrap-top">날짜 및 시간 선택</div>
							<!-- 달력 -->
							<div class="calendar-wrap" id="calendar-wrap">
								<div class="calendar-box">
									<div class="ctr-box clearfix">
										<button type="button" title="prev" class="btn-cal prev">
											<i class="bi bi-chevron-left"></i>
										</button>
										<span class="cal-year"></span>
										.
										<span class="cal-month"></span>
										<button type="button" title="next" class="btn-cal next">
											<i class="bi bi-chevron-right"></i>
										</button>
									</div>
									<table class="cal-table">
										<thead>
											<tr>
												<th>일</th>
												<th>월</th>
												<th>화</th>
												<th>수</th>
												<th>목</th>
												<th>금</th>
												<th>토</th>
											</tr>
										</thead>
										<tbody class="cal-body"></tbody>
									</table>
								</div>
							</div>
							<!-- //달력 -->
							<!-- 시간 -->
							<div class="calendar-wrap time-list-wrap">
								<ul class="time-list" id="time-list"></ul>
							</div>
							<!-- //시간 -->
						</div>
						<div class="info-area">
							<div class="title-main inline">예약자 정보</div>
							<span class="title-sub2">
								<i class="bi bi-info-circle"></i>
								주소 및 연락처 수정 시 회원정보 갱신
							</span>
							<input type="hidden" name="requestDate" value="">
							<input type="hidden" name="requestTime" value="">
						</div>
						<div class="input-area">
							<label for="address" class="required">주소</label>
							<input type="hidden" name="address">
							<input type="hidden" name="latitude">
							<input type="hidden" name="longitude">
							<button type="button" id="btn-zipcode" class="btn-form btn-zipcode" onclick="execDaumPostcode()">
								주소 입력
								<i class="bi bi-chevron-right"></i>
							</button>
							<input type="text" class="input-field" placeholder="상세주소를 입력해주세요." autocomplete="no" name="addressDetail">
						</div>
						<div class="input-area">
							<label for="phoneNum" class="required">연락처</label>
							<input type="text" class="input-field" placeholder="연락처를 입력해주세요." autocomplete="no" name="phoneNum" id="phoneNum" maxlength="13" required>
							<p class="caption-error">올바른 형식이 아닙니다.</p>
						</div>
						<div class="input-area">
							<label for="content" class="required">수리요청 상세내용</label>
							<textarea name="content" class="input-field" placeholder="고객에게 보여질 수리 상세 내용을 입력해주세요." required>에어컨 가동 시 곧바로 꺼지는 현상이 발생합니다.
수리 요청드립니다.</textarea>
						</div>
						<button type="submit" class="btn-submit">수리 예약</button>
					</form>
					<!-- modal -->
					<div id="request-complete-modal" class="modal request">
						<div class="container">
							<div class="modal-title">수리 예약 신청 완료</div>
							<div class="request-content">
								<div class="request-info-area">
									<p class="info-title">예약 신청 일시</p>
									<p id="modal-date" class="underline"></p>
									<p class="info-title">수리기사 성함</p>
									<p id="modal-name"></p>
									<p class="info-title">예약자 연락처</p>
									<p id="modal-phone"></p>
									<p class="info-title">예약자 주소</p>
									<p id="modal-address"></p>
									<p class="info-title">수리 신청 내용</p>
									<p id="modal-description"></p>
								</div>
								<div class="request-desc-area">
									<p class="red">수리기사 승인 시 예약이 확정됩니다.</p>
									<p>예약 현황은 마이페이지에서 확인 가능합니다.</p>
								</div>
							</div>
							<a href="list.request" class="btn-enter">확인</a>
							<button type="button" class="btn-close-modal">
								<img src="${pageContext.request.contextPath }/resources/img/iconClose.png" alt="닫기 버튼">
							</button>
						</div>
					</div>
					<!-- //modal -->
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>
	<!-- 다음 주소검색 api -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<!-- 카카오맵 api -->
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6e324617d728d10d01ca7e36c2a14bf1&libraries=services,clusterer&autoload=false"></script>
	<script>
        kakao.maps.load(function () {
            //console.log("kakao.maps.load()");
            var geocoder;
        });
        function execDaumPostcode() {
            //console.log("execDaumPostcode()");
            new daum.Postcode({
                oncomplete: function (data) {
                    var addr = '';
                    if (data.userSelectedType === 'R') addr = data.roadAddress; // 도로명주소
                    else addr = data.jibunAddress; // 지번주소
                    var zipcode = data.zonecode; // 우편번호

                    // 위도 및 경도 좌푯값 구하기
                    const geocoder = new kakao.maps.services.Geocoder();
                    geocoder.addressSearch(data.roadAddress, (result, status) => {
                        if (status === kakao.maps.services.Status.OK) {
                            var latitude = result[0].y; // 위도
                            var longitude = result[0].x; // 경도
                            $("input[name=latitude]").val(latitude);
                            $("input[name=longitude]").val(longitude);
                        }
                    });

                    $("input[name=address]").val(addr); // 주소 값 넣기
                    $("#btn-zipcode").html('<p style="text-align: left;">' + addr + " [" + zipcode + "]" + '</p>'); // 주소 + 우편번호 보여주기
                    $("#btn-zipcode").removeClass("error");

                    $("input[name=addressDetail]").focus(); // 상세주소 포커스
                }
            }).open();
        }
	</script>
	<!-- //api -->

</body>

</html>