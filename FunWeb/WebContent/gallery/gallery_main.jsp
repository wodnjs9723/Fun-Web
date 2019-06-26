<%@page import="gallery.GalleryDAO"%>
<%@page import="gallery.GalleryBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/gallery.css" rel="stylesheet" type="text/css">
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/jquery-3.3.1.js"></script>
<link rel="stylesheet"
				href="//cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css"
				media="screen">
<script	src="//cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.js"></script>

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
<script type="text/javascript">
$(document).ready(function(){
    //FANCYBOX
    //https://github.com/fancyapps/fancyBox
    $(".fancybox").fancybox({
        openEffect: "none",
        closeEffect: "none"
    });
});
</script>
<body>
	<div id="wrap">
		<!-- 헤더가 들어가는 곳 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<!-- 헤더가 들어가는 곳 -->

		<!-- 본문 들어가는 곳 -->
		<!-- 서브페이지 메인이미지 -->
		<div id="sub_img"></div>
		<!-- 서브페이지 메인이미지 -->
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu"></nav>
		<!-- 왼쪽메뉴 -->
		<!-- 게시판 -->
		<article>
			<h1>갤러리</h1>
			<!--####
### How to add in your boostrap project
1) Add jQuery "<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>"
2) Download fancybox (https://github.com/fancyapps/fancyBox)
3) Or use CDN (https://cdnjs.com/libraries/fancybox)
####--!>

<!-- References: https://github.com/fancyapps/fancyBox -->
			<%
				GalleryDAO gdao = new GalleryDAO();
				List galleryList = null;
				galleryList = gdao.getGallery();
			%>

			<div class="container">
				<div class="row">
					<div class='list-group gallery'>
					<%
						for(int i=0;i<galleryList.size();i++){
							GalleryBean gb = (GalleryBean)galleryList.get(i);
							String date = new SimpleDateFormat("YYYY-MM-dd HH:mm").format(gb.getReg_date()); 
					%>
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="../upload/<%=gb.getImg_name() %>"> 
								<img class="img-responsive" alt="" src="../upload/<%=gb.getImg_name() %>" width="680" height="500" />
								<div class="imgA">
									<small class="image_title"><%=gb.getImg_title() %></small>
									<small class="image_reg_date"><%=date %></small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
					<%
						}
					%>
					</div>
					<!-- list-group / end -->
				</div>
				<!-- row / end -->
			</div>
			<!-- container / end -->
			<div class="gallerybtn">
				<input type="button" value="사진올리기" class="gallerybtn"
					onclick="location.href='galleryForm.jsp'">
			</div>
		</article>
		<!-- 게시판 -->
		<div class="clear"></div>
		<!-- 푸터 들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는 곳 -->
	</div>
</body>
</html>



