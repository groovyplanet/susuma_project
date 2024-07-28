<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
		fetch("getCategory.ajax?rootNo=" + selectedCategory).then(function(response) {
			return response.json();
		}).then(function(data) {
			subCategorySelect.innerHTML = '<option value="">선택</option>';
			data.forEach(function(subCategory) {
				const option = document.createElement('option');
				option.value = subCategory.caNo; // 하위 카테고리 번호
				option.textContent = subCategory.caName; // 하위 카테고리 이름
				subCategorySelect.appendChild(option);
			});
			subCategorySelect.focus();
		})
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
						<select id="sub-category" name="subCate">
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
						<c:choose>
							<c:when test="${dto.profilePhotoImg == '' }">
								<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile">
							</c:when>
							<c:otherwise>
								<img src="data:image/png;base64,${dto.profilePhotoImg }" alt="Profile Picture" class="profile">
							</c:otherwise>
						</c:choose>
						<h3>${dto.name}</h3>
						<div class="master-info">
							<c:if test="${dto.reviewCount > 0}">
								<p class="master-stars">
									<i class="bi bi-star-fill gold"></i>
									<strong>${dto.averageScore }</strong>
									<span class="review-count">(${dto.reviewCount })</span>
								</p>
							</c:if>
							<p>
								<c:set var="addressParts" value="${fn:split(dto.address, ' ')}" />
								<i class="bi bi-geo-alt"></i>${addressParts[0]}
								${addressParts[1]} (${dto.maxDistance}km 이내 가능)
							</p>
							<p>
								<span class="master-category">
									<span>${dto.caRootName }
										<i class="bi bi-chevron-right"></i>${dto.caName }</span>
								</span>
							</p>
							<p>${dto.shortDescription }</p>
						</div>
					</a>
				</c:forEach>

			</div>
		</div>


	</section>

	<%@ include file="../include/footer.jsp"%>
	<script>
		function applyFilters() {
			const form = document.getElementById('filter-form');
			form.submit();
		}
	</script>

</body>

</html>