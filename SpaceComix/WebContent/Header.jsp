<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<header>
		<div class="logo">
			<a href="home.jsp"><img src="Logo.png" alt="SpaceComix Logo"></a>
		</div>
		<nav>
			<ul>
				<li><a href="index.jsp">Home</a></li>
				<li><a href="catalog.jsp">Catalogo</a></li>
				<li><a href="cart.jsp">Carrello</a></li>
				<%String name = (String) session.getAttribute("user");
			       if (name != null) {
			           out.print("<a href=\"profilo.jsp\">" + name + "</a></li>");
			           out.print("<form action=\"Logout\" method=\"get\" > " +
			        		     "<input type=\"submit\" value=\"Logout\"/>" +
			           "</form> ");
			       } else {
			    	   out.print("<li><a href=\"Login.jsp\">Login</a></li>" +
			   				"<li><a href=\"register.jsp\">Registrazione</a></li>");
			       }
			    %>
			</ul>
		</nav>
	</header>
</body>
</html>