<%@page import="member.MemberDAO"%>
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
	%>
	<jsp:useBean id="mb" class="member.MemberBean"/>
	<jsp:setProperty property="*" name="mb"/>
	<%
		MemberDAO mdao = new MemberDAO();
		mdao.updateMember(mb);
	%>
	<script type="text/javascript">
		alert("회원정보 수정 성공");
		location.href="../main/main.jsp";
	</script>
</body>
</html>