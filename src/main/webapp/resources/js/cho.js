
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
        if (regex.test($(this).val()) || $(this).val() == "") $(this).parent().removeClass("error");
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

document.addEventListener("DOMContentLoaded", function () {
    /*
    member/find_info.html
    */
    var formFindInfo = document.getElementById('form-find-info');
    if (formFindInfo) {
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
    }

    /*
    user/profile_edit.html
    master/profile_edit.html
    */

    var profileEdit = document.querySelector(".profile-edit");
    if (profileEdit) {

        // 비밀번호 유효성 검사
        profileEdit.querySelector("#pw").addEventListener('blur', function () {
            var regex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!@#$%^&*]{8,}$/;
            var inputArea = this.parentElement;
            if (regex.test(this.value)) {
                inputArea.classList.remove("error");
            } else {
                inputArea.classList.add("error");
            }

            var pwRe = document.getElementById('pw_re').value;
            var pw = document.getElementById('pw').value;
            if (pwRe !== "" && pw === pwRe) {
                inputArea.classList.remove("error-re");
            } else if (pwRe !== "") {
                inputArea.classList.add("error-re");
            }
        });
        // 비밀번호 확인 유효성 검사
        profileEdit.querySelector("#pw_re").addEventListener('blur', function () {
            var inputArea = this.parentElement;
            var pw = document.getElementById('pw').value;
            var pwRe = this.value;

            if (pw === pwRe) {
                inputArea.classList.remove("error-re");
            } else {
                inputArea.classList.add("error-re");
            }
        });

        // 이동 가능 거리 radio
        profileEdit.querySelectorAll(".distance-radio").forEach(function (radio) {
            radio.addEventListener('click', function () {
                if (!this.classList.contains("active")) {
                    document.querySelectorAll(".distance-radio").forEach(function (element) {
                        element.classList.remove("active");
                    });
                    this.classList.add("active");
                }
            });
        });

        // 연락처 자동 대쉬
        profileEdit.querySelector("#phone_num").addEventListener('keyup', function () {
            if (this.value.length === 11) {
                this.value = this.value.replace(/[^0-9]/g, "").replace(/^(010)(\d{4})(\d{4})$/, '$1-$2-$3');
            }
        });

        // 연락처 유효성 검사
        profileEdit.querySelector("#phone_num").addEventListener('blur', function () {
            var regex = /^(010-[0-9]{4}-[0-9]{4})$/;
            if (regex.test(this.value) || this.value == "") {
                this.parentElement.classList.remove("error");
            } else {
                this.parentElement.classList.add("error");
            }
        });

        // 사업자 번호 자동 대쉬
        profileEdit.querySelector("#business_num").addEventListener('keyup', function () {
            if (this.value.length === 10) {
                this.value = this.value.replace(/[^0-9]/g, "").replace(/([0-9]{3})([0-9]{2})([0-9]{5})/, '$1-$2-$3');
            }
        });

        // 사업자 번호 유효성 검사
        profileEdit.querySelector("#business_num").addEventListener('blur', function () {
            var regex = /([0-9]{3})-?([0-9]{2})-?([0-9]{5})/;
            if (regex.test(this.value)) {
                this.parentElement.classList.remove("error");
            } else {
                this.parentElement.classList.add("error");
            }
        });

        // 수리 분야 추가
        profileEdit.querySelector("#add-category-btn").addEventListener('click', function () {
            var html = document.querySelector("#category-select-area-template").innerHTML;
            document.querySelector("#category-select-area-wrap").insertAdjacentHTML('beforeend', html);
        });

        // 근무 요일 체크
        profileEdit.querySelectorAll(".work-hours-form .check-area input[type='checkbox']").forEach(function (checkbox) {
            checkbox.addEventListener('click', function () {
                var selects = this.parentElement.parentElement.querySelectorAll("select");
                selects.forEach(function (select) {
                    select.disabled = !checkbox.checked; // 체크 시 select 활성화, 비활성화
                });
            });
        });

        // 근무 요일 및 시간 입력 버튼 클릭
        profileEdit.querySelector("#btn-work-hours-enter").addEventListener('click', function () {
            // form에 반영
            // 초기화
            var workHoursList = document.querySelector("#work-hours-list");
            workHoursList.innerHTML = '';
            // p 태그 추가
            document.querySelectorAll('input[name="work-hours-week"]:checked').forEach(function (checkbox) {
                var num = checkbox.value;
                var parentElement = checkbox.parentElement.parentElement;
                var startTime = parentElement.querySelector('select[name="work_hours_' + num + '_s"]').value;
                var endTime = parentElement.querySelector('select[name="work_hours_' + num + '_e"]').value;
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
                var pElement = document.createElement('p');
                pElement.textContent = day + " " + startTime + ":00 ~ " + endTime + ":00";
                workHoursList.appendChild(pElement);
            });
            //해당 영역 
            if (document.querySelectorAll('input[name="work-hours-week"]:checked').length > 0) {
                workHoursList.style.display = 'block';
            } else {
                workHoursList.style.display = 'none';
            }
            // 모달 닫기
            document.querySelector("#work-hours-modal").classList.remove("show");
        });

        var formProfileEdit = document.getElementById('form-profile-edit');

        // 회원정보 수정 버튼 클릭 시
        formProfileEdit.addEventListener('submit', function (event) {
            event.preventDefault(); // 기본 폼 제출 막기
            // 이메일
            if (document.querySelector("input[name=email]").parentElement.classList.contains("error")) {
                document.querySelector("input[name=email]").focus();
                return false;
            }
            // 연락처
            if (document.querySelector("input[name=phone_num]").parentElement.classList.contains("error")) {
                document.querySelector("input[name=phone_num]").focus();
                return false;
            }
            // 사업자등록번호
            if (document.querySelector("input[name=type]").value == "master" && document.querySelector("input[name=business_num]").parentElement.classList.contains("error")) {
                document.querySelector("input[name=business_num]").focus();
                return false;
            }
            // submit
            this.submit();
        })

        var formPwChange = document.getElementById('form-pw-change');

        // 비밀번호 변경 버튼 클릭 시
        formPwChange.addEventListener('submit', function (event) {
            event.preventDefault(); // 기본 폼 제출 막기

            // 비밀번호
            var pwInput = document.querySelector("input[name='pw']");
            if (pwInput.parentElement.classList.contains("error")) {
                pwInput.focus();
                return false;
            }

            // 비밀번호 확인
            var pwReInput = document.querySelector("input[name='pw_re']");
            if (pwReInput.parentElement.classList.contains("error-re")) {
                pwReInput.focus();
                return false;
            }

            // submit
            this.submit();
        })
    } /* if (profileEdit) */

    /*
    user/profile_edit.html
    master/profile_edit.html
    */

    var requestArea = document.querySelector(".main-area.request");
    if (requestArea) {

        var formRequest = document.getElementById('form-request');

        // 예약 신청 버튼 클릭 시
        formRequest.addEventListener('submit', function (event) {
            event.preventDefault(); // 기본 폼 제출 막기

            document.getElementById('request-complete-modal').classList.add('show');

            // submit 
            //this.submit(); // db 저장 후 다시 돌아와서 모달창 보이기
        })
    }

}); /* DOMContentLoaded */



