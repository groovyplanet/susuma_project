<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../include/head.jsp"%>
<script type="text/javascript" src="../../resources/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<div class="container">
		<%@ include file="../include/snb.jsp"%>
		<div class="content_wrap">
			<form name="writeForm" id="writeForm" method="post" action="updateForm.board">
				<div class="title_wrap">
					<span>${type=='notice'?'공지사항':type=='faq'?'FAQ':'1:1 문의' } 수정</span>
					<div class="btn_wrap">
						<a href="list.board?type=${type }" class="btn black">
							<i class="bi bi-list-ul"></i>
							목록
						</a>
						<button type="button" id="btn-submit" class="btn">
							<i class="bi bi-check-lg"></i>
							완료
						</button>
					</div>
				</div>
				<div class="table_wrap">
					<input type="hidden" name="me_no" value="1">
					<input type="hidden" name="boNo" value="${dto.boNo }">
					<input type="hidden" name="type" value="${type}">
					<table class="view write" id="board_view">
						<tr>
							<th>제목</th>
							<td>
								<input name="title" type="text" value="${dto.title }" required>
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<textarea id="orgContent" style="display: none;">${dto.content }</textarea>
								<textarea id="txtContent" name="content" style="width: 99%;"></textarea>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</div>

	<script id="smartEditor" type="text/javascript">
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : oEditors,
			elPlaceHolder : "txtContent", //textarea ID 입력
			sSkinURI : "../../resources/smarteditor/SmartEditor2Skin.html", //martEditor2Skin.html 경로 입력
			fCreator : "createSEditor2",
			htParams : {
				// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseToolbar : true,
				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseVerticalResizer : false,
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseModeChanger : false
			},
			fOnAppLoad : function() {
				var sHTML = $("#orgContent").val();
				console.log(sHTML);
				oEditors.getById["txtContent"].exec("PASTE_HTML", [ sHTML ]);
				var sDefaultFont = '나눔고딕';
				var nFontSize = 11;
				oEditors.getById["txtContent"].setDefaultFont(sDefaultFont, nFontSize);
			},
		});

		$("#btn-submit").click(function() {
			oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);
			$("#writeForm").submit();
		});
	</script>

</body>

</html>