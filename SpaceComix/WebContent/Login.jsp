<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="ISO-8859-1">
	<title>Pagina di Login</title>
	<link rel="stylesheet" href="style.css">
	<%@include file="Header.jsp" %>
</head>
<body>
    <h1>Login Page</h1>
    <form action="Login" method="post" class ="login">
        <label for="email">Email:	</label>
        <input type="email" id="email" name="email" required><br>
        <div class = "password-container" >
        	<label for="password">Password:	</label>
        	<input type="password" id="password" name="password" required>
        	<button type="button" class = "toggle-password" onclick="togglePasswordVisibility()">V</button>
 		</div>
 		<br>
        <div class="center">
    		<input type="submit" value="Login">
    		<input type="reset" value="Reset"/>
		</div>
  	</form>
  	<% String error = (String) session.getAttribute("error");
       if (error != null) {
    	   out.print("<p class = \"error\">" + error + "</p>");
           session.setAttribute("error", null);
       }
    %>
    
<script>
function togglePasswordVisibility() {
    var passwordField = document.getElementById("password");
    if (passwordField.type === "password") {
        passwordField.type = "text";
    } else {
        passwordField.type = "password";
    }
}
</script>
</body>
<%@include file="Footer.jsp" %>
</html>