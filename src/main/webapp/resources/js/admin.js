
/*
list.jsp (회원/게시물)목록
*/
function sort(sortField, sortOrder) {
	document.searchForm.sortField.value = sortField;
	document.searchForm.sortOrder.value = sortOrder;
	document.searchForm.submit();
}

function goPage(page) {
	document.searchForm.page.value = page;
	document.searchForm.submit();
}

// 라디오 버튼 클릭 시 검색
const radios = document.searchForm ? document.searchForm.querySelectorAll('input[type="radio"]') : [];
if (radios.length > 0) {
	radios.forEach(radio => {
		radio.addEventListener('change', function() {
			if (radio.name == 'rootNo') { // 상위 카테고리 변경 시
				const caNoAllRadio = document.getElementById('caNo_all');
				if (caNoAllRadio) {
					caNoAllRadio.checked = true; // 하위 카테고리가 있다면 초기화
				}
			}
			document.searchForm.submit();
		});
	});
}

/*
member_list.jsp 회원 목록
*/
var member_list = document.getElementById('member_list');
if (member_list) {
	// 사용자(행) 클릭 시 상세 화면으로 이동
	member_list.onclick = function(e) {
		if (e.target.tagName != "TD") return;
		location.href = "view.member?meNo=" + e.target.closest("tr").dataset.meno;
	}
}
/*
board_list.jsp 게시판 목록
*/
var board_list = document.getElementById('board_list');
if (board_list) {
	// 게시물(행) 클릭 시 상세 화면으로 이동
	board_list.onclick = function(e) {
		if (e.target.tagName != "TD") return;
		location.href = "view.board?boNo=" + e.target.closest("tr").dataset.bono;
	}
}