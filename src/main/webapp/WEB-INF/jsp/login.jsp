<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <h2>Login</h2>

    <c:if test="${param.error != null}">
        <div class="alert alert-warning">
            Invalid username and password.
        </div>
    </c:if>
    <c:if test="${param.logout != null}">
        <div class="alert alert-info">
            You have been logged out.
        </div>
    </c:if>

    <form action="login" method="post">
        <div class="form-group">
            <label for="usernameField">Username</label>
            <input name="username" type="text" class="form-control" id="usernameField" placeholder="Enter username">
        </div>
        <div class="form-group">
            <label for="passwordField">Password</label>
            <input name="password"  type="password" class="form-control" id="passwordField" placeholder="Password">
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>
</div>
</body>
</html>

