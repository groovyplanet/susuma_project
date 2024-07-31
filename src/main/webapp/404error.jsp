<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body, html {
    width: 100%;
    height: 100%;
    overflow: hidden;
}

.container {
    position: relative;
    width: 100%;
    height: 100%;
}

.background-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.go-home-button {
    position: absolute;
    top: 75%;
    left: 51%;
    transform: translate(-50%, -50%);
    padding: 10px 20px;
    font-size: 16px;
    background-color: #F49D00;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight : 300;
}

.go-home-button:hover {
    background-color: #F5AF26;
}


</style>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 페이지</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <img src="${pageContext.request.contextPath }/resources/img/404.jpg" alt="404 이미지" class="background-image">
        <button type="button" class="go-home-button" onclick="location.href='main.member'">홈으로</button>
    </div>
</body>
</html>
