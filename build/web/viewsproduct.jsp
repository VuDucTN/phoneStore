<%-- 
    Document   : viewsproduct
    Created on : Apr 3, 2023, 12:14:30 PM
    Author     : LENOVO
--%>

<%@page import="models.User"%>
<%@page import="connection.connectDB"%>
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
        <title>Orders</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <style>
        img{
            width: 550px;
            height: 500px;
            border-radius: 20px;
        }
        body{
             background-color: #d7fefa;
        }
    </style>
    <body>
        <%@include file="includes/navbar.jsp" %>
        <fmt:setLocale value='Vi_VN' />
        <section>
            <div class="row" style=" margin:40px 0 10px 0 ;">
                <div class="col-lg-5">
                    <img src="images/${THE_PRODUCT.image}" alt="image"></img>
                    <div class="row d-flex justify-content-center" style=" margin-top: 20px">
                        <a class="nav-link btn btn btn-warning" style="color:white; margin-right: 10px" role="button" href="add-to-cart?id=${THE_PRODUCT.id}">Add to cart</a>                    
                        <a class="nav-link btn btn btn-primary" style="color:white" role="button" href="login.jsp">Buy Now</a>
                    </div>
                </div>
                <div class="col-lg-5">
                    <div class="col" style="text-align: center;">
                        <div style=" height: 250px; margin-top: 100px">
                            <h1 style=" font-weight: bold">${THE_PRODUCT.name}</h1>
                            <p style=" text-align: left; margin-left: 30px">Lorem ipsum dolor sit amet consectetur adipisicing elit.
                            Molestiae modi cum ipsam ad, illo possimus laborum ut
                            reiciendis obcaecati. Ducimus, quas. Corrupti, pariatur eaque?
                            Reiciendis assumenda iusto sapiente inventore animi?</p>
                            <div class="d-flex justify-content-center" style="align-items: center ">
                                <span style="padding-right: 10px;">Price:</span>
                                <p style="width: 250px; height: 50px; border-radius: 15px; font-size: 28px; font-weight: bold; color: white; background-color: red">
                                    <fmt:formatNumber value='${THE_PRODUCT.price}' type='currency'/>
                                </p>
                            </div>
                            
                        </div>
                    </div>
                </div>        
            </div>
        </section>
        
        
        <%@include file="includes/footer.jsp" %>
    </body>
</html>