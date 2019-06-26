<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
if (ServletFileUpload.isMultipartContent(request)){
    ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
    //UTF-8 인코딩 설정
    uploadHandler.setHeaderEncoding("UTF-8");
    List<FileItem> items = uploadHandler.parseRequest(request);
    String realname = "";
    Long size = 0L;
    //각 필드태그들을 FOR문을 이용하여 비교를 합니다.
    for (FileItem item : items) {
        //image.html 에서 file 태그의 name 명을 "image_file"로 지정해 주었으므로
        if(item.getFieldName().equals("image_file")) {
            if(item.getSize() > 0) {
                String ext = item.getName().substring(item.getName().lastIndexOf(".")+1);
                //파일 기본경로
                String defaultPath = request.getServletContext().getRealPath("/");
                System.out.println(request.getServletContext().getRealPath("/"));
                //파일 기본경로 _ 상세경로
                String path = defaultPath + "upload" + File.separator;
                System.out.println(defaultPath + "upload" + File.separator);
                 
                File file = new File(path);
                 
                //디렉토리 존재하지 않을경우 디렉토리 생성
                if(!file.exists()) {
                    file.mkdirs();
                }
                //서버에 업로드 할 파일명(한글문제로 인해 원본파일은 올리지 않는것이 좋음)
                realname = UUID.randomUUID().toString() + "." + ext;
                size = item.getSize();
                ///////////////// 서버에 파일쓰기 /////////////////
                InputStream is = item.getInputStream();
                OutputStream os=new FileOutputStream(path + realname);
                int numRead;
                byte b[] = new byte[(int)item.getSize()];
                while((numRead = is.read(b,0,b.length)) != -1){
                    os.write(b,0,numRead);
                }
                if(is != null)  is.close();
                os.flush();
                os.close();
                ///////////////// 서버에 파일쓰기 /////////////////
            }
        }
    }
    response.setContentType("text/plain; charset=UTF-8");
    PrintWriter pw = response.getWriter();
    //json string 값으로 callback
    //json 값으로 넘기는 필요 값
    //imageurl, filename,filesize,imagealign
    pw.print("{\"imageurl\" : \"../upload/"+realname+"\",\"filename\":\""+realname+"\",\"filesize\": 400,\"imagealign\":\"C\"}");
    pw.flush();
    pw.close();
}
%>

</body>
</html>