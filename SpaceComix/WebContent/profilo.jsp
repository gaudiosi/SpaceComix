<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="it.SpaceComix.model.UserBean" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<% 	UserBean user = (UserBean) session.getAttribute("user");
	out.print("<title>" + user.getUsername() + "\'s Profile</title>"); %>
	<link rel="stylesheet" href="style.css">
</head>
<body>
	<% if (user != null) {
 	   out.print("<form action=\"UpdateProfile\" method=\"post\">" +
				"<div class = \"campi1\">" +
					"<label for=\"text\">Nome:	</label>" +
		        	"<input type=\"text\" id=\"nome\" name=\"nome\" value=\"" + user.getNome() + "\" required><br>" +
		        "</div>" +
		        "<div class = \"campi1\">" +
		        	"<label for=\"text\">Cognome:	</label>" +
		        	"<input type=\"text\" id=\"cognome\" name=\"cognome\" value=\"" + user.getCognome() + "\" required>" +
		        "</div>" +
		        "<br>" +
		        "<div class = \"campi2\">" + 
		        	"<label for=\"text\">Username:	</label>" +
 			 		"<input type=\"text\" id=\"username\" name=\"username\" value=\"" + user.getUsername() + "\" required>" +
 			 	"</div>" +
 			 	"<div class = \"campi2\">" +
 		        	"<label for=\"email\">Email:	</label>" +
 		        	"<input type=\"email\" id=\"email\" name=\"email\" value=\"" + user.getEmail() + "\" required><br>" +
 		        "</div>" +
 		      	"<br>" +
 		        "<div class = \"password-container\" >" +
 		        	"<label for=\"password\">Password:	</label>" + 
 		        	"<input type=\"password\" id=\"password1\" name=\"password1\" value=\"" + user.getPassword() + "\" required>" +
 		        	"<button type=\"button\" class = \"toggle-password\" onclick=\"togglePasswordVisibility()\">V</button>" +
 		        "</div>" +
 		       	"<br>" +
 		        "<div class = \"bottoni\">" +
 		        	"<input type=\"submit\" value=\"Update\">" +
 		        	"<input type=\"reset\" value=\"Reset\"/>" +
 		        "</div>" +
 		  	"</form>");
    } %>
    <% String error = (String) session.getAttribute("error");
       if (error != null) {
           out.print("<p class = \"error\">" + error + "</p>");
           session.setAttribute("error", null);
       }
    %>
    <div class ="bottoni">
    	<a href="home.jsp" class="bottone"> Home </a>
    </div>
    
<script>
function togglePasswordVisibility1() {
    var passwordField = document.getElementById("password1");
    if (passwordField.type === "password") {
        passwordField.type = "text";
    } else {
        passwordField.type = "password";
    }
}
function togglePasswordVisibility2() {
    var passwordField = document.getElementById("password2");
    if (passwordField.type === "password") {
        passwordField.type = "text";
    } else {
        passwordField.type = "password";
    }
}
</script>
</body>
</html>