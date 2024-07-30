document.addEventListener('DOMContentLoaded', function () {
	// 로그인 버튼 클릭 시 모달 띄우기
	const loginButton = document.getElementById('btn-login-modal');
	const loginModal = document.getElementById('login-modal');

	if (loginButton && loginModal) {
		loginButton.addEventListener('click', function () {
			loginModal.classList.add('show');
			document.loginForm.email.focus(); // 이메일에 포커스
			var cookies = document.cookie;
			var arr = cookies.split("; ");
			for (var i in arr) {
				if (arr[i].indexOf("saveEmail") != -1) {
					document.loginForm.pw.focus(); // 이메일 저장 시 비밀번호에 포커스
				}
			}
		});

		// 로그인 모달 배경 클릭 시 모달 닫기
		loginModal.addEventListener('mousedown', function (event) {
			if (event.target == loginModal) {
				loginModal.classList.remove('show');
			}
		});
	}

	// 모달 닫기 버튼 클릭 시 모달 닫기(공통)
	const closeButtons = document.querySelectorAll(".btn-close-modal");
	closeButtons.forEach(function (button) {
		button.addEventListener("click", function () {
			const modals = document.querySelectorAll(".modal");
			modals.forEach(function (modal) {
				modal.classList.remove("show");
			});
		});
	});

	const myElement = document.getElementById('myElementId');
	if (myElement) {
		myElement.addEventListener('click', function () {
			// 클릭 시 실행할 코드
		});
	}

	// 알림 버튼 클릭 시
	const alarmButton = document.getElementById('btn-alarm-list');
	const alarmList = document.getElementById('alram-list');

	if (alarmButton && alarmList) {
		alarmButton.parentElement.addEventListener('click', function () {
			alarmList.style.display = (window.getComputedStyle(alarmList).getPropertyValue('display') === 'none') ? 'block' : 'none';
		});
	}

});

function deleteAndGoAlert(element, alNo) {
	// 읽은 알림 삭제
	fetch('deleteAlert.ajax?alNo=' + alNo)
		.then(response => response.text())
		.then(html => {
			console.log('알림 삭제');
			// 작업 완료 후 URL로 이동
			window.location.href = element.href;
		})
}
