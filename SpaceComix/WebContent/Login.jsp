<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="UTF-8">
	<title>Pagina di Login</title>
	<link rel="stylesheet" href="style.css">
	<%@include file="Header.jsp" %>
</head>
<body>
	<div class="quadrato">
    <h1>Login Page</h1>
    <form action="Login" method="post" class ="login">
    <div class = "ordine">
        <label for="email">Email:	</label>
        <input type="email" id="email" name="email" required><br>
        <div class = "password-container" >
        	<label for="password">Password:	</label>
        	<input type="password" id="password" name="password" required>
        	<button type="button" class = "toggle-password" onclick="togglePasswordVisibility('password')">V</button>
 		</div>
 		<br>
 	</div>
 	<div class="button-container">
        <div class="button-color">
        	<input type="submit" value="Login" class="button">
        </div>
        <div class="button-color">
        	<input type="reset" value="Reset" class="button">
        </div>
    </div>
  	</form>
    </div>
    <% String error = (String) session.getAttribute("error");
       if (error != null) {
    	   out.print("<p class = \"error\">" + error + "</p>");
           session.setAttribute("error", null);
       }
    %>
<script>
function togglePasswordVisibility(pass) {
    var passwordField = document.getElementById(pass);
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