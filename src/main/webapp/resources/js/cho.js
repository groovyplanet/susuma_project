$(document).ready(function () {

    /*
    member/join.html
    */

    // 탭 메뉴(의뢰인으로 가입 or 수리기사로 가입)
    $(".tab-btn").click(function () {
        if (!$(this).hasClass("active")) {
            $(".tab-btn").toggleClass("active");
            $("#master-info-area").toggle();
            if ($("#business_num").prop('required')) $("#business_num").prop('required', false);
            else $("#business_num").prop('required', true);
            $("#form-join")[0].reset();
            $(".input-area").removeClass("error").removeClass("error-re");
            console.log($("input[type='radio'][name='type']:not(:checked)").val());
        }
    })

    // 이동 가능 거리 radio
    $(".distance-radio").click(function () {
        if (!$(this).hasClass("active")) {
            $(".distance-radio").removeClass("active");
            $(this).addClass("active");
        }
    })

    // 회원가입 폼 관련
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

    // 수리 분야 추가
    $("#add-category-btn").click(function () {
        var html = $("#category-select-area-template").html();
        $("#category-select-area-wrap").append(html);
    })

    // 근무 요일 및 시간
    $(".check-area input[type='checkbox']").click(function () {
        if ($(this).prop('checked')) $(this).parent().parent().find("select").removeAttr("disabled");
        else $(this).parent().parent().find("select").attr("disabled", "disabled");
    })
    $("#btn-work-hours-enter").click(function () {
        // form에 반영
        $("#work-hours-list").empty();
        $('input:checkbox[name=work-hours-week]:checked').each(function (index) {
            var num = $(this).val();
            var startTime = $(this).parent().parent().find("select[name='work_hours_" + num + "_s']").val();
            var endTime = $(this).parent().parent().find("select[name='work_hours_" + num + "_e']").val();
            var day;
            switch (num) {
                case "1": day = "월요일"; break;
                case "2": day = "화요일"; break;
                case "3": day = "수요일"; break;
                case "4": day = "목요일"; break;
                case "5": day = "금요일"; break;
                case "6": day = "토요일"; break;
                case "7": day = "일요일"; break;
                default: day = "잘못된 입력";
            }
            $("#work-hours-list").append("<p>" + day + " : " + startTime + " ~ " + endTime + "</p>");
        })

        if ($('input:checkbox[name=work-hours-week]:checked').length > 0) $("#work-hours-list").show();
        else $("#work-hours-list").hide();

        $(".modal").removeClass("show"); // 창 닫기
    })



});
