<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="it.SpaceComix.model.UserBean" %>
<html>
  <head>
    <meta charset="ISO-8859-1">
    <title>Header</title>
    <link rel="stylesheet" href="HeaderAndFooterStyle.css">
  </head>
  <body>
    <nav class="navbar">
	<a href = "index.jsp" class = "logo-img"><img src="Immagini/Logo.png" alt="Logo del sito" class="logo"></a>
      <div>
        <a href="Catalogo.jsp" class="navbar-button">Novità</a>
        <a href="faq.jsp" class="navbar-button">FAQ</a>
		<a href="carrello.jsp" class="navbar-button">Carrello</a>
		<%UserBean user = (UserBean) session.getAttribute("user");
			       if (user != null) {
			           out.print("<a href=\"profilo.jsp\" class=\"navbar-button\">" + user.getUsername() + "</a>");
			           out.print("<form action=\"Logout\" method=\"get\"> " +
			        		     "<input type=\"submit\" value=\"Logout\">" + 
			           			 "</form> ");
			       } else {
			    	   out.print("<a href=\"Login.jsp\" class=\"navbar-button\">Login</a>" +
			   				"<a href=\"register.jsp\" class=\"navbar-button\">Register</a>");
			       }
			    %>
      </div>
    </nav>
  </body>
</html>