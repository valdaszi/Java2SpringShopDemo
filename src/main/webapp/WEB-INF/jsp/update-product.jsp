<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Pakeisti produkto aprašymą</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
</head>
<body>
    <div class="container">

        <h1>Redaguoti produktą</h1>

        <c:url var="updateUrl" value="/product/update/${product.id}"/>

        <form:form method="POST" action="${updateUrl}" enctype="multipart/form-data">
            <div class="form-group">
                <label for="nameField">Produkto pavadinimas</label>
                <input name="name" type="text" class="form-control" id="nameField" value="${product.name}">
            </div>

            <div class="form-group">
                <label for="imageField">Produkto paveiksliukas</label>
                <input name="file" type="file" class="form-control-file" id="imageField">
            </div>

            <button type="submit" class="btn btn-primary">Saugoti</button>
        </form:form>

    </div>
</body>
</html>
