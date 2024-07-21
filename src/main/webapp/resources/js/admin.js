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

	// 라디오 버튼(가입 승인 여부) 클릭 시 검색
	const radios = document.searchForm.querySelectorAll('input[name="join_approval"]');
	radios.forEach(radio => {
		radio.addEventListener('change', function() {
			document.searchForm.submit();
		});
	});
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

	// 라디오 버튼(답변 완료 여부) 클릭 시 검색
	const radios = document.searchForm.querySelectorAll('input[name="answerCheck"]');
	radios.forEach(radio => {
		radio.addEventListener('change', function() {
			document.searchForm.submit();
		});
	});
}