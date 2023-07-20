<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="it.SpaceComix.model.UserBean" %>
<!DOCTYPE html>
<html lang="it">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <link rel="stylesheet" href="HeaderAndFooterStyle.css">
  </head>
  <body>
    <nav class="navbar" id="myNavbar">
    	<div style="padding: 0.1em 0.1em; min-width: 500px">
			<a href = "index" class = "logo-img"><img src="Immagini/Logo.svg" alt="Logo del sito" class="logo"></a>
			<div id="escludi">
				<%@include file="BarraRicerca.jsp" %>
			</div>
		</div>
      	<div id="myLinks">
        	<a href="Catalogo.jsp" class="navbar-button">Novità</a>
        	<a href="faq.jsp" class="navbar-button">FAQ</a>
			<a href="carrello.jsp" class="navbar-button">Carrello</a>
			<%UserBean user = (UserBean) session.getAttribute("user");
			       if (user != null) {
			           	if (user.getRuolo().equals("admin")) {
			        	  	 out.print("<a href=\"ADMIN.jsp\" class=\"navbar-button\"> ADMIN PAGE</a>");
			           	}
			           	out.print("<a href=\"profilo.jsp\" class=\"navbar-button\">" + user.getUsername() + "</a>");
			           	out.print("<form action=\"Logout\" method=\"get\" class=\"navbar-button\"> " +
			        		     "<input id=\"logout\" type=\"submit\" value=\"Logout\">" + 
			           			 "</form> ");
			       } else {
			       		out.print("<a href=\"Login.jsp\" class=\"navbar-button\">Login</a>" +
			   			"<a href=\"register.jsp\" class=\"navbar-button\">Register</a>");
			       }
			%>
		</div>
		<a href="javascript:void(0);" class="icon" onclick="myFunction()">
    		<i class="fa fa-bars"></i>
  		</a>
      
    </nav>

<script>
window.addEventListener("resize", function() {
	  var screenWidth = window.innerWidth;
	  var breakpoint = 984; // Sostituisci questo con il numero di pixel desiderato
	  
	  if (screenWidth > breakpoint) {
	    var x = document.getElementById("myLinks");
	    x.style.display = "flex";
	  } else {
	    myFunction();
	  }
	});

function myFunction() {
	  var x = document.getElementById("myLinks");
	  if (x.style.display === "block") {
	    x.style.display = "none";
	  } else {
	    x.style.display = "block";
	  }
	}
</script>
</body>
</html>