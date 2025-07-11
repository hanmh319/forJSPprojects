<%@ page import="java.io.*, java.util.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ page import="com.sist.web.dao.BoardDao" %>
<%@ page import="com.sist.web.model.Board" %>

<%
request.setCharacterEncoding("UTF-8");

String uploadPath = application.getRealPath("/images");
File uploadDir = new File(uploadPath);
if (!uploadDir.exists()) {
    uploadDir.mkdirs();
}

String bbsId = "";
String bbsEmail = "";
String bbsTitle = "";
String bbsContent = "";
String savedFileName = null;

// Apache Commons FileUpload 사용
DiskFileItemFactory factory = new DiskFileItemFactory();
ServletFileUpload upload = new ServletFileUpload(factory);

try {
    List<FileItem> items = upload.parseRequest(request);

    for (FileItem item : items) {
        if (item.isFormField()) {
            // 일반 form 필드 처리
            String fieldName = item.getFieldName();
            String value = item.getString("UTF-8");

            if ("bbsId".equals(fieldName)) 
            	bbsId = value;
            if ("bbsEmail".equals(fieldName)) 
            	bbsEmail = value;
            if ("bbsTitle".equals(fieldName)) 
            	bbsTitle = value;
            if ("bbsContent".equals(fieldName)) 
            	bbsContent = value;

        } else {
            // 파일 필드 처리
            String fileName = new File(item.getName()).getName();

            if (fileName != null && !fileName.isEmpty()) {
                savedFileName = System.currentTimeMillis() + "_" + fileName;
                File uploadedFile = new File(uploadPath + File.separator + savedFileName);
                item.write(uploadedFile);
            }
        }
    }
} catch (Exception e) {
    e.printStackTrace();
}

// 이미지 경로 처리
String imagePath = (savedFileName == null) ? null : "/images/" + savedFileName;

// Board 객체 생성
Board board = new Board();
board.setUserId(bbsId);
board.setTbTitle(bbsTitle);
board.setTbContent(bbsContent);
board.setImagePath(imagePath);

// DB에 저장
BoardDao boardDao = new BoardDao();
boardDao.boardInsert(board);

// 게시판 목록으로 이동
response.sendRedirect("/forTest.jsp");
%>