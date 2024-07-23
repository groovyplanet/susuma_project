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




							<!-- db에서 가져온 list 반복문으로 출력 -->
							<c:forEach var="dtox" items="${CategoryMainList}">
								<option value="">${dtox.caName }</option>
							</c:forEach>


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

				<c:forEach var="dto" items="${memberList}">
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
		
	</script>

</body>

</html>