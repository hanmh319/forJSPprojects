<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.web.dao.UserDao" %>
<%@ page import="com.sist.web.model.User" %>

<%
    Logger logger = LogManager.getLogger("userUpdateForm.jsp");
    User user = null;
    String cookieUserId = CookieUtil.getValue(request, "USER_ID");

    if(!StringUtil.isEmpty(cookieUserId)){
        logger.debug("cookie userId: "+cookieUserId);

        UserDao userDao = new UserDao();
        user = userDao.userSelect(cookieUserId);

        if(user == null){
            logger.debug("쿠키는 있는데 사용자 정보 없음");
            CookieUtil.deleteCookie(request, response, "/", "USER_ID");
            response.sendRedirect("/");
        } else if(!StringUtil.equals(user.getStatus(), "Y")) {
            logger.debug("정지된 사용자");
            CookieUtil.deleteCookie(request, response, "/", "USER_ID");
            user = null;
            response.sendRedirect("/");
        }
    }
%>

<% if (user != null) { %>
<!DOCTYPE html>
<html>
<head>
    <title>회원정보 수정</title>
    <meta charset="UTF-8">
    <!-- ✅ Bootstrap 적용 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
    $(document).ready(function(){
        $("#btnUpdate").on("click", function(){
            let idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
            let emptCheck = /\s/g;

            if($.trim($("#userPwd").val()).length <= 0){
                alert("비밀번호를 입력하세요.");
                $("#userPwd").focus(); return;
            }
            if(emptCheck.test($("#userPwd").val())){
                alert("비밀번호에 공백이 포함될 수 없습니다.");
                $("#userPwd").focus(); return;
            }
            if(!idPwCheck.test($("#userPwd").val())){
                alert("비밀번호는 영문 대소문자+숫자 4~12자리로 입력하세요.");
                $("#userPwd").focus(); return;
            }
            if($.trim($("#userPwdConfirm").val()).length <= 0){
                alert("비밀번호 확인을 입력하세요.");
                $("#userPwdConfirm").focus(); return;
            }
            if($("#userPwd").val() != $("#userPwdConfirm").val()){
                alert("비밀번호가 일치하지 않습니다.");
                $("#userPwdConfirm").focus(); return;
            }
            if($.trim($("#userName").val()).length <= 0){
                alert("이름을 입력하세요.");
                $("#userName").focus(); return;
            }
            if($.trim($("#userEmail").val()).length <= 0){
                alert("이메일을 입력하세요.");
                $("#userEmail").focus(); return;
            }
            if(!fn_validateEmail($("#userEmail").val())){
                alert("이메일 형식이 올바르지 않습니다.");
                $("#userEmail").focus(); return;
            }

            $("#updateForm").submit();
        });
    });

    function fn_validateEmail(value) {
        let emailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
        return emailReg.test(value);
    }
    </script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card p-4 bg-white">
                <h3 class="text-center mb-4">회원정보 수정</h3>
                <form id="updateForm" name="updateForm" method="post" action="/userUpdateProc.jsp">

                    <div class="mb-3">
                        <label for="userId" class="form-label">아이디</label>
                        <input type="text" id="userId" class="form-control" value="<%=user.getUserId()%>" readonly />
                        <input type="hidden" name="userId" value="<%=user.getUserId()%>" />
                    </div>

                    <div class="mb-3">
                        <label for="userPwd" class="form-label">비밀번호</label>
                        <input type="password" id="userPwd" name="userPwd" class="form-control" placeholder="비밀번호 입력" maxlength="12" />
                    </div>

                    <div class="mb-3">
                        <label for="userPwdConfirm" class="form-label">비밀번호 확인</label>
                        <input type="password" id="userPwdConfirm" class="form-control" placeholder="비밀번호 확인" maxlength="12" />
                    </div>

                    <div class="mb-3">
                        <label for="userName" class="form-label">이름</label>
                        <input type="text" id="userName" name="userName" class="form-control" value="<%=user.getUserName()%>" maxlength="15" />
                    </div>

                    <div class="mb-3">
                        <label for="userEmail" class="form-label">이메일</label>
                        <input type="text" id="userEmail" name="userEmail" class="form-control" value="<%=user.getUserEmail()%>" maxlength="30" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">판매자 여부</label>
                        <input type="text" class="form-control" value="<%=user.getSell()%>" readonly />
                        <div class="form-text">판매자 여부는 수정할 수 없습니다.</div>
                    </div>

                    <button type="button" id="btnUpdate" class="btn btn-primary w-100 mt-3">수정하기</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
<% } %>
