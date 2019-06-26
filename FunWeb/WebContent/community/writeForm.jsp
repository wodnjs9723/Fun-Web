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
<script type="text/javascript" src="../js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="../daumeditor/css/editor.css" type="text/css" charset="utf-8" />
<script src="../daumeditor/js/editor_loader.js?environment=development"	type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>
<script type="text/javascript">
	function setConfig() {
		var config = {
			txHost : '', /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) http://xxx.xxx.com */
			txPath : '', /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) /xxx/xxx/ */
			txService : 'sample', /* 수정필요없음. */
			txProject : 'sample', /* 수정필요없음. 프로젝트가 여러개일 경우만 수정한다. */
			initializedId : "", /* 대부분의 경우에 빈문자열 */
			wrapper : "tx_trex_container", /* 에디터를 둘러싸고 있는 레이어 이름(에디터 컨테이너) */
			form : 'tx_editor_form' + "", /* 등록하기 위한 Form 이름 */
			txIconPath : "../daumeditor/images/icon/editor/", /*에디터에 사용되는 이미지 디렉터리, 필요에 따라 수정한다. */
			txDecoPath : "../daumeditor/images/deco/contents/", /*본문에 사용되는 이미지 디렉터리, 서비스에서 사용할 때는 완성된 컨텐츠로 배포되기 위해 절대경로로 수정한다. */
			canvas : {
				styles : {
					color : "#123456", /* 기본 글자색 */
					fontFamily : "굴림", /* 기본 글자체 */
					fontSize : "10pt", /* 기본 글자크기 */
					backgroundColor : "#fff", /*기본 배경색 */
					lineHeight : "1.5", /*기본 줄간격 */
					padding : "8px" /* 위지윅 영역의 여백 */
				},
				showGuideArea : false
			},
			events : {
				preventUnload : false
			},
			sidebar : {
				attachbox : {
					show : true,
					confirmForDeleteAll : true
				}
			},
			size : {
				contentWidth : 700
			/* 지정된 본문영역의 넓이가 있을 경우에 설정 */}
		};
		EditorJSLoader.ready(function(Editor) {
			editor = new Editor(config);
		});
		
		 //form submit 버튼 클릭
        $("#save").click(function(){
            //다음에디터가 포함된 form submit
            Editor.save();
        })

	}

	function validForm(editor) {
		var validator = new Trex.Validator();
		var content = editor.getContent();
		if (!validator.exists(content)) {
			alert('내용을 입력하세요');
			return false;
		}
		return true;
	}

	function setForm(editor){
		//var i, input;
		var form = editor.getForm(); 
		var content = editor.getContent(); 
		var textarea = document.createElement('textarea'); 
		//textarea를 생성하여 해당태그에 에디터 입력값들을 신규생성 textarea에 담는다 
		textarea.name = 'content'; 
		textarea.value = content; 
		form.createField(textarea);
		
		 /* var images = editor.getAttachments('image',true);
	     for (i = 0; i < images.length; i++) {
	          // existStage는 현재 본문에 존재하는지 여부
	          // data는 팝업에서 execAttach 등을 통해 넘긴 데이터
	          alert('attachment information - image[' + i + '] \r\n' + JSON.stringify(images[i].data));
	          input = document.createElement('input');
	          input.type = 'hidden';
	          input.name = 'attach_image';
	          input.value = images[i].data.imageurl;  // 예에서는 이미지경로만 받아서 사용
	          tx_editor_form.createField(input);
	     } */
		
		
		return true; 
	}
	
	$(function() {
		$.ajax({
			type : "POST",
			url : "../daumeditor/editor_template.html",
			success : function(data) {
				$("#editorTd").html(data);
				setConfig();
			},
			error : function(request, status, error) {
				alert("에러");
			}
		});
	});
	
</script>
</head>
<body>
	<%	
		String id = (String)session.getAttribute("id");
		
		if(id == null){
	%>
	<script type="text/javascript">
		alert("로그인후 이용해주세요.");
		location.href="../member/login.jsp";
	</script>
	<%
			
		}
		// id 님이 로그인 하셨습니다.(페이지 출력)
		// 로그인 -> 세션 id값 존재
		// 로그인 X, 잘못된 경로 접근 -> 다시 로그인 입력창으로 이동
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
				<li><a href="#">자유게시판</a></li>
				<li><a href="#">졸업생/직장인</a></li>
				<li><a href="#">이슈/정치/사회</a></li>
				<li><a href="#">Best 게시글</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 글쓰기 -->
		<article>
			<h1>글쓰기</h1>
			<form name="tx_editor_form" id="tx_editor_form" action="writePro.jsp" method="post" accept-charset="utf-8">
				<table width="100%">
					<tr>
						<td width="40px">제목</td>
						<td width="60px">
							<select name="category" id="category">
								<option value="가벼운글" selected="selected">가벼운글</option>
								<option value="진지한글">진지한글</option>
								<option value="웃긴글">웃긴글</option>
								<option value="웃긴글">정보</option>
							</select>
						</td>
						<td><input type="text" id="subject" name="subject"/></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" id="editorTd"></td>
					</tr>
					<tr>
						<td colspan="3">
						<input type="submit" id="save" value="저장" >
						<input type="reset" value="초기화" /></td>
					</tr>
				</table>
			</form>
		</article>
		<!-- 글쓰기 -->
		<div class="clear"></div>
		<!-- 푸터 들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는 곳 -->
	</div>
</body>
</html>



