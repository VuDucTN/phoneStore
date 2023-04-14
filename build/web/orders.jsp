<%-- 
    Document   : orders
    Created on : Mar 31, 2023, 8:21:27 PM
    Author     : LENOVO
--%>

<%@page import="java.math.RoundingMode"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.sql.Connection"%>
<%@page import="models.Order"%>
<%@page import="DAO.OrderDAO"%>
<%@page import="java.util.List"%>
<%@page import="models.User"%>
<%@page import="connection.connectDB"%>
<% User auth = (User) request.getSession().getAttribute("auth");
    List<Order> orders = null;
    if (auth != null) {
        request.setAttribute("auth", auth);
        orders = new OrderDAO().userOrders(auth.getId());
    } else {
        response.sendRedirect("index.jsp");
    }

    Locale locale = new Locale("vi", "VN");
    NumberFormat format = NumberFormat.getCurrencyInstance(locale);
    format.setRoundingMode(RoundingMode.HALF_UP);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Orders</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <body>
        <%@include file="includes/navbar.jsp" %>


        <div class="container">
            <div class="cart-header my-3">
                <h3>Your Orders</h3>
            </div>
            <table class="table table-light">
                <thead>
                    <tr>
                        <th scope="col">Date</th>
                        <th scope="col">Customer</th>
                        <th scope="col">Name</th>
                        <th scope="col">Category</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Price</th>
                        <th scope="col">Cancel</th>
                    </tr>
                <tbody>
                    <% if (orders != null) {
                            for (Order o : orders) {%>
                    <tr>

                        <td><%= o.getDate()%></td>
                        <td><%= auth.getName()%></td>
                        <td><%= o.getName()%></td>
                        <td><%= o.getCategory()%></td>
                        <td><%= o.getQuantity()%></td>
                        <td><%= format.format(o.getPrice()) %></td>
                        <td><a class="btn btn-sm btn-danger" href="cancel-oders?id=<%= o.getOrderId() %>">Cancel</tr>
                    </tr>
                    <%}

                        }%>
                  
                </tbody>
                </thead>
            </table>
        </div>

    </body>
</html>
