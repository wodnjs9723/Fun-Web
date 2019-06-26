<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
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
		// 세션값 X -> 로그인 페이지
		String id = (String)session.getAttribute("id");
			
		if(id == null){
			response.sendRedirect("../member/loginForm.jsp");
		}
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		String pass = request.getParameter("pass");
		
		BoardDAO bdao = new BoardDAO();
		// 삭제 처리 메서드(id,pass)
		// deleteMenber(id,pass)
		int check = bdao.deleteborad(id,pass,num);
		
		if(check == 1){
			%>
			<script type="text/javascript">
               alert("삭제 완료");
               location.href="free_notice_board.jsp?pageNum=<%=pageNum%>";
			</script>
			<%
		}else if(check == 0){
			%>
			<script type="text/javascript">
			   alert("비밀번호 오류!!");
			   history.back();
			</script>
			<%
		}
		// 삭제 완료 = 1, 비밀번호 오류 = 0, 아이디가 없을 경우 = -1
		
	%>
</body>
</html>