<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
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
	
	String id = (String)session.getAttribute("id");
	if(id == null){
		response.sendRedirect("login.jsp");
	}
	String pass = request.getParameter("pass");
	MemberDAO mdao = new MemberDAO();
	int check = mdao.idCheck(id, pass);
	
	if(check == 1){
		response.sendRedirect("mem_info.jsp");
	}else{
%>
	<script type="text/javascript">
		alert("비밀번호를 다시 확인해주세요.");
		history.back();
	</script>
<%
	}
	
	
	
%>
</body>
</html>