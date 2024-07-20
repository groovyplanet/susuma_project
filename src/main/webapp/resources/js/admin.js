/*
member_list.jsp 회원 목록
*/
var member_list = document.getElementById('member_list');
if (member_list) {
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
	board_list.onclick = function(e) {
		if (e.target.tagName != "TD") return;
		location.href = "view.board?boNo=" + e.target.closest("tr").dataset.bono;
	}
}