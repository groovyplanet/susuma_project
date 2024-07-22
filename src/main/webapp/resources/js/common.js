// JQuery 라이브러리 사용
// $(document).ready(function () {

//     $("#btn-login-modal").click(function () { // 로그인 버튼
//         $("#login-modal").toggleClass("show"); // 로그인 모달 창
//     })

//     $(".btn-close-modal").click(function () { // 모달 창 삭제 버튼
//         $(".modal").removeClass("show");
//     })

//     $("#btn-alarm-list").click(function () { // 알림 버튼
//         $("#alram-list").toggle(); // 알림 목록
//     })

// });
/*
window.onload = function () {
    // 로그인 버튼 클릭 시 모달 띄우기
    document.getElementById('btn-login-modal').addEventListener('click', function () {
        document.getElementById('login-modal').classList.add('show');
    });

    // 로그인 모달 배경 클릭 시 모달 닫기
    document.getElementById('login-modal').addEventListener('click', function (event) {
        if (!event.target.closest('.container')) {
            document.getElementById('login-modal').classList.remove('show');
        }
    });

    // 모달 닫기 버튼 클릭 시 모달 닫기(공통)
    var closeButtons = document.querySelectorAll(".btn-close-modal");
    closeButtons.forEach(function (button) {
        button.addEventListener("click", function () {
            var modals = document.querySelectorAll(".modal");
            modals.forEach(function (modal) {
                modal.classList.remove("show");
            });
        });
    });

    // 알림 버튼 클릭 시
    document.getElementById('btn-alarm-list').addEventListener('click', function () {
        var alarmList = document.getElementById('alram-list');
        alarmList.style.display = (window.getComputedStyle(alarmList).getPropertyValue('display') == 'none') ? 'block' : 'none';
    });

}*/
document.addEventListener('DOMContentLoaded', function() {
    // 로그인 버튼 클릭 시 모달 띄우기
    const loginButton = document.getElementById('btn-login-modal');
    const loginModal = document.getElementById('login-modal');
    
    if (loginButton && loginModal) {
        loginButton.addEventListener('click', function() {
            loginModal.classList.add('show');
            document.loginForm.email.focus(); // 이메일에 포커스
        });

        // 로그인 모달 배경 클릭 시 모달 닫기
        loginModal.addEventListener('click', function(event) {
            if (!event.target.closest('.container')) {
                loginModal.classList.remove('show');
            }
        });
    }

    // 모달 닫기 버튼 클릭 시 모달 닫기(공통)
    const closeButtons = document.querySelectorAll(".btn-close-modal");
    closeButtons.forEach(function(button) {
        button.addEventListener("click", function() {
            const modals = document.querySelectorAll(".modal");
            modals.forEach(function(modal) {
                modal.classList.remove("show");
            });
        });
    });

    const myElement = document.getElementById('myElementId');
    if (myElement) {
        myElement.addEventListener('click', function() {
            // 클릭 시 실행할 코드
        });
    }

    // 알림 버튼 클릭 시
    const alarmButton = document.getElementById('btn-alarm-list');
    const alarmList = document.getElementById('alram-list');

    if (alarmButton && alarmList) {
        alarmButton.addEventListener('click', function() {
            alarmList.style.display = (window.getComputedStyle(alarmList).getPropertyValue('display') === 'none') ? 'block' : 'none';
        });
    }
});
