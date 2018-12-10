<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cart</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <h2>Shopping cart</h2>

    <%@ include file="pagination.jsp" %>

    <table class="table">
        <tr>
            <th>#</th>
            <th>Product</th>
            <th class="text-right">Quantity</th>
            <th class="text-right">Price</th>
            <th class="text-right">Total</th>
            <th></th>
        </tr>

        <c:set var="index" scope="page" value="${offset + 1}"/>
        <c:forEach var="p" items="${items}">

            <tr>
                <td>${index}</td>
                <td>${p.product.name}</td>
                <td class="text-right">${p.quantity}</td>
                <td class="text-right">${p.price}</td>
                <td class="text-right">${p.total}</td>
                <td></td>
            </tr>

            <c:set var="index" value="${index + 1}" scope="page"/>

        </c:forEach>

        <tr>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th class="text-right">${total}</th>

        </tr>
    </table>

</div>
</body>
</html>