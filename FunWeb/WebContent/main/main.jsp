<%@page import="gallery.GalleryBean"%>
<%@page import="gallery.GalleryDAO"%>
<%@page import="reference.ReferenceBean"%>
<%@page import="reference.ReferenceDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">

<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->

<!--[if IE 6]>
 <script src="script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->


</head>
<body>
	<%
		
		
		BoardDAO bdao = new BoardDAO(); // 게시판 자료 불러오기
		ReferenceDAO rdao = new ReferenceDAO(); // 자료실 자료 불러오기
		GalleryDAO gdao = new GalleryDAO(); // 갤러리 자료 불러오기
		
		List boardList = bdao.getBoardList();
		
		List referList = rdao.getReferenceList();
		
		List galleryList = gdao.main_getGallery();
		
		String date = null;
	%>
	<div id="wrap">
		<!-- 헤더파일들어가는 곳 -->
			<jsp:include page="../inc/top.jsp"></jsp:include>
		<!-- 헤더파일들어가는 곳 -->
		<!-- 메인이미지 들어가는곳 -->
		<div class="clear"></div>
		<div id="main_img">
			<img src="../images/main_img.jpg" width="971" height="282">
		</div>
		<!-- 메인이미지 들어가는곳 -->
		<!-- 메인 콘텐츠 들어가는 곳 -->
		<article id="front">
			<div id="solution" onclick="location.href='../gallery/gallery_main.jsp'">
			<%
				for(int i=0;i<galleryList.size();i++){
				GalleryBean gb = (GalleryBean)galleryList.get(i);
				date = new SimpleDateFormat("YYYY-MM-dd HH:mm").format(gb.getReg_date()); 
			%>
				<div id="hosting">
				<h3><%=gb.getImg_title() %></h3>
					<img src="../upload/<%=gb.getImg_name() %>" width="200" height="100" >
				</div>
			<%
				}
			%>
			</div>
			<div class="clear"></div>
			<div id="news_notice">
				<h3>
					<span class="orange">&nbsp;&nbsp;&nbsp;&nbsp;자료실</span>
				</h3>
				<table>
				<%
					for (int i = 0; i < referList.size(); i++) {
						ReferenceBean rb = (ReferenceBean) referList.get(i);
						date = new SimpleDateFormat("YYYY.MM.dd HH:mm").format(rb.getReg_date());
				%>
					<tr>
						<td class="contxt">
							<a href="../referenceRoom/reference_content.jsp?num=<%=rb.getNum()%>&pageNum=1"><%=rb.getRefer_subject() %></a>
						</td>
						<td><%=date %></td>
					</tr>
				<%
					}
				%>
				</table>
			</div>
			<div id="news_notice">
				<h3 class="brown">자유 게시판</h3>
				
				<table>
				<%
					for (int i = 0; i < boardList.size(); i++) {
						BoardBean bb = (BoardBean) boardList.get(i);
						date = new SimpleDateFormat("YYYY.MM.dd HH:mm").format(bb.getReg_date());
				%>
					<tr>
						<td class="contxt">
							<a href="../community/content.jsp?num=<%=bb.getNum()%>&pageNum=1" class="left"><%=bb.getSubject()%></a>
						</td>
						<td><%=date %></td>
					</tr>
				<%
					}
				%>
				</table>
			</div>
		</article>
		<!-- 메인 콘텐츠 들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터 들어가는 곳 -->
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는 곳 -->
	</div>
</body>
</html>