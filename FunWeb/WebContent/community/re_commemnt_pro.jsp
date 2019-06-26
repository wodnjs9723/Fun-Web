<%@page import="comment.CommentDAO"%>
<%@page import="comment.CommentBean"%>
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
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		int re_ref = Integer.parseInt(request.getParameter("re_ref"));
		int re_lev = Integer.parseInt(request.getParameter("re_lev"));
		int re_seq = Integer.parseInt(request.getParameter("re_seq"));
		String re_comment = request.getParameter("re_comment");
		String re_id = request.getParameter("re_id");
		String pageNum = request.getParameter("pageNum");
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
			cb.setBoard_num(board_num);
			cb.setRe_ref(re_ref);
			cb.setRe_lev(re_lev);
			cb.setRe_seq(re_seq);
			cb.setComment(re_comment);
			cb.setRe_id(re_id);
			
			CommentDAO cdao = new CommentDAO();
			
			cdao.insertRe_Comment(cb);
			
			response.sendRedirect("content.jsp?num="+board_num+"&pageNum="+pageNum); 
		}
	%>
</body>
</html>