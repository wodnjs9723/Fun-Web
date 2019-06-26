<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="mail.SMTPAuthenticator"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	
		String fromEmail = request.getParameter("fromEmail");
		String toEmail = request.getParameter("toEmail");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
		Properties p = new Properties();
		
		p.put("mail.smtp.host", "smtp.naver.com");
		
		p.put("mail.smtp.prot","465");
		p.put("mail.smtp.starttls.enable","true");
		p.put("mail.smtp.auth","true");
		p.put("mail.smtp.debug","true");
		p.put("mail.smtp.socketFactory.prot","465");
		p.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback","fasle");
		
		try{
		Authenticator auth = new SMTPAuthenticator();
		Session ses = Session.getInstance(p,auth);
		
		ses.setDebug(true);
		
		MimeMessage msg = new MimeMessage(ses);
		msg.setSubject(subject);
		
		Address fromAddr = new InternetAddress(fromEmail);
		msg.setFrom(fromAddr);
		
		Address toAddr = new InternetAddress(toEmail);
		msg.addRecipient(Message.RecipientType.TO, toAddr);
		
		msg.setContent(content, "text/html;charset=UTF-8");
		
		Transport.send(msg);
		} catch(Exception e){
			out.println("<script>alert('메일보내기 실패');history.back();</script>");
			return;
		}
		
		out.println("<script>alert('메일보내기 성공');location.href='mailForm.jsp'</script>");
		
		
		
	%>
</body>
</html>