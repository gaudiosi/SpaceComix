<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="it.SpaceComix.model.UserBean" %>
<html lang="it">
  <head>
    <meta charset="UTF-8">
    <title>Header</title>
    <link rel="stylesheet" href="HeaderAndFooterStyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>
  <body>
    <nav class="navbar" id="myNavbar">
	<a href = "index.jsp" class = "logo-img"><img src="Immagini/Logo.png" alt="Logo del sito" class="logo"></a>
      <div>
        <a href="Catalogo.jsp" class="navbar-button">Novità</a>
        <a href="faq.jsp" class="navbar-button">FAQ</a>
		<a href="carrello.jsp" class="navbar-button">Carrello</a>
		<%UserBean user = (UserBean) session.getAttribute("user");
			       if (user != null) {
			           out.print("<a href=\"profilo.jsp\" class=\"navbar-button\">" + user.getUsername() + "</a>");
			           out.print("<form action=\"Logout\" method=\"get\" class=\"navbar-button\"> " +
			        		     "<input type=\"submit\" value=\"Logout\">" + 
			           			 "</form> ");
			       } else {
			    	   out.print("<a href=\"Login.jsp\" class=\"navbar-button\">Login</a>" +
			   				"<a href=\"register.jsp\" class=\"navbar-button\">Register</a>");
			       }
			    %>
		  <a href="javascript:void(0);" class="icon" onclick="myFunction()">
    	  <i class="fa fa-bars"></i>
  		  </a>
      </div>
    </nav>
    
    
    
    
<script>
function myFunction() {
  var x = document.getElementById("myNavbar");
  if (x.className === "navbar") {
    x.className += " responsive";
  } else {
    x.className = "navbar";
  }
}
</script>
  </body>
</html>