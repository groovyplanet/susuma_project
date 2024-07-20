<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입 결과</title>
    <script>
        window.onload = function() {
            var isSuccess = <%= request.getAttribute("isSuccess") %>;
            if (isSuccess) {
                alert('회원가입에 성공했습니다.');
            } else {
                alert('회원가입에 실패했습니다.');
            }
            window.location.href = '<%= request.getContextPath() %>/index.jsp';
        }
    </script>
</head>
<body>
</body>
</html>
