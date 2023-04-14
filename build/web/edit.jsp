<%-- 
    Document   : edit
    Created on : Apr 14, 2023, 8:07:40 AM
    Author     : LENOVO
--%>

<%@page import="java.math.RoundingMode"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <style>
        body{
            background-color: #d7fefa;
        }
        section{
            background-color: white;
            border-radius: 20px;
            max-width: 700px;
            margin: 20px auto;
        }
        form{
            width: 550px;
        }

        .container{
            background-color: greenyellow;
            border-radius: 20px 20px 0 0;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
    <body>
        <%@include file="includes/navbar.jsp" %> 
        <fmt:setLocale value='Vi_VN' />
        <section>
            <div class="container">
                <h3 class="my-3">Update Product</h3>
            </div>
            <div  class="d-flex justify-content-center">
                <form action="ProductSevlet" method="GET">
                    <input type="hidden" name="command" value="UPDATE" />
                    <input type="hidden" name="productId"
                           value="${THE_PRODUCT_UPDATE.id}">
                    <div class="form-group">
                        <label for="exampleInputEmail1">Name Product</label>
                        <input type="text" class="form-control" id="" name="name" value="${THE_PRODUCT_UPDATE.name}">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">Price</label>
                        <input type="text" class="form-control" id="" name="price" value="<fmt:formatNumber value='${THE_PRODUCT_UPDATE.price}' type='currency'/>">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">Category</label>
                        <input type="text" class="form-control" id="" name="category" value="${THE_PRODUCT_UPDATE.category}">
                    </div>
                    <button type="submit" class="btn btn-primary" value="save">Submit</button>
                </form>
            </div>
        </section>
    </body>
</html>
