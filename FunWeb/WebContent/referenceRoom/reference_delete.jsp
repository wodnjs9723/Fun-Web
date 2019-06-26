<%@page import="reference.ReferenceDAO"%>
<%@page import="java.io.File"%>
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
		
		ReferenceDAO rdao = new ReferenceDAO();
		
		String oldfileName = rdao.deleteRefer(num);
		
		// 현재 실행중인 웹프로젝트에 접근(프로젝트의 정보를 가져오기)
		ServletContext ctx = getServletContext();
		
		String realpath = ctx.getRealPath("upload");
		System.out.println(realpath);
		
		
		File oldf = new File(realpath+"\\"+oldfileName);
		oldf.delete();
		
		response.sendRedirect("reference_main.jsp?pageNum="+pageNum);
	%>
</body>
</html>