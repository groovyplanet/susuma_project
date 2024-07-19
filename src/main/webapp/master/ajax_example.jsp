<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h3>제목</h3>
	<div class="chat">
		
			
		
	</div>

	<button onclick="ajax()">클릭</button>


	<script type="text/javascript">
		
	function ajax() {
		fetch("../chat?name=홍길동&age=20")
		.then(function(response) {
			
			return response.json();
		})
		.then(function(data) {
			
			console.log(data);
			
			var chat = document.querySelector(".chat");
			
			var div = document.createElement("div");
			div.innerHTML = data.key;
			
			chat.appendChild(div);
		})
		
		
	}

	
	</script>

</body>
</html>