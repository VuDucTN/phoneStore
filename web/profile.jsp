<%-- 
    Document   : orders
    Created on : Mar 31, 2023, 8:21:27 PM
    Author     : LENOVO
--%>

<%@page import="models.User"%>
<%@page import="connection.connectDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    } else {
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <style>
        .all{
            width: 1000px;
        }
        .profile{
            width: 350px;
            margin: 2px;
        }
        .profile-card{
            margin-top: 10px;
        }
    </style>
    <body>
        <%@include file="includes/navbar.jsp" %>
        <div class="card-header my-3">
            <h3 class="my-3">Profile</h3>
        </div>

        <div class="all d-flex justify-content-center">
            <form action="updateUser" method="post">
                <input type="hidden" name="userId"
                           value="${THE_USER.id}">
                <div class="profile">
                    <div class="profile-card">
                        <h5>Name:</h5>
                        <input type="text" name="name" class="form-control" value="${THE_USER.name}"></input>
                    </div>
                    <div class="profile-card">
                        <h5>Password:</h5>
                        <input type="password" name="password" class="form-control" value="${THE_USER.password}"></input>
                    </div>
                    <div class="profile-card">
                        <h5>Email:</h5>
                        <input type="text" name="email" class="form-control" value="${THE_USER.email}"></input>
                    </div>
                    <div class="profile-card">
                        <h5>Phone:</h5>
                        <input type="text" name="phone" class="form-control" value="${THE_USER.phone}"></input>
                    </div>
                    <div class="profile-card">
                        <input type="submit" value="UPDATE" class="btn btn-success"></input>
                    </div>
                </div>
            </form>
        </div>

        <%@include file="includes/footer.jsp" %>
    </body>
</html>