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
 		        "<label for=\"email\">Email:	</label>" +
 		        "<input type=\"email\" id=\"email\" name=\"email\" value=\"" + user.getEmail() + "\" required><br>" +
 		        "<div class = \"password-container\" >" +
 		        	"<label for=\"password\">Password:	</label>" + 
 		        	"<input type=\"password\" id=\"password\" name=\"password\" value=\"" + user.getPassword() + "\" required>" +
 		        	"<button type=\"button\" class = \"toggle-password\" onclick=\"togglePasswordVisibility()\">V</button><br>" +
 		        "</div>" +
 		        "<label for=\"text\">Username:	</label>" +
 		        "<input type=\"text\" id=\"username\" name=\"username\" value=\"" + user.getUsername() + "\" required><br>" +
 		        "<label for=\"text\">Nome:	</label>" +
 		        "<input type=\"text\" id=\"nome\" name=\"nome\" value=\"" + user.getNome() + "\" required><br>" +
 		        "<label for=\"text\">Cognome:	</label>" +
 		        "<input type=\"text\" id=\"cognome\" name=\"cognome\" value=\"" + user.getCognome() + "\" required><br>" +
 		        "<input type=\"submit\" value=\"Update\">" +
 		        "<input type=\"reset\" value=\"Reset\"/>" +
 		  	"</form>");
    } %>
    <% String error = (String) session.getAttribute("error");
       if (error != null) {
           out.print("<p class = \"error\">" + error + "</p>");
           session.setAttribute("error", null);
       }
    %>
     <a href="home.jsp" class="bottone"> Home </a>
    
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