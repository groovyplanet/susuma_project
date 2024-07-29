package com.susuma.controller;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("*.mail")
public class mailController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doAction(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doAction(req, resp);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		/* SMTP 서버 설정 */
		String port = "587"; // ssl
		String host = "smtp.naver.com";
		String username = "wonpic26@naver.com"; // 예원 임시 이메일
		String password = "tntnak12"; // 예원 임시 비밀번호

		Properties props = new Properties();
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true"); // TLS 사용 설정
		props.put("mail.smtp.ssl.protocols", "TLSv1.2"); // TLS 버전 설정

		Session session = Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		/* 메일 발송 */
		//String sendMail = "ssm@susuma.com"; // 보낸 사람
		String recieveMail = "chojo1031@naver.com"; // 받는 사람(임시)
		String tempPassword = ""; // 임시 비밀번호

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(username));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recieveMail));
			message.setSubject("[수수마] 비밀번호 재설정 안내");
			message.setText("안녕하세요,\n\n회원님의 임시 비밀번호는 다음과 같습니다: " + tempPassword + "\n\n이 임시 비밀번호로 로그인 후 비밀번호를 변경해주시기 바랍니다.");
			
			Transport.send(message);
			System.out.println("이메일 전송 완료");

		} catch (MessagingException e) {

			e.printStackTrace();
		}
	}

}
