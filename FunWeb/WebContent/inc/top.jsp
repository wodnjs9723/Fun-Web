<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<header>
<%
	// 로그인 성공시(세션 id값이 있을경우)
	// ooo 님 | logout(링크)
	
	String id = (String)session.getAttribute("id");
		
	if(id != null){
		// 로그인 상태
%>
	<div id="login">
		<a href="../member/infoCheck.jsp?id=<%=id %>"><%=id %>님</a> | <a href="../member/logout.jsp">logout</a>
	</div>
<%
	}else{
%>
	<div id="login">
		<a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a>
	</div>
<%
	}
%>
	<div class="clear"></div>
	<!-- 로고들어가는 곳 -->
	<div id="logo">
		<img src="../images/logo.gif" width="265" height="62" alt="Fun Web">
	</div>
	<!-- 로고들어가는 곳 -->
	<nav id="top_menu">
		<ul>
			<li><a href="../">HOME</a></li>
			<li><a href="../community/free_notice_board.jsp">커뮤니티</a></li>
			<li><a href="../gallery/gallery_main.jsp">갤러리</a></li>
			<li><a href="../referenceRoom/reference_main.jsp">자료실</a></li>
			<li><a href="../center/service_center.jsp">고객센터</a></li>
		</ul>
	</nav>
</header>
