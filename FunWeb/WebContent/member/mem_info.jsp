<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
</head>
<script type="text/javascript">
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
<body>
	<%
		String id = (String)session.getAttribute("id");
		if(id == null){
			response.sendRedirect("loginForm.jsp");
		}
		
		// 디비 처리객체 MemberDAO 객체 생성
		MemberDAO mdao = new MemberDAO();
		// getMember(id); 메서드 호출 => 회원정보 저장
		MemberBean mb = mdao.getMember(id);
	%>
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
			<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문메인이미지 -->
		<div id="sub_img_member"></div>
		<!-- 본문메인이미지 -->
		<!-- 왼쪽메뉴 -->
		 <nav id="sub_menu">
		<ul>
			<li><a href="#">회원정보 수정</a></li>
			<li><a href="mem_delete.jsp">회원탈퇴</a></li>
		</ul>
		</nav> 
		<!-- 왼쪽메뉴 -->
		<!-- 본문내용 -->
		<article>
		<h1>회원정보 수정</h1>
		<form action="mem_info_Pro.jsp" method="post" id="join" name="fr" onsubmit="return check()">
			<fieldset>
				<legend>회원 정보<span class="info">(* 필수)</span></legend>
				<label>아이디*</label> <input type="text" name="id" class="id" value="<%=id %>" readonly="readonly"><br>
				<label>비밀번호*</label> <input type="password" name="pass" required><br>
				<label>비밀번호 확인*</label> <input type="password" name="passcheck"><br>
				<label>이름*</label> <input type="text" name="name" value="<%=mb.getName() %>" required><br>
				<label>이메일*</label> <input type="email" name="email" value="<%=mb.getEmail() %>" required><br>
				<label>주소*</label> <input type="text" name="postcode"  class="postcode" value="<%=mb.getPostcode() %>" placeholder="우편번호*"> 
				<input type="button" value="우편번호 찾기" class="postbtn" onclick="postcodeFind()"><br>
				<label><!-- 빈공간 주기 --></label>
				<input type="text" name="address"  class="address" value="<%=mb.getAddress() %>" placeholder="주소*"><br>
				<label><!-- 빈공간 주기 --></label>
				<input type="text" name="detailaddress" class="detailAddress" value="<%=mb.getDetailaddress() %>" placeholder="상세주소*">
				<input type="text" name="extraaddress" class="extraAddress" value="<%=mb.getExtraaddress() %>" placeholder="참고항목"><br>
				<label>전화번호*</label> <input type="text" name="phone" value="<%=mb.getPhone() %>" required><br>
			</fieldset>

			<div class="clear"></div>
			<div id="buttons">
				<input type="submit" value="회원정보 수정" class="submit"> 
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