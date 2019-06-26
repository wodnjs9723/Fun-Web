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
	<h1>WebContent/member/loginPro.jsp</h1>
	<%
		request.setCharacterEncoding("UTF-8");
		// 로그인 처리
		
		// id,pw 정보를 저장
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		// MemberDAO 객체 생성(회원가입 메서드)
		MemberDAO mdao = new MemberDAO();
		int check = mdao.idCheck(id, pass);
		if(check == 1){
		// 1 -> 로그인 성공,id 값을 세션정보로 저장, main.jsp
			session.setAttribute("id", id);
			response.sendRedirect("../main/main.jsp");
		} else if(check == 0){
		// 0 -> "비밀번호 오류", 페이지 뒤로가기
	%>
		<script type="text/javascript">
			alert("비밀번호 오류");
			history.back();
		</script>
	<%
		}else if(check == -1){
		// -1 -> "아이디 없음", 페이지 뒤로가기
	%>
		<script type="text/javascript">
			alert("아이디 오류");
			history.back();
		</script>
	<%
		}
		
		
	%>
</body>
</html>