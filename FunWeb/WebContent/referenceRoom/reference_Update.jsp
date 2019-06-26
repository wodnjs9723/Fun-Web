<%@page import="reference.ReferenceBean"%>
<%@page import="reference.ReferenceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->

<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
 <style type="text/css">
 .inputbtncss{
 	border: none;
	background-color: #FFF;
 }
 .refer_subject{
 	width: 300px;
 }
 
 </style>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	ReferenceDAO rdao = new ReferenceDAO();
	
	ReferenceBean rb = rdao.getReference(num);
	%>
	<div id="wrap">
		<!-- 헤더가 들어가는 곳 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<!-- 헤더가 들어가는 곳 -->

		<!-- 본문 들어가는 곳 -->
		<!-- 서브페이지 메인이미지 -->
		<div id="sub_img"></div>
		<!-- 서브페이지 메인이미지 -->
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="#">Java</a></li>
				<li><a href="#">Jsp</a></li>
				<li><a href="#">DataBase</a></li>
				<li><a href="#">Android</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 게시판 -->
		<article>
			<h1>자료실</h1>
			<form action="reference_UpdatePro.jsp" method="post" enctype="multipart/form-data">
					<input type="hidden" name="num" value="<%=rb.getNum()%>">
					<input type="hidden" name="pageNum" value="<%=pageNum%>">
					<input type="hidden" name="oldfile_name" value="<%=rb.getRefer_file_name()%>">
					제목 : <input type="text" name="subject" class="refer_subject" value="<%=rb.getRefer_subject()%>"><br>
					파일 : <input type="file" name="file_name"><br>
					<textarea rows="30" cols="100" name="content"><%=rb.getRefer_content() %></textarea>
				<input type="submit" name="수정" class="inputbtncss"><br>
			</form>
			<div class="clear"></div>
		</article>
		<!-- 게시판 -->
		<div class="clear"></div>
		<!-- 푸터 들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는 곳 -->
	</div>
</body>
</html>



