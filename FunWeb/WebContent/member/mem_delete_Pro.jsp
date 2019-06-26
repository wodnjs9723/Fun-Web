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
				response.sendRedirect("loginForm.jsp");
			}
			// 한글처리
			request.setCharacterEncoding("UTF-8");
			// id,pass 값 저장
			String pass = request.getParameter("pass");
			// MemberDAO 객체 생성
			MemberDAO mdao = new MemberDAO();
			// 삭제 처리 메서드(id,pass)
			// deleteMenber(id,pass)
			int check = mdao.deleteMember(id,pass);
			
			if(check == 1){
				session.invalidate();
				%>
				<script type="text/javascript">
	               alert("탈퇴 완료");
	               location.href="../main/main.jsp";
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