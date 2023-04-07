<%-- 
    Document   : managerProduct
    Created on : Apr 6, 2023, 1:29:29 PM
    Author     : LENOVO
--%>

<%@page import="models.Product"%>
<%@page import="DAO.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page import="models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    } else {
        response.sendRedirect("index.jsp");
    }

    ProductDAO productDAO = new ProductDAO();
    List<Product> products = productDAO.getAllProducts();
    request.setAttribute("productlist", products);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <style>
        img:hover{
            transform: scale(5.2);
        }
    </style>
    <body>
    <body>
        <%@include file="includes/navbar.jsp" %>

        <div class="container" style="margin-top:25px ; border-radius:12px ; background-color: white;">
            <h3 class="card-header my-3">Manager Product</h3>
            <table class="table table-loght">
                <thead>
                    <tr>
                        <th scope="col">Name</th>
                        <th scope="col">Image</th>
                        <th scope="col">Category</th>
                        <th scope="col">Price</th>
                        <th scope="col">Edit</th>
                        <th scope="col">Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <fmt:setLocale value='Vi_VN' />
                    <c:forEach var="tempProduct" items="${productlist}">
                        <tr>
                            <td><p>${tempProduct.name}</p></td>
                            <td><img src="images/${tempProduct.image}" style="width:50px; height: 50px "></img></td>
                            <td>${tempProduct.category}</td>
                            <td><fmt:formatNumber value='${tempProduct.price}' type='currency'/></td>
                            <td><a class="btn btn-sm btn-success" href="">Edit</a></td>
                            <td><a class="btn btn-sm btn-danger" href="">Remove</a></td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>
            <hr/>
        </div>

    </body>
</html>
