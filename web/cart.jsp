<%-- 
    Document   : card
    Created on : Mar 31, 2023, 8:20:54 PM
    Author     : LENOVO
--%>

<%@page import="java.math.RoundingMode"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="Sevlet.ProductSevlet"%>
<%@page import="models.Product"%>
<%@page import="DAO.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page import="models.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="models.User"%>
<%@page import="connection.connectDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    }

    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart_list");
    List<Cart> cartProduct = null;

    if (cart_list != null) {
        ProductDAO pdao = new ProductDAO();
        cartProduct = pdao.getCarts(cart_list);
        int total = pdao.getTotalCartPrice(cart_list);
        request.setAttribute("cart_list", cart_list);
        request.setAttribute("total", total);
    }

    Locale locale = new Locale("vi", "VN");
    NumberFormat format = NumberFormat.getCurrencyInstance(locale);
    format.setRoundingMode(RoundingMode.HALF_UP);

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <style type="text/css">
        .table tbody td{
            vartical-align: middle;
        }

        .btn-incre, .btn-decre{
            box-shadow: none;
            font-size: 25px;
        }
        body{
            background-color: #d7fefa;
        }

    </style>
    <body>
        <fmt:setLocale value='Vi_VN' />
        <%@include file="includes/navbar.jsp" %>

        <div class="container" style="margin-top:25px ; border-radius:12px ; background-color: white;">
            <h3 class="card-header my-3">Your Cart</h3>
            <table class="table table-loght">
                <thead>
                    <tr>
                        <th scope="col">Name</th>
                        <th scope="col">Category</th>
                        <th scope="col">Price</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Cancel</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (cart_list != null) {
                            for (Cart c : cartProduct) {
                    %>

                    <tr>
                        <td><%= c.getName()%></td>
                        <td><%= c.getCategory()%></td>
                        <td><%= format.format(c.getPrice())%></td>
                        <td>
                            <form action="order" method="get" class="form-inline">
                                <input type="hidden" name="id" value="<%= c.getId() %>" class="form-input" />
                                <div class="form-group d-flex justify-content-between">
                                    <a class="btn btn-sm btn-decre" href="quantity-inc-dec?action=dec&id=<%= c.getId()%>"><i class="fas fa-minus-square"></i></a>
                                    <input type="text" style="width:50px " name="quantity" value="<%= c.getQuantity()%>" class="form-control" readonly="" />
                                    <a class="btn btn-sm btn-incre" href="quantity-inc-dec?action=inc&id=<%= c.getId()%>"><i class="fas fa-plus-square"></i></a>
                                </div>
                                <c:if test="${sessionScope.auth != null}" >
                                    <button type="submit" class="btn btn-sm btn-primary" >Buy Now</button>
                                </c:if>
                                <c:if test="${sessionScope.auth == null }" >
                                    <a class="" href="login.jsp">Login to Buy</a>
                                </c:if>
                            </form>
                        </td>
                        <td><a class="btn btn-sm btn-danger" href="remove-from-cart?id=<%= c.getId()%>">Remove</a></td>
                    </tr>  
                    <%}
                        }%>

                </tbody>
            </table>
            <hr/>
            <div class="d-flex justify-content-end" style="align-items: center; align-content: center">          
                <span>Total price:</span> <h5 style="margin-left:5px ; font-weight: bold"><fmt:formatNumber value='${(total>0)?total:0}' type='currency'/></h5>
                <c:if test="${sessionScope.auth != null }" >
                    <a style=" margin-bottom: 10px" class="mx-2 btn btn-primary" href="buyall">Buy All Products</a>
                </c:if>
            </div>
        </div>



        <%--<%@include file="includes/footer.jsp" %>--%>
    </body>
</html>
