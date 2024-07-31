<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container main-only">
			<div class="main-area join profile-edit">
				<div class="title">회원가입</div>
				<div class="menu-tab">
					<!-- 의뢰인으로 가입 or 수리기사로 가입 -->
					<label for="radio-user" id="btn-join-user" class="tab-btn active">
						의뢰인으로 가입
						<i class="bi bi-check-lg"></i>
					</label>
					<label for="radio-master" id="btn-join-master" class="tab-btn">
						수리기사로 가입
						<i class="bi bi-check-lg"></i>
					</label>
				</div>
				<!-- 입력 폼 -->
				<div class="join-form">
					<form action="joinForm.member" method="post" id="form-join" enctype="multipart/form-data">
						<input type="radio" name="type" value="user" id="radio-user" checked style="display: none;">
						<input type="radio" name="type" value="master" id="radio-master" style="display: none;">
						<div class="input-area">
							<label for="email" class="required">이메일</label>
							<input type="text" class="input-field" placeholder="이메일을 입력해주세요." autocomplete="no" name="email" id="email" required>
							<p class="caption-error">올바른 형식이 아닙니다.</p>
							<p class="caption-duplicate-check yes">가입 가능한 이메일입니다.</p>
							<p class="caption-duplicate-check no">이미 가입되어있는 이메일입니다.</p>
						</div>
						<div class="input-area">
							<label for="pw" class="required">비밀번호</label>
							<input type="password" class="input-field" placeholder="비밀번호를 입력해주세요." autocomplete="no" name="pw" id="pw" required>
							<input type="password" class="input-field" placeholder="비밀번호를 다시 한번 입력해주세요." autocomplete="no" name="pw_re" id="pw_re" required>
							<p class="caption-error">영문+숫자 조합 8자리 이상 입력해주세요.</p>
							<p class="caption-error-re">비밀번호가 일치하지 않습니다.</p>
						</div>
						<div class="input-area">
							<label for="name" class="required">이름</label>
							<input type="text" class="input-field " placeholder="이름을 입력해주세요." autocomplete="no" name="name" id="name" required>
						</div>
						<div class="input-area">
							<label for="phoneNum" id="phoneNum-label" class="">연락처</label>
							<input type="text" class="input-field" placeholder="연락처를 입력해주세요." autocomplete="no" name="phoneNum" id="phoneNum" maxlength="13">
							<p class="caption-error">올바른 형식이 아닙니다.</p>
						</div>
						<div class="input-area">
							<label for="address" id="address-label" class="required">주소</label>
							<input type="hidden" name="address">
							<input type="hidden" name="latitude" value="0.0">
							<!-- 위도 -->
							<input type="hidden" name="longitude" value="0.0">
							<!-- 경도 -->
							<button type="button" id="btn-zipcode" class="btn-form btn-zipcode" onclick="execDaumPostcode()">
								주소 검색
								<i class="bi bi-search"></i>
							</button>
							<input type="text" class="input-field" placeholder="상세주소를 입력해주세요." autocomplete="no" name="addressDetail">
						</div>
						<div id="master-info-area" style="display: none;">
							<div class="input-area">
								<label for="businessNumber" class="required">사업자등록번호</label>
								<input type="text" class="input-field" placeholder="사업자등록번호를 입력해주세요." autocomplete="no" name="businessNumber" id="businessNumber" maxlength="12">
								<p class="caption-error">올바른 형식이 아닙니다.</p>
							</div>
							<!-- 수리 분야(동적 추가 및 삭제) -->
							<div class="input-area">
								<div class="category-add-area">
									<label for="category" class="required">수리 분야</label>
								</div>
								<div id="category-select-area-wrap">
									<div class="category-select-area">
										<select id="category" onchange="handleCategoryChange()" class="select-category">
											<option value="">선택</option>
											<c:forEach var="categoryDto" items="${CategoryMainList}">
												<option value="${categoryDto.caNo }" ${dto.caRootNo == categoryDto.caNo ? 'selected' : ''}>${categoryDto.caName }</option>
											</c:forEach>
										</select>
										<select name="caNo" id="sub-category" class="select-category">
											<option value="">선택</option>
											<c:forEach var="categorySubDto" items="${CategorySubList}">
												<option value="${categorySubDto.caNo }" ${dto.caNo == categorySubDto.caNo ? 'selected' : ''}>${categorySubDto.caName }</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
							<!-- 근무 가능 요일 및 시간(모달창에서 요일 선택 후 시간 입력) -->
							<div class="input-area">
								<label class="required">근무 가능 요일 및 시간</label>
								<button type="button" id="btn-work_hours" class="btn-form btn-work_hours" onclick="$('#work-hours-modal').addClass('show');">
									시간 입력
									<i class="bi bi-chevron-right"></i>
								</button>
								<input type="hidden" name="workHours" value="${dto.workHours}">
								<div id="work-hours-list" class="work-hours-list" style="display: none;">
									<!-- 사용자가 모달에서 입력한 요일/시작시간/종료시간 표시 -->
								</div>
							</div>
							<div class="input-area">
								<label for="maxDistance" class="required">이동 가능 거리</label>
								<div class="distance-radio-area">
									<input type="radio" name="maxDistance" value="5" id="distanc-5" checked>
									<input type="radio" name="maxDistance" value="10" id="distanc-10">
									<input type="radio" name="maxDistance" value="20" id="distanc-20">
									<input type="radio" name="maxDistance" value="50" id="distanc-50">
									<input type="radio" name="maxDistance" value="100" id="distanc-100">
									<label for="distanc-5" class="distance-radio active">5km 이내</label>
									<label for="distanc-10" class="distance-radio">10km 이내</label>
									<label for="distanc-20" class="distance-radio">20km 이내</label>
									<label for="distanc-50" class="distance-radio">50km 이내</label>
									<label for="distanc-100" class="distance-radio">100km 이내</label>
								</div>
							</div>
							<div class="input-area">
								<label for="shortDescription" class="required">한 줄 소개</label>
								<input type="text" class="input-field" placeholder="고객에게 보여질 한 줄 소개 멘트를 입력해주세요." autocomplete="no" name="shortDescription" id="shortDescription">
							</div>
						</div>
						<!-- //master-info-area -->
						<div class="input-area">
							<label>이메일 수신 동의</label>
							<div class="checkbox-area">
								<input type="checkbox" name="emailNotification" id="emailNotification" value="Y" class="checkbox-agree">
								<label for="emailNotification">SUSUMA 이용과 관련한 알림을 이메일로도 받아보실 수 있습니다.</label>
							</div>
						</div>
						<div class="input-area">
							<label class="required">약관 동의</label>
							<div class="checkbox-area all-check">
								<input type="checkbox" name="check-terms-all" id="check-terms-all" value="" class="checkbox-agree">
								<label for="check-terms-all">전체 동의</label>
							</div>
							<div class="checkbox-area">
								<input type="checkbox" name="checkbox-terms" id="checkbox-terms" value="" class="checkbox-agree" required>
								<span onclick="$('#terms-modal').addClass('show');">이용약관</span>
								<label for="checkbox-terms">동의 </label>
							</div>
							<div class="checkbox-area">
								<input type="checkbox" name="checkbox-terms" id="checkbox-privacy" value="" class="checkbox-agree" required>
								<span onclick="$('#privacy-modal').addClass('show');">개인정보처리방침</span>
								<label for="checkbox-privacy">동의 </label>
							</div>
						</div>
						<input type="submit" class="btn-submit" value="가입">
					</form>
					<!-- modal -->
					<div id="work-hours-modal" class="modal">
						<div class="container">
							<div class="modal-title">근무 가능 요일 및 시간</div>
							<div class="work-hours-form">
								<%
								String[] days = {"월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"};
								for (int i = 0; i < days.length; i++) {
									String num = String.valueOf(i + 1); // 1부터 시작하는 값
									String day = days[i];
								%>
								<div class="week-area">
									<div class="check-area">
										<input type="checkbox" name="work-hours-week" id="work_hours_<%=num%>" value="<%=num%>">
										<label for="work_hours_<%=num%>"><%=day%></label>
									</div>
									<div class="time-area">
										<div class="time-select-area">
											<select name="work_hours_<%=num%>_s" disabled>
												<%
												for (int hour = 9; hour <= 21; hour++) {
													String hourStr = String.format("%02d:00", hour);
													out.println("<option value=\"" + hourStr + "\">" + hourStr + "</option>");
												}
												%>
											</select>
											<span>~</span>
											<select name="work_hours_<%=num%>_e" disabled>
												<%
												for (int hour = 9; hour <= 21; hour++) {
													String hourStr = String.format("%02d:00", hour);
													out.println("<option value=\"" + hourStr + "\">" + hourStr + "</option>");
												}
												%>
											</select>
										</div>
									</div>
								</div>
								<%
								}
								%>
								<button type="button" class="btn-enter" id="btn-work-hours-enter">입력</button>
							</div>
							<button type="button" class="btn-close-modal">
								<img src="${pageContext.request.contextPath }/resources/img/iconClose.png" alt="닫기 버튼">
							</button>
						</div>
					</div>
					<!-- //modal -->
					<!-- modal -->
					<div id="terms-modal" class="modal terms">
						<div class="container">
							<div class="modal-title">이용약관</div>
							<div class="terms-content">
								<h6>제1조 (목적)</h6>
								<p>이 약관은 '수수마' (이하 '회사')가 제공하는 모든 서비스(이하 '서비스')의 이용조건 및 절차, 이용자와 회사의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.</p>

								<h6>제2조 (정의)</h6>
								<p>
									1. '웹사이트'란 회사가 서비스를 이용자에게 제공하기 위하여 설정한 온라인 플랫폼을 말합니다.
									<br>
									2. '이용자'란 웹사이트에 접속하여 이 약관에 따라 회사가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.
									<br>
									3. '회원'이란 웹사이트에 개인정보를 제공하여 회원등록을 한 자로서, 회사의 정보를 지속적으로 제공받으며 서비스를 계속적으로 이용할 수 있는 자를 말합니다.
									<br>
									4. '비회원'이란 회원에 가입하지 않고 회사가 제공하는 서비스를 이용하는 자를 말합니다.
								</p>

								<h6>제3조 (약관의 명시와 개정)</h6>
								<p>
									1. 회사는 이 약관의 내용을 웹사이트의 초기 서비스화면에 게시합니다.
									<br>
									2. 회사는 약관을 개정할 경우, 적용일자 및 개정사유를 명시하여 적용일자 7일 이전부터 적용일자 전일까지 공지합니다.
								</p>

								<h6>제4조 (서비스의 제공 및 변경)</h6>
								<p>
									1. 회사는 다음과 같은 업무를 수행합니다:
									<br>
									- 정보 제공
									<br>
									- 콘텐츠 제공
									<br>
									- 기타 회사가 정하는 업무
									<br>
									2. 회사는 필요에 따라 서비스의 내용을 변경할 수 있으며, 이 경우 변경된 서비스의 내용 및 제공일자를 명시하여 이용자에게 통지합니다.
								</p>

								<h6>제5조 (서비스의 중단)</h6>
								<p>회사는 컴퓨터 등 정보통신설비의 보수점검, 교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.</p>

							</div>
							<button type="button" class="btn-close-modal">
								<img src="${pageContext.request.contextPath }/resources/img/iconClose.png" alt="닫기 버튼">
							</button>
						</div>
					</div>
					<!-- //modal -->
					<!-- modal -->
					<div id="privacy-modal" class="modal terms">
						<div class="container">
							<div class="modal-title">개인정보처리방침</div>
							<div class="terms-content">
								<h6>제1조 (개인정보의 수집 및 이용 목적)</h6>
								<p>회사는 다음의 목적을 위하여 개인정보를 수집 및 이용합니다: 서비스 제공 및 운영, 회원관리, 고객 문의 및 불만 처리.</p>

								<h6>제2조 (수집하는 개인정보 항목)</h6>
								<p>회사는 회원가입, 상담, 서비스 신청 등을 위해 아래와 같은 개인정보를 수집할 수 있습니다: 이메일 주소, 비밀번호, 이름 (선택사항).</p>

								<h6>제3조 (개인정보의 보유 및 이용기간)</h6>
								<p>회사는 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 법령에 따라 보존해야 하는 경우에는 그러하지 아니합니다.</p>

								<h6>제4조 (개인정보의 제3자 제공)</h6>
								<p>
									회사는 이용자의 개인정보를 원칙적으로 외부에 제공하지 않습니다. 다만, 아래의 경우에는 예외로 합니다:
									<br>
									- 이용자가 사전에 동의한 경우
									<br>
									- 법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우.
								</p>

								<h6>제5조 (개인정보의 안전성 확보 조치)</h6>
								<p>
									회사는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다:
									<br>
									- 관리적 조치: 내부관리계획 수립 및 시행
									<br>
									- 기술적 조치: 개인정보처리시스템 등의 접근권한 관리.
								</p>

								<h6>제6조 (개인정보 보호책임자)</h6>
								<p>
									회사는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 이용자의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다:
									<br>
									- 개인정보 보호책임자: [홍길동]
									<br>
									- 연락처: [이메일 주소].
								</p>

								<p>이 약관과 개인정보처리방침은 [날짜]부터 적용됩니다.</p>
							</div>
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