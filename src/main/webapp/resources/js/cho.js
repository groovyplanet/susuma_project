$(document).ready(function () {

    $("#email").blur(function () { // 이메일
        var regex = /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/;
        if (regex.test($(this).val())) $(this).parent().removeClass("error");
        else $(this).parent().addClass("error");
    });
    $("#pw").blur(function () { // 비밀번호
        var regex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
        if (regex.test($(this).val())) $(this).parent().removeClass("error");
        else $(this).parent().addClass("error");
        if ($('#pw_re').val() != "" && $('#pw').val() == $('#pw_re').val()) $(this).parent().removeClass("error-re");
        else if ($('#pw_re').val() != "") $(this).parent().addClass("error-re");
    });
    $("#pw_re").blur(function () { // 비밀번호 확인
        if ($('#pw').val() == $('#pw_re').val()) $(this).parent().removeClass("error-re");
        else $(this).parent().addClass("error-re");
    });

    $("#phone_num").keyup(function () { // 연락처 자동 대쉬
        if ($(this).val().length == 11) {
            $(this).val($(this).val().replace(/[^0-9]/, "").replace(/^(010)(\d{4})(\d{4})$/, `$1-$2-$3`));
        }
    });
    $("#phone_num").blur(function () { // 연락처
        var regex = /^(010-[0-9]{4}-[0-9]{4})$/;
        if (regex.test($(this).val())) $(this).parent().removeClass("error");
        else $(this).parent().addClass("error");
    });
    $("#business_num").keyup(function () { // 사업자 번호 자동 대쉬
        if ($(this).val().length == 10) {
            $(this).val($(this).val().replace(/[^0-9]/, "").replace(/([0-9]{3})([0-9]{2})([0-9]{5})/, `$1-$2-$3`));
        }
    });
    $("#business_num").blur(function () { // 사업자 번호
        var regex = /([0-9]{3})-?([0-9]{2})-?([0-9]{5})/;
        if (regex.test($(this).val())) $(this).parent().removeClass("error");
        else $(this).parent().addClass("error");
    });
    $("#btn-join-user, #btn-join-master").click(function () { // 의뢰인으로 가입 or 수리기사로 가입
        if (!$(this).hasClass("active")) {
            $(".join-form").toggle();
            $(".menu-tab button").toggleClass("active");
        }
    })


});
