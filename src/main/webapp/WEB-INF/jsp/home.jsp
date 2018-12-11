<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <script>

        function displayCart(data) {
            document.getElementById('cart-menu').style.display = data > 0 ? 'block' : 'none';
            document.getElementById('cart-size').innerHTML = data;
        }

        function add(id) {
            $.get('cart/api/add', { id: id })
                .done(function(data) {
                    displayCart(data);
                });
        }

        $(document).ready(function() {
            $.get('cart/api/size')
                .done(function(data) {
                    displayCart(data);
                });
        })
    </script>

    <style>
        #cart-menu {
            display: none;
        }
    </style>

</head>
<body>
<div class="container">

    <ul class="nav justify-content-end">

        <!-- c:if test="${data.cartItemList.size() > 0}" -->
            <li class="nav-item" id="cart-menu">
                <a class="nav-link active" href="cart">Shopping cart
                    <!-- span class="badge badge-light">${data.cartItemList.size()}</span -->
                    <span class="badge badge-light" id="cart-size"></span>
                </a>
            </li>
        <!-- /c:if -->

        <c:if test="${!data.logged}">
            <li class="nav-item">
                <a class="nav-link active" href="login">Login</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="register">Register</a>
            </li>
        </c:if>
        <c:if test="${data.logged}">
            <li class="nav-item">
                <a class="nav-link active" href="logout">Logout</a>
            </li>
        </c:if>
    </ul>


    <%@ include file="pagination.jsp" %>

    <%--
    <!-- naudosime del idomumo ne table elementa, o bootstrap card (https://getbootstrap.com/docs/4.1/components/card/) -->
    <table class="table">
        <tr>
            <th>#</th>
            <th>Product</th>
            <th>Category</th>
            <th class="text-right">Price</th>
            <th></th>
            <th></th>
        </tr>

        <c:set var="index" scope="page" value="${offset + 1}"/>
        <c:forEach var="p" items="${products}">

            <tr>
                <td>${index}</td>
                <td>${p.name}</td>
                <td>${p.category.name}</td>
                <td class="text-right">${p.price}</td>
                <td>
                    <img height="100" src="${pageContext.servletContext.contextPath}/images/${p.image}">
                </td>
                <td>
                    <a class="btn btn-primary" href="#" role="button" onclick="add(${p.id})">Add</a>
                </td>

            </tr>

            <c:set var="index" value="${index + 1}" scope="page"/>
        </c:forEach>

    </table>
    --%>

    <div class="card-columns">
        <c:forEach var="p" items="${products}">

            <div class="card">
                <c:if test="${p.image != null}">
                    <img class="card-img-top" width="150" src="${pageContext.servletContext.contextPath}/images/${p.image}">
                </c:if>
                <div class="card-body">
                    <h5 class="card-title">${p.name}</h5>
                    <p class="card-text">Kaina: ${p.price}</p>
                    <a href="#" onclick="add(${p.id})" class="btn btn-primary">Į krepšelį</a>
                </div>
                <div class="card-footer">
                    <small class="text-muted">Kategorija: ${p.category.name}</small>
                </div>
            </div>

        </c:forEach>
    </div>


</div>
</body>
</html>
