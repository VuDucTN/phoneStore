<%-- 
    Document   : index.jsp
    Created on : Mar 31, 2023, 7:20:14 PM
    Author     : LENOVO
--%>

<%@page import="Sevlet.ProductSevlet"%>
<%@page import="models.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.RoundingMode"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="DAO.ProductDAO"%>
<%@page import="models.User"%>
<%@page import="models.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="connection.connectDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    }

    ProductDAO productDAO = new ProductDAO();
    List<Product> products = productDAO.getAllProducts();
    request.setAttribute("productlist", products);

    Locale locale = new Locale("vi", "VN");
    NumberFormat format = NumberFormat.getCurrencyInstance(locale);
    format.setRoundingMode(RoundingMode.HALF_UP);

%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>SmartPhone Store</title>
        <%@include file="includes/header.jsp" %>
    </head>
    <style>
        body{
            background-color: lightgoldenrodyellow;
        }
    </style>
    </<body>
        <%@include file="includes/navbar.jsp" %>

        <%@include file="includes/carousel.jsp" %>


        <!--Cart Product-->
        <div class="container">
            <div class="card-header my-3" style="font-weight: bold">New Products</div>
            <div class="row">
                <fmt:setLocale value='Vi_VN' />
                <c:forEach var="tempProduct" items="${productlist}">
                <div class="col-md-3 my-3" >
                    <div class="card w-100" style="width: 18rem;">
                        <img src="images/${tempProduct.image}" class="card-img-top" style="max-width: 250px; max-height: 260px;" alt="iphone" />
                        <div class="card-body">
                            <h5 class="card-title">${tempProduct.name}</h5>
                            <h6 class="price" style="color: red; font-weight: bold"><fmt:formatNumber value='${tempProduct.price}' type='currency'/></h6>
                            <h6 class="category">Category: ${tempProduct.category}</h6>
                            <!--                <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>-->
                            <div class="mt-3 d-flex justify-content-between">
                                <a href="add-to-cart?id=${tempProduct.id}" class="btn btn-outline-primary">Add to cart</a>
                                
                                <% if (auth != null) { %>
                                <a href="#" class="btn btn-outline-warning">Buy Now</a>
                                <%} %>
                            </div>
                            <hr/>
                            <div class="d-flex justify-content-around">
                                <span><a href="viewsproduct.jsp" class="">views</a></span>
                                <c:if test="${sessionScope.auth.role == 1}">
                                    <span><a href="viewsproduct.jsp" class="">edit</a></span>
                                </c:if>  
                            </div>        
                        </div>
                    </div>
                </div>
                </c:forEach>
            </div>
        </div>
        <!--Cart Product-->

        <%@include file="includes/footer.jsp" %>
    </body>
</html>
