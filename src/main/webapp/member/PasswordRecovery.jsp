<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../include/head.jsp"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>

</head>

<body>
	<%@ include file="../include/header.jsp"%>
		
	<%
	    String userEmail = request.getParameter("email"); // 사용자 입력 이메일
	
	    if (userEmail != null && !userEmail.isEmpty()) {
	        String tempPassword = generateTemporaryPassword(); // 임시 비밀번호 생성
	        boolean emailSent = false;
	        boolean userExists = false;
	
	        try {
	            // 데이터베이스 연결 설정
	            String dbURL = "jdbc:oracle:thin:@172.30.1.23:1521:xe"; // 데이터베이스 URL
	            String dbUser = "SSM"; // 데이터베이스 사용자 이름
	            String dbPassword = "SSM"; // 데이터베이스 비밀번호
	            
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);
	
	            // 이메일이 존재하는지 확인
	            String sql = "SELECT EMAIL FROM MEMBER WHERE EMAIL = ?";
	            PreparedStatement statement = connection.prepareStatement(sql);
	            statement.setString(1, userEmail);
	            ResultSet resultSet = statement.executeQuery();
	
	            if (resultSet.next()) {
	                userExists = true;
	                emailSent = sendTemporaryPassword(userEmail, tempPassword); // 임시 비밀번호 이메일 발송
	
	                if (emailSent) {
	                    // 임시 비밀번호를 데이터베이스에 업데이트
	                    String updateSql = "UPDATE MEMBER SET PW = ? WHERE EMAIL = ?";
	                    PreparedStatement updateStatement = connection.prepareStatement(updateSql);
	                    updateStatement.setString(1, tempPassword);
	                    updateStatement.setString(2, userEmail);
	                    updateStatement.executeUpdate();
	                }
	            }
	
	            resultSet.close();
	            statement.close();
	            connection.close();
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	
	        if (userExists) {
	            if (emailSent) {
	                out.println("임시 비밀번호가 이메일로 발송되었습니다.");
	            } else {
	                out.println("이메일 발송에 실패했습니다.");
	            }
	        } else {
	            out.println("입력한 이메일 주소가 존재하지 않습니다.");
	        }
	    } else {
	        out.println("이메일 주소를 입력하세요.");
	    }
	%>
	
	<form action="passwordRecovery.jsp" method="post">
	    <label for="email">이메일 주소:</label>
	    <input type="email" id="email" name="email" required>
	    <button type="submit">비밀번호 찾기</button>
	</form>
	
	<%! 
	    // 임시 비밀번호 생성 메서드
	    String generateTemporaryPassword() {
	        return "a1b2c3d4"; // 임시 비밀번호 예시
	    }
	
	    // 이메일 발송 메서드
	    boolean sendTemporaryPassword(String toEmail, String tempPassword) {
	        // 이메일 발송 설정
	        String host = "smtp.naver.com";
	        String port = "587";
	        String username = "tjgml2435@naver.com";
	        String password = "kosaf12639!"; // 네이버 계정 비밀번호
	
	        Properties props = new Properties();
	        props.put("mail.smtp.auth", "true");
	        props.put("mail.smtp.starttls.enable", "true");
	        props.put("mail.smtp.host", host);
	        props.put("mail.smtp.port", port);
	
	        Session session = Session.getInstance(props, new Authenticator() {
	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(username, password);
	            }
	        });
	
	        try {
	            Message message = new MimeMessage(session);
	            message.setFrom(new InternetAddress(username));
	            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
	            message.setSubject("비밀번호 재설정 안내");
	            message.setText("안녕하세요,\n\n회원님의 임시 비밀번호는 다음과 같습니다: " + tempPassword + "\n\n이 임시 비밀번호로 로그인 후 비밀번호를 변경해주시기 바랍니다.");
	
	            Transport.send(message);
	            return true;
	        } catch (MessagingException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }
	%>
		

	<%@ include file="../include/footer.jsp"%>

</body>

</html>