	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@ page import="java.util.*, java.net.URLEncoder" %>
	<%@ page import="com.sist.web.model.Board" %>
	<%@ page import="com.sist.web.dao.BoardDao" %>
	<%@ page import="com.sist.web.model.Paging" %>
	<%@ page import="com.sist.common.util.StringUtil" %>
	<%@ page import="com.sist.web.util.CookieUtil" %>
	<%@ page import="com.sist.web.dao.UserDao" %>
	<%@ page import="com.sist.web.model.User" %>
	
	
	<%
	    request.setCharacterEncoding("UTF-8");
	    response.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html; charset=UTF-8");
	
	    String searchKeyword = request.getParameter("searchKeyword");
	
	    Board search = new Board();
	    if (searchKeyword != null && !searchKeyword.isEmpty()) {
	        search.setTbTitle(searchKeyword);
	        search.setTbContent(searchKeyword);
	    }
	
	    long curPage = 1;
	    String pageParam = request.getParameter("page");
	    if (pageParam != null && !pageParam.equals("")) {
	        curPage = Long.parseLong(pageParam);
	    }
	
	    long listCount = 6;
	    long pageCount = 5;
	
	    BoardDao boardDao = new BoardDao();
	    long totalCount = boardDao.getTotalCount(search); 
	
	    Paging paging = new Paging(totalCount, listCount, pageCount, curPage);
	    search.setStartRow(paging.getStartRow());
	    search.setEndRow(paging.getEndRow());
	
	    List<Board> boardList = boardDao.boardList(search);
	
	    String encodedKeyword = searchKeyword != null ? URLEncoder.encode(searchKeyword, "UTF-8") : "";
	    
	    // 글쓰기, 수정 버튼 관련 체크
	    String loginUserId = CookieUtil.getValue(request, "USER_ID");
	    UserDao userDao = new UserDao();
		String userSell = "N"; // 기본값
		if (CookieUtil.getValue(request, "USER_ID") != null) {
		      // User 객체에서 가져오는 부분 (예시)
		      User user = userDao.userSelect(CookieUtil.getValue(request, "USER_ID"));
		      if (user != null) {
			      userSell = user.getSell();  
		      }
	
	  	}
		
		
		 
	
	%>
	
	<!DOCTYPE html>
	<html lang="en">
	<head>
	
	  <meta charset="UTF-8">
	  <title>첫화면</title>
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
	  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	  <script>
	  $(document).ready(function () {
	    $('#loginModal').on('show.bs.modal', function () {
	      $('#loginModalContent').load('/loginForm.jsp');
	    });
	  });
	  const userSell = "<%= userSell %>";
	  
	  const loginUserId = "<%= loginUserId != null ? loginUserId : "" %>";
	  
	  function checkSellPermission() {
	    if (userSell === "Y") {
	      window.location.href = "/boardWrite.jsp"; // 글쓰기 페이지로 이동
	    } else {
	      alert("글쓰기 권한이 없습니다. 판매자로 등록된 사용자만 글을 작성할 수 있습니다.");
	    }
	  }
		  
	  function checkEditPermission(postUserId, postId) {
	    if (!loginUserId) {
	      alert("로그인한 사용자만 수정할 수 있습니다.");
	      return;
	    }
	
	    if (loginUserId !== postUserId) {
	      alert("작성자만 수정할 수 있습니다.");
	      return;
	    }
	
	    // 모두 통과했으면 수정 페이지로 이동
	    const form = document.createElement("form");
	    form.method = "POST";
	    form.action = "/updateForm.jsp";
	
	    const input = document.createElement("input");
	    input.type = "hidden";
	    input.name = "bbsSeq";
	    input.value = postId;
	    form.appendChild(input);
	
	    document.body.appendChild(form);
	    form.submit();
	  }
	  // 삭제도 비슷한 방식으로 form 생성 후 이동시키는것(우리가 했던 방식과 유사점을 갖고 있음)
	  function checkDeletePermission(postUserId, postId) {
	  if (!loginUserId) {
	    alert("로그인한 사용자만 삭제할 수 있습니다.");
	    return;
	  }
	
	  if (loginUserId !== postUserId) {
	    alert("작성자만 삭제할 수 있습니다.");
	    return;
	  }
	
	  if (!confirm("정말 이 게시글을 삭제하시겠습니까?")) {
	    return;
	  }
	
	  // 수정 방식과 동일한 폼 전송 구조
	  const form = document.createElement("form");
	  form.method = "POST";
	  form.action = "/deleteProc.jsp"; // 삭제 처리 JSP
	
	  const input = document.createElement("input");
	  input.type = "hidden";
	  input.name = "bbsSeq";
	  input.value = postId;
	
	  form.appendChild(input);
	  document.body.appendChild(form);
	  form.submit();
	 }
	</script>
	</head>
	<body>
	<%
		if(StringUtil.isEmpty(CookieUtil.getValue(request, "USER_ID")))
		{		//로그인이 안되어 있을 경우
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
    <input type="text" name="searchKeyword" class="form-control" placeholder="검색어자리"
           aria-label="검색어자리" value="<%= searchKeyword != null ? searchKeyword : "" %>">
    <button type="submit" class="btn btn-primary">Search</button>
  </div>
</form>
	    </form>
	    <ul class="nav">
	      <li class="nav-item">
	  		<a href="#" class="nav-link px-2" data-bs-toggle="modal" data-bs-target="#loginModal">로그인</a>
			</li>
	    </ul>
	  </div>
	</nav>
	<%
		}
		else
		{		//로그인이 되어 있을 경우
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
    <input type="text" name="searchKeyword" class="form-control" placeholder="검색어자리"
           aria-label="검색어자리" value="<%= searchKeyword != null ? searchKeyword : "" %>">
    <button type="submit" class="btn btn-primary">Search</button>
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
	
	
	
	<div class="album py-5 bg-body-tertiary">
	  <div class="container">
	  
	    
	<div class="d-flex justify-content-end mb-3">
	  <button type="button" class="btn btn-sm btn-outline-primary" onclick="checkSellPermission()">
	    글쓰기
	  </button>
	</div>
	
	<script>

	</script>
	    
	    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
	<%
	  if (boardList != null && !boardList.isEmpty()) {
	    for (Board board : boardList) {
	%>
	      
	      <div class="col">
	        <div class="card h-100 shadow-sm">
	          <img src="<%= board.getImagePath() != null ? board.getImagePath() : "/images/default.jpg" %>" 
	               class="card-img-top" 
	               style="height: 225px; object-fit: cover;" 
	               alt="썸네일 이미지">
	          <div class="card-body">
  <p class="card-text"><strong><%= board.getTbTitle() %></strong></p>

  <%
      long price = board.getPrice();
      String priceFormatted = String.format("%,d원", price);
  %>
  <p class="card-text fw-bold text_dark"><%= priceFormatted %></p>

  <div class="d-flex justify-content-between align-items-center">
    <div class="btn-group">
	                <a href="boardView.jsp?seq=<%=board.getTbNum() %>" class="btn btn-sm btn-outline-secondary">View</a>
					<form method="post" action="/updateForm.jsp" style="display:inline;">
					  <input type="hidden" name="bbsSeq" value="<%= board.getTbNum() %>">
					  <input type="hidden" name="postUserId" value="<%= board.getUserId() %>">
					<button 
					  type="button" 
					  class="btn btn-sm btn-outline-secondary"
					  onclick="checkEditPermission('<%= board.getUserId() %>', <%= board.getTbNum() %>)">
					  Edit
					</button>
					<button 
					  type="button" 
					  class="btn btn-sm btn-outline-secondary"
					  onclick="checkDeletePermission('<%= board.getUserId() %>', <%= board.getTbNum() %>)">
					  delete
					</button>
					</form>
	              </div>
    <small class="text-body-secondary"><%= board.getRegDate() %></small>
  </div>
</div>
	        </div>
	      </div>
	<%
	    }
	  } else {
	%>
	      <p>등록된 게시물이 없습니다.</p>
	<%
	  }
	%>
	    </div>
	  </div>
	</div>
	
	<div class="d-flex justify-content-center mt-4">
	  <nav>
	    <ul class="pagination">
	      <% if (paging.getPrevBlockPage() > 0) { %>
	        <li class="page-item">
	          <a class="page-link" href="?page=<%= paging.getPrevBlockPage() %>&searchKeyword=<%= encodedKeyword %>">Previous</a>
	        </li>
	      <% } else { %>
	        <li class="page-item disabled"><a class="page-link">이전</a></li>
	      <% } %>
	
	      <% for (long i = paging.getStartPage(); i <= paging.getEndPage(); i++) { %>
	        <li class="page-item <%= (i == paging.getCurPage()) ? "active" : "" %>">
	          <a class="page-link" href="?page=<%= i %>&searchKeyword=<%= encodedKeyword %>"><%= i %></a>
	        </li>
	      <% } %>
	
	      <% if (paging.getNextBlockPage() > 0) { %>
	        <li class="page-item">
	          <a class="page-link" href="?page=<%= paging.getNextBlockPage() %>&searchKeyword=<%= encodedKeyword %>">Next</a>
	        </li>
	      <% } else { %>
	        <li class="page-item disabled"><a class="page-link">다음</a></li>
	      <% } %>
	    </ul>
	  </nav>
	</div>
	
	<!-- 모달 틀은 만들어놔야함 -->
	
	<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-body" id="loginModalContent">
	        <!-- 여기에 폼이 불러와짐 -->
	      </div>
	    </div>
	  </div>
	</div>
	
	
	
	
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

<footer class="py-5 bg-dark text-center">
  <a href="/adminDashboard.jsp" class="text-white mb-3 d-block">&lt;관리자 대시보드&gt;</a>
  <div class="container">
    <p class="m-0 text-white">Copyright &copy; Your Website 2023</p>
  </div>
</footer>
<jsp:include page="/include/cartInclude.jsp" />
	</body>
	</html>