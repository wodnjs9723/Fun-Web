<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
 <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
 <script type="text/javascript">
 	function winopen() {
		// alert("버튼클릭");
		if(document.fr.id.value == ""){
			alert("ID 값을 입력하세요.");
			document.fr.id.focus();
			return;
		}
		// 폼태그에 있는 ID값을 가져오기
		var fid = document.fr.id.value;
		// alert("입력된 아이디 : "+fid);
		
		// 새 창 열기
		// window.open("페이지 주소", "창이름(생략가능)", "창크기...옵션");
		window.open("joinIDCheck.jsp?userid="+fid,"","width=400, height=200");
	}
 	
 	function postcodeFind(){
 		new daum.Postcode({
 			oncomplete: function(data) {
 				var addr = '';
 				var extraAddr = '';
 				
                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.fr.extraaddress.value = extraAddr;
                
                } else {
                	document.fr.extraaddress.value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.fr.postcode.value = data.zonecode;
                document.fr.address.value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.fr.detailaddress.focus();
            }
        }).open();
    }
 	
 	function check(){
 		var pass = document.fr.pass.value;
 		var passcheck = document.fr.passcheck.value;
 		if(pass != passcheck){
 			alert("비밀번호를 확인해주세요!");
 			return false;
 		}
 		
 	}
 </script>
</head>
<body>
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
			<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문메인이미지 -->
		<div id="sub_img_member"></div>
		<!-- 본문메인이미지 -->
		<!-- 왼쪽메뉴 -->
		<!-- <nav id="sub_menu">
		<ul>
			<li><a href="#">회원가입</a></li>
			<li><a href="#">Privacy policy</a></li>
		</ul>
		</nav> -->
		<!-- 왼쪽메뉴 -->
		<!-- 본문내용 -->
		<article>
		<h1>회원가입</h1>
		<form action="joinPro.jsp" method="post" id="join" name="fr" onsubmit="return check()">
			<fieldset>
				<legend>회원 정보<span class="info">(* 필수)</span></legend>
				<label>아이디*</label> <input type="text" name="id" class="id" required>
				<input type="button" value="중복체크" class="dup" onclick="winopen()"><br>
				<label>비밀번호*</label> <input type="password" name="pass" required><br>
				<label>비밀번호 확인*</label> <input type="password" name="passcheck"><br>
				<label>이름*</label> <input type="text" name="name" required><br>
				<label>이메일*</label> <input type="email" name="email" required><br>
				<label>주소*</label> <input type="text" name="postcode"  class="postcode" placeholder="우편번호*"> 
				<input type="button" value="우편번호 찾기" class="postbtn" onclick="postcodeFind()"><br>
				<label><!-- 빈공간 주기 --></label>
				<input type="text" name="address" placeholder="주소*" class="address"><br>
				<label><!-- 빈공간 주기 --></label>
				<input type="text" name="detailaddress" placeholder="상세주소*" class="detailAddress">
				<input type="text" name="extraaddress" placeholder="참고항목" class="extraAddress"><br>
				<label>전화번호*</label> <input type="text" name="phone" required><br>
			</fieldset>

			<div class="clear"></div>
			<div id="buttons">
				<input type="submit" value="회원가입" class="submit"> 
				<input type="reset" value="초기화" class="cancel">
			</div>
		</form>
		</article>
		<!-- 본문내용 -->
		<!-- 본문들어가는 곳 -->

		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
			<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터들어가는 곳 -->
	</div>
</body>
</html>