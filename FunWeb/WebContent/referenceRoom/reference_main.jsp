<%@page import="reference.ReferenceBean"%>
<%@page import="reference.ReferenceDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.util.List"%>
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
	// DB에 있는 글정보를 가져와서 처리 
	// DB 처리 객체 생성
	ReferenceDAO rdao = new ReferenceDAO();

	// DB에 저장되어있는 글 개수를 계산 
			int count = rdao.getReferenceCount();

			// 페이징처리 
			// 한페이지에 보여줄 글의 개수를 설정
			int pageSize = 10;
			// 현재위치한 페이지의 위치를 가져오기 
			String pageNum = request.getParameter("pageNum");
			// pageNum값이 없을경우 항상 1페이지
			if (pageNum == null) {
				pageNum = "1";
			}

			//  시작행 계산하기   1 ~ 11 ~ 21 ~ 31 ~ ....
			int currentPage = Integer.parseInt(pageNum);
			int startRow = (currentPage - 1) * pageSize + 1;

			// 끝행 계산하기  10~ 20~ 30~ 40~ ....
			int endRow = currentPage * pageSize;

			// DB에 글이 있을경우에만 글정보를 모두 가져오기
			List referenceList = null;
			if (count != 0) {
				//boardList = bdao.getBoardList();
				referenceList = rdao.getReferenceList(startRow, pageSize);
			}
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
			<table id="notice">
				<tr>
					<th class="tno">번호</th>
					<th class="ttitle">제목</th>
					<th class="twrite">작성자</th>
					<th class="tdate">날짜</th>
					<th class="tread">조회수</th>
				</tr>
				<%
					for(int i=0;i<referenceList.size();i++){
						ReferenceBean rb = (ReferenceBean) referenceList.get(i);
						String date = new SimpleDateFormat("YYYY-MM-dd HH:mm").format(rb.getReg_date());
				%>
				<tr>
					<td><%=rb.getNum() %></td>
					<td class="left"><a href="reference_content.jsp?num=<%=rb.getNum()%>&pageNum=<%=pageNum%>"><%=rb.getRefer_subject() %></a></td>
					<td><%=rb.getRefer_id() %></td>
					<td><%=date%></td>
					<td><%=rb.getReadcount() %></td>
				</tr>
				<%
					}
				%>
				
			</table>
			<div id="table_search">
				<input type="button" value="글쓰기" class="writebtn"	onclick="location.href='referenceForm.jsp'"> 
				<input type="text" name="search" class="input_box"> 
				<input type="button" value="검색" class="btn">
			</div>
			<div class="clear"></div>
			<div id="page_control">
			<%
				// 페이징 처리 출력
				if (count != 0) {
				// 전체 페이지수 계산 
				// 글 : 50개 -> 한 화면 : 10개 출력 / 5개 페이지
				// 글 : 56개 ->  "    : 10개 출력 / 6개 페이지 
				// 전체 글개수 / 페이지크기 (나머지 있을때 + 1,없으면 +0)

				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
				// 한 화면에 보여줄 페이지 번호의 개수 
				int pageBlock = 10;

				// 시작 페이지 번호 계산
				//  1~10 => 1 , 11~20 =>11 , 21~30 => 21
				int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;

				// 끝 페이지 번호 계산
				int endPage = startPage + pageBlock - 1;
				if (endPage > pageCount) {
					endPage = pageCount;
				}

				// 이전
				if (startPage > pageBlock) {
			%>
			<a href="free_notice_board.jsp?pageNum=<%=startPage - pageBlock%>">[이전]</a>
			<%
				}

				// 1...10  11...20  21...30
				for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="free_notice_board.jsp?pageNum=<%=i%>">[<%=i%>]</a>
			<%
				}
				// 다음
				if (endPage < pageCount) {
			%>
				<a href="free_notice_board.jsp?pageNum=<%=startPage + pageBlock%>">[다음]</a>
			<%
				}

				}
			%>
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



