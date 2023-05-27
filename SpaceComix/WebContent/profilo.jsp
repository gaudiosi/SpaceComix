<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="it.SpaceComix.model.UserBean" %>
<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="UTF-8">
	<title>Profile</title>
	<link rel="stylesheet" href="style.css">
	<%@include file="Header.jsp" %>
</head>
<body>
<div class="quadrato">
<div>
	<% if (user != null) {%>
	<h1> <%=user.getUsername() %>'s Profile</h1>
 	  <form action="UpdateProfile" method="post" class="profile">
 	  		<div class = "ordine">
				<div class = "campi1">
					<label for="text">Nome:	</label>
		        	<input type="text" id="nome" name="nome" value=" <%= user.getNome() %>"  required><br>
		        </div>
		        <div class = "campi1">
		        	<label for="text">Cognome:	</label>
		        	<input type="text" id="cognome" name="cognome" value=" <%= user.getCognome() %> " required>
		        	</div>
		        <br>
		        <div class = "campi2"> 
		        	<label for="text">Username:	</label>
 			 		<input type="text" id="username" name="username" value=" <%= user.getUsername() %>" required>
 			 	</div>
 			 	<div class = "campi2">
 		        	<label for="email">Email:	</label>
 		        	<input type="email" id="email" name="email" value= "<%= user.getEmail() %>" required><br>
 		        </div>
 		      	<br>
 		        <div class = "password-container" >
 		        	<label for="password">Password:	</label>
 		        	<input type="password" id="password" name="password" value=" <%= user.getPassword()%>" required>
 		        	<button type="button" class = "toggle-password" onclick="togglePasswordVisibility('password')">V</button>
 		        </div>
 		  	</div>
 		       	<br>
 		       		<div class="button-container">
        <div class="button-color">
        	<input type="submit" value="Update" class="button">
        </div>
        <div class="button-color">
        	<input type="reset" value="Reset" class="button">
        </div>
    </div>
 		  	</form>
    <% } %>
    <% String error = (String) session.getAttribute("error");
       if (error != null) {
           out.print("<p class = \"error\">" + error + "</p>");
           session.setAttribute("error", null);
       }
    %>
</div>
</div>
    
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