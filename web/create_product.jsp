<%-- 
    Document   : card
    Created on : Mar 31, 2023, 8:20:54 PM
    Author     : LENOVO
--%>

<%@page import="models.User"%>
<%@page import="connection.connectDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    } else {
        response.sendRedirect("index.jsp");
    }
%>

<fmt:setLocale value="en"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Card</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <body>
        <%@include file="includes/navbar.jsp" %>

        <div class="container">
            <h3 class="card-header my-3">Create Product</h3>
        </div>

        <section style="margin: 0 auto"  style="width: 100%">
            <c:if test="${not empty succMsg}">
                <p class="text-success text-center">${succMsg}</p>
                <c:remove var="succMsg" scope="session"/>
            </c:if>
            <c:if test="${not empty failedMsg}">
                <p class="text-dark text-center">${failedMsg}</p>
                <c:remove var="failMsg" scope="session"/>
            </c:if>
            <div  class="d-flex justify-content-center">
                <form action="ProductSevlet" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="command" value="ADD" />
                    <div class="form-group" style="width: 1000px">
                        <label for="exampleInputEmail1">Name Product</label>
                        <input type="text" class="form-control" id="" name="name">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">Price</label>
                        <input type="text" class="form-control" id="" name="price">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">Image</label>
                        <input type="file" class="form-control" id="" name="image">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">Category</label>
                        <input type="text" class="form-control" id="" name="category">
                    </div>
                    <button type="submit" class="btn btn-primary" value="save">Submit</button>
                </form>
            </div>
        </section>



        <%@include file="includes/footer.jsp" %>
    </body>
</html>
