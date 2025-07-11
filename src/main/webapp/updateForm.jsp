<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.util.HttpUtil"  %>
<%@ page import="com.sist.web.util.CookieUtil"  %>
<%@ page import="com.sist.web.dao.BoardDao" %>
<%@ page import="com.sist.web.model.Board" %>

<%
    Logger logger = LogManager.getLogger("/updateForm.jsp");

    String cookieUserId = CookieUtil.getValue(request, "USER_ID");

    long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
    String searchValue = HttpUtil.get(request, "searchValue", "");
    long curPage = HttpUtil.get(request, "curPage", (long)1);

    String errorMessage = "";
    Board board = null;

    if(bbsSeq > 0) {
        BoardDao boardDao = new BoardDao();
        board = boardDao.boardSelect(bbsSeq);

        if(board != null) {
            if(!StringUtil.equals(cookieUserId, board.getUserId())){
                board = null;
                errorMessage = "로그인 사용자의 게시물이 아닙니다.";
            }
        } else {
            errorMessage = "해당 게시글이 존재하지 않습니다.";
        }
    } else {
        errorMessage = "게시물 번호가 올바르지 않습니다.";
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시물 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
    $(document).ready(function(){
        <% if(board == null){ %>
            alert("<%=errorMessage%>");
            location.href = "/forTest.jsp";
        <% } else { %>
            $("#bbsTitle").focus();

            $("#btnList").on("click", function(){
                document.bbsForm.action = "/forTest.jsp";
                document.bbsForm.submit();
            });

            $("#btnUpdate").on("click", function(){
                if ($.trim($("#bbsTitle").val()).length <= 0) {
                    alert("제목을 입력하세요.");
                    $("#bbsTitle").focus();
                    return;
                }

                if ($.trim($("#bbsContent").val()).length <= 0) {
                    alert("내용을 입력하세요.");
                    $("#bbsContent").focus();
                    return;
                }

                if(confirm("입력하신 내용으로 수정하시겠습니까?")) {
                    document.updateForm.submit();
                }
            });
        <% } %>
    });
    </script>
</head>
<body>
<div class="container mt-5">
    <% if(board != null) { %>
    <div class="card shadow p-4">
        <h3 class="mb-4">게시물 수정</h3>
        <form name="updateForm" id="updateForm" action="updateProc.jsp" method="post" enctype="multipart/form-data">
           <div class="mb-3">
                <label for="uploadFile" class="form-label">파일 첨부</label>
                <input type="file" class="form-control" name="uploadFile" id="uploadFile" />
            </div>
            <div class="mb-3">
			    <label for="bbsPrice" class="form-label">금액</label>
			    <input type="number" name="bbsPrice" id="bbsPrice" class="form-control" value="<%= board.getPrice() %>" required />
			</div>
            <div class="mb-3">
                <label for="bbsId" class="form-label">작성자 ID</label>
                <input type="text" name="bbsId" id="bbsId" class="form-control" value="<%= board.getUserId() %>" readonly />
            </div>
            <div class="mb-3">
                <label for="bbsTitle" class="form-label">제목</label>
                <input type="text" name="bbsTitle" id="bbsTitle" maxlength="100" class="form-control" value="<%= board.getTbTitle() %>" required />
            </div>
            <div class="mb-3">
                <label for="bbsContent" class="form-label">내용</label>
                <textarea class="form-control" rows="10" name="bbsContent" id="bbsContent" required><%= board.getTbContent() %></textarea>
            </div>


            <!-- Hidden -->
            <input type="hidden" name="bbsSeq" value="<%= bbsSeq %>"/>
            <input type="hidden" name="searchValue" value="<%= searchValue %>" />
            <input type="hidden" name="curPage" value="<%= curPage %>"/>
        </form>

        <div class="d-flex justify-content-end mt-4">
            <button type="button" id="btnUpdate" class="btn btn-primary me-2">수정</button>
            <button type="button" id="btnList" class="btn btn-secondary">리스트</button>
        </div>
    </div>

    <!-- 리스트 이동용 폼 -->
    <form name="bbsForm" method="post" action = "/forTest.jsp">
        <input type="hidden" name="bbsSeq" value="<%= bbsSeq %>" />
        <input type="hidden" name="searchValue" value="<%= searchValue %>" />
        <input type="hidden" name="curPage" value="<%= curPage %>"/>
    </form>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
