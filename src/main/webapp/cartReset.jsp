<%
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if (c.getName().startsWith("cart_")) {
                c.setMaxAge(0);
                c.setPath("/");
                response.addCookie(c);
            }
        }
    }
    response.sendRedirect(request.getHeader("Referer"));
%>
