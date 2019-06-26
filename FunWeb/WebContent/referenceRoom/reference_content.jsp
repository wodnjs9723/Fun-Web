<%@page import="java.text.SimpleDateFormat"%>
<%@page import="reference.ReferenceDAO"%>
<%@page import="reference.ReferenceBean"%>
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
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	ReferenceDAO rdao = new ReferenceDAO();
	
	rdao.updateReadCount(num);
	
	ReferenceBean rb = rdao.getReference(num);
	
	String date = new SimpleDateFormat("yyyy.MM.dd hh:mm:ss").format(rb.getReg_date());
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
			<table id="refer_notice">
				<tr>
					<td colspan="6"><h3><%=rb.getRefer_subject() %></h3></td>
				<tr>
					<td class="refer_writer">작성자</td>
					<td><%=rb.getRefer_id() %></td>
					<td class="refer_regdate">작성일</td>
					<td><%=date %></td>
					<td class="refer_readcount">조회수</td>
					<td><%=rb.getReadcount() %></td>
				</tr>
				<tr>
					<td class="refer_file">첨부파일</td>
					<td colspan="5" style="float: left;">
						<a href="refer_download.jsp?file_name=<%=rb.getRefer_file_name() %>" class="file_a" style="margin-left: 20px; "><%=rb.getRefer_file_name() %></a>
					</td>
				</tr>
				<tr>
					<td colspan="6" class="refer_content">
						<%=rb.getRefer_content() %>
					</td>
				</tr>
			</table>
			<div id="table_search">
				<%
					
					if(id != null && id.equals(rb.getRefer_id())){
				%>
					<input type="button" value="수정" class="refer_listbtn"	onclick="location.href='reference_Update.jsp?num=<%=num %>&pageNum=<%=pageNum%>'"> 
					<input type="button" value="삭제" class="refer_listbtn"	onclick="location.href='reference_delete.jsp?num=<%=num%>&pageNum=<%=pageNum%>'"> 
				<%
					}
				%>
				<input type="button" value="목록" class="refer_listbtn"	onclick="location.href='reference_main.jsp?pageNum=<%=pageNum%>'"> 
			</div>
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



