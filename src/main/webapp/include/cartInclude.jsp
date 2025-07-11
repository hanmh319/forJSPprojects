<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder" %>
<%
    Cookie[] cookies = request.getCookies();
    long totalPrice = 0;
    
%>

<div class="container my-3 p-3 border bg-light" >
    <div style="position: fixed; top: 120px; right: 20px; width: 320px; 
                background: #f8f9fa; border: 1px solid #ccc; padding: 10px; 
                z-index: 9999; box-shadow: 2px 2px 8px rgba(0,0,0,0.1);">
        <h5>장바구니</h5>
        <table class="table table-sm table-bordered">
            <thead>
                <tr>
                    <th>구매상품명</th>
                    <th>수량</th>
                    <th>금액</th>
                </tr>
            </thead>
            <tbody>
            <%
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if (c.getName().startsWith("cart_")) {
                        String value = URLDecoder.decode(c.getValue(), "UTF-8");
                        String[] parts = value.split("\\|");

                        if(parts.length >= 3) {
                            String title = parts[0];
                            long price = 0;
                            int qty = 0;
                            try {
                                price = Long.parseLong(parts[1]);
                                qty = Integer.parseInt(parts[2]);
                            } catch(NumberFormatException e) {
                                continue;
                            }

                            long subtotal = price * qty;
                            totalPrice += subtotal;
            %>
                            <tr>
                                <td><%= title %></td>
                                <td><%= qty %>개</td>
                                <td><%= String.format("%,d원", subtotal) %></td>
                            </tr>
            <%
                        }
                    }
                }
            }
            %>
            </tbody>
        </table>
        <hr>
        <strong>총 금액: <%= String.format("%,d원", totalPrice) %></strong>
        <br><br>
        <form action="cartReset.jsp" method="post" style="display:inline;">
            <button class="btn btn-sm btn-outline-danger">초기화</button>
        </form>
        <a href="orderPage.jsp" class="btn btn-sm btn-outline-primary">주문하기</a>
    </div>
</div>
