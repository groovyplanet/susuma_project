$(document).ready(function() {
	var IMP = window.IMP;
	IMP.init('imp76636773'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용

	$('#confirmCharge').click(function() {
		// 사용자 입력 필드에서 금액을 가져옵니다.
		const amount = $('#chargeAmount').val().replace(/[^\d]/g, '');

		if (amount <= 0) {
			alert('충전 금액은 0보다 커야 합니다.');
			return;
		}

		IMP.request_pay({
			pg: 'html5_inicis.INIBillTst', // PG사 선택 결제할 곳 (이니시스 : html5_inicis.INIBillTst , 카카오페이 : kakaopay.TC0ONETIME)
			pay_method: 'card', // 지불수단
			merchant_uid: 'SUSUMA-' + new Date().getTime(), // 가맹점에서 구별할 수 있는 고유 ID
			name: 'SUSUMA 포인트 충전',
			amount: amount, // 사용자 입력 금액
		}, function(rsp) { // 콜백 함수
			var msg;
			if (rsp.success) {
				// 결제 정보 확인을 위한 요청
				$.ajax({
					url: "<%=request.getContextPath()%>/payments/complete", // 가맹점 서버의 결제 완료 확인 URL
					type: 'POST',
					dataType: 'json',
					data: {
						imp_uid: rsp.imp_uid // 결제 고유 ID
					}
				}).done(function(data) {
					if (data.everythings_fine) {
						// 포인트 충전 요청
						fetch('/Susuma/member/chargePoints.member', {
							method: 'POST',
							headers: {
								'Content-Type': 'application/x-www-form-urlencoded',
							},
							body: new URLSearchParams({
								points: amount, // 충전할 포인트
								imp_uid: rsp.imp_uid // 결제 고유 ID
							}),
						})
							.then(response => response.json())
							.then(data => {
								if (data.status === 'success') {

								} else {
									alert(data.message); // 실패 메시지 표시
								}
							})
							.catch(error => {
								alert('충전에 실패했습니다.');
								console.error('Error:', error);
							});

					} else {
						// 결제 정보가 유효하지 않을 때
						alert('결제에 문제가 발생했습니다.');
					}
				}).fail(function(xhr, status, error) {
					// 포인트 충전 요청
					fetch('/Susuma/member/chargePoints.member', {
						method: 'POST',
						headers: {
							'Content-Type': 'application/x-www-form-urlencoded',
						},
						body: new URLSearchParams({
							points: amount, // 충전할 포인트
							imp_uid: rsp.imp_uid // 결제 고유 ID
						}),
					})
						.then(response => response.json())
						.then(data => {
							if (data.status === 'success') {
								msg = '결제가 완료되었습니다.';
								msg += '\n고유ID : ' + rsp.imp_uid;
								msg += '\n주문번호 : ' + rsp.merchant_uid;
								msg += '\n충전금액 : ' + rsp.paid_amount + 'P';
								msg += '\nSUSUMA 포인트 충전이 완료되었습니다.';
								alert(msg);
								setTimeout(function() {
									location.reload(); // alert를 끄면 페이지를 새로고침하여 포인트를 업데이트합니다.
								}, 2000);
							} else {
								alert(data.message); // 실패 메시지 표시
							}
						})
						.catch(error => {
							alert('충전에 실패했습니다.');
							console.error('Error:', error);
						});
				});
			} else {
				// 결제 실패 시 메시지
				msg = '결제에 실패하였습니다.';
				msg += '\n에러내용 : ' + rsp.error_msg;
				alert(msg);
				// 실패 시 페이지 새로고침
				location.reload();
			}
		});
	});
});

$(document).ready(function() {
	var IMP = window.IMP;
	IMP.init('imp76636773'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용

	$('#kakaoPay').click(function() {
		// 사용자 입력 필드에서 금액을 가져옵니다.
		const amount = $('#chargeAmount').val().replace(/[^\d]/g, '');

		if (amount <= 0) {
			alert('충전 금액은 0보다 커야 합니다.');
			return;
		}

		IMP.request_pay({
			pg: 'kakaopay.TC0ONETIME', // PG사 선택 결제할 곳
			pay_method: 'card', // 지불수단
			merchant_uid: 'SUSUMA-' + new Date().getTime(), // 가맹점에서 구별할 수 있는 고유 ID
			name: 'SUSUMA 포인트 충전',
			amount: amount, // 사용자 입력 금액
		}, function(rsp) { // 콜백 함수
			var msg;
			if (rsp.success) {
				// 결제 정보 확인을 위한 요청
				$.ajax({
					url: "<%=request.getContextPath()%>/payments/complete", // 가맹점 서버의 결제 완료 확인 URL
					type: 'POST',
					dataType: 'json',
					data: {
						imp_uid: rsp.imp_uid // 결제 고유 ID
					}
				}).done(function(data) {
					if (data.everythings_fine) {
						// 포인트 충전 요청
						fetch('/Susuma/member/chargePoints.member', {
							method: 'POST',
							headers: {
								'Content-Type': 'application/x-www-form-urlencoded',
							},
							body: new URLSearchParams({
								points: amount, // 충전할 포인트
								imp_uid: rsp.imp_uid // 결제 고유 ID
							}),
						})
							.then(response => response.json())
							.then(data => {
								if (data.status === 'success') {

								} else {
									alert(data.message); // 실패 메시지 표시
								}
							})
							.catch(error => {
								alert('충전에 실패했습니다.');
								console.error('Error:', error);
							});

					} else {
						// 결제 정보가 유효하지 않을 때
						alert('결제에 문제가 발생했습니다.');
					}
				}).fail(function(xhr, status, error) {
					// 포인트 충전 요청
					fetch('/Susuma/member/chargePoints.member', {
						method: 'POST',
						headers: {
							'Content-Type': 'application/x-www-form-urlencoded',
						},
						body: new URLSearchParams({
							points: amount, // 충전할 포인트
							imp_uid: rsp.imp_uid // 결제 고유 ID
						}),
					})
						.then(response => response.json())
						.then(data => {
							if (data.status === 'success') {
								msg = '결제가 완료되었습니다.';
								msg += '\n고유ID : ' + rsp.imp_uid;
								msg += '\n주문번호 : ' + rsp.merchant_uid;
								msg += '\n충전금액 : ' + rsp.paid_amount + 'P';
								msg += '\nSUSUMA 포인트 충전이 완료되었습니다.';
								alert(msg);
								setTimeout(function() {
									location.reload(); // alert를 끄면 페이지를 새로고침하여 포인트를 업데이트합니다.
								}, 2000);
							} else {
								alert(data.message); // 실패 메시지 표시
							}
						})
						.catch(error => {
							alert('충전에 실패했습니다.');
							console.error('Error:', error);
						});
				});
			} else {
				// 결제 실패 시 메시지
				msg = '결제에 실패하였습니다.';
				msg += '\n에러내용 : ' + rsp.error_msg;
				alert(msg);
				// 실패 시 페이지 새로고침
				location.reload();
			}
		});
	});
});

$(document).ready(function() {
	var IMP = window.IMP;
	IMP.init('imp76636773'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용

	$('#tossPay').click(function() {
		// 사용자 입력 필드에서 금액을 가져옵니다.
		const amount = $('#chargeAmount').val().replace(/[^\d]/g, '');

		if (amount <= 0) {
			alert('충전 금액은 0보다 커야 합니다.');
			return;
		}

		IMP.request_pay({
			pg: 'tosspay.tosstest', // PG사 선택 결제할 곳 (이니시스 : html5_inicis.INIBillTst , 카카오페이 : kakaopay.TC0ONETIME)
			pay_method: 'card', // 지불수단
			merchant_uid: 'SUSUMA-' + new Date().getTime(), // 가맹점에서 구별할 수 있는 고유 ID
			name: 'SUSUMA 포인트 충전',
			amount: amount + 'P', // 사용자 입력 금액
		}, function(rsp) { // 콜백 함수
			var msg;
			if (rsp.success) {
				// 결제 정보 확인을 위한 요청
				$.ajax({
					url: "<%=request.getContextPath()%>/payments/complete", // 가맹점 서버의 결제 완료 확인 URL
					type: 'POST',
					dataType: 'json',
					data: {
						imp_uid: rsp.imp_uid // 결제 고유 ID
					}
				}).done(function(data) {
					if (data.everythings_fine) {
						// 포인트 충전 요청
						fetch('/Susuma/member/chargePoints.member', {
							method: 'POST',
							headers: {
								'Content-Type': 'application/x-www-form-urlencoded',
							},
							body: new URLSearchParams({
								points: amount, // 충전할 포인트
								imp_uid: rsp.imp_uid // 결제 고유 ID
							}),
						})
							.then(response => response.json())
							.then(data => {
								if (data.status === 'success') {

								} else {
									alert(data.message); // 실패 메시지 표시
								}
							})
							.catch(error => {
								alert('충전에 실패했습니다.');
								console.error('Error:', error);
							});

					} else {
						// 결제 정보가 유효하지 않을 때
						alert('결제에 문제가 발생했습니다.');
					}
				}).fail(function(xhr, status, error) {
					// 포인트 충전 요청
					fetch('/Susuma/member/chargePoints.member', {
						method: 'POST',
						headers: {
							'Content-Type': 'application/x-www-form-urlencoded',
						},
						body: new URLSearchParams({
							points: amount, // 충전할 포인트
							imp_uid: rsp.imp_uid // 결제 고유 ID
						}),
					})
						.then(response => response.json())
						.then(data => {
							if (data.status === 'success') {
								msg = '결제가 완료되었습니다.';
								msg += '\n고유ID : ' + rsp.imp_uid;
								msg += '\n주문번호 : ' + rsp.merchant_uid;
								msg += '\n충전금액 : ' + rsp.paid_amount + 'P';
								msg += '\nSUSUMA 포인트 충전이 완료되었습니다.';
								alert(msg);
								setTimeout(function() {
									location.reload(); // alert를 끄면 페이지를 새로고침하여 포인트를 업데이트합니다.
								}, 2000);
							} else {
								alert(data.message); // 실패 메시지 표시
							}
						})
						.catch(error => {
							alert('충전에 실패했습니다.');
							console.error('Error:', error);
						});
				});
			} else {
				// 결제 실패 시 메시지
				msg = '결제에 실패하였습니다.';
				msg += '\n에러내용 : ' + rsp.error_msg;
				alert(msg);
				// 실패 시 페이지 새로고침
				location.reload();
			}
		});
	});
});


$(document).ready(function() {
	var IMP = window.IMP;
	IMP.init('imp76636773'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용

	$('#naver').click(function() {
		// 사용자 입력 필드에서 금액을 가져옵니다.
		const amount = $('#chargeAmount').val().replace(/[^\d]/g, '');

		if (amount <= 0) {
			alert('충전 금액은 0보다 커야 합니다.');
			return;
		}

		IMP.request_pay({
			pg: 'kcp.AO0Q9', // PG사 선택 결제할 곳 (이니시스 : html5_inicis.INIBillTst , 카카오페이 : kakaopay.TC0ONETIME)
			pay_method: 'card', // 지불수단
			merchant_uid: 'SUSUMA-' + new Date().getTime(), // 가맹점에서 구별할 수 있는 고유 ID
			name: 'SUSUMA 포인트 충전',
			amount: amount + 'P', // 사용자 입력 금액
		}, function(rsp) { // 콜백 함수
			var msg;
			if (rsp.success) {
				// 결제 정보 확인을 위한 요청
				$.ajax({
					url: "<%=request.getContextPath()%>/payments/complete", // 가맹점 서버의 결제 완료 확인 URL
					type: 'POST',
					dataType: 'json',
					data: {
						imp_uid: rsp.imp_uid // 결제 고유 ID
					}
				}).done(function(data) {
					if (data.everythings_fine) {
						// 포인트 충전 요청
						fetch('/Susuma/member/chargePoints.member', {
							method: 'POST',
							headers: {
								'Content-Type': 'application/x-www-form-urlencoded',
							},
							body: new URLSearchParams({
								points: amount, // 충전할 포인트
								imp_uid: rsp.imp_uid // 결제 고유 ID
							}),
						})
							.then(response => response.json())
							.then(data => {
								if (data.status === 'success') {

								} else {
									alert(data.message); // 실패 메시지 표시
								}
							})
							.catch(error => {
								alert('충전에 실패했습니다.');
								console.error('Error:', error);
							});

					} else {
						// 결제 정보가 유효하지 않을 때
						alert('결제에 문제가 발생했습니다.');
					}
				}).fail(function(xhr, status, error) {
					// 포인트 충전 요청
					fetch('/Susuma/member/chargePoints.member', {
						method: 'POST',
						headers: {
							'Content-Type': 'application/x-www-form-urlencoded',
						},
						body: new URLSearchParams({
							points: amount, // 충전할 포인트
							imp_uid: rsp.imp_uid // 결제 고유 ID
						}),
					})
						.then(response => response.json())
						.then(data => {
							if (data.status === 'success') {
								msg = '결제가 완료되었습니다.';
								msg += '\n고유ID : ' + rsp.imp_uid;
								msg += '\n주문번호 : ' + rsp.merchant_uid;
								msg += '\n충전금액 : ' + rsp.paid_amount + 'P';
								msg += '\nSUSUMA 포인트 충전이 완료되었습니다.';
								alert(msg);
								setTimeout(function() {
									location.reload(); // alert를 끄면 페이지를 새로고침하여 포인트를 업데이트합니다.
								}, 2000);
							} else {
								alert(data.message); // 실패 메시지 표시
							}
						})
						.catch(error => {
							alert('충전에 실패했습니다.');
							console.error('Error:', error);
						});
				});
			} else {
				// 결제 실패 시 메시지
				msg = '결제에 실패하였습니다.';
				msg += '\n에러내용 : ' + rsp.error_msg;
				alert(msg);
				// 실패 시 페이지 새로고침
				location.reload();
			}
		});
	});
});

$(document).ready(function() {
	var IMP = window.IMP;
	IMP.init('imp76636773'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용

	$('#danal').click(function() {
		// 사용자 입력 필드에서 금액을 가져옵니다.
		const amount = $('#chargeAmount').val().replace(/[^\d]/g, '');

		if (amount <= 0) {
			alert('충전 금액은 0보다 커야 합니다.');
			return;
		}

		IMP.request_pay({
			pg: 'danal.A010002002', // PG사 선택 결제할 곳 (이니시스 : html5_inicis.INIBillTst , 카카오페이 : kakaopay.TC0ONETIME)
			pay_method: 'card', // 지불수단
			merchant_uid: 'SUSUMA-' + new Date().getTime(), // 가맹점에서 구별할 수 있는 고유 ID
			name: 'SUSUMA 포인트 충전',
			amount: amount + 'P', // 사용자 입력 금액
		}, function(rsp) { // 콜백 함수
			var msg;
			if (rsp.success) {
				// 결제 정보 확인을 위한 요청
				$.ajax({
					url: "<%=request.getContextPath()%>/payments/complete", // 가맹점 서버의 결제 완료 확인 URL
					type: 'POST',
					dataType: 'json',
					data: {
						imp_uid: rsp.imp_uid // 결제 고유 ID
					}
				}).done(function(data) {
					if (data.everythings_fine) {
						// 포인트 충전 요청
						fetch('/Susuma/member/chargePoints.member', {
							method: 'POST',
							headers: {
								'Content-Type': 'application/x-www-form-urlencoded',
							},
							body: new URLSearchParams({
								points: amount, // 충전할 포인트
								imp_uid: rsp.imp_uid // 결제 고유 ID
							}),
						})
							.then(response => response.json())
							.then(data => {
								if (data.status === 'success') {

								} else {
									alert(data.message); // 실패 메시지 표시
								}
							})
							.catch(error => {
								alert('충전에 실패했습니다.');
								console.error('Error:', error);
							});

					} else {
						// 결제 정보가 유효하지 않을 때
						alert('결제에 문제가 발생했습니다.');
					}
				}).fail(function(xhr, status, error) {
					// 포인트 충전 요청
					fetch('/Susuma/member/chargePoints.member', {
						method: 'POST',
						headers: {
							'Content-Type': 'application/x-www-form-urlencoded',
						},
						body: new URLSearchParams({
							points: amount, // 충전할 포인트
							imp_uid: rsp.imp_uid // 결제 고유 ID
						}),
					})
						.then(response => response.json())
						.then(data => {
							if (data.status === 'success') {
								msg = '결제가 완료되었습니다.';
								msg += '\n고유ID : ' + rsp.imp_uid;
								msg += '\n주문번호 : ' + rsp.merchant_uid;
								msg += '\n충전금액 : ' + rsp.paid_amount + 'P';
								msg += '\nSUSUMA 포인트 충전이 완료되었습니다.';
								alert(msg);
								setTimeout(function() {
									location.reload(); // alert를 끄면 페이지를 새로고침하여 포인트를 업데이트합니다.
								}, 2000);
							} else {
								alert(data.message); // 실패 메시지 표시
							}
						})
						.catch(error => {
							alert('충전에 실패했습니다.');
							console.error('Error:', error);
						});
				});
			} else {
				// 결제 실패 시 메시지
				msg = '결제에 실패하였습니다.';
				msg += '\n에러내용 : ' + rsp.error_msg;
				alert(msg);
				// 실패 시 페이지 새로고침
				location.reload();
			}
		});
	});
});







