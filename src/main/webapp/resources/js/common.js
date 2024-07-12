$(document).ready(function () {

    $("#btn-login-modal").click(function () { // 로그인 버튼
        $("#login-modal").toggleClass("show"); // 로그인 모달 창
    })

    $(".btn-close-modal").click(function () { // 모달 창 삭제 버튼
        $(".modal").removeClass("show");
    })

    $("#btn-alarm-list").click(function () { // 알림 버튼
        $("#alram-list").toggle(); // 알림 목록
    })
    
});