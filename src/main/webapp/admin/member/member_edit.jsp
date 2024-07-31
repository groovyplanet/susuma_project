<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
            console.log(22);
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

	<div class="container">
		<%@ include file="../include/snb.jsp"%>
		<div class="content_wrap">
			<form name="EditForm" method="post" action="editForm.member" enctype="multipart/form-data">
				<input type="hidden" name="meNo" value="${dto.meNo}">
				<input type="hidden" name="type" value="${type}">
				<div class="title_wrap">
					<span>${type=='user'?'의뢰인':'수리기사' } ${dto==null?'등록':'수정' }</span>
					<div class="btn_wrap">
						<a href="list.member?type=${type }" class="btn black">
							<i class="bi bi-list-ul"></i>
							목록
						</a>
						<button type="submit" class="btn">
							<i class="bi bi-check-lg"></i>
							완료
						</button>
					</div>
				</div>
				<div class="table_wrap">
					<table class="view write" id="member_view">
						<tr>
							<c:choose>
								<c:when test="${empty dto}">
									<th>프로필 사진</th>
									<td>
										<div class="img_wrap">
											<input type="file" name="profilePhoto">
										</div>
									</td>
									<td></td>
									<td></td>
								</c:when>
								<c:otherwise>
									<th>회원 번호</th>
									<td>${dto.meNo}</td>
									<th>프로필 사진</th>
									<td>
										<div class="img_wrap">
											<c:choose>
												<c:when test="${dto.profilePhotoImg == '' }">
													<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile">
												</c:when>
												<c:otherwise>
													<img src="data:image/png;base64,${dto.profilePhotoImg }" alt="Profile Picture" class="profile">
												</c:otherwise>
											</c:choose>
											<input type="file" name="profilePhoto">
										</div>
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<th class="wp13">이메일</th>
							<td class="wp37">
								<input type="text" name="email" value="${dto.email}" required placeholder="aaa@aaa.aaa">
							</td>
							<td></td>
							<td></td>
							<!-- <th class="wp13">비밀번호</th>
							<td>
								<input type="text" name="pw" value="${dto.pw}" required>
							</td> -->
						</tr>
						<tr>
							<th>이름</th>
							<td>
								<input type="text" name="name" value="${dto.name}" required>
							</td>
							<th>연락처</th>
							<td>
								<input type="text" name="phoneNum" value="${dto.phoneNum}" placeholder="010-0000-0000">
							</td>
						</tr>
						<tr>
							<th>
								<div style="display: flex; gap: 2px; align-items: center;">
									주소
									<button type="button" id="btn-zipcode" class="btn-form btn-zipcode" onclick="execDaumPostcode()" style="border: none; cursor: pointer; padding: 2px 4px; background: none;">
										<i class="bi bi-search"></i>
									</button>
								</div>
							</th>
							<td>
								<input type="text" name="address" value="${dto.address}">
							</td>
							<th>상세 주소</th>
							<td>
								<input type="text" name="addressDetail" value="${dto.addressDetail}">
							</td>
						</tr>
						<tr>
							<th>위도</th>
							<td>
								<input type="text" name="latitude" value="${dto.latitude}" placeholder="0.0">
							</td>
							<th>경도</th>
							<td>
								<input type="text" name="longitude" value="${dto.longitude}" placeholder="0.0">
							</td>
						</tr>
						<c:if test="${type == 'master' }">
							<tr>
								<th>수리기사 가입 승인여부</th>
								<td>
									<div class="radio_wrap">
										<input type="radio" id="joinApprovalYes" name="joinApproval" value="Y" ${dto.joinApproval == 'Y' || dto==null ? 'checked' : ''}>
										<label for="joinApprovalYes">승인</label>
										<input type="radio" id="joinApprovalNo" name="joinApproval" value="N" ${dto.joinApproval == 'N' ? 'checked' : ''}>
										<label for="joinApprovalNo">미승인</label>
									</div>
								</td>
								<th>수리기사 가입 승인일시</th>
								<td>
									<c:choose>
										<c:when test="${empty dto.joinApprovalTime}">
									        -
									    </c:when>
										<c:otherwise>
											<fmt:formatDate value="${dto.joinApprovalTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr>
								<th>수리 분야</th>
								<td>
									<div class="select_wrap">
										<select id="category" onchange="handleCategoryChange()">
											<option value="">선택</option>
											<c:forEach var="categoryDto" items="${CategoryMainList}">
												<option value="${categoryDto.caNo }" ${dto.caRootNo == categoryDto.caNo ? 'selected' : ''}>${categoryDto.caName }</option>
											</c:forEach>
										</select>
										<select id="sub-category" name="caNo">
											<option value="">선택</option>
											<c:forEach var="categorySubDto" items="${CategorySubList}">
												<option value="${categorySubDto.caNo }" ${dto.caNo == categorySubDto.caNo ? 'selected' : ''}>${categorySubDto.caName }</option>
											</c:forEach>
										</select>
									</div>
								</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<th>사업자등록번호</th>
								<td>
									<input type="text" name="businessNumber" value="${dto.businessNumber}" placeholder="123-45-67890" required>
								</td>
								<th>수리기사 이동가능거리</th>
								<td>
									<input type="text" name="maxDistance" value="${dto.maxDistance}" placeholder="0">
								</td>
							</tr>
							<tr>
								<th>수리기사 한줄소개</th>
								<td>
									<input type="text" name="shortDescription" value="${dto.shortDescription}">
								</td>
								<th>수리기사 포인트</th>
								<td>
									<input type="text" name="point" value="${dto.point}" placeholder="0">
								</td>
							</tr>
							<tr>
								<th>근무가능 요일별 시간<br>(09시~21시)</th>
								<td>
									<c:choose>
										<c:when test="${dto == null }"><!-- 신규 등록 시 기본값 설정 -->
											<textarea name="workHours" class="mh160" required>월 09:00 ~ 21:00
