<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Pagina di Login</title>
</head>
<body>
    <h1>Login Page</h1>
    <form action="Login" method="post">
        <label for="username">Username:	</label>
        <input type="text" id="username" name="username" required><br>
        <label for="password">Password:	</label>
        <input type="password" id="password" name="password" required><br>
        <input type="submit" value="Login">
  	</form>
  	<% String error = (String) request.getAttribute("error");
       if (error != null) {
           out.print("<p style=\"color:red\">" + error + "</p>");
       }
    %>
</body>
</html>