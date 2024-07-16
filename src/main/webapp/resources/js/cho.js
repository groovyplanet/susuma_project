
$(document).ready(function () {

    /*
    member/join.html
    */

    // 탭 메뉴(의뢰인으로 가입 or 수리기사로 가입)
    $(".main-area.join .tab-btn").click(function () {
        if (!$(this).hasClass("active")) {
            $(".tab-btn").toggleClass("active");
            $("#master-info-area").toggle();
            // 사업자등록번호 required 속성 토글
            $("#business_num").prop('required', !$("#business_num").prop('required'));
            // 폼 정보 리셋
            //$("#form-join")[0].reset(); 
            //$(".input-area").removeClass("error").removeClass("error-re");
        }
    })

    // 이동 가능 거리 radio
    $(".main-area.join .join-form .distance-radio").click(function () {
        if (!$(this).hasClass("active")) {
            $(".distance-radio").removeClass("active");
            $(this).addClass("active");
        }
    })

    // 회원가입 폼 관련
    $(".main-area.join .join-form #email").blur(function () { // 이메일
        var regex = /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/;
        var inputArea = $(this).parent();
        if (regex.test($(this).val())) {
            inputArea.removeClass("error");
            // ajax로 이메일 중복확인
            if ($(this).val() == "ss@naver.com") {
                inputArea.addClass("duplicate-yes");
                inputArea.removeClass("duplicate-no");
            } else {
                inputArea.removeClass("duplicate-yes");
                inputArea.addClass("duplicate-no");
            }
        } else {
            inputArea.addClass("error");
            inputArea.removeClass("duplicate-yes duplicate-no");
        }
    });
    $(".main-area.join .join-form #pw").blur(function () { // 비밀번호
        var regex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!@#$%^&*]{8,}$/;
        var inputArea = $(this).parent();
        if (regex.test($(this).val())) inputArea.removeClass("error");
        else inputArea.addClass("error");
        if ($('#pw_re').val() != "" && $('#pw').val() == $('#pw_re').val()) inputArea.removeClass("error-re");
        else if ($('#pw_re').val() != "") inputArea.addClass("error-re");
    });
    $(".main-area.join .join-form #pw_re").blur(function () { // 비밀번호 확인
        var inputArea = $(this).parent();
        if ($('#pw').val() == $('#pw_re').val()) inputArea.removeClass("error-re");
        else inputArea.addClass("error-re");
    });

    $(".main-area.join .join-form #phone_num").keyup(function () { // 연락처 자동 대쉬
        if ($(this).val().length == 11) {
            $(this).val($(this).val().replace(/[^0-9]/, "").replace(/^(010)(\d{4})(\d{4})$/, `$1-$2-$3`));
        }
    });
    $(".main-area.join .join-form #phone_num").blur(function () { // 연락처
        var regex = /^(010-[0-9]{4}-[0-9]{4})$/;
        if (regex.test($(this).val())) $(this).parent().removeClass("error");
        else $(this).parent().addClass("error");
    });
    $(".main-area.join .join-form #business_num").keyup(function () { // 사업자 번호 자동 대쉬
        if ($(this).val().length == 10) {
            $(this).val($(this).val().replace(/[^0-9]/, "").replace(/([0-9]{3})([0-9]{2})([0-9]{5})/, `$1-$2-$3`));
        }
    });
    $(".main-area.join .join-form #business_num").blur(function () { // 사업자 번호
        var regex = /([0-9]{3})-?([0-9]{2})-?([0-9]{5})/;
        if (regex.test($(this).val())) $(this).parent().removeClass("error");
        else $(this).parent().addClass("error");
    });

    // 수리 분야 추가
    $(".main-area.join .join-form #add-category-btn").click(function () {
        var html = $("#category-select-area-template").html();
        $("#category-select-area-wrap").append(html);
    })

    // 근무 요일 및 시간
    $(".main-area.join .join-form .check-area input[type='checkbox']").click(function () {
        if ($(this).prop('checked')) $(this).parent().parent().find("select").removeAttr("disabled"); // 체크 시 select 활성화
        else $(this).parent().parent().find("select").attr("disabled", "disabled"); // 비활성화
    })
    $(".main-area.join .join-form #btn-work-hours-enter").click(function () {
        // form에 반영
        $("#work-hours-list").empty();
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
            $("#work-hours-list").append("<p>" + day + " " + startTime + ":00 ~ " + endTime + ":00</p>");
        })

        if ($('input:checkbox[name=work-hours-week]:checked').length > 0) $("#work-hours-list").show();
        else $("#work-hours-list").hide();

        $(".modal").removeClass("show"); // 창 닫기
    })

    // 이용약관 동의 체크박스
    $(".main-area.join .join-form #check-terms-all").click(function () {
        $("input[name=checkbox-terms]").prop("checked", $(this).is(":checked"));
    });

    $(".main-area.join .join-form input[name=checkbox-terms]").click(function () {
        var total = $("input[name=checkbox-terms]").length;
        var checked = $("input[name=checkbox-terms]:checked").length;
        $("#check-terms-all").prop("checked", total == checked);
    });

    // 가입하기 버튼 클릭 시
    $('#form-join').on('submit', function (event) {
        event.preventDefault(); // 기본 폼 제출 막기
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
        if ($("input[name=phone_num]").parent().hasClass("error")) {
            $("input[name=phone_num]").focus();
            return false;
        }
        // 사업자등록번호
        if ($("input[name=type]").val() == "master" && $("input[name=business_num]").parent().hasClass("error")) {
            $("input[name=business_num]").focus();
            return false;
        }

        // submit
        $(this)[0].submit();
    });
});
