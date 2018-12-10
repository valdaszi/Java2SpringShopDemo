<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Create Account</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script>
        function check_pass() {
            document.getElementById('submit').disabled =
                document.getElementById('passwordField').value !== document.getElementById('passwordConfirmField').value;
        }
    </script>
</head>
<body>
<div class="container">
    <h2>Create Account</h2>

    <c:if test="${param.exists != null}">
        <div class="alert alert-warning">
            An account with that username already exists.
        </div>
    </c:if>

    <form action="register" method="post">
        <div class="form-group">
            <label for="usernameField">Username</label>
            <input name="username" type="text" class="form-control" id="usernameField" placeholder="Enter username">
        </div>
        <div class="form-group">
            <label for="passwordField">Password</label>
            <input name="password" type="password" class="form-control" id="passwordField" placeholder="Password" onkeyup="check_pass();">
        </div>
        <div class="form-group">
            <label for="passwordConfirmField">Confirm password</label>
            <input name="passwordConfirm" type="password" class="form-control" id="passwordConfirmField" placeholder="Confirm Password" onkeyup="check_pass();">
        </div>
        <button type="submit" class="btn btn-primary" id="submit" disabled>Submit</button>
    </form>

</div>
</body>
</html>

