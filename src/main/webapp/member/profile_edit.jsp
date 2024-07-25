<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../include/head.jsp"%>
<script>

function handleCategoryChange() {
    const categorySelect = document.getElementById('category');
    const subCategorySelect = document.getElementById('sub-category');
    const selectedCategory = categorySelect.value;

    // 선택된 상위 카테고리가 없는 경우, 하위 카테고리 초기화
    if (!selectedCategory) {
        subCategorySelect.innerHTML = '<option value="">선택</option>';
        return;
    }

    // AJAX 요청을 통해 하위 카테고리 가져오기
	fetch("getCategory.ajax?rootNo="+selectedCategory)
	.then(function(response) {
		return response.json();
	})
	.then(function(data) {
        subCategorySelect.innerHTML = '<option value="">선택</option>';
        data.forEach(function(subCategory) {
            const option = document.createElement('option');
            option.value = subCategory.caNo; // 하위 카테고리 번호
            option.textContent = subCategory.caName; // 하위 카테고리 이름
            subCategorySelect.appendChild(option);
        });
        subCategorySelect.focus();
	})
    .catch(function(error) {
        console.error('Fetch error:', error);
    });
}
</script>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb.jsp"%>
			<div class="content profile-edit">
				<div class="join-form profile-edit-form">
					<form action="editForm.member" method="post" id="form-profile-edit">
						<input type="hidden" name="meNo" value="${dto.meNo}">
						<input type="hidden" name="type" value="${dto.type}">
						<div class="img-profile-area">
							<label for="profile_photo" class="label-profile_photo">
								<img id="img-profile" class="img-profile" src="../resources/img/iconProfileDefault.png" alt="Profile Image">
								<span class="img-profile-overlay">프로필 변경</span>
								<img src="${pageContext.request.contextPath }/resources/img/icon-edit.png" alt="수정 아이콘" class="icon">
							</label>
							<input type="file" class="input-file" id="profile_photo" name="profilePhoto" onchange="readURL(this);" style="display: none;">
						</div>
						<div class="input-area">
							<label for="email">이메일</label>
							<input type="text" class="input-field" value="${dto.email}" autocomplete="no" name="email" id="email" disabled>
						</div>
						<div class="input-area">
							<label for="">비밀번호</label>
							<button type="button" id="btn-pw-change" class="btn-form btn-pw-change" onclick="$('#pw-change-modal').addClass('show');">
								비밀번호 변경
								<i class="bi bi-chevron-right"></i>
							</button>
						</div>
						<div class="input-area">
							<label for="name" class="required">이름</label>
							<input type="text" class="input-field " placeholder="이름을 입력해주세요." autocomplete="no" name="name" id="name" required value="${dto.name}">
						</div>
						<div class="input-area">
							<label for="phoneNum">연락처</label>
							<input type="text" class="input-field" placeholder="연락처를 입력해주세요." autocomplete="no" name="phoneNum" id="phoneNum" maxlength="13" value="${dto.phoneNum}">
							<p class="caption-error">올바른 형식이 아닙니다.</p>
						</div>
						<div class="input-area">
							<label for="address">주소</label>
							<input type="hidden" name="address" value="${dto.address}">
							<input type="hidden" name="latitude" value="${dto.latitude}">
							<input type="hidden" name="longitude" value="${dto.longitude}">
							<button type="button" id="btn-zipcode" class="btn-form btn-zipcode" onclick="execDaumPostcode()">
								<p style="text-align: left;">${dto.address}</p>
							</button>
							<input type="text" class="input-field" placeholder="상세주소를 입력해주세요." autocomplete="no" name="addressDetail" value="${dto.addressDetail}">
						</div>
						<div id="master-info-area" style="display: ${dto.type=='master' ? 'block' : 'none'};">
							<div class="input-area">
								<label for="businessNumber" class="required">사업자등록번호</label>
								<input type="text" class="input-field" placeholder="사업자등록번호를 입력해주세요." autocomplete="no" name="businessNumber" id="businessNumber" maxlength="12" value="${dto.businessNumber}">
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
								<label>근무 가능 요일 및 시간</label>
								<button type="button" id="btn-work_hours" class="btn-form btn-work_hours" onclick="$('#work-hours-modal').addClass('show');">
									시간 입력
									<i class="bi bi-chevron-right"></i>
								</button>
								<div id="work-hours-list" class="work-hours-list">
									<!-- 사용자가 모달에서 입력한 요일/시작시간/종료시간 표시 -->
									<input type="hidden" name="workHours" value="${dto.workHours}">
									<p>월 09:00 ~ 20:00</p>
									<p>수 10:00 ~ 20:00</p>
									<p>금 10:00 ~ 20:00</p>
								</div>
							</div>
							<div class="input-area">
								<label for="max_distance">이동 가능 거리</label>
								<div class="distance-radio-area">
									<input type="radio" name="max_distance" value="5" id="distanc-5" checked>
									<input type="radio" name="max_distance" value="10" id="distanc-10">
									<input type="radio" name="max_distance" value="20" id="distanc-20">
									<input type="radio" name="max_distance" value="50" id="distanc-50">
									<input type="radio" name="max_distance" value="100" id="distanc-100">
									<label for="distanc-5" class="distance-radio active">5km 이내</label>
									<label for="distanc-10" class="distance-radio">10km 이내</label>
									<label for="distanc-20" class="distance-radio">20km 이내</label>
									<label for="distanc-50" class="distance-radio">50km 이내</label>
									<label for="distanc-100" class="distance-radio">100km 이내</label>
								</div>
							</div>
							<div class="input-area">
								<label for="shortDescription">한 줄 소개</label>
								<input type="text" class="input-field" placeholder="고객에게 보여질 한 줄 소개 멘트를 입력해주세요." autocomplete="no" name="shortDescription" id="shortDescription" value="${dto.shortDescription}">
							</div>
							<div class="input-area">
								<label for="description">수리 상세 내용</label>
								<textarea class="input-field" placeholder="고객에게 보여질 수리 상세 내용을 입력해주세요." name="description">${dto.description}</textarea>
							</div>
						</div>
						<!-- //master-info-area -->
						<div class="input-area">
							<label>이메일 수신 동의</label>
							<div class="checkbox-area">
								<input type="checkbox" name="emailNotification" id="emailNotification" value="Y" class="checkbox-agree" ${dto.emailNotification == 'Y' ? 'checked' : ''}>
								<label for="emailNotification">SUSUMA 이용과 관련한 알림을 이메일로도 받아보실 수 있습니다.</label>
							</div>
						</div>
						<input type="submit" class="btn-submit" value="회원정보 수정">
						<div class="exit-area">
							<a href="exit.member">
								회원탈퇴
								<i class="bi bi-chevron-right"></i>
							</a>
						</div>
					</form>
					<!-- modal -->
					<div id="work-hours-modal" class="modal">
						<div class="container">
							<div class="modal-title">근무 가능 요일 및 시간</div>
							<div class="work-hours-form">
								<div class="week-area">
									<div class="check-area">
										<input type="checkbox" name="work-hours-week" id="work_hours_1" value="1">
										<label for="work_hours_1">월요일</label>
									</div>
									<div class="time-area">
										<div class="time-select-area">
											<select name="work_hours_1_s" disabled>
												<option value="09">09:00</option>
												<option value="1010">10:00</option>
											</select>
											<span>~</span>
											<select name="work_hours_1_e" disabled>
												<option value="20">20:00</option>
												<option value="21">21:00</option>
											</select>
										</div>
									</div>
								</div>
								<div class="week-area">
									<div class="check-area">
										<input type="checkbox" name="work-hours-week" id="work_hours_2" value="2">
										<label for="work_hours_2">화요일</label>
									</div>
									<div class="time-area">
										<div class="time-select-area">
											<select name="work_hours_2_s" disabled>
												<option value="10">10:00</option>
											</select>
											<span>~</span>
											<select name="work_hours_2_e" disabled>
												<option value="20">20:00</option>
											</select>
										</div>
									</div>
								</div>
								<div class="week-area">
									<div class="check-area">
										<input type="checkbox" name="work-hours-week" id="work_hours_3" value="3">
										<label for="work_hours_3">수요일</label>
									</div>
									<div class="time-area">
										<div class="time-select-area">
											<select name="work_hours_3_s" disabled>
												<option value="10">10:00</option>
											</select>
											<span>~</span>
											<select name="work_hours_3_e" disabled>
												<option value="20">20:00</option>
											</select>
										</div>
									</div>
								</div>
								<div class="week-area">
									<div class="check-area">
										<input type="checkbox" name="work-hours-week" id="work_hours_4" value="4">
										<label for="work_hours_4">목요일</label>
									</div>
									<div class="time-area">
										<div class="time-select-area">
											<select name="work_hours_4_s" disabled>
												<option value="10">10:00</option>
											</select>
											<span>~</span>
											<select name="work_hours_4_e" disabled>
												<option value="20">20:00</option>
											</select>
										</div>
									</div>
								</div>
								<div class="week-area">
									<div class="check-area">
										<input type="checkbox" name="work-hours-week" id="work_hours_5" value="5">
										<label for="work_hours_5">금요일</label>
									</div>
									<div class="time-area">
										<div class="time-select-area">
											<select name="work_hours_5_s" disabled>
												<option value="10">10:00</option>
											</select>
											<span>~</span>
											<select name="work_hours_5_e" disabled>
												<option value="20">20:00</option>
											</select>
										</div>
									</div>
								</div>
								<div class="week-area">
									<div class="check-area">
										<input type="checkbox" name="work-hours-week" id="work_hours_6" value="6">
										<label for="work_hours_6">토요일</label>
									</div>
									<div class="time-area">
										<div class="time-select-area">
											<select name="work_hours_6_s" disabled>
												<option value="10">10:00</option>
											</select>
											<span>~</span>
											<select name="work_hours_6_e" disabled>
												<option value="20">20:00</option>
											</select>
										</div>
									</div>
								</div>
								<div class="week-area">
									<div class="check-area">
										<input type="checkbox" name="work-hours-week" id="work_hours_7" value="7">
										<label for="work_hours_7">일요일</label>
									</div>
									<div class="time-area">
										<div class="time-select-area">
											<select name="work_hours_7_s" disabled>
												<option value="10">10:00</option>
											</select>
											<span>~</span>
											<select name="work_hours_7_e" disabled>
												<option value="20">20:00</option>
											</select>
										</div>
									</div>
								</div>
								<button type="button" class="btn-enter" id="btn-work-hours-enter">입력</button>
							</div>
							<button type="button" class="btn-close-modal">
								<img src="${pageContext.request.contextPath }/resources/img/iconClose.png" alt="닫기 버튼">
							</button>
						</div>
					</div>
					<!-- 비밀번호 변경 모달 -->
					<div id="pw-change-modal" class="modal">
						<div class="container">
							<div class="modal-title">비밀번호 변경</div>
							<div class="pw-change-form">
								<form action="changePwForm.member" method="post" id="form-pw-change">
									<div class="input-area">
										<label for="pw_old">현재 비밀번호</label>
										<input type="password" class="input-field" placeholder="현재 비밀번호를 입력해주세요." autocomplete="no" name="pw_old" id="pw_old" required>
										<p class="caption-error">비밀번호가 일치하지 않습니다.</p>
										<!-- 비밀번호가 일치하지 않을 경우 input-area에 class error 추가 -->
										<p class="caption-error">현재 비밀번호와 새로 입력한 비밀번호가 동일합니다.</p>
										<!-- 비밀번호가 현재 비밀번호가 동일할 경우 input-area에 class error 추가 -->
									</div>
									<div class="input-area">
										<label for="pw">변경할 비밀번호</label>
										<input type="password" class="input-field" placeholder="변경하실 비밀번호를 입력해주세요." autocomplete="no" name="pw" id="pw" required>
										<input type="password" class="input-field" placeholder="변경하실 비밀번호를 다시 한번 입력해주세요." autocomplete="no" name="pw_re" id="pw_re" class="pw_re" required>
										<p class="caption-error">영문+숫자 조합 8자리 이상 입력해주세요.</p>
										<p class="caption-error-re">비밀번호가 일치하지 않습니다.</p>
									</div>
									<button type="submit" class="btn-enter" id="btn-pw-change-enter">변경</button>
								</form>
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

                    $("input[name=addressDetail]").focus(); // 상세주소 포커스
                }
            }).open();
        }
    </script>
	<!-- //api -->
	<script>
        function readURL(input) { // 프로필 사진 변경
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('img-profile').setAttribute('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        };
    </script>

</body>

</html>