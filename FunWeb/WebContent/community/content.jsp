<%@page import="java.util.List"%>
<%@page import="comment.CommentBean"%>
<%@page import="comment.CommentDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/comments.css" rel="stylesheet" type="text/css">

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
	function show(index){
		document.getElementById("txtDivid"+index).style.display = 'block';
		document.getElementById("txtDivco"+index).style.display = 'block';
		document.getElementById("txtDivcanbtn"+index).style.display = 'block';
	}
	function hide(index){
		document.getElementById("txtDivid"+index).style.display = 'none';
		document.getElementById("txtDivco"+index).style.display = 'none';
		document.getElementById("txtDivcanbtn"+index).style.display = 'none';
	}
	function cmUpdateOpen(index){
		document.getElementById("txtDivcoUpdate"+index).style.display = 'block';
		document.getElementById("txtDivupdatecanbtn"+index).style.display = 'block';
		document.getElementById("txtDivupdate"+index).style.display = 'block';
	}
	function updatehide(index){
		document.getElementById("txtDivcoUpdate"+index).style.display = 'none';
		document.getElementById("txtDivupdatecanbtn"+index).style.display = 'none';
		document.getElementById("txtDivupdate"+index).style.display = 'none';
	}
</script>
<body>
	<%-- 글은 볼수있음
	<%	
		String id = (String)session.getAttribute("id");
		
		if(id == null){
	%>
	<script type="text/javascript">
		alert("로그인 후 이용해주세요.");
	</script>
	<%
			response.sendRedirect("../member/login.jsp");
		}
		// id 님이 로그인 하셨습니다.(페이지 출력)
		// 로그인 -> 세션 id값 존재
		// 로그인 X, 잘못된 경로 접근 -> 다시 로그인 입력창으로 이동
	%> --%>
	<%
		
		request.setCharacterEncoding("UTF-8");
	
		String id = (String)session.getAttribute("id");
		// 선택한 글의 내용(정보)를 보여주는 페이지
		// num, pageNum 파라미터 저장
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");

		// DB 처리 객체 생성
		BoardDAO bdao = new BoardDAO();

		// 조회수를 변경 ( 1증가 )->Db 메서드 
		bdao.updateReadcount(num);

		// 글번호에 해당하는 정보를 가져오기 
		BoardBean bb = bdao.getBoard(num);

		// 표사용하여 정보 출력
		
		/////////////////////////////////////////////////////////
		
		CommentDAO cdao = new CommentDAO();
		
		
		int count = cdao.getCommentCount(num);
		List commentList = null;
		if(count != 0){
			commentList = cdao.getComment(num);//comment에선 board_num에 대입
		}

	%>
	<div id="wrap">
		<!-- 헤더가 들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더가 들어가는 곳 -->

		<!-- 본문 들어가는 곳 -->
		<!-- 서브페이지 메인이미지 -->
		<div id="sub_img"></div>
		<!-- 서브페이지 메인이미지 -->
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="free_notice_board.jsp">자유게시판</a></li>
				<li><a href="#">졸업생/직장인</a></li>
				<li><a href="#">이슈/정치/사회</a></li>
				<li><a href="#">Best 게시글</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 글쓰기 -->
		<article>
			<h1><%=bb.getCategory() %></h1>
				<table width="100%">
					<tr>
						<td colspan="2">
							<h2><%=bb.getSubject() %></h2>
						</td>
					</tr>
					<tr>
						<td><%=bb.getId() %></td>
						<%
							String date = new SimpleDateFormat("YYYY-MM-dd HH:mm").format(bb.getReg_date()); 
						%>
						<td><%=date %></td>
					</tr>
					<tr>
						<td colspan="2"><%=bb.getContent() %>  </td>
					</tr>
					<tr>
						
					</tr>
				</table>
			<input type="button" value="목록" class="listbtn" onclick="location.href='free_notice_board.jsp?pageNum=<%=pageNum%>'">
			<%
				if(id != null && id.equals(bb.getId())){
			%>
			<input type="button" value="수정" class="listbtn" onclick="location.href='updateForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
			<input type="button" value="삭제" class="listbtn" onclick="location.href='deleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
			<%
				}
			%>
			<hr>
			<div class="comment">
			<h2>댓글달기</h2>
			<table>
				<tr>
					<td>
					<%
						if(id != null){
					%>
						작성자 : <%=id %>
					<%
						}else{
					%>
						로그인 후 이용해주세요.
					<%
						}
					%>
					</td>
				</tr>
				<tr>
					<td>
						<form id="enquiry" action="comment_Pro.jsp?num=<%=num %>&pageNum=<%=pageNum %>" method="post">
  							<textarea maxlength="140" name="comment" placeholder="댓글을 입력해주세요."></textarea>
  							<input type="submit" value="등록하기">
						</form>
					</td>
				</tr>
			</table>
			</div>
			<br>
			<h2>댓글 <span class="count"><%=count %></span></h2>
			<hr>
			
			<table width="650">
			<%
				if(count != 0){
					for(int i=0;i<commentList.size();i++){
						CommentBean cb = (CommentBean)commentList.get(i);
						// 답글 들여쓰기
						int wid=0;
						if(cb.getRe_lev() > 0){
							wid = 30;
							
						}
						if(cb.getRe_id() != null){
			%>
			
				<tr>
					<td class="comm_id">
					<img src="level.gif" height="15" width="<%=wid%>">
						<span class="comm_id">@<%=cb.getRe_id() %></span>
					</td>
				</tr>
			<%
						}
			%>
				<tr>
				
					<td class="comm_id" colspan="1">
					<img src="level.gif" height="15" width="<%=wid%>">
						<%=cb.getId() %>
						<%
							if(cb.getId().equals(bb.getId())){
						%>
							<span class="writer">글쓴이</span>
						<%
							}
						%>
					</td>
			<%
				String comm_date = new SimpleDateFormat("YYYY-MM-dd HH:mm").format(cb.getReg_date()); 
			%>
					<td class="comm_date"><%=comm_date %></td>
				</tr>
				<tr>
					<td class="comm_comment">
						<img src="level.gif" height="15" width="<%=wid%>">
						<%=cb.getComment() %>
					</td>
					<td class="comm_input">
					<%
						if(id != null && id.equals(cb.getId())){
					%>
					<input type="button" value="수정" class="updatebtn" onclick="cmUpdateOpen(<%=i %>)")>
					<input type="button" value="삭제" class="deletebtn" onclick="location.href='commentdeletePro.jsp?num=<%=cb.getNum()%>&pageNum=<%=pageNum%>&board_num=<%=cb.getBoard_num()%>'">
					<%
						}
					%>
					<input type="button" value="댓글" id="recommbtn<%=i %>" class="re_commbtn" onclick="show(<%=i%>)">
					</td>
				</tr>
				
				<tr>
					<td>
						<div id="txtDivid<%=i %>" style="display: none;">
							<span class="re_comm_id">@<%=cb.getId() %></span>댓글달기 
						</div>
					</td>
					<td class="comm_input">
						<div id="txtDivcanbtn<%=i %>" style="display: none;" >
							<input type="button" value="닫기" id="recommcanbtn<%=i %>" class="re_commbtn" onclick="hide(<%=i%>)">
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="comm_input">
						<form action="re_commemnt_pro.jsp" method="post">
						<div id="txtDivco<%=i %>" style="display: none;">
							<input type="hidden" name="board_num" value="<%=cb.getBoard_num() %>">
							<input type="hidden" name="re_id" value="<%=cb.getId() %>">
							<input type="hidden" name="re_ref" value="<%=cb.getRe_ref() %>">
							<input type="hidden" name="re_lev" value="<%=cb.getRe_lev() %>">
							<input type="hidden" name="re_seq" value="<%=cb.getRe_seq() %>">
							<input type="hidden" name="pageNum" value="<%=pageNum %>">
							<textarea maxlength="140" id="re_comm<%=i %>" name="re_comment" placeholder="댓글을 입력해주세요."></textarea>
							<input type="submit" value="등록" class="re_commbtn">
						</div>
						</form>
					</td>
				</tr>
				<tr>
				<td>
					<div id="txtDivupdate<%=i %>" style="display: none;" >
					댓글수정
					</div>
				</td>
				<td class="comm_input" >
						<div id="txtDivupdatecanbtn<%=i %>" style="display: none;" >
							<input type="button" value="닫기" id="recommcanbtn<%=i %>" class="re_commbtn" onclick="updatehide(<%=i%>)">
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="comm_input">
						<form action="cmUpdatePro.jsp" method="post">
						<div id="txtDivcoUpdate<%=i %>" style="display: none;">
							<input type="hidden" name="board_num" value="<%=cb.getBoard_num() %>">
							<input type="hidden" name="num" value="<%=cb.getNum() %>">
							<input type="hidden" name="pageNum" value="<%=pageNum %>">
							<textarea maxlength="140" id="re_comm<%=i %>" name="re_commentupdate" class="coupdatetxt"><%=cb.getComment() %></textarea>
							<input type="submit" value="수정" class="re_commbtn">
						</div>
						</form>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<hr>
					</td>
				</tr>
				
				<%
					}
				}
			%>
			</table>
			
		</article>
		<!-- 글쓰기 -->
		<div class="clear"></div>
		
		
		<!-- 푸터 들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는 곳 -->
	</div>
</body>
</html>



