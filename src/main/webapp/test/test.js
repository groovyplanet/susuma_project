function loadMoreRequests(page) {
    fetch('getRequestsAjax.request?page=' + page)
        .then(response => response.text())
        .then(html => {
            // 서버에서 반환된 HTML 조각을 DOM에 삽입
            document.querySelector('#requestListContainer').innerHTML = html;
        })
        .catch(error => console.error('Error fetching requests:', error));
}

$(".request-summary").on("click", ".pay-request", function () { //.box에 click, a태그한테 위임

    // 현재 클릭된 버튼을 참조
    var button = $(this);

    // 결제 모달을 표시
    $('#request-list-pay-modal').addClass('show');

    // 모달에서 확인 버튼 클릭 이벤트
    $('#request-list-pay-modal .btn-confirm').one('click', function (event) {
        event.preventDefault();

        // 클릭된 버튼의 data-reqno 속성 값을 가져옴
        var reqNo = button.data('reqno');

        // AJAX 요청을 통해 서버에 결제 상태를 업데이트
        $.ajax({
            url: 'payAjax.request', // 절대 경로 사용
            type: 'POST',
            data: {
                reqNo: reqNo,
                payStatus: 'Y'
            },
            success: function (data) {
                console.log(data);
                // 서버 응답이 'Success'이면 버튼을 업데이트
                if ($.trim(data) === 'Success') {
                    button.text('결제 완료');
                    button.removeClass('approve').addClass('complete');
                    button.removeClass('pay-request').prop('disabled', true);

                    // 결제 모달을 숨김
                    $('#request-list-pay-modal').removeClass('show');
                    alert('결제가 완료되었습니다.');
                } else {
                    alert('결제 처리 실패');
                }
            },
            error: function (xhr, status, error) {
                console.error('서버 오류: ' + xhr.status);
                alert('결제 처리 중 오류가 발생했습니다.');
            }
        });
    });

})
