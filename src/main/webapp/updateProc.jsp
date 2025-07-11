<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ page import="com.sist.web.dao.BoardDao" %>
<%@ page import="com.sist.web.model.Board" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="org.apache.logging.log4j.LogManager, org.apache.logging.log4j.Logger" %>

<%
request.setCharacterEncoding("UTF-8");

Logger logger = LogManager.getLogger("updateProc.jsp");
String cookieUserId = CookieUtil.getValue(request, "USER_ID");

String uploadPath = application.getRealPath("/images");
File uploadDir = new File(uploadPath);
if (!uploadDir.exists()) {
    uploadDir.mkdirs();
}

long bbsSeq = 0;
String bbsId = "";
String bbsTitle = "";
String bbsContent = "";
String searchValue = "";
long curPage = 1;
int boardPrice = 0;  // ← 금액 변수 추가
String savedFileName = null;

DiskFileItemFactory factory = new DiskFileItemFactory();
ServletFileUpload upload = new ServletFileUpload(factory);

boolean success = false;
String errorMessage = "";

try {
    List<FileItem> items = upload.parseRequest(request);
    for (FileItem item : items) {
        if (item.isFormField()) {
            String fieldName = item.getFieldName();
            String value = item.getString("UTF-8");

            if ("bbsSeq".equals(fieldName)) bbsSeq = Long.parseLong(value);
            if ("bbsId".equals(fieldName)) bbsId = value;
            if ("bbsTitle".equals(fieldName)) bbsTitle = value;
            if ("bbsContent".equals(fieldName)) bbsContent = value;
            if ("searchValue".equals(fieldName)) searchValue = value;
            if ("curPage".equals(fieldName)) curPage = Long.parseLong(value);
            if ("bbsPrice".equals(fieldName)) boardPrice = Integer.parseInt(value);  // ← 금액 파싱
        } else {
            // 파일 업로드 처리
            String fileName = new File(item.getName()).getName();
            if (fileName != null && !fileName.isEmpty()) {
                savedFileName = System.currentTimeMillis() + "_" + fileName;
                File uploadedFile = new File(uploadPath + File.separator + savedFileName);
                item.write(uploadedFile);
            }
        }
    }

    BoardDao boardDao = new BoardDao();
    Board board = boardDao.boardSelect(bbsSeq);

    if (board != null) {
        if (cookieUserId.equals(board.getUserId())) {
            board.setTbTitle(bbsTitle);
            board.setTbContent(bbsContent);
            board.setPrice(boardPrice); // ← 금액 설정
            if (savedFileName != null) {
                board.setImagePath("/images/" + savedFileName);
            }
            int result = boardDao.boardUpdate(board);
            success = (result > 0);
        } else {
            errorMessage = "수정 권한이 없습니다.";
        }
    } else {
        errorMessage = "게시물이 존재하지 않습니다.";
    }

} catch (Exception e) {
    errorMessage = "예외 발생: " + e.getMessage();
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 수정</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function(){
            <% if (success) { %>
                alert("게시물이 성공적으로 수정되었습니다.");
                document.bbsForm.action = "/forTest.jsp";
                document.bbsForm.submit();
            <% } else { %>
                alert("<%= errorMessage %>");
                history.back();
            <% } %>
        });
    </script>
</head>
<body>
<form name="bbsForm" method="post">
    <input type="hidden" name="bbsSeq" value="<%= bbsSeq %>">
    <input type="hidden" name="searchValue" value="<%= searchValue %>">
    <input type="hidden" name="curPage" value="<%= curPage %>">
</form>
</body>
</html>
