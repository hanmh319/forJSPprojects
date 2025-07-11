<%@ page import="com.sist.web.dao.UserDao" %>
<%@ page import="com.sist.web.model.User" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = request.getParameter("userId");
    String userPwd = request.getParameter("userPwd");
    String userName = request.getParameter("userName");
    String userEmail = request.getParameter("userEmail");

    UserDao userDao = new UserDao();
    User user = new User();

    user.setUserId(userId);
    user.setUserPwd(userPwd);
    user.setUserName(userName);
    user.setUserEmail(userEmail);

    int result = userDao.userUpdate(user);

    if(result > 0){
        response.sendRedirect("/forTest.jsp");
    } else {
        response.sendRedirect("/userUpdateForm.jsp?error=1");
    }
%>