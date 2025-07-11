<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder" %>
<%
    Cookie[] cookies = request.getCookies();
    long totalPrice = 0;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>주문 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: #f9f9f9;
            padding-top: 40px;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .order-container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        h2 {
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
            margin-bottom: 25px;
            color: #007bff;
        }
        .total-price {
            font-size: 1.25rem;
            font-weight: bold;
            margin-top: 20px;
        }
        .btn-primary {
            width: 100%;
            font-size: 1.1rem;
        }
    </style>
</head>
<body>
    <div class="order-container">
        <h2>주문 내역 확인</h2>

        <table class="table table-bordered">
            <thead class="table-light">
                <tr>
                    <th>상품명</th>
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

        <div class="total-price">총 결제 금액: <%= String.format("%,d원", totalPrice) %></div>

        <form action="orderProc.jsp" method="post" class="mt-4">
            <div class="mb-3">
                <label for="buyerName" class="form-label">주문자 이름</label>
                <input type="text" class="form-control" id="buyerName" name="buyerName" required />
            </div>
            <div class="mb-3">
                <label for="buyerPhone" class="form-label">연락처</label>
                <input type="tel" class="form-control" id="buyerPhone" name="buyerPhone" required pattern="[0-9\-]+" />
            </div>
            <div class="mb-3">
                <label for="buyerAddress" class="form-label">배송 주소</label>
                <input type="text" class="form-control" id="buyerAddress" name="buyerAddress" required />
            </div>

            <button type="submit" class="btn btn-primary">주문 완료</button>
        </form>
    </div>
</body>
</html>
