<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.dao.NoticeDao" %>
<%@ page import="com.sist.web.model.Notice" %>

<%
    // 세션X쿠키O에서 로그인한 관리자 정보 확인
    String loginAdmin = CookieUtil.getValue(request, "ADMIN_ID");

    if (loginAdmin == null) {
        // 로그인하지 않은 관리자 → 접근 제한
%>
        <script>
            alert("관리자만 접근 가능합니다.");
            location.href = "login.jsp"; // 로그인 페이지로 이동
        </script>
<%
        return;
    }

    // 폼에서 받은 데이터
    String notiTitle = request.getParameter("notiTitle");
    String notiContent = request.getParameter("notiContent");

    // 데이터 유효성 검사 (제목과 내용이 없으면 오류)
    if (notiTitle == null || notiTitle.trim().isEmpty() || notiContent == null || notiContent.trim().isEmpty()) {
        out.println("<script>");
        out.println("alert('제목과 내용을 모두 입력해 주세요.');");
        out.println("history.back();");
        out.println("</script>");
        return;
    }

    // Notice 객체 생성하여 값 세팅
    Notice notice = new Notice();
    notice.setAdminId(loginAdmin);  // 로그인한 관리자 ID 일단 없다고 치자.
    notice.setNotiTitle(notiTitle);
    notice.setNotiContent(notiContent);
    notice.setNotiReadCnt(0);  // 기본 읽은 횟수 0
    notice.setNotiRegDate(new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()));

    // NoticeDao 객체를 사용하여 공지사항 저장
    NoticeDao noticeDao = new NoticeDao();
    int result = noticeDao.noticeInsert(notice);  // 공지사항 INSERT

    // 처리 결과에 따른 메시지 출력
    if (result > 0) {
%>
        <script>
            alert("공지사항이 성공적으로 등록되었습니다.");
            location.href = "noticeList.jsp";  // 공지사항 목록 페이지로 이동
        </script>
<%
    } else {
%>
        <script>
            alert("공지사항 등록에 실패했습니다.");
            history.back();  // 이전 페이지로 돌아가기
        </script>
<%
    }
%>
