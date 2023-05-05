<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SignIn Page</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<h1>Register Page</h1>
    <form action="Signin" method="post">
        <label for="email">Email:	</label>
        <input type="email" id="email" name="email" required><br>
        <div class = "password-container" >
        	<label for="password">Password:	</label>
        	<input type="password" id="password" name="password" required><br>
        	<button type="button" class = "toggle-password" onclick="togglePasswordVisibility()">V</button><br>" +
 		</div>
        <label for="text">Username:	</label>
        <input type="text" id="username" name="username" required><br>
        <label for="text">Nome:	</label>
        <input type="text" id="nome" name="nome" required><br>
        <label for="text">Cognome:	</label>
        <input type="text" id="cognome" name="cognome" required><br>
        <input type="submit" value="Register">
        <input type="reset" value="Reset"/>
  	</form>
  	<% String error = (String) session.getAttribute("error1");
       if (error != null) {
           out.print("<p style=\"color:red\">" + error + "</p>");
           session.setAttribute("error1", null);
       }
    %>
    <a href="home.jsp" class="bottone"> Home</a>
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
</html>