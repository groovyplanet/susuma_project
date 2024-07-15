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

window.onload = function () {
    // 로그인 버튼 클릭 시
    document.getElementById('btn-login-modal').addEventListener('click', function () {
        document.getElementById('login-modal').classList.add('show');
    });

    // 모달 닫기 버튼 클릭 시
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
}