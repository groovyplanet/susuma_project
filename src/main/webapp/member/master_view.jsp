<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.susuma.member.model.MemberDTO"%>
<%@ include file="../include/head.jsp"%>
</head>

<body>
	<%@ include file="../include/header.jsp"%>

	<section class="main-section">
		<div class="container">
			<div class="content master-view">
				<div class="new-edit-form">
					<div class="new-profile-img">
						<c:choose>
							<c:when test="${dto.profilePhotoImg == '' }">
								<img src="${pageContext.request.contextPath }/resources/img/iconProfileDefault.png" alt="Profile Picture" class="profile">
							</c:when>
							<c:otherwise>
								<img src="data:image/png;base64,${dto.profilePhotoImg }" alt="Profile Picture" class="profile">
							</c:otherwise>
						</c:choose>
					</div>
					<div class="new-master-section">
						<div class="new-master-name">
							<c:out value="${dto.name}" />
						</div>
						<div class="new-review-star">
							★4.73
							<span>(400)</span>
						</div>

						<div class="new-map">
							위치 :
							<c:out value="${dto.address}" />
						</div>
						<div class="one-line-pr">
							<c:out value="${dto.shortDescription}" />
						</div>

						<div class="reserve-button-block">
							<a href="${pageContext.request.contextPath }/member/memberRequest.member?meNo=${dto.meNo}" class="new-btn new-reserve" id="reserve-button">예약 신청</a>
							<a class="new-btn new-reserve-contact" id="reserve-contact" onclick="window.open(this.href='message.jsp', '_blank', 'width=440, height=550'); return false;">문의 신청</a>
						</div>
					</div>
				</div>

				<div class="new-location_management">
					<div class="new-location_managementtitle">
						<img width="25" height="25" src="${pageContext.request.contextPath }/resources/img/iconmap.png" alt="">
						위치 관리
					</div>
					<div class="new-location_details">
						<p>
							현재 위치:
							<c:out value="${dto.address}" />
						</p>
					</div>
				</div>

				<div class="new-detailed_description">
					<div class="new-detailed_descriptiontitle">서비스 상세 설명</div>
					<div class="new-description_details">
						<p>
							<c:out value="${dto.description}" />
						</p>
					</div>
				</div>
				<div class="new-detailed_description">
					<div class="new-detailed_descriptiontitle">
						<svg width="30" height="30" fill="#121619" xmlns="http://www.w3.org/2000/svg" class="assets_asset__PJO1J" viewBox="0 0 48 48" name="folderLight">
                            <g clip-path="url(#icon_folder_light_svg__a)">
                                <path fill-rule="evenodd" clip-rule="evenodd" d="M9 15.7c0-2.607 2.092-4.7 4.7-4.7h4.1c1.031 0 2.188.374 3.004 1.055l.004.003L25.5 16H34.5c2.608 0 4.7 2.093 4.7 4.7v11.8c0 2.608-2.093 4.7-4.7 4.7H13.7A4.685 4.685 0 0 1 9 32.5V15.7Zm4.7-2.5a2.485 2.485 0 0 0-2.5 2.5v16.8c0 1.392 1.107 2.5 2.5 2.5h20.8c1.392 0 2.5-1.108 2.5-2.5V20.7c0-1.392-1.108-2.5-2.5-2.5h-9.4a1.1 1.1 0 0 1-.708-.258l-4.996-4.197-.002-.001c-.383-.319-1.026-.544-1.594-.544h-4.1Z" fill="#121619"></path>
                            </g>
                            <defs>
                                <clipPath id="icon_folder_light_svg__a">
                                    <path fill="#fff" transform="translate(9 11)" d="M0 0h30.2v26.2H0z"></path>
                                </clipPath>
                            </defs>
                        </svg>
						서비스 상세 설명
					</div>
					<div class="new-description_details">
						<p>

							안녕하세요 고객님! 패밀리크린입니다 의뢰 주심에 감사드립니다.
							<br>
							패밀리크린 청소팀은 내 가족이 사는 집이라 생각하고 친환경세제를 사용하여
							<br>
							정성스런 마음으로 꼼꼼하고 건강한 청소를 지향하며 소독으로 시작하여 깨끗하게 마무리 해 드립니다
							<br>
							청소전과 후 사진자료 남겨드립니다 전과 후가 완전히 달라집니다 결정 되시면 연락주십시요 감사합니다.
							<br>
							[청소범위 안내]입니다 *모든창틀과  유리청소(외부쪽 외창은 제외)
						</p>
					</div>
				</div>
				<div class="new-service_scheduling">
					<div class="new-service_schedulingtitle">
						<svg width=25 height=22 fill="#121619" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="64px" height="64px" viewBox="0 0 610.398 610.398" xml:space="preserve">
                            <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                            <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                            <g id="SVGRepo_iconCarrier">
                                <g>
                                    <g>
                                        <path d="M159.567,0h-15.329c-1.956,0-3.811,0.411-5.608,0.995c-8.979,2.912-15.616,12.498-15.616,23.997v10.552v27.009v14.052 c0,2.611,0.435,5.078,1.066,7.44c2.702,10.146,10.653,17.552,20.158,17.552h15.329c11.724,0,21.224-11.188,21.224-24.992V62.553 V35.544V24.992C180.791,11.188,171.291,0,159.567,0z">
                                        </path>
                                        <path d="M461.288,0h-15.329c-11.724,0-21.224,11.188-21.224,24.992v10.552v27.009v14.052c0,13.804,9.5,24.992,21.224,24.992 h15.329c11.724,0,21.224-11.188,21.224-24.992V62.553V35.544V24.992C482.507,11.188,473.007,0,461.288,0z">
                                        </path>
                                        <path d="M539.586,62.553h-37.954v14.052c0,24.327-18.102,44.117-40.349,44.117h-15.329c-22.247,0-40.349-19.79-40.349-44.117 V62.553H199.916v14.052c0,24.327-18.102,44.117-40.349,44.117h-15.329c-22.248,0-40.349-19.79-40.349-44.117V62.553H70.818 c-21.066,0-38.15,16.017-38.15,35.764v476.318c0,19.784,17.083,35.764,38.15,35.764h468.763c21.085,0,38.149-15.984,38.149-35.764 V98.322C577.735,78.575,560.671,62.553,539.586,62.553z M527.757,557.9l-446.502-0.172V173.717h446.502V557.9z">
                                        </path>
                                        <path d="M353.017,266.258h117.428c10.193,0,18.437-10.179,18.437-22.759s-8.248-22.759-18.437-22.759H353.017 c-10.193,0-18.437,10.179-18.437,22.759C334.58,256.074,342.823,266.258,353.017,266.258z">
                                        </path>
                                        <path d="M353.017,348.467h117.428c10.193,0,18.437-10.179,18.437-22.759c0-12.579-8.248-22.758-18.437-22.758H353.017 c-10.193,0-18.437,10.179-18.437,22.758C334.58,338.288,342.823,348.467,353.017,348.467z">
                                        </path>
                                        <path d="M353.017,430.676h117.428c10.193,0,18.437-10.18,18.437-22.759s-8.248-22.759-18.437-22.759H353.017 c-10.193,0-18.437,10.18-18.437,22.759S342.823,430.676,353.017,430.676z">
                                        </path>
                                        <path d="M353.017,512.89h117.428c10.193,0,18.437-10.18,18.437-22.759c0-12.58-8.248-22.759-18.437-22.759H353.017 c-10.193,0-18.437,10.179-18.437,22.759C334.58,502.71,342.823,512.89,353.017,512.89z">
                                        </path>
                                        <path d="M145.032,266.258H262.46c10.193,0,18.436-10.179,18.436-22.759s-8.248-22.759-18.436-22.759H145.032 c-10.194,0-18.437,10.179-18.437,22.759C126.596,256.074,134.838,266.258,145.032,266.258z">
                                        </path>
                                        <path d="M145.032,348.467H262.46c10.193,0,18.436-10.179,18.436-22.759c0-12.579-8.248-22.758-18.436-22.758H145.032 c-10.194,0-18.437,10.179-18.437,22.758C126.596,338.288,134.838,348.467,145.032,348.467z">
                                        </path>
                                        <path d="M145.032,430.676H262.46c10.193,0,18.436-10.18,18.436-22.759s-8.248-22.759-18.436-22.759H145.032 c-10.194,0-18.437,10.18-18.437,22.759S134.838,430.676,145.032,430.676z">
                                        </path>
                                        <path d="M145.032,512.89H262.46c10.193,0,18.436-10.18,18.436-22.759c0-12.58-8.248-22.759-18.436-22.759H145.032 c-10.194,0-18.437,10.179-18.437,22.759C126.596,502.71,134.838,512.89,145.032,512.89z">
                                        </path>
                                    </g>
                                </g>
                            </g>
                        </svg>
						서비스 일정 관리
					</div>
					<div class="new-schedule_details">
						<ul>
							예약 가능한 시간 :
							<li>월요일: 10:00 - 12:00</li>
							<li>화요일: 14:00 - 16:00</li>
							<li>수요일: 09:00 - 11:00</li>
						</ul>
					</div>

				</div>

				<div class="review-list-master">
					<div class="review">
						<div class="tab-review">
							<button id="tab-pic-list" class="tab active">사진/비디오</button>
							<button id="tab-review-list" class="tab">후기</button>
						</div>
						<div class="review-list">
							<ul class="pic-list-view item">
								<li>
									<img width="50px" height="150px" src="${pageContext.request.contextPath }/resources/img/exampleidentify.png" alt="">
								</li>
								<li>
									<img width="50px" height="150px" src="${pageContext.request.contextPath }/resources/img/exampleidentify.png" alt="">
								</li>
								<li>
									<img width="50px" height="150px" src="${pageContext.request.contextPath }/resources/img/exampleidentify.png" alt="">
								</li>
								<li>
									<img width="50px" height="150px" src="${pageContext.request.contextPath }/resources/img/exampleidentify.png" alt="">
								</li>
							</ul>
							<div class="pic-review-view item" style="display: none;">
								<div class="member-review-pic">
									<img src="${pageContext.request.contextPath }/resources/img/example1.jpeg" alt="">
									<img src="${pageContext.request.contextPath }/resources/img/example2.jpg" alt="">
									<img src="${pageContext.request.contextPath }/resources/img/example3.jpg" alt="">
								</div>
								<span class="sizetype-view">
									<span class="date">24.07.09</span>
									<span class="starreview">★★★★★</span>
									<span class="nickname">김모씨</span>
									<span class="review-oneline">기사님이 깨끗하고 집안이 멋져요</span>
								</span>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="../include/footer.jsp"%>
	<script>
		$(document).ready(function() {
			$("#tab-pic-list").click(function() {
				if (!$(this).hasClass("active")) {
					$(".pic-list-view").show();
					$(".pic-review-view").hide();
					$("#tab-pic-list").addClass("active");
					$("#tab-review-list").removeClass("active");
				}
			});

			$("#tab-review-list").click(function() {
				if (!$(this).hasClass("active")) {
					$(".pic-list-view").hide();
					$(".pic-review-view").show();
					$("#tab-review-list").addClass("active");
					$("#tab-pic-list").removeClass("active");
				}
			});
		});
	</script>

</body>

</html>