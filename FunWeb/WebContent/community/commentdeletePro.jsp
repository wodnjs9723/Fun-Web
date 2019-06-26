<%@page import="comment.CommentDAO"%>
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
	
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		
		
		CommentDAO cdao = new CommentDAO();
		
		cdao.deletecomment(num);
		
		response.sendRedirect("content.jsp?num="+board_num+"&pageNum="+pageNum);
	%>
</body>
</html>