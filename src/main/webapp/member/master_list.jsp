<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

	<section class="main-section">
		<div class="container filter">
			<div class="main-area">
				<form id="filter-form" action="masterList.member" method="GET">
					<div class="filter">
						<label for="category">상위 카테고리</label>
						<select id="category" onchange="handleCategoryChange()">
							<option value="">선택</option>
							<c:forEach var="dtox" items="${CategoryMainList}">
								<option value="${dtox.caNo }">${dtox.caName }</option>
							</c:forEach>
						</select>
					</div>
					<div class="filter" id="sub-category-filter">
						<label for="sub-category">하위 카테고리</label>
						<select id="sub-category">
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
					<a class="technician" style="text-decoration: none; color: black;" href="${pageContext.request.contextPath }/member/masterView.member?meNo=${dto.meNo}">
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