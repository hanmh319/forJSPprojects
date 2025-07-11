<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%@ page import="com.sist.common.util.StringUtil" %>
<%@ page import="com.sist.web.util.HttpUtil" %>
<%@ page import="com.sist.web.util.CookieUtil" %>
<%@ page import="com.sist.web.dao.BoardDao" %>
<%@ page import="com.sist.web.model.Board" %>

<%
	BoardDao boardDao = new BoardDao();
	long seq = HttpUtil.get(request, "seq", 1);
	Board board = boardDao.boardSelect(seq);
	String loginUserId = CookieUtil.getValue(request, "USER_ID");
%>


<!DOCTYPE html>
<html lang="en">
    <head>
    
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>View</title>
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        
        <link href="css/styles.css" rel="stylesheet" />
         <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    $('.btn-add-cart').on('click', function () {
        const title = "<%= board.getTbTitle() %>";
        const price = <%= board.getPrice() %>;
        const quantityRaw = $('#inputQuantity').val();
        const quantity = parseInt(quantityRaw);
        const tbNum = "<%= String.valueOf(board.getTbNum()) %>";

        console.log("title:", title);
        console.log("price:", price);
        console.log("quantityRaw:", quantityRaw, "parsed quantity:", quantity);
        console.log("tbNum (string):", tbNum);

        if (!quantity || quantity <= 0) {
            alert("수량을 올바르게 입력하세요.");
            return;
        }

        // 값 조합
        const rawValue = title + "|" + price + "|" + quantity;
        const value = encodeURIComponent(rawValue);

        console.log("쿠키 저장 시도 key: cart_" + tbNum + " value: " + value);

        // 이 부분을 template literal 대신 문자열 덧셈으로 명확하게 작성
        document.cookie = "cart_" + tbNum + "=" + value + "; path=/; max-age=86400";

        console.log("저장 후 document.cookie: " + document.cookie);

        alert("장바구니에 담았습니다.");
        $('#cartArea').load('/include/cartInclude.jsp');
    });
});
</script>

    </head>
    <body>
        <!-- Navigation-->
<%
    // 네비게이션 바 통일
    if (loginUserId == null || loginUserId.isEmpty()) {
%>
<nav class="py-2 bg-body-tertiary border-bottom">
  <div class="container d-flex flex-wrap">
    <ul class="nav me-auto">
      <li class="nav-item"><a href="/" class="nav-link px-2 active">홈</a></li>
      <li class="nav-item"><a href="/noticeList.jsp" class="nav-link px-2">공지사항</a></li>
      <li class="nav-item"><a href="/userUpdateForm.jsp" class="nav-link px-2">회원정보수정</a></li>
    </ul>
    <form action="forTest.jsp" method="post" class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
      <div class="input-group">
        <input type="text" name="searchKeyword" class="form-control" placeholder="검색어를 입력하세요"
               value="<%= request.getParameter("searchKeyword") != null ? request.getParameter("searchKeyword") : "" %>">
        <button type="submit" class="btn btn-primary">검색</button>
      </div>
    </form>

  </div>
</nav>
<%
    } else {
%>
<nav class="py-2 bg-body-tertiary border-bottom">
  <div class="container d-flex flex-wrap">
    <ul class="nav me-auto">
      <li class="nav-item"><a href="/" class="nav-link px-2 active">홈</a></li>
      <li class="nav-item"><a href="/noticeList.jsp" class="nav-link px-2">공지사항</a></li>
      <li class="nav-item"><a href="/userUpdateForm.jsp" class="nav-link px-2">회원정보수정</a></li>
    </ul>
    <form action="forTest.jsp" method="post" class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
      <div class="input-group">
        <input type="text" name="searchKeyword" class="form-control" placeholder="검색어를 입력하세요"
               value="<%= request.getParameter("searchKeyword") != null ? request.getParameter("searchKeyword") : "" %>">
        <button type="submit" class="btn btn-primary">검색</button>
      </div>
    </form>
    <ul class="nav">
      <li class="nav-item">
        <a href="logOut.jsp" class="nav-link px-2">로그아웃</a>
      </li>
    </ul>
  </div>
</nav>
<%
    }
%>

        <!-- Product section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="row gx-4 gx-lg-5 align-items-center">
                    <div class="col-md-6"><img class="card-img-top mb-5 mb-md-0" src="<%=board.getImagePath() %>" alt="..." /></div>
                    <div class="col-md-6">
                        <div class="small mb-1">공연</div>
                        <h1 class="display-5 fw-bolder"><%=board.getTbTitle() %></h1>
                        <div class="fs-5 mb-5">
                          <%
						      long price = board.getPrice();
						      String priceFormatted = String.format("%,d원", price);
						  %>
                           <p class="lead"style="white-space: pre-line;"><%=priceFormatted %></p>
                        </div>
                        <p class="lead"style="white-space: pre-line;"><%=board.getTbContent()%></p>
                        <div class="d-flex">
                            <input class="form-control text-center me-3" id="inputQuantity" type="number" value="1" style="max-width: 3rem" />
                            <button class="btn btn-outline-dark flex-shrink-0 btn-add-cart" type="button">
                                <i class="bi-cart-fill me-1"></i>
                                장바구니
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer-->
<footer class="py-5 bg-dark text-center">
  <a href="/adminDashboard.jsp" class="text-white mb-3 d-block">&lt;관리자 대시보드&gt;</a>
  <div class="container">
    <p class="m-0 text-white">Copyright &copy; Your Website 2023</p>
  </div>
</footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        
           <div id="cartArea">
        <jsp:include page="/include/cartInclude.jsp" />
    </div>
    </body>
</html>
