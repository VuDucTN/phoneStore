<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--nav-->
<nav class="navbar navbar-expand-lg navbar-light" style="background-color:yellow; font-weight: 700">

    <a class="navbar-brand" href="index.jsp">
        <img src="images/logoShop.png" alt="logo" style="width: 120px; height: 75px"/>
    </a>

    <button
        class="navbar-toggler"
        type="button"
        data-toggle="collapse"
        data-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent"
        aria-expanded="false"
        aria-label="Toggle navigation"
        >
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link" href="cart.jsp">Cart</a>
            </li>


            <c:if test="${sessionScope.auth.role == 1}" >
                <li class="nav-item">
                <a class="nav-link" href="create_product.jsp">Create Product</a>
            </li>
            </c:if>
           
            <% if (auth != null) { %>
            <li class="nav-item">
                <a class="nav-link" href="orders.jsp">Orders</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="log-out">Logout</a>
            </li>
            <%} %>
            <c:if test="${sessionScope.auth != null}">
                <li class="nav-item">
                <a class="nav-link" href="profile.jsp" style="font-weight: bold; color: blue">Hello ${auth.name}</a>
            </li>
            </c:if> 


        </ul>

        <form class="form-inline my-2 my-lg-0">
            <input
                class="form-control mr-sm-2"
                type="search"
                placeholder="Search"
                aria-label="Search"
                />
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">
                Search
            </button>
        </form>
        <% if (auth == null) { %>
    </div>
    <div class="collapse navbar-collapse justify-content-end">
        <ul class="navbar-nav">
            <li class="nav-item px-2">
                <a class="nav-link btn btn btn-success" style="color:white" role="button" href="login.jsp">Login</a>
            </li>
            <li class="nav-item">
                <a class="nav-link btn btn btn-primary" style="color:white" role="button" href="register.jsp">Register</a>
            </li>
        </ul>
    </div>
    <% }%>
</nav>
<!--nav-->

