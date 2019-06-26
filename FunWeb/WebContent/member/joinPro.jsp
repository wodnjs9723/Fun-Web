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
	<!-- <h1>WebContent/member/joinPro.jsp</h1> -->
	<%
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		// join.jsp 페이지에서 전달된 정보를 저장
		// -> MemberBean(파라미터값 저장)
	
	%>
		<jsp:useBean id="mb" class="member.MemberBean"/>
		<jsp:setProperty property="*" name="mb"/>
	<%
		// -> MemberDAO (insertMember()) -> DB에 저장
		MemberDAO mdao = new MemberDAO();
		mdao.insertMember(mb);
		// => 로그인페이지로 이동(login.jsp)
	%>
	<script type="text/javascript">
		alert("회원가입 성공");
		location.href="login.jsp";
	</script>
</body>
</html>