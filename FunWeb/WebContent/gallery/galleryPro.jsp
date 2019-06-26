<%@page import="gallery.GalleryDAO"%>
<%@page import="gallery.GalleryBean"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		// MultipartRequest : 파일 업로드를 직접적으로 처리하는 클래스
		// cos.jar -> 안에 포함
		
		// 현재 실행중인 웹프로젝트에 접근(프로젝트의 정보를 가져오기)
		ServletContext ctx = getServletContext();
		
		// 업로드 경로(컴퓨터의 HDD) 가상경로
		// /upload => upload 폴더 생성
		
		// 업로드할 실제 경로
		// D:\workspace_jsp71\.metadata
		// \.plugins\org.eclipse.wst.server.core
		// \tmp0\wtpwebapps\StudyJSP/upload
		
		// 업로드 실제 서버 경로 가져오기
		String realpath = ctx.getRealPath("upload");
		System.out.println(realpath);
		
		// 업로드 처리가능한 파일의 최대 용량
		int max = 100 * 1024 * 1024; // 10MB
		
		// 실제 파일업로드 기능을 처리하는 클래스를 생성
		// 인자1 ) form 태그에서 가져온 파일/텍스트 정보를 저장하기위한 request 객체
		// 인자2 ) 업로드될 파일의 위치
		// 인자3 ) 업로드 하는 파일의 최대크기(용량)
		// 인자4 ) 파일이름이 한글일 경우 처리하는 인코딩방식
		// 인자5 ) 동링한 파일의 이름이 업로드 될경우, 중복처리가
		// 되지 않도록 자동으로 파일 이름을 변환해주는
		// 기능을 가지고있는 객체
		MultipartRequest multi 
			= new MultipartRequest(
					request,
					realpath,
					max,
					"UTF-8",
					new DefaultFileRenamePolicy()
				); 
		
		
		
		Enumeration e = multi.getFileNames();
		String fname = null;
		while(e.hasMoreElements()){
			fname = (String)e.nextElement();
			System.out.println("클라이언트가 업로드한 파일 원본 이름 : " + multi.getOriginalFileName(fname));
			System.out.println("서버에 업로드된 파일 원본 이름 : " + multi.getFilesystemName(fname));
			
			// 서버에 저장되어있는 파일 정보를 가져온다.
			File f = multi.getFile(fname);
			
			System.out.println("파일크기 : "+f.length());
			
			/* // 업로드된 파일 삭제
			f.delete(); */
		}
		// 이름, 제목 저장
		// request.getParameter("name");
		String img_title = multi.getParameter("img_title");
		String img_name = multi.getFilesystemName(fname);
		GalleryBean gb = new GalleryBean();
		gb.setRealpath(realpath);
		gb.setImg_title(img_title);
		gb.setImg_name(img_name);
				
		GalleryDAO gdao = new GalleryDAO();
				
		gdao.insertImage(gb);
				
				
		System.out.println("img_title : " + img_title);
		System.out.println("img_name : " + img_name);
		
		response.sendRedirect("gallery_main.jsp");
	%>
</body>
</html>