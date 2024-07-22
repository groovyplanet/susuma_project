<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp"%>
<style>
.filters, .search-filters {
	display: flex;
	justify-content: center;
	margin: 20px 0;
}

.filter, .search-filter {
	margin: 0 10px;
}

.filters {
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
}

.filter {
	margin: 10px;
}

.filter label {
	margin-right: 10px;
	font-weight: bold;
	color: #333;
}

.filter select, .search-filter input, .search-filter select {
	padding: 8px 12px;
	border-radius: 5px;
	border: 1px solid #ddd;
	transition: border-color 0.3s ease;
}

.filter select:focus, .search-filter input:focus, .search-filter select:focus
	{
	border-color: #aaa;
	outline: none;
}

.search-filters button {
	background-color: #F49D00;
	border: 1px solid #F49D00;
	color: white;
	padding: 10px 10px;
	border-radius: 15px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.search-filters button:hover {
	background-color: #D98C00;
}

.technician {
	border: 1px solid #ddd;
	margin: 10px;
	padding: 20px;
	width: 300px;
	text-align: center;
	transition: transform 0.3s ease-in-out;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	background-color: #fff;
}

.technician:hover {
	transform: translateY(-5px);
	box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
}

.technician img {
	width: 100px;
	height: 100px;
	border-radius: 50%;
	margin-bottom: 10px;
}

.search-filters {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 20px 0;
}

.search-filter {
	margin: 0 10px;
}

.search-filter label {
	margin-right: 10px;
	font-weight: bold;
	color: #333;
}

.search-filters button {
	background-color: #F49D00;
	border: 1px solid #F49D00;
	color: white;
	padding: 10px 10px;
	border-radius: 15px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.search-filters button:hover {
	background-color: #D98C00;
}
/* CSS 추가 */
#sub-category {
	pointer-events: none; /* 상위 카테고리를 선택하지 않았을 때, 하위 카테고리 선택 불가능하도록 설정 */
	opacity: 0.5; /* 선택할 수 없는 상태에서는 투명도를 조정하여 비활성화된 상태를 시각적으로 구분 */
}

#sub-category-filter {
	margin-top: 10px; /* 하위 카테고리 필터의 상단 여백 설정 */
}

.main-area {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 10px;
}

.filter, .search-filters {
	display: flex;
	flex-direction: column;
	margin-right: 10px;
}

.search-filters {
	flex-direction: row;
	align-items: center;
	margin: 0px;
}

.search-filter {
	margin-right: 10px;
}

.distance-radio-area {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 20px 0;
}

.distance-radio-area input[type="radio"] {
	display: none;
}

.main-area {
	margin-top: 10px;
}

.distance-radio-area label {
	background-color: #f8f9fa;
	border: 1px solid #ced4da;
	border-radius: 5px;
	padding: 10px 15px;
	margin: 0 5px;
	cursor: pointer;
	transition: background-color 0.3s ease, color 0.3s ease;
}

.distance-radio-area input[type="radio"]:checked+label {
	background-color: #F49D00;
	color: white;
	border-color: #F49D00;
}

