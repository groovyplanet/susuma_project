<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<div class="container">
		<%@ include file="../include/snb.jsp"%>
		<div class="content_wrap">
			<div class="title_wrap">
				<span>${type=='user'?'의뢰인':'수리기사' } 상세</span>
				<div class="btn_wrap">
					<a href="list.member?type=${type }" class="btn black">
						<i class="bi bi-list-ul"></i>
						목록
					</a>
				</div>
			</div>
			<div class="table_wrap">
				<table class="view" id="member_view">
					<tr>
						<th>회원 번호</th>
						<td>${dto.meNo}</td>
						<th>프로필 사진</th>
						<td>
							<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile">
							<!-- ${dto.profilePhoto } -->
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${dto.name}</td>
						<th>이메일</th>
						<td>${dto.email}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>${empty dto.address ? '-' : dto.address}${empty dto.addressDetail ? '' : dto.addressDetail}</td>
						<th>연락처</th>
						<td>${dto.phoneNum}</td>
					</tr>
					<tr>
						<th>위도</th>
						<td>${dto.latitude}</td>
						<th>경도</th>
						<td>${dto.longitude}</td>
					</tr>
					<tr>
						<th>이메일 알림 수신 여부</th>
						<td>${dto.emailNotification}</td>
						<th>회원 상태</th>
						<td>${dto.status}</td>
					</tr>
					<c:if test="${type == 'master' }">
						<tr>
							<th>수리기사 가입 승인여부</th>
							<td>${dto.joinApproval}</td>
							<th>수리기사 가입 승인일시</th>
							<td>
								<fmt:formatDate value="${dto.joinApprovalTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
							</td>
						</tr>
						<tr>
							<th>사업자등록번호</th>
							<td>${dto.businessNumber}</td>
							<th>수리기사 이동가능거리</th>
							<td>${dto.maxDistance}</td>
						</tr>
						<tr>
							<th>수리기사 한줄소개</th>
							<td>${dto.shortDescription}</td>
							<th>수리 상세 내용</th>
							<td>${dto.description}</td>
						</tr>
						<tr>
							<th>수리기사 포인트</th>
							<td>${dto.point}</td>
							<th>근무가능 요일별 시간</th>
							<td>${dto.workHours}</td>
						</tr>
					</c:if>
					<tr>
						<th>가입 일시</th>
						<td>
							<fmt:formatDate value="${dto.insertTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
						</td>
						<th>수정 일시</th>
						<td>
							<fmt:formatDate value="${dto.updateTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>

</body>

</html>
