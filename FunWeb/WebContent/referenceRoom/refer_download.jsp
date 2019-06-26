<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
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
	
		String fileName = request.getParameter("file_name");
		
		String savePath="upload";
		ServletContext context = getServletContext();
		
		String sDownPath = context.getRealPath(savePath);
		
		System.out.print("다운로드 위치 : "+sDownPath);
		
		String sFilePath = sDownPath + "\\"+fileName;
		
		System.out.print("sFilePath 뭐야 : "+sDownPath);
		
		File f = new File(sFilePath);
		
		byte[] b = new byte[100*1024*1024];
		
		FileInputStream in = new FileInputStream(f);
		
		String sMimeType = getServletContext().getMimeType(sFilePath);
		
		System.out.print("유형"+sMimeType);
		
		if(sMimeType == null){
			sMimeType = "application.octec-stream";
		}
		/* String A = new String(fileName.getBytes("utf-8"),"8859_1");
		System.out.print(A); */
		String B = "utf-8";
		String sEncoding = URLEncoder.encode(fileName,B);
		
		response.setContentType(sMimeType);
		
		String header1 = "Content-Disposition";
		String header2 = "attachment; filename="+sEncoding;
		response.setHeader(header1, header2);
		
		ServletOutputStream out2 = response.getOutputStream();
		
		int numRead = 0;
		
		while((numRead=in.read(b,0,b.length))!=-1){
			out2.write(b,0,numRead);
		}
		out2.flush();
		out2.close();
		in.close();
	%>	
</body>
</html>