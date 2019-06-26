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
 <script type="text/javascript">
<!--  function chkMailFrm() {
	 var f = document.formmail;
	 if (!f.title.value) {
	  alert("제목을 입력해주세요");
	  f.title.focus();
	  return false;
	 }
	 if (!f.senduser.value) {
	  alert("이름을 입력해주세요");
	  f.senduser.focus();
	  return false;
	 }
	 if (!f.phone.value) {
	  alert("전화번호을 입력해주세요");
	  f.phone.focus();
	  return false;
	 }
	 if (!f.email.value) {
	  alert("이메일을 입력해주세요");
	  f.email.focus();
	  return false;
	 }
	}
 </script>
</head>
<body>
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 메인이미지 -->
		<div id="sub_img_center"></div>
		<!-- 메인이미지 -->

		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="#">공지사항</a></li>
				<li><a href="mailForm.jsp">건의사항</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->

		<!-- 게시판 -->
		<article>
			<h1>메일보내기</h1>
			<form name="formmail" method="get" action="mailPro.jsp"
				onSubmit="return chkMailFrm()">
				<a name=01></a>
				<table width="0" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="../images/mail/back_1.jpg" width="568" height="19" /></td>
					</tr>
					<tr>
						<td><table width="0" border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<td><img src="../images/mail/back_3.jpg" width="21" height="472" /></td>
									<td width="525" align="center">
									
										<table width="100%" border="0" cellpadding="0" cellspacing="5">
											<tr>
												<td width="200" align="right"><font color="#663300">제목</font></td>
												<td width="400" align="left"><input type="text"
													style="BORDER-RIGHT: #cccccc 1px solid; BORDER-TOP: #cccccc 1px solid; BORDER-LEFT: #cccccc 1px solid; WIDTH: 350px; COLOR: #333333; BORDER-BOTTOM: #cccccc 1px solid; HEIGHT: 20px"
													name="subject" size="32" /></td>
											</tr>
											<tr>
												<td align="right">보내는 사람</td>
												<td align="left"><input type="text"
													style="BORDER-RIGHT: #cccccc 1px solid; BORDER-TOP: #cccccc 1px solid; BORDER-LEFT: #cccccc 1px solid; WIDTH: 350px; COLOR: #333333; BORDER-BOTTOM: #cccccc 1px solid; HEIGHT: 20px"
													name="fromEmail" size="32" /></td>
											</tr>
											<tr>
											<tr>
												<td align="right">받는사람</td>
												<td align="left"><input type="text"
													style="BORDER-RIGHT: #cccccc 1px solid; BORDER-TOP: #cccccc 1px solid; BORDER-LEFT: #cccccc 1px solid; WIDTH: 350px; COLOR: #333333; BORDER-BOTTOM: #cccccc 1px solid; HEIGHT: 20px"
													name="toEmail" size="32"/ value="wodnjs9723@daum.net" readonly="readonly"></></td>
											</tr>
											<tr>
												<td align="right"><font color="#663300">내용</font></td>
												<td align="left"><textarea
														style="BORDER-RIGHT: #cccccc 1px solid; BORDER-TOP: #cccccc 1px solid; BORDER-LEFT: #cccccc 1px solid; WIDTH: 350px; COLOR: #333333; BORDER-BOTTOM: #cccccc 1px solid; HEIGHT: 198px"
														name="content" rows="5" cols="26"></textarea></td>
											</tr>
											<tr align="left">
												<td colspan="2">&nbsp;</td>
											</tr>
											<tr>
												<td>&nbsp;</td>
												<td align="right"><input name="submit" type="image"
													value="신청하기" src="../images/mail/ok.jpg" /> <a onclick="reset();"><img
														src="../images/mail/can.jpg" border="0" /></a></td>
											</tr>
										</table>
									</td>
									<td><img src="../images/mail/back_4.jpg" width="22" height="472" /></td>
								</tr>
							</table></td>
					</tr>
					<tr>
						<td><img src="../images/mail/back_2.jpg" width="568" height="19" /></td>
					</tr>
				</table>
			</form>
		</article>
		<!-- 게시판 -->
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터들어가는 곳 -->
	</div>
</body>
</html>