.distance-radio-area label:hover {
	background-color: #e9ecef;
}
</style>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container filter">
			<div class="main-area">
				<form id="filter-form" action="search.jsp" method="GET">
					<div class="filter">
						<label for="category">상위 카테고리</label>
						<select id="category" onchange="handleCategoryChange()">
							<option value="">선택</option>
							<option value="가전제품">가전제품</option>
							<option value="문/창문">문/창문</option>
							<option value="수도/보일러/전기">수도/보일러/전기</option>
							<option value="가구">가구</option>
							<option value="기타 설치/수리">기타 설치/수리</option>
						</select>
					</div>
					<div class="filter" id="sub-category-filter" style="display: none;">
						<label for="sub-category">하위 카테고리</label>
						<select id="sub-category">
							<option value="">선택</option>
						</select>
					</div>
					<div class="filter">
						<label for="region">지역</label>
						<select id="region">
							<option value="">선택</option>
							<option value="강남구">강남구</option>
							<option value="강동구">강동구</option>
							<option value="강북구">강북구</option>
							<option value="강서구">강서구</option>
							<option value="관악구">관악구</option>
							<option value="광진구">광진구</option>
							<option value="구로구">구로구</option>
							<option value="금천구">금천구</option>
							<option value="노원구">노원구</option>
							<option value="도봉구">도봉구</option>
							<option value="동대문구">동대문구</option>
							<option value="동작구">동작구</option>
							<option value="마포구">마포구</option>
							<option value="서대문구">서대문구</option>
							<option value="서초구">서초구</option>
							<option value="성동구">성동구</option>
							<option value="성북구">성북구</option>
							<option value="송파구">송파구</option>
							<option value="양천구">양천구</option>
							<option value="영등포구">영등포구</option>
							<option value="용산구">용산구</option>
							<option value="은평구">은평구</option>
							<option value="종로구">종로구</option>
							<option value="중구">중구</option>
							<option value="중랑구">중랑구</option>
						</select>
					</div>
					<div class="search-filters">
						<div class="search-filter">
							<label for="distance">가까운 거리 필터</label>
						</div>
						<div class="distance-radio-area">
							<input type="radio" name="max_distance" value="5" id="distance-5" checked onchange="handleRadioChange(event)">
							<label for="distance-5" class="distance-radio selected">5km 이내</label>

							<input type="radio" name="max_distance" value="10" id="distance-10" onchange="handleRadioChange(event)">
							<label for="distance-10" class="distance-radio">10km 이내</label>

							<input type="radio" name="max_distance" value="20" id="distance-20" onchange="handleRadioChange(event)">
							<label for="distance-20" class="distance-radio">20km 이내</label>

							<input type="radio" name="max_distance" value="50" id="distance-50" onchange="handleRadioChange(event)">
							<label for="distance-50" class="distance-radio">50km 이내</label>

							<input type="radio" name="max_distance" value="100" id="distance-100" onchange="handleRadioChange(event)">
							<label for="distance-100" class="distance-radio">100km 이내</label>
						</div>

						<div class="search-filter">
							<label for="rating-filter">별점순</label>
							<select id="rating-filter">
								<option value="desc">높은 순</option>
								<option value="asc">낮은 순</option>
							</select>
						</div>
						<button type="button" onclick="applyFilters()">검색</button>
					</div>
				</form>

				<c:forEach var="dto" items="${list}">
					<a class="technician" style="text-decoration: none; color: black;" href="${pageContext.request.contextPath }/user/master_view.jsp?meNo=${dto.meNo}">
						<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="홍길동">
						<h3>${dto.name}</h3>
						<p>별점: 4.9 (114)</p>
						<p>지역: 서울시 강남구 (10km 이내 가능)</p>
						<p>안녕하세요 저는 백엔드 경력 30년의 경력을 보유했습니다.</p>
					</a>
				</c:forEach>

			</div>
		</div>


	</section>

	<%@ include file="../include/footer.jsp"%>
	<script>
		$(document)
				.ready(
						function() {
							// 초기 로딩 시 실행
							handleCategoryChange();

							$('#category').change(function() {
								handleCategoryChange();
							});

							function handleCategoryChange() {
								var category = $('#category').val();
								var subCategorySelect = $('#sub-category');

								// 기존 옵션 제거
								subCategorySelect.find('option').not(':first')
										.remove();

								switch (category) {
								case '가전제품':
									subCategorySelect.prop('disabled', false)
											.css('opacity', '1').css(
													'pointer-events', 'auto');
									subCategorySelect.append($('<option>', {
										value : '냉장고 설치 및 수리',
										text : '냉장고 설치 및 수리'
									}));
									subCategorySelect.append($('<option>', {
										value : '세탁기 설치 및 수리',
										text : '세탁기 설치 및 수리'
									}));
									subCategorySelect.append($('<option>', {
										value : 'CCTV 설치',
										text : 'CCTV 설치'
									}));
									break;
								case '문/창문':
									subCategorySelect.prop('disabled', false)
											.css('opacity', '1').css(
													'pointer-events', 'auto');
									subCategorySelect.append($('<option>', {
										value : '문 설치 및 수리',
										text : '문 설치 및 수리'
									}));
									subCategorySelect.append($('<option>', {
										value : '창문 설치 및 수리',
										text : '창문 설치 및 수리'
									}));
									break;
								case '수도/보일러/전기':
									subCategorySelect.prop('disabled', false)
											.css('opacity', '1').css(
													'pointer-events', 'auto');
									subCategorySelect.append($('<option>', {
										value : '수도관 설치 및 수리',
										text : '수도관 설치 및 수리'
									}));
									subCategorySelect.append($('<option>', {
										value : '보일러 설치 및 수리',
										text : '보일러 설치 및 수리'
									}));
									subCategorySelect.append($('<option>', {
										value : '전기 배선 설치 및 수리',
										text : '전기 배선 설치 및 수리'
									}));
									break;
								case '가구':
									subCategorySelect.prop('disabled', false)
											.css('opacity', '1').css(
													'pointer-events', 'auto');
									subCategorySelect.append($('<option>', {
										value : '가구 수리',
										text : '가구 수리'
									}));
									subCategorySelect.append($('<option>', {
										value : '가구 설치',
										text : '가구 설치'
									}));
									subCategorySelect.append($('<option>', {
										value : '맞춤형 가구 제작/리폼',
										text : '맞춤형 가구 제작/리폼'
									}));
									break;
								case '기타 설치/수리':
									subCategorySelect.prop('disabled', false)
											.css('opacity', '1').css(
													'pointer-events', 'auto');
									subCategorySelect.append($('<option>', {
										value : '엘리베이터 설치/수리',
										text : '엘리베이터 설치/수리'
									}));
									subCategorySelect.append($('<option>', {
										value : '가정용 엘리베이터 설치/수리',
										text : '가정용 엘리베이터 설치/수리'
									}));
									subCategorySelect.append($('<option>', {
										value : '지붕 설치/수리',
										text : '지붕 설치/수리'
									}));
									break;
								default:
									subCategorySelect.prop('disabled', true)
											.css('opacity', '0.5').css(
													'pointer-events', 'none');
									subCategorySelect.append($('<option>', {
										value : '',
										text : '선택'
									}));
									break;
								}
							}

							// 초기 로딩 시 하위 카테고리 보이도록 설정
							$('#sub-category-filter').show();
						});

		$(document).ready(
				function() {
					// 초기 로딩 시 실행
					handleCategoryChange();

					$('#category').change(function() {
						handleCategoryChange();
					});

					function handleCategoryChange() {
						var category = $('#category').val();
						var subCategorySelect = $('#sub-category');

						if (category === '') {
							// 상위 카테고리가 선택되지 않은 경우
							subCategorySelect.prop('disabled', true).css(
									'opacity', '0.5').css('pointer-events',
									'none');
						} else {
							// 상위 카테고리가 선택된 경우
							subCategorySelect.prop('disabled', false).css(
									'opacity', '1').css('pointer-events',
									'auto');
						}
					}
				});

		$(document).ready(function() {
			$('.distance-radio-area input[type="radio"]').change(function() {
				// 기존에 체크된 라벨의 불을 끄기 위해 모든 라벨의 클래스 제거
				$('.distance-radio-area label').removeClass('checked');

				// 체크된 라벨에만 클래스 추가
				if ($(this).is(':checked')) {
					$(this).next('label').addClass('checked');
				}
			});
		});

		function applyFilters() {
			const form = document.getElementById('filter-form');
			const xhr = new XMLHttpRequest();

			xhr.onload = function() {
				if (xhr.status === 200) {
					const response = xhr.responseText;
					if (response.trim() === 'no_results') {
						alert('해당하는 필터의 기사님이 존재하지 않습니다.');
					} else {
						// 검색 결과를 처리하는 코드 추가
					}
				} else {
					alert('서버 오류가 발생했습니다.');
				}
			};

			xhr.onerror = function() {
				alert('서버에 연결할 수 없습니다.');
			};

			xhr.open('GET', form.action + '?'
					+ new URLSearchParams(new FormData(form)).toString(), true);
			xhr.send();
		}
	</script>

</body>

</html>