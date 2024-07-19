<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../include/head.jsp"%>
</head>

<body class="admin">
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<%@ include file="../include/snb.jsp"%>
			<div class="content-wrap">
				<div class="table-wrap">
					<table class="table-type-view">
						<tr>
							<th>프로필 사진</th>
							<td>
								<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile-pic">
								<!-- ${dto.profilePhoto } -->
							</td>
						</tr>
						<tr>
							<th>회원 번호</th>
							<td>${dto.meNo}</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>${dto.email}</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>${dto.address}(${dto.addressDetail})</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>${dto.phoneNum}</td>
						</tr>
						<tr>
							<th>이메일 알림 수신 여부</th>
							<td>${dto.emailNotification}</td>
						</tr>
						<tr>
							<th>회원 타입</th>
							<td>${dto.type}</td>
						</tr>
						<tr>
							<th>회원 상태</th>
							<td>${dto.status}</td>
						</tr>
						<tr>
							<th>위도</th>
							<td>${dto.latitude}</td>
						</tr>
						<tr>
							<th>경도</th>
							<td>${dto.kyungdo}</td>
						</tr>
						<tr>
							<th>수리기사 가입 승인여부</th>
							<td>${dto.joinApproval}</td>
						</tr>
						<tr>
							<th>수리기사 가입 승인일시</th>
							<td>
								<fmt:formatDate value="${dto.joinApprovalTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
							</td>
						</tr>
						<tr>
							<th>사업자등록번호</th>
							<td>${dto.businessNumber}</td>
						</tr>
						<tr>
							<th>수리기사 한줄소개</th>
							<td>${dto.shortDescription}</td>
						</tr>
						<tr>
							<th>수리기사 이동가능거리</th>
							<td>${dto.maxDistance}</td>
						</tr>
						<tr>
							<th>수리 상세 내용</th>
							<td>${dto.description}</td>
						</tr>
						<tr>
							<th>수리기사 포인트</th>
							<td>${dto.point}</td>
						</tr>
						<tr>
							<th>근무가능 요일별 시간</th>
							<td>${dto.workHours}</td>
						</tr>
						<tr>
							<th>가입 일시</th>
							<td>
								<fmt:formatDate value="${dto.insertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
							</td>
						</tr>
						<tr>
							<th>수정 일시</th>
							<td>
								<fmt:formatDate value="${dto.updateTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
							</td>
						</tr>
					</table>
				</div>
				<div>
					<input type="button" value="목록" onclick="location.href='list.member';">
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>

</body>

</html>