<%@page import="comment.CommentBean"%>
<%@page import="comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>e
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%	
		request.setCharacterEncoding("UTF-8");
		String id = (String)session.getAttribute("id");
		int boardnum = Integer.parseInt(request.getParameter("num"));
		String pageNum= request.getParameter("pageNum");
		String comment = request.getParameter("comment");
		
		if(id == null){
	%>
		<script type="text/javascript">
			alert("로그인후 이용해주세요.");
			history.back();
		</script>
	<%
		}else{
			CommentBean cb = new CommentBean();
			cb.setId(id);
			cb.setBoard_num(boardnum);
			cb.setComment(comment);
			
			CommentDAO cdao = new CommentDAO();
			
			cdao.insertcomment(cb);
			
			response.sendRedirect("content.jsp?num="+boardnum+"&pageNum="+pageNum); 
		}
	%>
</body>
</html>