<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>

<section>
	
	<!--
		input태그에 많이 사용되는 주요 속성
		
		required는 공백을 허용하지 않음	
		readonly는 값을 수정하지 못하고 읽기만 가능
		disabled 태그를 사용하지 않음
		checked 체크박스에서 미리선택
		selected 셀렉트태그에서 미리선택
	 -->
	
		
	<div align="center">
		
		<h3>회원정보 관리</h3>
		<p>정보를 수정하시려면, 수정버튼을 누르세요</p>
		
		<hr/>
		
		
		
		
		<form action="update.user" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id" placeholder="4글자 이상" value="${dto.id }" readonly="readonly"></td>
				</tr>			
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pw" placeholder="4자 이상" required="required" pattern="[0-9A-Za-z]{4,}"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" placeholder="이름" value="${dto.name }" required="required"></td>
				</tr>			
				<tr>
					<td>이메일</td>
					<td><input type="email" name="email" value="${dto.email }"></td>
				</tr>
				<tr>
					<td>남? 여?</td>
					<td>
						<input type="radio" name="gender" value="M" ${dto.gender == 'M' ? 'checked' : '' } >남자
						<input type="radio" name="gender" value="F" ${dto.gender == 'F' ? 'checked' : '' } >여자
					</td>
				</tr>			
			
			</table>
			
			<br/>
			<input type="submit" value="수정하기">
			<input type="button" value="취소" onclick="location.href='mypage.user';">
			
			
		</form>
		
		
		
	
	</div>
	

</section>


    
<%@ include file="../include/footer.jsp" %>