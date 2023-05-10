<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="UTF-8">
	<title>SignIn Page</title>
	<link rel="stylesheet" href="style.css">
	<%@include file="Header.jsp" %>
	<%@include file="Footer.jsp" %>
</head>
<body>
	<h1>Register Page</h1>
    <form action="Signin" method="post">
    	<div class ="campi1">
    		<label for="text">Nome:	</label>
        	<input type="text" id="nome" name="nome" required>
        </div>
        <div class ="campi1">
        	<label for="text">Cognome:	</label>
        	<input type="text" id="cognome" name="cognome" required>
        </div>
        <br>
        <div class ="campi2">
        	<label for="text">Username:	</label>
        	<input type="text" id="username" name="username" required>
        </div>
        <div class ="campi2">
        	<label for="email">Email:	</label>
        	<input type="email" id="email" name="email" required><br>
        </div>
        <br>
        <div class = "password-container" >
        	<label for="password">Password:	</label>
        	<input type="password" id="password1" name="password1" required>
        	<button type="button" class = "toggle-password" onclick="togglePasswordVisibility('password1')">V</button>
 		</div>
 		<div class = "password-container" >
        	<label for="password">Conferma Password:	</label>
        	<input type="password" id="password2" name="password2" required>
        	<button type="button" class = "toggle-password" onclick="togglePasswordVisibility('password2')">V</button>
 		</div>
 		<br>
        <input type="submit" value="Register">
        <input type="reset" value="Reset"/>
  	</form>
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
</html>