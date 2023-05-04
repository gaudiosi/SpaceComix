<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
  <head>
    <meta charset="ISO-8859-1">
    <link rel="stylesheet" href="HeaderAndFooterStyle.css">
  </head>
  <body>
    <nav class="navbar">
	<a href = "home.jsp" class = "logo-img"><img src="Logo.png" alt="Logo del sito" class="logo"></a>
      <div>
        <a href="ProductView.jsp" class="navbar-button">Novità</a>
        <a href="faq.jsp" class="navbar-button">FAQ</a>
		<a href="carrello.jsp" class="navbar-button">Carrello</a>
		<%String name = (String) session.getAttribute("user");
			       if (name != null) {
			           out.print("<a href=\"profilo.jsp\">" + name + "</a>");
			           out.print("<form action=\"Logout\" method=\"get\" > " +
			        		     "<input type=\"submit\" value=\"Logout\"/>" + 
			           			 "</form> ");
			       } else {
			    	   out.print("<a href=\"Login.jsp\">Login</a>" +
			   				"<a href=\"register.jsp\">Register</a>");
			       }
			    %>
      </div>
      </nav>
  </body>
</html>