화 09:00 ~ 21:00
수 09:00 ~ 21:00
목 09:00 ~ 21:00
금 09:00 ~ 21:00
토 09:00 ~ 21:00
일 09:00 ~ 21:00</textarea>
										</c:when>
										<c:otherwise>
											<textarea name="workHours" class="mh160" required>${dto.workHours}</textarea>
										</c:otherwise>
									</c:choose>
								</td>
								<th>수리 상세 내용</th>
								<td>
									<textarea name="description" class="mh160">${dto.description}</textarea>
								</td>
							</tr>
						</c:if>
						<tr>
							<th>이메일 알림 수신 여부</th>
							<td>
								<div class="radio_wrap">
									<input type="radio" id="joinApprovalYes" name="emailNotification" value="Y" ${dto.emailNotification == 'Y' || dto==null ? 'checked' : ''}>
									<label for="emailNotificationYes">수신</label>
									<input type="radio" id="emailNotificationNo" name="emailNotification" value="N" ${dto.emailNotification == 'N' ? 'checked' : ''}>
									<label for="emailNotificationNo">미수신</label>
								</div>
							</td>
							<th>회원 상태</th>
							<td>
								<div class="radio_wrap">
									<input type="radio" id="statusNormal" name="status" value="NORMAL" ${dto.status == 'NORMAL' || dto==null ? 'checked' : ''}>
									<label for="statusNormal">정상</label>
									<input type="radio" id="statusExit" name="status" value="EXIT" ${dto.status == 'EXIT' ? 'checked' : ''}>
									<label for="statusExit">탈퇴</label>
								</div>
							</td>
						</tr>
						<c:if test="${dto != null }">
							<tr>
								<th>가입 일시</th>
								<td>
									<fmt:formatDate value="${dto.insertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초" />
								</td>
								<th>수정 일시</th>
								<td>
									<c:choose>
										<c:when test="${empty dto.updateTime}">
									        -
									    </c:when>
										<c:otherwise>
											<fmt:formatDate value="${dto.updateTime}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초" />
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:if>
					</table>
				</div>
			</form>
		</div>
	</div>


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
                            document.querySelector('input[name="latitude"]').value = latitude;
                            document.querySelector('input[name="longitude"]').value = longitude;
                        }
                    });

                    document.querySelector('input[name="address"]').value = addr; // 주소 값 넣기
                    document.querySelector('input[name="addressDetail"]').focus(); // 상세주소 포커스
                }
            }).open();
        }
    </script>
	<!-- //api -->
</body>

</html>
