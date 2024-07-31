
/*
member/join.member
member/edit.member
*/

function handleCategoryChange() {
	const categorySelect = document.getElementById('category');
	const subCategorySelect = document.getElementById('sub-category');
	const selectedCategory = categorySelect.value;

	// 선택된 상위 카테고리가 없는 경우, 하위 카테고리 초기화
	if (!selectedCategory) {
		subCategorySelect.innerHTML = '<option value="">선택</option>';
		return;
	}

	// AJAX 요청을 통해 하위 카테고리 가져오기
	fetch("getCategory.ajax?rootNo=" + selectedCategory)
		.then(function (response) {
			return response.json();
		})
		.then(function (data) {
			subCategorySelect.innerHTML = '<option value="">선택</option>';
			data.forEach(function (subCategory) {
				const option = document.createElement('option');
				option.value = subCategory.caNo; // 하위 카테고리 번호
				option.textContent = subCategory.caName; // 하위 카테고리 이름
				subCategorySelect.appendChild(option);
			});
			subCategorySelect.focus();
		})
		.catch(function (error) {
			console.error('Fetch error:', error);
		});
}


$(document).ready(function () {

	/*
	member/join.member
	*/

	// 탭 메뉴(의뢰인으로 가입 or 수리기사로 가입)
	$(".main-area.join .tab-btn").click(function () {
		if (!$(this).hasClass("active")) {
			$(".tab-btn").toggleClass("active");
			$("#master-info-area").toggle();

			// 수리기사는 모든 정보 필수 입력
			$("#phoneNum-label").toggleClass('required');
			$("#phoneNum").prop('required', !$("#phoneNum").prop('required'));
			$("#businessNumber").prop('required', !$("#businessNumber").prop('required'));
			$("#category").prop('required', !$("#category").prop('required'));
			$("#sub-category").prop('required', !$("#sub-category").prop('required'));
			$("#shortDescription").prop('required', !$("#shortDescription").prop('required'));

			// 폼 정보 리셋
			//$("#form-join")[0].reset(); 
			//$(".input-area").removeClass("error").removeClass("error-re");
		}
	})


	/*
	member/join.member
	member/edit.member
	.profile-edit 클래스 공통으로 사용
	*/

	$(".profile-edit #email").blur(function () { // 이메일
		var regex = /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/;
		var inputArea = $(this).parent();
		if (regex.test($(this).val())) {
			inputArea.removeClass("error");

			// ajax로 이메일 중복확인
			fetch('checkEmailDuplication.ajax', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/x-www-form-urlencoded'
				},
				body: 'email=' + encodeURIComponent($(this).val()) // 이메일 주소에 @가 포함되므로 인코딩
			})
				.then(response => response.json())
				.then(data => {
					if (data.available) {
						// 이메일 사용 가능
						inputArea.addClass("duplicate-yes");
						inputArea.removeClass("duplicate-no");
					} else {
						// 이메일 중복
						inputArea.removeClass("duplicate-yes");
						inputArea.addClass("duplicate-no");
					}
				})

		} else {
			inputArea.addClass("error");
			inputArea.removeClass("duplicate-yes duplicate-no");
		}
	});

	$(".profile-edit #pw").blur(function () { // 비밀번호
		var regex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!@#$%^&*]{8,}$/;
		var inputArea = $(this).parent();
		if (regex.test($(this).val())) inputArea.removeClass("error");
		else inputArea.addClass("error");
		if ($('#pw_re').val() != "" && $('#pw').val() == $('#pw_re').val()) inputArea.removeClass("error-re");
		else if ($('#pw_re').val() != "") inputArea.addClass("error-re");
	});

	$(".profile-edit #pw_re").blur(function () { // 비밀번호 확인
		var inputArea = $(this).parent();
		if ($('#pw').val() == $('#pw_re').val()) inputArea.removeClass("error-re");
		else inputArea.addClass("error-re");
	});

	$(".profile-edit #phoneNum").keyup(function () { // 연락처 자동 대쉬
		if ($(this).val().length == 11) {
			$(this).val($(this).val().replace(/[^0-9]/, "").replace(/^(010)(\d{4})(\d{4})$/, `$1-$2-$3`));
		}
	});

	$(".profile-edit #phoneNum").blur(function () { // 연락처
		var regex = /^(010-[0-9]{4}-[0-9]{4})$/;
		if (regex.test($(this).val()) || $(this).val() == "") $(this).parent().removeClass("error");
		else $(this).parent().addClass("error");
	});

	$(".profile-edit #businessNumber").keyup(function () { // 사업자 번호 자동 대쉬
		if ($(this).val().length == 10) {
			$(this).val($(this).val().replace(/[^0-9]/, "").replace(/([0-9]{3})([0-9]{2})([0-9]{5})/, `$1-$2-$3`));
		}
	});

	$(".profile-edit #businessNumber").blur(function () { // 사업자 번호
		var regex = /([0-9]{3})-?([0-9]{2})-?([0-9]{5})/;
		if (regex.test($(this).val())) $(this).parent().removeClass("error");
		else $(this).parent().addClass("error");
	});

	// 근무 요일 및 시간
	$(".profile-edit .check-area input[type='checkbox']").click(function () {
		if ($(this).prop('checked')) $(this).parent().parent().find("select").removeAttr("disabled"); // 체크 시 select 활성화
		else $(this).parent().parent().find("select").attr("disabled", "disabled"); // 비활성화
	})

	$(".profile-edit #btn-work-hours-enter").click(function () {
		// form에 반영
		$("#work-hours-list").empty();
		var workHours = "";
		$('input:checkbox[name=work-hours-week]:checked').each(function (index) {
			var num = $(this).val();
			var startTime = $(this).parent().parent().find("select[name='work_hours_" + num + "_s']").val();
			var endTime = $(this).parent().parent().find("select[name='work_hours_" + num + "_e']").val();
			var day;
			switch (num) {
				case "1": day = "월"; break;
				case "2": day = "화"; break;
				case "3": day = "수"; break;
				case "4": day = "목"; break;
				case "5": day = "금"; break;
				case "6": day = "토"; break;
				case "7": day = "일"; break;
				default: day = "잘못된 입력";
			}
			$("#work-hours-list").append("<p>" + day + " " + startTime + " ~ " + endTime + "</p>");
			workHours += (workHours != "" ? "\n" : "") + day + " " + startTime + " ~ " + endTime;
		})
		$("input[name=workHours]").val(workHours); // DB에 저장될 값

		if ($('input:checkbox[name=work-hours-week]:checked').length > 0) $("#work-hours-list").show();
		else $("#work-hours-list").hide();

		$("#btn-work_hours").removeClass("error");
		$(".modal").removeClass("show"); // 창 닫기
	})

	// 이동 가능 거리 radio
	$(".profile-edit .distance-radio").click(function () {
		if (!$(this).hasClass("active")) {
			$(".distance-radio").removeClass("active");
			$(this).addClass("active");
		}
	})

	// 이용약관 동의 체크박스
	$(".profile-edit #check-terms-all").click(function () {
		$("input[name=checkbox-terms]").prop("checked", $(this).is(":checked"));
	});

	$(".profile-edit input[name=checkbox-terms]").click(function () {
		var total = $("input[name=checkbox-terms]").length;
		var checked = $("input[name=checkbox-terms]:checked").length;
		$("#check-terms-all").prop("checked", total == checked);
	});

	// 가입하기/프로필 수정 버튼 클릭 시
	$('#form-join, #form-profile-edit').on('submit', function (event) {
		event.preventDefault(); // 기본 폼 제출 막기

		if ($("input[name='type'][type='hidden']").length == 1) { // 회원정보 수정
			var type = $("input[name='type'][type='hidden']").val();
		} else {
			var type = $("input[name='type']:checked").val(); // 회원가입
		}
		console.log("type : " + type);

		// 이메일
		if ($("input[name=email]").parent().hasClass("error")) {
			$("input[name=email]").focus();
			return false;
		}
		// 비밀번호
		if ($("input[name=pw]").parent().hasClass("error")) {
			$("input[name=pw]").focus();
			return false;
		}
		// 비밀번호2
		if ($("input[name=pw_re]").parent().hasClass("error-re")) {
			$("input[name=pw_re]").focus();
			return false;
		}
		// 연락처
		if ($("input[name=phoneNum]").parent().hasClass("error")) {
			$("input[name=phoneNum]").focus();
			return false;
		}

		//주소
		if ($("input[name='address']").val() == "") {
			$("#btn-zipcode").addClass("error");
			$('html, body').scrollTop($("#address-label").offset().top);
			return false;
		}

		// 사업자등록번호
		if (type == "master" && $("input[name=businessNumber]").parent().hasClass("error")) {
			$("input[name=businessNumber]").focus();
			return false;
		}
		// 근무 가능 요일 및 시간
		if (type == "master" && $("input[name=workHours]").val() == '') {
			$("#btn-work_hours").addClass("error");
			$('html, body').scrollTop($("#btn-work_hours").parent().offset().top);
			return false;
		}

		// submit
		$(this)[0].submit();
	});


	/*
	member/find_info.html 비밀번호 찾기
	*/
