<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
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
		String id = (String)session.getAttribute("id");
		String category = request.getParameter("category");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		String pageNum = request.getParameter("pageNum");
		
		BoardBean bb = new BoardBean();
		bb.setNum(num);
		bb.setId(id);
		bb.setCategory(category);
		bb.setSubject(subject);
		bb.setContent(content);
		
		BoardDAO bdao = new BoardDAO();
		bdao.updateBoard(bb);
		
		System.out.println("작성자 : "+id);
		System.out.println("분류:" + request.getParameter("category"));
		System.out.println("제목:" + request.getParameter("subject"));
		System.out.println("내용:" + request.getParameter("content"));
		
		response.sendRedirect("free_notice_board.jsp");
	%>
</body>
</html>