/*	var formFindInfo = document.getElementById('form-find-info');
	if (formFindInfo) { // Vanilla JavaScript를 사용할 때는 요소의 존재 여부를 반드시 확인하고 이벤트 바인딩(null 값에 이벤트 리스너를 등록하려고 시도하기 때문에 오류 발생)
		// 임시 비밀번호 발급 버튼 클릭 시
		formFindInfo.addEventListener('submit', function (event) {
			event.preventDefault(); // 기본 폼 제출 막기

			var emailInput = this.querySelector('#email');
			if (emailInput.value != "") {
				// AJAX로 이메일 중복확인 및 임시 비밀번호 발급
				// 완료 안내 모달 띄우기
				document.getElementById('find-info-complete-modal').classList.add('show');
			} else {
				// 해당되는 이메일이 없습니다. 안내 모달 띄우기
				document.getElementById('find-info-error-modal').classList.add('show');
			}

			// ajax로 구현
			// this.submit();
		});
	} //if (formFindInfo)
*/
	/*
	member/edit.member 회원정보 수정 비밀번호 변경
	*/
/*
	var formPwChange = document.getElementById('form-pw-change');
	if (formPwChange) {
		formPwChange.addEventListener('submit', function (event) {
			event.preventDefault(); // 기본 폼 제출 막기

			// 비밀번호
			var $pwInput = $("input[name='pw']");
			if ($pwInput.parent().hasClass("error")) {
				$pwInput.focus();
				return false;
			}

			// 비밀번호 확인
			var $pwReInput = $("input[name='pw_re']");
			if ($pwReInput.parent().hasClass("error-re")) {
				$pwReInput.focus();
				return false;
			}

			// ajax로 현재 비밀번호 일치 여부 체크 후 새로운 비밀번호로 업데이트
			const formData = new FormData(formPwChange);
			fetch('changePwAjax.member', {
				method: 'POST',
				body: formData
			})
				.then(response => response.json())
				.then(data => {
					if (data.available) {
						alert("비밀번호가 변경되었습니다.");
						location.href = "edit.member";
					} else {
						alert(data.msg);
						$("input[name='pw_old']").focus();
					}
				})
		})
	} //if (formPwChange)
*/
	/*
	user/request.member 수리 예약
	*/
	var requestArea = document.querySelector(".main-area.request");
	if (requestArea) {

		// 연락처 자동 대쉬
		requestArea.querySelector("#phoneNum").addEventListener('keyup', function () {
			if (this.value.length === 11) {
				this.value = this.value.replace(/[^0-9]/g, "").replace(/^(010)(\d{4})(\d{4})$/, '$1-$2-$3');
			}
		});
		// 연락처 유효성 검사
		requestArea.querySelector("#phoneNum").addEventListener('blur', function () {
			var regex = /^(010-[0-9]{4}-[0-9]{4})$/;
			if (regex.test(this.value) || this.value == "") {
				this.parentElement.classList.remove("error");
			} else {
				this.parentElement.classList.add("error");
			}
		});

		// 수리기사 근무일시 파싱 후 출력 & 달력 disabled 제어
		var masterScheduleStr = $("input[name=workHours]").val().replace(/[\r\n]+/g, ''); // 개행문자 제거 -> "월 09:00 ~ 22:00화 10:00 ~ 20:00"
		var masterScheduleData = parseSchedule(masterScheduleStr); // [{ day: '월', startHour: 9, endHour: 22 }, { day: '화', startHour: 10, endHour: 20 }]
		var scheduleList = document.getElementById('master-work-hours-list');
		masterScheduleData.forEach(schedule => {
			const p = document.createElement('p');
			p.innerHTML = `${schedule.day} ${schedule.startHour} ~ ${schedule.endHour}`;
			scheduleList.appendChild(p);
		});

		// 수리기사 근무일시 파싱 함수
		function parseSchedule(scheduleString) {
			const regex = /([월화수목금토일])\s+(\d{1,2}:\d{2})\s*~\s*(\d{1,2}:\d{2})/g; // "월 09:00 ~ 22:00화 10:00 ~ 20:00"
			const parsedSchedule = [];
			let match;
			while ((match = regex.exec(scheduleString)) !== null) {
				parsedSchedule.push({
					day: match[1],
					startHour: match[2],
					endHour: match[3],
				});
			}
			return parsedSchedule; // [{ day: '월', startHour: 9, endHour: 22 }, { day: '화', startHour: 10, endHour: 20 }]
		}

		// 달력
		const init = {
			// 월 9:00 ~ 22:00화 9:00 ~ 22:00
			monList: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
			maxDayList: ['31', '28', '31', '30', '31', '30', '31', '31', '30', '31', '30', '31'],
			dayList: ['일', '월', '화', '수', '목', '금', '토'],
			today: new Date(),
			monForChange: new Date().getMonth(),
			activeDate: new Date(),
			getFirstDay: (yy, mm) => new Date(yy, mm, 1),
			getLastDay: (yy, mm) => new Date(yy, mm + 1, 0),
			nextMonth: function () {
				let d = new Date();
				d.setDate(1);
				d.setMonth(++this.monForChange);
				this.activeDate = d;
				return d;
			},
			prevMonth: function () {
				let d = new Date();
				d.setDate(1);
				d.setMonth(--this.monForChange);
				this.activeDate = d;
				return d;
			},
			addZero: (num) => (num < 10) ? '0' + num : num,
			activeTDTag: null,
			activeBtnTag: null,
			getIndex: function (node) {
				let index = 0;
				while (node = node.previousElementSibling) {
					index++;
				}
				return index;
			}
		};

		const $calBody = document.querySelector('.cal-body');
		const $btnNext = document.querySelector('.btn-cal.next');
		const $btnPrev = document.querySelector('.btn-cal.prev');

		/* loadDate() : 선택한 날짜 값 넣어주기 */
		function loadDate(date, dayIn) {
			let dateStr = document.querySelector('.cal-year').textContent + ". " + document.querySelector('.cal-month').textContent + ". " + date + "(" + init.dayList[dayIn] + ")";
			//2024. 7. 31(월)
			document.querySelector("input[name='requestDate']").value = dateStr;
		}

		/* loadYYMM() : 달력 한장 불러오기 */
		function loadYYMM(fullDate) {
			let yy = fullDate.getFullYear(); // 2024
			let mm = fullDate.getMonth(); // 6 (7월)
			let firstDay = init.getFirstDay(yy, mm); //Mon Jul 01 2024 00:00:00 GMT+0900 (한국 표준시)
			let lastDay = init.getLastDay(yy, mm); //Wed Jul 31 2024 00:00:00 GMT+0900 (한국 표준시)
			let markToday; // 18

			if (mm === init.today.getMonth() && yy === init.today.getFullYear()) {
				markToday = init.today.getDate();
			}

			document.querySelector('.cal-month').textContent = init.monList[mm];
			document.querySelector('.cal-year').textContent = yy;

			let trtd = '';
			let startCount;
			let countDay = 0;
			for (let i = 0; i < 6; i++) { // 최대 6주
				if (countDay >= init.maxDayList[mm]) break;
				trtd += '<tr>';
				for (let j = 0; j < 7; j++) { // 일주일 7일
					if (i === 0 && !startCount && j === firstDay.getDay()) {
						startCount = 1;
					}
					if (!startCount) {
						trtd += '<td class="disabled"><span>'
					} else {
						let fullDate = yy + '.' + init.addZero(mm + 1) + '.' + init.addZero(countDay + 1);
						trtd += '<td class="day';
						let todayFlag = false;
						let disabledFlag = false;
						// 오늘 날짜인 경우 today 클래스 추가
						if (markToday && markToday === countDay + 1) todayFlag = true;
						// 지나간 날짜인 경우 disabled 클래스 추가(오늘 날짜는 포함하기 위해 1일 더해줌)
						if (new Date(fullDate).getTime() + 24 * 60 * 60 * 1000 < init.today.getTime()) disabledFlag = true;
						// 수리기사 근무 불가 요일일 경우 disabled 클래스 추가 (요일이 수리기사 근무 가능 요일 데이터에 없을 경우)
						if (!masterScheduleData.some(item => item.day == init.dayList[j])) disabledFlag = true;

						var addClassName = "";
						if (todayFlag) addClassName += " today";
						if (disabledFlag) addClassName += " disabled";
						trtd += addClassName + '"'; // class="" 닫기
						trtd += ` data-date="${countDay + 1}" data-fdate="${fullDate}"><span>`;
					}
					trtd += (startCount) ? ++countDay : ''; // countDay가 날짜
					if (countDay === lastDay.getDate()) {
						startCount = 0;
					}
					trtd += '</span></td>';
				}
				trtd += '</tr>';
			}
			$calBody.innerHTML = trtd;
		}

		/* createNewList() */
		function createNewList(val) {
			let id = new Date().getTime() + '';
			let yy = init.activeDate.getFullYear();
			let mm = init.activeDate.getMonth() + 1;
			let dd = init.activeDate.getDate();
			const $target = $calBody.querySelector(`.day[data-date="${dd}"]`);

			let date = yy + '.' + init.addZero(mm) + '.' + init.addZero(dd);

			let eventData = {};
			eventData['date'] = date;
			eventData['memo'] = val;
			eventData['complete'] = false;
			eventData['id'] = id;
			init.event.push(eventData);
			$todoList.appendChild(createLi(id, val, date));
		}

		/* createLiElements() : 날짜 클릭 시 수리기사가 지정한 근무 시간만큼 li 생성해서 추가 */
		function createLiElements(startHour, endHour, todayFlag) {
			let ul = document.querySelector('.time-list');
			ul.innerHTML = '';

			for (let hour = parseInt(startHour); hour < parseInt(endHour); hour++) {
				let li = document.createElement('li');
				let button = document.createElement('button');
				button.textContent = `${init.addZero(hour)}:00`;
				button.classList.add('btn-select-time');

				// 기 예약일시인 경우 disabled 클래스 추가
				var requestDateTimeStr = $("input[name=requestDateTime]").val(); // 기 예약일시 -> "2024. 7. 29(월) 12:00, 2024. 7. 30(화) 17:00"
				var requestDateStr = $("input[name=requestDate]").val() + ` ${init.addZero(hour)}:00`; // 선택한 예약일시 -> "2024. 7. 29(월) 12:00"
				if (requestDateTimeStr.includes(requestDateStr)) { // 해당 일시가 예약일시에 포함된다면 선택 불가
					button.classList.add('disabled');
				}

				// 오늘 날짜인 경우 현재 시간 이전의 시간에는 disabled 클래스 추가
				if (todayFlag) {
					let now = new Date();
					let today = now.toISOString().split('T')[0]; // "YYYY-MM-DD" 형식의 오늘 날짜
					let currentHour = now.getHours();
					if (hour <= currentHour) {
						button.classList.add('disabled');
					}
				}

				button.type = "button";
				li.appendChild(button);
				ul.appendChild(li);
			}
		}

		loadYYMM(init.today);
		loadDate(init.today.getDate(), init.today.getDay());

		$btnNext.addEventListener('click', () => loadYYMM(init.nextMonth()));
		$btnPrev.addEventListener('click', () => loadYYMM(init.prevMonth()));

		/* 날짜 클릭 시 */
		$calBody.addEventListener('click', (e) => {
			var clickTd = e.target.tagName == 'TD' ? e.target : e.target.parentElement; //SPAN인 경우 TD 저장
			var classList = clickTd.classList;
			if (!classList.contains('disabled') && classList.contains('day')) {
				if (init.activeTDTag) init.activeTDTag.classList.remove('day-active');
				let date = Number(clickTd.textContent); //일
				loadDate(date, clickTd.cellIndex);
				let day = init.dayList[clickTd.cellIndex]; //요일

				// 요일에 따라 시간 선택 리스트 표시
				let index = masterScheduleData.findIndex((schedule) => schedule.day === day);
				let startHour = masterScheduleData[index].startHour;
				let endHour = masterScheduleData[index].endHour;
				createLiElements(startHour, endHour, classList.contains('today'));
				if (!document.querySelector('.time-list-wrap').classList.contains("show")) {
					document.querySelector('.time-list-wrap').classList.add("show");
					document.querySelector("#calendar-wrap").classList.remove("error");
				}
				clickTd.classList.add('day-active'); //day-active 클래스 추가
				init.activeTDTag = clickTd;
				init.activeDate.setDate(date);
			}
		});

		/* 시간 클릭 시 */
		document.querySelector('#time-list').addEventListener('click', (e) => {
			if (e.target.tagName != "BUTTON") return false;
			if (e.target.classList.hasClass == "disabled") {
				console.log("disabled 버튼입니다.");
				return false;
			}
			let btn = e.target;

			if (!btn.classList.contains('selected')) {
				if (init.activeBtnTag) init.activeBtnTag.classList.remove('selected');
				btn.classList.add('selected');
				init.activeBtnTag = btn;
				document.querySelector("input[name='requestTime']").value = btn.innerHTML;
				document.querySelector(".time-list-wrap").classList.remove("error");
			}
		});


		var formRequest = document.getElementById('form-request');

		// 예약 신청 버튼 클릭 시
		formRequest.addEventListener('submit', function (event) {
			event.preventDefault(); // 기본 폼 제출 막기

			//시간 
			var time = document.querySelector("input[name='requestTime']");
			var date = document.querySelector("input[name='requestDate']");
			if (time.value == "") {
				// 날짜 선택 전 - 날짜부터 선택
				if (!document.querySelector(".time-list-wrap").classList.contains("show")) {
					document.querySelector("#calendar-wrap").classList.add("error");
					window.scrollTo(0, document.getElementById('date-wrap-top').offsetTop);
				} else { // 날짜 선택 후 - 시간 선택
					document.querySelector(".time-list-wrap").classList.add("error");
					window.scrollTo(0, document.getElementById('date-wrap-top').offsetTop);
				}
				return false;
			}
			//주소
			var address = document.querySelector("input[name='address']");
			if (address.value == "") {
				document.querySelector("#btn-zipcode").classList.add("error");
				return false;
			}
			// 연락처
			if (document.querySelector("input[name=phoneNum]").parentElement.classList.contains("error")) {
				document.querySelector("input[name=phoneNum]").focus();
				return false;
			}

			// ajax로 db 저장 후 다시 돌아와서 모달창 보이기
			console.log(formRequest.querySelector("textarea[name=content]").value);
			const formData = new FormData(formRequest);
			fetch('insertRequest.ajax', {
				method: 'POST',
				body: formData
			})
				.then(response => response.json())
				.then(data => {
					if (data.available) {
						// insert 완료, 모달창 보여주기

						// 폼 데이터 가져오기
						var date = $('input[name="requestDate"]').val();
						var time = $('input[name="requestTime"]').val();
						var name = $('.master-name').text().trim();
						var phone = $('#phoneNum').val();
						var address = $('input[name="address"]').val();
						var description = $('textarea[name="content"]').val();

						// 데이터 출력 확인
						console.log(date, time, name, phone, address, description);

						// 모달에 데이터 설정
						$('#modal-date').text(date + ' ' + time);
						$('#modal-name').text(name);
						$('#modal-phone').text(phone);
						$('#modal-address').text(address);
						$('#modal-description').html(description); // HTML 태그가 있는 경우 .html() 사용

						document.getElementById('request-complete-modal').style.display = 'flex'; // 요소 표시
						setTimeout(function () {
							document.getElementById('request-complete-modal').classList.add('show'); // 애니메이션 시작
						}, 100); // 약간의 지연 추가
					}
				})

		})
	} //if (requestArea)


}); // $(document).ready(function () {})



